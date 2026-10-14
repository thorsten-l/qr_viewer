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

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/history_crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final key = List.generate(32, (i) => i);

  group('HistoryCipher', () {
    test('Hin und zurück ergibt denselben Text', () {
      final c = HistoryCipher(key);
      const text = '[{"raw":"WIFI:S:Heim;T:WPA;P:geheim;;"}] äöü 🚀';
      expect(c.decrypt(c.encrypt(text)), text);
    });

    test('leerer Text', () {
      final c = HistoryCipher(key);
      expect(c.decrypt(c.encrypt('')), '');
    });

    test('jeder Aufruf nutzt einen neuen IV', () {
      final c = HistoryCipher(key);
      final a = base64.decode(c.encrypt('gleich'));
      final b = base64.decode(c.encrypt('gleich'));
      expect(a.sublist(1, 17), isNot(b.sublist(1, 17)));
      expect(a, isNot(b));
    });

    test('Aufbau: Version, IV, Blöcke, HMAC', () {
      final bytes = base64.decode(HistoryCipher(key).encrypt('x' * 20));
      expect(bytes[0], 1);
      // 1 + 16 IV + 32 Geheimtext (20 Byte + Padding) + 32 HMAC
      expect(bytes.length, 81);
    });

    test('jedes veränderte Byte wird erkannt', () {
      final c = HistoryCipher(key);
      final bytes = base64.decode(c.encrypt('Inhalt des Verlaufs'));
      for (var i = 0; i < bytes.length; i++) {
        final changed = [...bytes]..[i] ^= 0x01;
        expect(c.decrypt(base64.encode(changed)), isNull, reason: 'Byte $i');
      }
    });

    test('falscher Schlüssel ergibt null', () {
      final data = HistoryCipher(key).encrypt('geheim');
      final other = HistoryCipher(List.filled(32, 7));
      expect(other.decrypt(data), isNull);
    });

    test('Unsinn ergibt null', () {
      final c = HistoryCipher(key);
      expect(c.decrypt(''), isNull);
      expect(c.decrypt('kein base64!'), isNull);
      expect(c.decrypt(base64.encode([1, 2, 3])), isNull);
      expect(c.decrypt('[{"raw":"klartext"}]'), isNull);
    });
  });

  group('Schlüssel', () {
    setUp(() => FlutterSecureStorage.setMockInitialValues({}));

    test('wird einmal erzeugt und dann wiederverwendet', () async {
      final a = await loadHistoryKey();
      final b = await loadHistoryKey();
      expect(a, hasLength(32));
      expect(b, a);
    });

    test('unbrauchbarer Eintrag wird ersetzt', () async {
      FlutterSecureStorage.setMockInitialValues({'history_key_v1': 'kaputt'});
      expect(await loadHistoryKey(), hasLength(32));
    });
  });

  group('Verschlüsselter Verlauf', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
    });

    test('gespeichert wird nur Geheimtext', () async {
      final h = await ScanHistory.load();
      await h.add('WIFI:S:Heim;T:WPA;P:streng-geheim;;', BarcodeType.wifi);
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString('scan_history_v2')!;
      expect(stored, isNot(contains('geheim')));
      expect(
        utf8.decode(base64.decode(stored), allowMalformed: true),
        isNot(contains('geheim')),
      );
      expect(prefs.getString('scan_history_v1'), isNull);
      final again = await ScanHistory.load();
      expect(again.entries.single.raw, 'WIFI:S:Heim;T:WPA;P:streng-geheim;;');
    });

    test('Klartext-Verlauf aus 2.1 wird übernommen und gelöscht', () async {
      SharedPreferences.setMockInitialValues({
        'scan_history_v1': jsonEncode([
          {
            'raw': 'https://example.org',
            'type': 'url',
            'format': 'qrCode',
            'time': '2026-10-09T07:00:00.000',
          },
        ]),
      });
      final h = await ScanHistory.load();
      expect(h.entries.single.raw, 'https://example.org');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('scan_history_v1'), isNull);
      expect(prefs.getString('scan_history_v2'), isNotNull);
      final again = await ScanHistory.load();
      expect(again.entries.single.raw, 'https://example.org');
    });

    test('ohne passenden Schlüssel beginnt der Verlauf leer', () async {
      final h = await ScanHistory.load();
      await h.add('alt', BarcodeType.text);
      // Wiederherstellung auf einem anderen Gerät: Schlüssel fehlt.
      FlutterSecureStorage.setMockInitialValues({});
      final restored = await ScanHistory.load();
      expect(restored.entries, isEmpty);
      await restored.add('neu', BarcodeType.text);
      final again = await ScanHistory.load();
      expect(again.entries.map((e) => e.raw), ['neu']);
    });
  });
}
