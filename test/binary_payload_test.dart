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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/binary_payload.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

/// Anfang eines echten VDV-eTicket-Barcodes (Aztec, Deutschlandsemesterticket).
final vdv = Uint8List.fromList([
  0x9e, 0x81, 0x80, 0xd7, 0xa4, 0x72, 0x22, 0x8d, 0x5c, 0xec, 0xfd, 0x6b, //
  0xc8, 0x5a, 0xe5, 0x6b, 0xd7, 0x6a, 0xcc, 0x06, 0xc2, 0x9a, 0xe0, 0xcb,
]);

/// So dekodiert Apple Vision Bytes als Windows-1252-Text.
String asAppleText(List<int> bytes) {
  const cp = {
    0x80: 0x20AC,
    0x82: 0x201A,
    0x83: 0x0192,
    0x84: 0x201E,
    0x85: 0x2026,
    0x86: 0x2020,
    0x87: 0x2021,
    0x88: 0x02C6,
    0x89: 0x2030,
    0x8A: 0x0160,
    0x8B: 0x2039,
    0x8C: 0x0152,
    0x8E: 0x017D,
    0x91: 0x2018,
    0x92: 0x2019,
    0x93: 0x201C,
    0x94: 0x201D,
    0x95: 0x2022,
    0x96: 0x2013,
    0x97: 0x2014,
    0x98: 0x02DC,
    0x99: 0x2122,
    0x9A: 0x0161,
    0x9B: 0x203A,
    0x9C: 0x0153,
    0x9E: 0x017E,
    0x9F: 0x0178,
  };
  return String.fromCharCodes(bytes.map((b) => cp[b] ?? b));
}

void main() {
  group('Erkennung', () {
    test('VDV-Ticket ist binär, Text nicht', () {
      expect(looksBinary(vdv), isTrue);
      expect(looksBinary(utf8.encode('Hallo Welt')), isFalse);
      expect(looksBinary(utf8.encode('Grüße aus Köln')), isFalse);
      expect(looksBinary(latin1.encode('Grüße')), isFalse);
      expect(looksBinary(utf8.encode('Zeile 1\nZeile 2\tTab')), isFalse);
      expect(isVdvTicket(vdv), isTrue);
      expect(isVdvTicket(utf8.encode('abc')), isFalse);
    });

    test('Android: Bytes kommen direkt von ML Kit', () {
      final b = Barcode(
        format: BarcodeFormat.aztec,
        rawValue: latin1.decode(vdv),
        rawDecodedBytes: DecodedBarcodeBytes(bytes: vdv),
      );
      expect(binaryContent(b), vdv);
    });

    test('iOS: Bytes werden aus dem Windows-1252-Text rekonstruiert', () {
      final b = Barcode(
        format: BarcodeFormat.aztec,
        rawValue: asAppleText(vdv),
      );
      expect(bytesFromCp1252(asAppleText(vdv)), vdv);
      expect(binaryContent(b), vdv);
    });

    test('Ohne Text, aber mit Bytes: binär', () {
      final b = Barcode(rawDecodedBytes: DecodedBarcodeBytes(bytes: vdv));
      expect(binaryContent(b), vdv);
    });

    test('Normaler Text bleibt Text', () {
      final text = 'https://example.org/äöü';
      final b = Barcode(
        rawValue: text,
        rawDecodedBytes: DecodedBarcodeBytes(
          bytes: Uint8List.fromList(utf8.encode(text)),
        ),
      );
      expect(binaryContent(b), isNull);
      expect(binaryContent(const Barcode(rawValue: 'Hallo')), isNull);
    });
  });

  group('Hex', () {
    test('Darstellungen und Rückwandlung', () {
      expect(toHex([0x9e, 0x01, 0xff]), '9E01FF');
      expect(toSpacedHex([0x9e, 0x01, 0xff]), '9E 01 FF');
      expect(fromHex('9E01FF'), [0x9e, 0x01, 0xff]);
      expect(fromHex(toHex(vdv)), vdv);
    });

    test('Hex-Dump mit Offset', () {
      expect(
        hexDump(vdv.sublist(0, 10), perLine: 8, text: false),
        '0000  9E 81 80 D7 A4 72 22 8D\n0008  5C EC',
      );
    });

    test('Hex-Dump mit Textspalte, bündig auch in der letzten Zeile', () {
      expect(
        hexDump(vdv.sublist(0, 10), perLine: 8),
        '0000  9E 81 80 D7 A4 72 22 8D  .....r".\n'
        '0008  5C EC                    \\.',
      );
      expect(printableAscii([0x44, 0x45, 0x00, 0x7F, 0x20, 0x7E]), 'DE.. ~');
      expect(hexDumpWidth(8), 39);
      expect(hexDumpWidth(8, text: false), 29);
    });
  });

  testWidgets('Ergebnisansicht zeigt VDV-Ticket als Hex', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    await tester.pumpWidget(
      testApp(
        ResultPage(
          raw: toHex(vdv),
          type: BarcodeType.unknown,
          format: BarcodeFormat.aztec,
          binary: true,
        ),
      ),
    );

    expect(find.text('VDV-eTicket (signiert)'), findsOneWidget);
    expect(find.text('Format: Aztec'), findsOneWidget);
    expect(find.text('Binärdaten · 24 Bytes'), findsOneWidget);
    // Kurzes Fragment: kein Schlüssel ableitbar, Hex steht im Klappbereich.
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rohdaten (Hex)'));
    await tester.pumpAndSettle();
    expect(find.textContaining('0000  9E 81 80 D7'), findsOneWidget);
    expect(find.text('Öffnen …'), findsNothing);

    await tester.tap(find.text('Kopieren'));
    await tester.pump();
    expect(copied, toSpacedHex(vdv));
  });

  group('Verlauf', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('Binäreinträge bleiben nach dem Laden binär', () async {
      final h = await ScanHistory.load();
      await h.add(
        toHex(vdv),
        BarcodeType.unknown,
        format: BarcodeFormat.aztec,
        binary: true,
      );
      await h.add('Text', BarcodeType.text);
      final again = await ScanHistory.load();
      expect(again.entries.map((e) => e.binary), [false, true]);
      expect(again.entries.last.raw, toHex(vdv));
    });

    testWidgets('Verlaufsliste zeigt Hex und Ticket-Typ', (tester) async {
      final h = await ScanHistory.load();
      await h.add(
        toHex(vdv),
        BarcodeType.unknown,
        format: BarcodeFormat.aztec,
        binary: true,
      );
      await tester.pumpWidget(testApp(HistoryPage(history: h)));
      expect(find.textContaining('9E 81 80 D7'), findsOneWidget);
      expect(
        find.textContaining('Aztec · VDV-eTicket (signiert)'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.memory), findsOneWidget);
    });
  });
}
