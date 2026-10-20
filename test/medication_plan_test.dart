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

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/binary_payload.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/history_crypto.dart';
import 'package:qr_viewer/medication_plan.dart';
import 'package:qr_viewer/qr_content.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

/// Erfundener Medikationsplan im BMP-Format (keine echten Daten).
const _plan =
    '<MP v="027" U="0123456789ABCDEF0123456789ABCDEF" l="de-DE">'
    '<P g="Max" f="Müller" b="19500101"/>'
    '<A n="Praxis Muster" s="Hauptstr. 1" z="12345" c="Musterstadt" '
    't="20261019"/><S><M p="12345678" m="1" du="1"/></S></MP>';

/// Erfundener, vollständigerer Plan mit allen Bausteinen der Spezifikation.
const _fullPlan =
    '<MP v="028" U="0123456789ABCDEF0123456789ABCDEF" l="de-DE" a="1" z="2">'
    '<P g="Erika" f="Beispiel" t="Dr." b="19600315" s="W"/>'
    '<A n="Praxis Sonnenschein" s="Lindenweg 3" z="38300" c="Wolfenbüttel" '
    'p="05331 123" t="2026-10-19T09:30:00"/>'
    '<O ai="Penicillin" w="70" x="Zeile 1~Zeile 2"/>'
    '<S><M f="TAB" m="1" v="1/2" du="1" i="zum Essen" r="Blutdruck">'
    '<W w="Ramipril" s="5 mg"/></M>'
    '<M p="1234567" m="1" du="1"/></S>'
    '<S c="425"><M a="Methotrexat Muster" wo="1" m="1" du="1" '
    'r="Rheuma"/></S>'
    '<S t="Akut &amp; kurzfristig"><M a="Schmerzmittel" t="max. 3x täglich" '
    'du="1" x="nur bei Bedarf"/><X t="Viel trinken"/>'
    '<R t="Salbe nach Rezeptur" x="2x täglich"/></S></MP>';

