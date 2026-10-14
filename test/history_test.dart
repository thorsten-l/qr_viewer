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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('ScanHistory', () {
    test('behält nur die letzten 25, neueste zuerst', () async {
      final h = await ScanHistory.load();
      for (var i = 1; i <= 27; i++) {
        await h.add('inhalt $i', BarcodeType.text);
      }
      expect(h.entries.length, 25);
      expect(h.entries.first.raw, 'inhalt 27');
      expect(h.entries.last.raw, 'inhalt 3');
    });

    test(
      'gleicher Inhalt wird nach oben verschoben statt verdoppelt',
      () async {
        final h = await ScanHistory.load();
        await h.add('a', BarcodeType.text);
        await h.add('b', BarcodeType.text);
        await h.add('a', BarcodeType.text);
        expect(h.entries.map((e) => e.raw), ['a', 'b']);
      },
    );

    test('bleibt nach erneutem Laden erhalten', () async {
      final h = await ScanHistory.load();
      final t = DateTime(2026, 10, 9, 8, 15);
      await h.add('https://example.org', BarcodeType.url, time: t);

      final again = await ScanHistory.load();
      expect(again.entries.single.raw, 'https://example.org');
      expect(again.entries.single.type, BarcodeType.url);
      expect(again.entries.single.time, t);
    });

    test('beschädigte Daten ergeben einen leeren Verlauf', () async {
      FlutterSecureStorage.setMockInitialValues({});
      SharedPreferences.setMockInitialValues({'scan_history_v1': '{kaputt'});
      final h = await ScanHistory.load();
      expect(h.entries, isEmpty);
    });

    test('2FA-Schlüssel werden nicht gespeichert', () async {
      final h = await ScanHistory.load();
      await h.add(
        'otpauth://totp/ACME:jo?secret=JBSWY3DPEHPK3PXP',
        BarcodeType.text,
      );
      await h.add('otpauth://totp/kaputt', BarcodeType.text);
      expect(h.entries.map((e) => e.raw), ['otpauth://totp/kaputt']);
    });

    test('einzeln löschen und wiederherstellen', () async {
      final h = await ScanHistory.load();
      for (final t in ['a', 'b', 'c']) {
        await h.add(t, BarcodeType.text);
      }
      final b = h.entries[1];
      expect(await h.remove(b), 1);
      expect(h.entries.map((e) => e.raw), ['c', 'a']);
      expect((await ScanHistory.load()).entries.length, 2);
      await h.restore(1, b);
      expect(h.entries.map((e) => e.raw), ['c', 'b', 'a']);
      expect(await h.remove(b), 1);
      expect(await h.remove(b), -1);
    });

    test('CSV nach RFC 4180 und JSON', () async {
      final h = await ScanHistory.load();
      final t = DateTime.utc(2026, 10, 11, 9);
      await h.add('Zeile 1\n"zwei", drei', BarcodeType.text, time: t);
      await h.add(
        '9E8180',
        BarcodeType.text,
        format: BarcodeFormat.aztec,
        binary: true,
        time: t,
      );
      expect(
        historyCsv(h.entries),
        'time,format,type,binary,content\r\n'
        '2026-10-11T09:00:00.000Z,aztec,text,true,9E 81 80\r\n'
        '2026-10-11T09:00:00.000Z,qrCode,text,false,'
        '"Zeile 1\n""zwei"", drei"\r\n',
      );
      expect(historyJson(h.entries), contains('"binary": true'));
    });

    test('löschen leert Verlauf und Speicher', () async {
      final h = await ScanHistory.load();
      await h.add('x', BarcodeType.text);
      await h.clear();
      expect(h.entries, isEmpty);
      expect((await ScanHistory.load()).entries, isEmpty);
    });
  });

  group('HistoryPage', () {
    Future<ScanHistory> pumpPage(WidgetTester tester) async {
      final h = await ScanHistory.load();
      await h.add('Hallo Welt', BarcodeType.text);
      await h.add('https://example.org', BarcodeType.url);
      await tester.pumpWidget(testApp(HistoryPage(history: h)));
      return h;
    }

    testWidgets('zeigt leeren Zustand', (tester) async {
      final h = await ScanHistory.load();
      await tester.pumpWidget(testApp(HistoryPage(history: h)));
      expect(find.text('Noch keine gescannten Inhalte.'), findsOneWidget);
      expect(find.byTooltip('Verlauf löschen'), findsNothing);
    });

    testWidgets('listet Einträge, neueste zuerst', (tester) async {
      await pumpPage(tester);
      final tiles = tester.widgetList<ListTile>(find.byType(ListTile)).toList();
      expect(tiles.length, 2);
      expect((tiles[0].title as Text).data, 'https://example.org');
      expect((tiles[1].title as Text).data, 'Hallo Welt');
    });

    testWidgets('Kopieren legt den Inhalt in die Zwischenablage', (
      tester,
    ) async {
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
      await pumpPage(tester);

      await tester.tap(find.byTooltip('Kopieren').last);
      await tester.pump();
      expect(copied, 'Hallo Welt');
      expect(find.text('In die Zwischenablage kopiert'), findsOneWidget);
    });

    testWidgets('Antippen öffnet die Ergebnisansicht', (tester) async {
      await pumpPage(tester);
      await tester.tap(find.text('https://example.org'));
      await tester.pumpAndSettle();
      expect(find.byType(ResultPage), findsOneWidget);
      expect(find.text('Host: example.org'), findsOneWidget);
    });

    testWidgets('Wischen löscht einen Eintrag, Rückgängig holt ihn zurück', (
      tester,
    ) async {
      final h = await pumpPage(tester);
      await tester.drag(find.text('Hallo Welt'), const Offset(-600, 0));
      await tester.pumpAndSettle();
      expect(h.entries.map((e) => e.raw), ['https://example.org']);
      expect(find.text('Eintrag gelöscht'), findsOneWidget);
      await tester.tap(find.text('Rückgängig'));
      await tester.pumpAndSettle();
      expect(h.entries.map((e) => e.raw), [
        'https://example.org',
        'Hallo Welt',
      ]);
      expect(find.text('Hallo Welt'), findsOneWidget);
    });

    testWidgets('Suche filtert nach Inhalt und Typ', (tester) async {
      await pumpPage(tester);
      await tester.tap(find.byTooltip('Verlauf durchsuchen'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'hallo');
      await tester.pump();
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Hallo Welt'), findsWidgets);
      await tester.enterText(find.byType(TextField), 'URL');
      await tester.pump();
      expect(find.text('https://example.org'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pump();
      expect(find.text('Keine Treffer'), findsOneWidget);
      await tester.tap(find.byTooltip('Verlauf durchsuchen'));
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Export bietet CSV und JSON an', (tester) async {
      await pumpPage(tester);
      await tester.tap(find.byTooltip('Exportieren'));
      await tester.pumpAndSettle();
      expect(find.text('Als CSV teilen'), findsOneWidget);
      expect(find.text('Als JSON teilen'), findsOneWidget);
    });

    testWidgets('Verlauf löschen fragt nach und leert die Liste', (
      tester,
    ) async {
      final h = await pumpPage(tester);
      await tester.tap(find.byTooltip('Verlauf löschen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Löschen'));
      await tester.pumpAndSettle();
      expect(h.entries, isEmpty);
      expect(find.text('Noch keine gescannten Inhalte.'), findsOneWidget);
    });
  });
}
