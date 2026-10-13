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
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_viewer/app_info.dart';
import 'package:qr_viewer/result_page.dart';

import 'test_app.dart';

Widget _wrap(Widget child) => testApp(child);

void main() {
  testWidgets('URL-Ergebnis zeigt Host und Öffnen-Button', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const ResultPage(
          raw: 'https://www.ostfalia.de/pfad?x=1',
          type: BarcodeType.url,
        ),
      ),
    );

    expect(find.text('URL'), findsOneWidget);
    expect(find.text('Host: www.ostfalia.de'), findsOneWidget);
    expect(find.text('https://www.ostfalia.de/pfad?x=1'), findsOneWidget);
    expect(find.text('Kopieren'), findsOneWidget);
    expect(find.text('Öffnen …'), findsOneWidget);
  });

  testWidgets('Öffnen fragt per Dialog nach und lässt sich abbrechen', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const ResultPage(raw: 'https://example.org', type: BarcodeType.url),
      ),
    );

    await tester.tap(find.text('Öffnen …'));
    await tester.pumpAndSettle();

    expect(find.text('Link öffnen?'), findsOneWidget);
    await tester.tap(find.text('Abbrechen'));
    await tester.pumpAndSettle();
    expect(find.text('Link öffnen?'), findsNothing);
  });

  testWidgets('Reiner Text bietet kein Öffnen an', (tester) async {
    await tester.pumpWidget(
      _wrap(const ResultPage(raw: 'Hallo Welt', type: BarcodeType.text)),
    );

    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Hallo Welt'), findsOneWidget);
    expect(find.text('Kopieren'), findsOneWidget);
    expect(find.text('Öffnen …'), findsNothing);
    expect(find.textContaining('Host:'), findsNothing);
  });

  testWidgets('javascript:-Schema wird nicht als Link behandelt', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const ResultPage(raw: 'javascript:alert(1)', type: BarcodeType.url),
      ),
    );

    expect(find.text('Öffnen …'), findsNothing);
  });

  testWidgets('Info-Dialog zeigt Name, Version und Build-Datum', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        AppInfoDialog(
          info: PackageInfo(
            appName: 'QR Viewer',
            packageName: 'de.l9g.qr_viewer',
            version: '1.0.0',
            buildNumber: '1',
          ),
          buildDate: DateTime(2026, 10, 8, 14, 5),
        ),
      ),
    );

    expect(find.text('Thorsten Ludewig'), findsOneWidget);
    expect(find.text('1.0.0 (Build 1)'), findsOneWidget);
    expect(find.text('Build-Datum'), findsOneWidget);
    expect(find.text('8.10.2026 14:05'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Support'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Lizenzen'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Anleitungen'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Schließen'), findsOneWidget);
    expect(find.byIcon(Icons.link), findsOneWidget);
  });

  testWidgets('Ohne Build-Datum wird der Installationszeitpunkt gezeigt', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        AppInfoDialog(
          info: PackageInfo(
            appName: 'QR Viewer',
            packageName: 'de.l9g.qr_viewer',
            version: '1.0.0',
            buildNumber: '1',
            updateTime: DateTime(2026, 10, 7, 9, 30),
          ),
        ),
      ),
    );

    expect(find.text('Installiert am'), findsOneWidget);
    expect(find.text('7.10.2026 09:30'), findsOneWidget);
  });

  testWidgets('QR-Inhalt wird in Source Code Pro in 20 pt angezeigt', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(const ResultPage(raw: 'Hallo Welt', type: BarcodeType.text)),
    );

    final text = tester.widget<SelectableText>(
      find.widgetWithText(SelectableText, 'Hallo Welt'),
    );
    expect(text.style?.fontFamily, kContentFont);
    expect(kContentFont, 'SourceCodePro');
    expect(text.style?.fontSize, 20);
  });
}
