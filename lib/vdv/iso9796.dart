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

import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Ergebnis einer ISO-9796-2-Nachrichtenrückgewinnung.
class RecoveredMessage {
  const RecoveredMessage(this.message, this.hashValid);

  /// Rückgewonnener Teil plus nicht rückgewinnbarer Rest.
  final Uint8List message;

  /// True, wenn der SHA-1-Hash in der Signatur zur Nachricht passt.
  final bool hashValid;
}

/// ISO/IEC 9796-2 (Schema 1, SHA-1) mit RSA: m = s^e mod n.
///
/// Erwartet Kopfbyte 0x6A und Endbyte 0xBC. Gibt null zurück, wenn der
/// Schlüssel nicht passt.
RecoveredMessage? recoverMessage(
  List<int> signature,
  BigInt modulus,
  BigInt exponent, [
  List<int> remainder = const [],
]) {
  final size = signature.length;
  if (size < 22) return null;
  final m = _toBytes(_toBigInt(signature).modPow(exponent, modulus), size);
  if (m == null || m.first != 0x6A || m.last != 0xBC) return null;
  final message = Uint8List.fromList([
    ...m.sublist(1, size - 21),
    ...remainder,
  ]);
  final hash = m.sublist(size - 21, size - 1);
  final digest = sha1.convert(message).bytes;
  var valid = digest.length == hash.length;
  for (var i = 0; valid && i < hash.length; i++) {
    valid = digest[i] == hash[i];
  }
  return RecoveredMessage(message, valid);
}

BigInt _toBigInt(List<int> bytes) {
  var v = BigInt.zero;
  for (final b in bytes) {
    v = (v << 8) | BigInt.from(b);
  }
  return v;
}

Uint8List? _toBytes(BigInt value, int size) {
  final out = Uint8List(size);
  var v = value;
  for (var i = size - 1; i >= 0; i--) {
    out[i] = (v & BigInt.from(0xFF)).toInt();
    v = v >> 8;
  }
  return v == BigInt.zero ? out : null;
}

/// Wandelt Big-Endian-Bytes in eine BigInt (für Modulus und Exponent).
BigInt bytesToBigInt(List<int> bytes) => _toBigInt(bytes);
