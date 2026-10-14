// Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Verschlüsselung des Verlaufs: AES-256-CBC mit PKCS7 und HMAC-SHA256
/// (Encrypt-then-MAC). Der 32-Byte-Hauptschlüssel wird je Installation
/// zufällig erzeugt und liegt nur im Schlüsselbund (iOS, nicht in iCloud
/// synchronisiert, nicht auf andere Geräte übertragbar) bzw. im Android
/// Keystore. Eine Sicherung enthält damit höchstens Geheimtext.
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';

const _keyName = 'history_key_v1';

const _storage = FlutterSecureStorage(
  iOptions: IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
    synchronizable: false,
  ),
);

final _random = Random.secure();

Uint8List randomBytes(int n) =>
    Uint8List.fromList(List.generate(n, (_) => _random.nextInt(256)));

/// Liest den Hauptschlüssel oder legt einen neuen an. Null, wenn der
/// Schlüsselspeicher nicht erreichbar ist; dann wird nichts gespeichert,
/// damit ein vorhandener Verlauf nicht mit einem Ersatzschlüssel
/// überschrieben wird.
Future<Uint8List?> loadHistoryKey() async {
  try {
    final stored = await _storage.read(key: _keyName);
    if (stored != null) {
      try {
        final key = base64.decode(stored);
        if (key.length == 32) return key;
      } on FormatException {
        // Unbrauchbarer Eintrag: neuen Schlüssel anlegen.
      }
    }
    final key = randomBytes(32);
    await _storage.write(key: _keyName, value: base64.encode(key));
    return key;
  } catch (_) {
    return null;
  }
}

/// Format: base64( Version 0x01 | IV (16) | Geheimtext | HMAC (32) ).
/// Der HMAC deckt Version, IV und Geheimtext ab und wird vor dem
/// Entschlüsseln geprüft.
class HistoryCipher {
  HistoryCipher(List<int> masterKey)
    : assert(masterKey.length == 32),
      _encKey = _derive(masterKey, 'qrv-history-enc'),
      _macKey = _derive(masterKey, 'qrv-history-mac');

  static const _version = 1;
  static const _ivLength = 16;
  static const _macLength = 32;

  final Uint8List _encKey;
  final List<int> _macKey;

  /// Eigene Schlüssel für Verschlüsselung und HMAC aus dem Hauptschlüssel.
  static Uint8List _derive(List<int> master, String label) =>
      Uint8List.fromList(
        Hmac(sha256, master).convert(utf8.encode(label)).bytes,
      );

  static const _block = 16;

  /// AES-256-CBC über ganze Blöcke; [data].length ist ein Vielfaches von 16.
  Uint8List _cbc(bool encrypt, Uint8List iv, Uint8List data) {
    final cbc = CBCBlockCipher(AESEngine())
      ..init(encrypt, ParametersWithIV(KeyParameter(_encKey), iv));
    final out = Uint8List(data.length);
    for (var o = 0; o < data.length; o += _block) {
      cbc.processBlock(data, o, out, o);
    }
    return out;
  }

  /// PKCS7: 1 bis 16 Füllbytes mit ihrer Anzahl als Wert.
  static Uint8List _pad(List<int> data) {
    final n = _block - data.length % _block;
    return Uint8List.fromList([...data, ...List.filled(n, n)]);
  }

  static Uint8List? _unpad(Uint8List data) {
    if (data.isEmpty) return null;
    final n = data.last;
    if (n < 1 || n > _block || n > data.length) return null;
    for (var i = data.length - n; i < data.length; i++) {
      if (data[i] != n) return null;
    }
    return Uint8List.sublistView(data, 0, data.length - n);
  }

  /// Verschlüsselt [text] mit einem neuen zufälligen IV.
  String encrypt(String text) {
    final iv = randomBytes(_ivLength);
    final body = _cbc(true, iv, _pad(utf8.encode(text)));
    final head = BytesBuilder(copy: false)
      ..addByte(_version)
      ..add(iv)
      ..add(body);
    final signed = head.takeBytes();
    final mac = Hmac(sha256, _macKey).convert(signed).bytes;
    return base64.encode([...signed, ...mac]);
  }

  /// Entschlüsselt [data]; null bei falschem Format, falschem Schlüssel
  /// oder veränderten Daten.
  String? decrypt(String data) {
    try {
      final bytes = base64.decode(data);
      if (bytes.length < 1 + _ivLength + _block + _macLength) return null;
      if (bytes[0] != _version) return null;
      final signed = Uint8List.sublistView(bytes, 0, bytes.length - _macLength);
      final mac = Uint8List.sublistView(bytes, bytes.length - _macLength);
      final expected = Hmac(sha256, _macKey).convert(signed).bytes;
      if (!_equal(mac, expected)) return null;
      final iv = Uint8List.sublistView(bytes, 1, 1 + _ivLength);
      final body = Uint8List.sublistView(signed, 1 + _ivLength);
      if (body.isEmpty || body.length % _block != 0) return null;
      final plain = _unpad(_cbc(false, iv, body));
      return plain == null ? null : utf8.decode(plain);
    } catch (_) {
      return null;
    }
  }

  /// Vergleich in konstanter Zeit.
  static bool _equal(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
