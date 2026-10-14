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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_viewer/app_info.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/localization.dart';
import 'package:qr_viewer/main.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:qr_viewer/scan_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  test('13 Sprachen, Englisch zuerst', () {
    expect(kSupportedLocales.map((l) => l.languageCode), [
      'en',
      'ar',
      'de',
      'es',
      'fr',
      'hi',
      'it',
      'ja',
      'pl',
      'pt',
      'ru',
      'uk',
      'zh',
    ]);
  });

  test('Alle ARB-Dateien haben dieselben Schlüssel', () {
    Set<String> keys(String lang) =>
        (jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map)
            .keys
            .cast<String>()
            .where((k) => !k.startsWith('@'))
            .toSet();
    final en = keys('en');
    for (final l in kSupportedLocales) {
      expect(keys(l.languageCode), en, reason: l.languageCode);
    }
  });

  testWidgets('Nicht unterstützte Sprache fällt auf Englisch zurück', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(
        Scaffold(
          appBar: AppBar(
            title: ScanModeMenu(selected: ScanMode.qr, onSelected: (_) {}),
          ),
        ),
        locale: const Locale('nl'),
      ),
    );
    expect(find.text('Scan QR code'), findsOneWidget);
  });

  testWidgets('Arabisch wird von rechts nach links dargestellt', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(raw: 'Hallo', type: BarcodeType.text),
        locale: const Locale('ar'),
      ),
    );
    expect(
      Directionality.of(tester.element(find.byType(SelectableText))),
      TextDirection.rtl,
    );
  });

  for (final locale in kSupportedLocales) {
    final lang = locale.languageCode;
    final l = lookupAppLocalizations(locale);

    group('Sprache $lang', () {
      setUp(() {
        SharedPreferences.setMockInitialValues({});
        FlutterSecureStorage.setMockInitialValues({});
      });

      testWidgets('Scanner-Menü', (tester) async {
        tester.view.physicalSize = const Size(1080, 2340);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          testApp(
            Scaffold(
              appBar: AppBar(
                title: ScanModeMenu(selected: ScanMode.qr, onSelected: (_) {}),
                actions: const [
                  IconButton(onPressed: null, icon: Icon(Icons.history)),
                  IconButton(onPressed: null, icon: Icon(Icons.info_outline)),
                  IconButton(onPressed: null, icon: Icon(Icons.flashlight_on)),
                ],
              ),
            ),
            locale: locale,
          ),
        );
        expect(find.text(ScanMode.qr.title(l)), findsOneWidget);
        await tester.tap(find.text(ScanMode.qr.title(l)));
        await tester.pumpAndSettle();
        for (final m in ScanMode.values) {
          expect(find.text(m.hint(l)), findsOneWidget);
        }
      });

      testWidgets('Ergebnis und Link-Dialog', (tester) async {
        await tester.pumpWidget(
          testApp(
            const ResultPage(
              raw: 'https://example.org/pfad',
              type: BarcodeType.url,
            ),
            locale: locale,
          ),
        );
        expect(find.text(l.typeUrl), findsOneWidget);
        expect(find.text(l.hostLine('example.org')), findsOneWidget);
        await tester.tap(find.text(l.openEllipsis));
        await tester.pumpAndSettle();
        expect(find.text(l.openLinkTitle), findsOneWidget);
      });

      testWidgets('Verlauf', (tester) async {
        final h = await ScanHistory.load();
        await h.add(
          '4006381333931',
          BarcodeType.product,
          format: BarcodeFormat.ean13,
        );
        await tester.pumpWidget(
          testApp(HistoryPage(history: h), locale: locale),
        );
        expect(find.text(l.history), findsOneWidget);
        expect(find.textContaining(l.typeProduct), findsOneWidget);
      });

      testWidgets('Info-Dialog', (tester) async {
        await tester.pumpWidget(
          testApp(
            AppInfoDialog(
              info: PackageInfo(
                appName: 'QR Viewer',
                packageName: 'de.l9g.qr_viewer',
                version: '1.1.0',
                buildNumber: '5',
              ),
              buildDate: DateTime(2026, 10, 9, 8, 30),
            ),
            locale: locale,
          ),
        );
        expect(find.text(l.infoDeveloper), findsOneWidget);
        expect(find.text(l.infoVersionValue('1.1.0', '5')), findsOneWidget);
        expect(find.text(l.infoBuildDate), findsOneWidget);
      });
    });
  }
}
