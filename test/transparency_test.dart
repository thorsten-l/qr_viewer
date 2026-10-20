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
import 'package:qr_viewer/content_actions.dart';
import 'package:qr_viewer/qr_content.dart';
import 'package:qr_viewer/result_page.dart';

import 'test_app.dart';

/// Erfundene Seriennummer im Format der Amazon-Transparency-Codes.
const _code = 'AZ:QX7K2M9PL4T8VN3RB6WD1HC5JE';

void main() {
  test('AZ: mit Seriennummer wird als Transparency-Code erkannt', () {
    final p = parseContent(_code);
    expect(p.kind, ContentKind.transparency);
    expect(p.fields.single.label, FieldLabel.serialNumber);
    expect(p.fields.single.value, 'QX7K2M9PL4T8VN3RB6WD1HC5JE');
  });

  test('Transparency-Code bietet keine Aktion an', () {
    final p = parseContent(_code);
    expect(contentAction(p, _code), isNull);
  });

  test('Ähnliche Texte bleiben Text', () {
    for (final s in [
      'AZ: 12345678901234567890', // Leerzeichen, z. B. Aktenzeichen
      'AZ:12345', // zu kurz
      'AZ:QX7K2M9PL4T8VN3RB6WD1HC5JE-1', // Sonderzeichen
      'az:QX7K2M9PL4T8VN3RB6WD1HC5JE', // Präfix klein
    ]) {
      expect(parseContent(s).kind, ContentKind.text, reason: s);
    }
  });

  testWidgets('Ergebnisseite zeigt die Karte ohne Aktionsknopf', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: _code,
          type: BarcodeType.text,
          format: BarcodeFormat.dataMatrix,
        ),
      ),
    );
    expect(find.text('Amazon-Transparency-Code'), findsWidgets);
    expect(find.text('Seriennummer'), findsOneWidget);
    expect(find.text('QX7K2M9PL4T8VN3RB6WD1HC5JE'), findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);
  });
}
