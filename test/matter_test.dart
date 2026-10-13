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

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/matter.dart';
import 'package:qr_viewer/qr_content.dart';
import 'package:qr_viewer/result_page.dart';

import 'test_app.dart';

/// Beispiel aus der Matter-Spezifikation (Test-Hersteller 0xFFF1).
const specExample = 'MT:Y.K9042C00KA0648G00';

/// Baut einen Matter-Code wie ein Gerätehersteller; nur für Tests.
String encodeMatter({
  int version = 0,
  required int vendorId,
  required int productId,
  int flow = 0,
  int discovery = 2,
  required int discriminator,
  required int passcode,
}) {
  final bytes = List<int>.filled(11, 0);
  var offset = 0;
  void put(int value, int count) {
    for (var i = 0; i < count; i++) {
      if ((value >> i) & 1 == 1) {
        bytes[(offset + i) >> 3] |= 1 << ((offset + i) & 7);
      }
    }
    offset += count;
  }

  put(version, 3);
  put(vendorId, 16);
  put(productId, 16);
  put(flow, 2);
  put(discovery, 8);
  put(discriminator, 12);
  put(passcode, 27);
  const alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-.';
  final out = StringBuffer('MT:');
  for (var i = 0; i < bytes.length; i += 3) {
    final chunk = bytes.sublist(i, i + 3 > bytes.length ? bytes.length : i + 3);
    var v = 0;
    for (var j = chunk.length - 1; j >= 0; j--) {
      v = (v << 8) | chunk[j];
    }
    final chars = switch (chunk.length) {
      3 => 5,
      2 => 4,
      _ => 2,
    };
    for (var c = 0; c < chars; c++) {
      out.write(alphabet[v % 38]);
      v ~/= 38;
    }
  }
  return out.toString();
}

void main() {
  group('Matter-Code lesen', () {
    test('Beispiel der Spezifikation', () {
      final m = parseMatter(specExample)!;
      expect(m.vendorId, 0xFFF1);
      expect(m.productId, 0x8000);
      expect(m.flow, MatterFlow.standard);
      expect(m.discovery, {MatterDiscovery.ble});
      expect(m.discriminator, 3840);
      expect(m.passcode, 20202021);
      expect(m.devices, 1);
      expect(m.manualCode, '3497-011-2332');
    });

    test('Kodierer im Test ergibt dasselbe wie die Spezifikation', () {
      expect(
        encodeMatter(
          vendorId: 0xFFF1,
          productId: 0x8000,
          discriminator: 3840,
          passcode: 20202021,
        ),
        specExample,
      );
    });

    test('Hersteller-Ablauf: langer Kopplungscode mit IDs', () {
      final m = parseMatter(
        encodeMatter(
          vendorId: 0xFFF1,
          productId: 0x8000,
          flow: 2,
          discovery: 5,
          discriminator: 3840,
          passcode: 20202021,
        ),
      )!;
      expect(m.flow, MatterFlow.custom);
      expect(m.discovery, {MatterDiscovery.softAp, MatterDiscovery.onNetwork});
      expect(m.manualCode, '7497-011-2336-55213-27687');
    });

    test('Prüfziffer nach Verhoeff', () {
      expect(verhoeffCheckDigit('3497011233'), 2);
      expect(verhoeffCheckDigit('236'), 3);
    });

    test('mehrere Geräte in einem Code', () {
      final m = parseMatter('$specExample*Y.K9042C00KA0648G00')!;
      expect(m.devices, 2);
      expect(m.passcode, 20202021);
    });

    test('Kleinbuchstaben im Präfix werden erkannt', () {
      expect(parseMatter('mt:Y.K9042C00KA0648G00'), isNotNull);
    });

    test('ungültige Codes', () {
      expect(parseMatter('MT:'), isNull);
      expect(parseMatter('MT:ABC'), isNull);
      expect(parseMatter('MT:Y.K9042C00KA0648G0!'), isNull);
      expect(parseMatter('XT:Y.K9042C00KA0648G00'), isNull);
      // Version ungleich 0
      expect(
        parseMatter(
          encodeMatter(
            version: 1,
            vendorId: 1,
            productId: 1,
            discriminator: 1,
            passcode: 20202021,
          ),
        ),
        isNull,
      );
      // Verbotener Passcode
      expect(
        parseMatter(
          encodeMatter(
            vendorId: 1,
            productId: 1,
            discriminator: 1,
            passcode: 12345678,
          ),
        ),
        isNull,
      );
    });
  });

  group('Inhaltserkennung', () {
    test('MT: wird als Matter-Gerät erkannt', () {
      final p = parseContent(specExample);
      expect(p.kind, ContentKind.matter);
      expect(p[FieldLabel.manualCode], '3497-011-2332');
      expect(p[FieldLabel.setupCode], '20202021');
      expect(p[FieldLabel.vendorId], '0xFFF1 (65521)');
      expect(p[FieldLabel.productId], '0x8000 (32768)');
      expect(p[FieldLabel.discriminator], '3840');
      expect(p[FieldLabel.discovery], 'ble');
      expect(p[FieldLabel.flow], 'standard');
    });

    test('kaputter Matter-Code bleibt Text', () {
      expect(parseContent('MT:kaputt').kind, ContentKind.text);
    });

    test('Matter-Codes landen im Verlauf', () {
      expect(ScanHistory.shouldStore(specExample), isTrue);
    });
  });

  testWidgets('Ergebnisseite zeigt Matter-Daten übersetzt', (tester) async {
    await tester.pumpWidget(
      testApp(const ResultPage(raw: specExample, type: BarcodeType.text)),
    );
    expect(find.text('Matter-Gerät'), findsWidgets);
    expect(find.text('Manueller Kopplungscode'), findsOneWidget);
    expect(find.text('3497-011-2332'), findsOneWidget);
    expect(find.text('Einrichtungscode (PIN)'), findsOneWidget);
    expect(find.text('20202021'), findsOneWidget);
    expect(find.text('0xFFF1 (65521)'), findsOneWidget);
    expect(find.text('Bluetooth LE'), findsOneWidget);
    expect(find.text('Standard'), findsOneWidget);
  });
}
