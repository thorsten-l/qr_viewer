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
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/localization.dart';
import 'package:qr_viewer/main.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:qr_viewer/scan_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  group('ScanMode', () {
    test('unbekannter oder fehlender Name ergibt QR-Code', () {
      expect(ScanMode.fromName(null), ScanMode.qr);
      expect(ScanMode.fromName('gibtsnicht'), ScanMode.qr);
      expect(ScanMode.fromName('barcode'), ScanMode.barcode);
    });

    test('Formate je Scan-Art', () {
      expect(ScanMode.qr.formats, [BarcodeFormat.qrCode]);
      expect(ScanMode.barcode.formats, contains(BarcodeFormat.ean13));
      expect(ScanMode.barcode.formats, isNot(contains(BarcodeFormat.qrCode)));
      expect(ScanMode.all.formats, isEmpty);
      final de = lookupAppLocalizations(const Locale('de'));
      expect(ScanMode.qr.title(de), 'QR-Code scannen');
    });

    test('Formatnamen', () {
      final de = lookupAppLocalizations(const Locale('de'));
      expect(formatLabel(BarcodeFormat.ean13, de), 'EAN-13');
      expect(formatLabel(BarcodeFormat.dataMatrix, de), 'Data Matrix');
      expect(formatLabel(BarcodeFormat.unknown, de), 'Unbekannt');
    });
  });

  testWidgets('Menü zeigt alle Scan-Arten und meldet die Auswahl', (
    tester,
  ) async {
    ScanMode? chosen;
    await tester.pumpWidget(
      testApp(
        Scaffold(
          appBar: AppBar(
            title: ScanModeMenu(
              selected: ScanMode.qr,
              onSelected: (m) => chosen = m,
            ),
          ),
        ),
      ),
    );

    expect(find.text('QR-Code scannen'), findsOneWidget);
    await tester.tap(find.text('QR-Code scannen'));
    await tester.pumpAndSettle();
    final l = lookupAppLocalizations(const Locale('de'));
    for (final m in ScanMode.values) {
      expect(find.text(m.label(l)), findsOneWidget);
    }
    await tester.tap(find.text('Barcode'));
    await tester.pumpAndSettle();
    expect(chosen, ScanMode.barcode);
  });

  testWidgets('Ergebnis zeigt Format und Typ eines Barcodes', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: '4006381333931',
          type: BarcodeType.product,
          format: BarcodeFormat.ean13,
        ),
      ),
    );
    expect(find.text('Produktcode'), findsOneWidget);
    expect(find.text('Format: EAN-13'), findsOneWidget);
    expect(find.text('Öffnen …'), findsNothing);
  });

  group('Verlauf mit Format', () {
    test('Format wird gespeichert', () async {
      SharedPreferences.setMockInitialValues({});
      final h = await ScanHistory.load();
      await h.add(
        '4006381333931',
        BarcodeType.product,
        format: BarcodeFormat.ean13,
      );
      final again = await ScanHistory.load();
      expect(again.entries.single.format, BarcodeFormat.ean13);
    });

    test('Einträge aus Version 1.0 ohne Format gelten als QR-Code', () async {
      SharedPreferences.setMockInitialValues({
        'scan_history_v1': jsonEncode([
          {'raw': 'alt', 'type': 'text', 'time': '2026-10-09T07:00:00.000'},
        ]),
      });
      final h = await ScanHistory.load();
      expect(h.entries.single.raw, 'alt');
      expect(h.entries.single.format, BarcodeFormat.qrCode);
    });
  });
}