void main() {
  group('parseMedicationPlan', () {
    test('liest Patient, Ersteller, Parameter und Blöcke', () {
      final plan = parseMedicationPlan(_fullPlan)!;
      expect(plan.patientName, 'Dr. Erika Beispiel');
      expect(plan.birthDate, DateTime(1960, 3, 15));
      expect(plan.author['n'], 'Praxis Sonnenschein');
      expect(plan.authorAddress, 'Lindenweg 3, 38300 Wolfenbüttel');
      expect(plan.printedAt, DateTime(2026, 10, 19, 9, 30));
      expect(plan.parameters['ai'], 'Penicillin');
      expect(plan.root['a'], '1');
      expect(plan.sections.map((s) => s.title), [
        null,
        'Wöchentliche Anwendung',
        'Akut & kurzfristig',
      ]);
    });

    test('Medikamente: Name, Form, Schema, Einheit, Wochentag', () {
      final plan = parseMedicationPlan(_fullPlan)!;
      final first = plan.sections[0].entries[0] as PlanMedication;
      expect(first.name, 'Ramipril 5 mg');
      expect(first.form, 'Tabl');
      expect(first.scheme, '1-0-1/2-0');
      expect(first.unit, 'Stück');
      expect(first['i'], 'zum Essen');
      final pznOnly = plan.sections[0].entries[1] as PlanMedication;
      expect(pznOnly.name, isNull);
      expect(pznOnly.pzn, '1234567');
      final weekly = plan.sections[1].entries.single as PlanMedication;
      expect(weekly.weekday, 1);
      final free = plan.sections[2].entries[0] as PlanMedication;
      expect(free.scheme, 'max. 3x täglich');
      expect(free['x'], 'nur bei Bedarf');
      final text = plan.sections[2].entries[1] as PlanText;
      expect(text.text, 'Viel trinken');
      final recipe = plan.sections[2].entries[2] as PlanText;
      expect(recipe.recipe, isTrue);
      expect(recipe.extra, '2x täglich');
    });

    test('Tilde wird zum Zeilenumbruch, kein Plan ergibt null', () {
      final plan = parseMedicationPlan(_fullPlan)!;
      expect(planText(plan.parameters['x']!), 'Zeile 1\nZeile 2');
      expect(parseMedicationPlan('<html></html>'), isNull);
    });
  });

  testWidgets('Karte zeigt Patient, Blöcke und Dosierung', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: _fullPlan,
          type: BarcodeType.text,
          format: BarcodeFormat.dataMatrix,
        ),
      ),
    );
    expect(find.text('Dr. Erika Beispiel'), findsOneWidget);
    expect(find.text('Seite 1 von 2'), findsOneWidget);
    expect(find.text('Wöchentliche Anwendung'), findsOneWidget);
    expect(find.text('Ramipril 5 mg'), findsOneWidget);
    expect(find.text('PZN 1234567'), findsOneWidget);
    expect(
      find.textContaining('Montag: 1-0-0-0 Stück', findRichText: true),
      findsOneWidget,
    );
    // Kopier-Knopf nur bei Einträgen mit PZN; er kopiert nur die PZN.
    final copy = find.byTooltip('PZN kopieren');
    expect(copy, findsOneWidget);
    String? clipboard;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          clipboard = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    await tester.ensureVisible(copy);
    await tester.tap(copy);
    await tester.pump();
    expect(clipboard, '1234567');
    // Der Rohinhalt ist eingeklappt.
    expect(find.text(_fullPlan), findsNothing);
  });

  test('BMP-XML wird als Medikationsplan erkannt', () {
    expect(isMedicationPlan(_plan), isTrue);
    expect(isMedicationPlan('<?xml version="1.0"?>\n$_plan'), isTrue);
    for (final s in ['<MPX v="1"/>', '<MP/>', 'MP v="027"', '<html>']) {
      expect(isMedicationPlan(s), isFalse, reason: s);
    }
  });

  test(
    'Medikationsplan kommt nicht in den Verlauf, auch als Binärdaten',
    () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
      final history = await ScanHistory.load();
      await history.add(
        _plan,
        BarcodeType.text,
        format: BarcodeFormat.dataMatrix,
      );
      await history.add(
        toHex(latin1.encode(_plan)),
        BarcodeType.text,
        format: BarcodeFormat.dataMatrix,
        binary: true,
      );
      expect(history.entries, isEmpty);
      await history.add('Hallo', BarcodeType.text);
      expect(history.entries, hasLength(1));
    },
  );

  test(
    'Ein alter Verlauf mit Medikationsplan wird beim Laden bereinigt',
    () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
      final cipher = HistoryCipher((await loadHistoryKey())!);
      final time = DateTime(2026, 10, 19).toIso8601String();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'scan_history_v2',
        cipher.encrypt(
          jsonEncode([
            {
              'raw': _plan,
              'type': 'text',
              'format': 'dataMatrix',
              'time': time,
            },
            {'raw': 'Hallo', 'type': 'text', 'format': 'qrCode', 'time': time},
          ]),
        ),
      );
      final history = await ScanHistory.load();
      expect(history.entries.map((e) => e.raw), ['Hallo']);
      // Auch gespeichert ist der Plan nicht mehr.
      expect(
        cipher.decrypt(prefs.getString('scan_history_v2')!),
        isNot(contains('<MP')),
      );
    },
  );

  testWidgets('Ergebnisseite zeigt Titel und Hinweis', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: _plan,
          type: BarcodeType.text,
          format: BarcodeFormat.dataMatrix,
        ),
      ),
    );
    // Seitentitel und Kartentitel.
    expect(find.text('Medikationsplan'), findsNWidgets(2));
    expect(
      find.text(
        'Medikationspläne enthalten Gesundheitsdaten und werden nicht im '
        'Verlauf gespeichert.',
      ),
      findsOneWidget,
    );
  });
}
