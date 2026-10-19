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
import 'package:qr_viewer/result_page.dart';
import 'package:qr_viewer/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  test('Aktionen sind standardmäßig aus und werden gespeichert', () async {
    SharedPreferences.setMockInitialValues({});
    final settings = await AppSettings.load();
    expect(settings.actionsEnabled, isFalse);
    await settings.setActionsEnabled(true);
    expect((await AppSettings.load()).actionsEnabled, isTrue);
  });

  test('Scannen von Foto: standardmäßig aus, wird gespeichert', () async {
    SharedPreferences.setMockInitialValues({});
    final settings = await AppSettings.load();
    expect(settings.scanFromPhoto, isFalse);
    await settings.setScanFromPhoto(true);
    expect((await AppSettings.load()).scanFromPhoto, isTrue);
  });

  testWidgets('Scannen von Foto lässt sich einschalten', (tester) async {
    final settings = AppSettings();
    await tester.pumpWidget(testApp(const SettingsPage(), settings: settings));
    await tester.tap(find.text('Scannen von Foto'));
    await tester.pump();
    expect(settings.scanFromPhoto, isTrue);
  });

  testWidgets('Ohne Aktionen: kein Öffnen, Host und Kopieren bleiben', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(raw: 'https://example.org', type: BarcodeType.url),
        settings: AppSettings(),
      ),
    );
    expect(find.text('Öffnen …'), findsNothing);
    expect(find.text('Host: example.org'), findsOneWidget);
    expect(find.text('Kopieren'), findsOneWidget);
  });

  testWidgets('Schalter auf der Einstellungsseite blendet Aktionen ein', (
    tester,
  ) async {
    final settings = AppSettings();
    await tester.pumpWidget(
      testApp(
        const Column(
          children: [
            Expanded(child: SettingsPage()),
            Expanded(
              child: ResultPage(raw: 'tel:+495311234', type: BarcodeType.phone),
            ),
          ],
        ),
        settings: settings,
      ),
    );
    expect(find.byType(FilledButton), findsNothing);
    await tester.tap(find.text('Aktionen aktivieren'));
    await tester.pump();
    expect(settings.actionsEnabled, isTrue);
    expect(find.byType(FilledButton), findsOneWidget);
  });
}
