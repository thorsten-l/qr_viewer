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
import 'package:qr_viewer/binary_payload.dart';
import 'package:qr_viewer/content_actions.dart';
import 'package:qr_viewer/deutsche_post.dart';
import 'package:qr_viewer/gtin.dart';
import 'package:qr_viewer/localization.dart';
import 'package:qr_viewer/qr_content.dart';
import 'package:qr_viewer/result_page.dart';

import 'test_app.dart';

ActionTarget? action(
  String raw, {
  TargetPlatform platform = TargetPlatform.android,
  bool product = false,
}) => contentAction(parseContent(raw, productCode: product), raw, platform);

/// Post-Matrixcode mit bekannten Bytes; die Sendungsnummer ist mit dem
/// Verfahren aus BinaryEye nachgerechnet.
final stampBytes = fromHex('444541351F010203040A0B0C0D0E${'00' * 33}');

void main() {
  group('Aktionen', () {
    test('Link öffnen, auch ohne Schema', () {
      final a = action('https://example.com/a?b=1')!;
      expect(a.action, ContentAction.open);
      expect(a.uri.toString(), 'https://example.com/a?b=1');
      expect(
        action('example.com/pfad')!.uri.toString(),
        'https://example.com/pfad',
      );
    });

    test('E-Mail mit Betreff und Text, Leerzeichen als %20', () {
      final a = action('mailto:a@b.de?subject=Hallo Welt&body=x+y')!;
      expect(a.action, ContentAction.email);
      expect(a.uri.toString(), 'mailto:a@b.de?subject=Hallo%20Welt&body=x%2By');
      expect(
        action('MATMSG:TO:a@b.de;SUB:Hi;BODY:Text;;')!.uri.toString(),
        'mailto:a@b.de?subject=Hi&body=Text',
      );
    });

    test('Telefon öffnet den Wähler ohne Leerzeichen', () {
      final a = action('tel:+49 531 1234')!;
      expect(a.action, ContentAction.call);
      expect(a.uri.toString(), 'tel:+495311234');
    });

    test('SMS: iOS mit &body=, Android mit ?body=', () {
      const raw = 'SMSTO:+491701234567:Hallo du';
      expect(action(raw)!.uri.toString(), 'sms:+491701234567?body=Hallo%20du');
      expect(
        action(raw, platform: TargetPlatform.iOS)!.uri.toString(),
        'sms:+491701234567&body=Hallo%20du',
      );
      expect(action('sms:+4912345')!.uri.toString(), 'sms:+4912345');
    });

    test('Ort: Apple Karten unter iOS, geo: unter Android', () {
      const raw = 'geo:52.26,10.52?q=Ostfalia';
      expect(
        action(raw)!.uri.toString(),
        'geo:52.26,10.52?q=52.26,10.52(Ostfalia)',
      );
      final ios = action(raw, platform: TargetPlatform.iOS)!.uri!;
      expect(ios.host, 'maps.apple.com');
      expect(ios.queryParameters, {'ll': '52.26,10.52', 'q': 'Ostfalia'});
    });

    test('2FA gibt den Original-Link an die Authenticator-App', () {
      const raw = 'otpauth://totp/ACME:jo@acme.de?secret=JBSWY3DPEHPK3PXP';
      final a = action(raw)!;
      expect(a.action, ContentAction.otp);
      expect(a.uri.toString(), raw);
    });

    test('Produkt und Buch nachschlagen', () {
      final p = action('4006381333931', product: true)!;
      expect(p.action, ContentAction.lookUp);
      expect(p.uri!.host, 'duckduckgo.com');
      expect(p.uri!.queryParameters['q'], '4006381333931');
      expect(
        action('9783161484100', product: true)!.uri.toString(),
        'https://openlibrary.org/isbn/9783161484100',
      );
    });

    test('Kontakt und Termin als Datei, Text und WLAN ohne Aktion', () {
      final c = action('MECARD:N:Müller,Jonas;TEL:0531 1;EMAIL:j@m.de;;')!;
      expect(c.action, ContentAction.addContact);
      expect(c.fileName, 'contact.vcf');
      expect(c.mimeType, 'text/vcard');
      final e = action(
        'BEGIN:VEVENT\nSUMMARY:Treffen\nDTSTART:20261012T100000\nEND:VEVENT',
      )!;
      expect(e.action, ContentAction.addEvent);
      expect(e.fileName, 'event.ics');
      expect(action('Hallo Welt'), isNull);
      expect(action('WIFI:S:Netz;T:WPA;P:geheim;;'), isNull);
      expect(action('{"a":1}'), isNull);
    });
  });

  group('vCard und iCalendar', () {
    test('MECARD wird zur vCard 3.0, die sich wieder einlesen lässt', () {
      const raw =
          'MECARD:N:Müller,Jonas;TEL:0531 1;EMAIL:j@m.de;'
          'ADR:,,Hauptstr. 1,Wolfenbüttel,,38302,DE;NOTE:a;b;;';
      final vcf = toVCard(raw, parseContent(raw));
      expect(vcf, startsWith('BEGIN:VCARD\r\nVERSION:3.0\r\n'));
      expect(vcf, contains('N:Müller;Jonas;;;\r\n'));
      expect(vcf, contains('FN:Jonas Müller\r\n'));
      expect(vcf, endsWith('END:VCARD\r\n'));
      final again = parseContent(vcf);
      expect(again.kind, ContentKind.contact);
      expect(again[FieldLabel.name], 'Jonas Müller');
      expect(again[FieldLabel.phone], '0531 1');
      expect(again[FieldLabel.email], 'j@m.de');
    });

    test('echte vCard bleibt erhalten, nur mit CRLF', () {
      const raw = 'BEGIN:VCARD\nVERSION:4.0\nFN:A B\nEND:VCARD';
      expect(
        toVCard(raw, parseContent(raw)),
        'BEGIN:VCARD\r\nVERSION:4.0\r\nFN:A B\r\nEND:VCARD\r\n',
      );
    });

    test('VEVENT wird in VCALENDAR verpackt', () {
      const raw = 'BEGIN:VEVENT\nSUMMARY:Treffen\nEND:VEVENT';
      final ics = toICalendar(raw)!;
      expect(ics, startsWith('BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:'));
      expect(
        ics,
        contains('BEGIN:VEVENT\r\nSUMMARY:Treffen\r\nEND:VEVENT\r\n'),
      );
      expect(ics, endsWith('END:VCALENDAR\r\n'));
      expect(parseContent(ics)[FieldLabel.title], 'Treffen');
      expect(toICalendar('Hallo'), isNull);
    });
  });

  group('Links', () {
    test('umgangssprachliche URLs und URL:-Präfix', () {
      expect(parseContent('example.com/x').kind, ContentKind.url);
      expect(
        parseContent('URL:https://l9g.de')[FieldLabel.link],
        'https://l9g.de',
      );
      expect(parseContent('beispiel.de').kind, ContentKind.url);
    });

    test('keine Fehlerkennung bei Abkürzungen und Zahlen', () {
      for (final t in ['z.B.', '1.5', 'v1.2.3', 'Hallo Welt.de', 'a.b']) {
        expect(parseContent(t).kind, isNot(ContentKind.url), reason: t);
      }
    });

    test('andere Schemata: erlaubt mit // oder bekannt, sonst Text', () {
      expect(linkUri('market://details?id=de.l9g.qr_viewer'), isNotNull);
      expect(linkUri('itms-apps://apps.apple.com/app/id6820565028'), isNotNull);
      expect(linkUri('fido:/1234567890'), isNotNull);
      expect(linkUri('Hinweis:Text'), isNull);
      expect(linkUri('javascript://alert(1)'), isNull);
      expect(linkUri('file:///etc/passwd'), isNull);
      expect(linkUri('intent://x#Intent;end'), isNull);
    });

    test('Tracking-Parameter werden entfernt, andere bleiben', () {
      expect(
        withoutTracking(
          Uri.parse('https://a.de/p?id=7&utm_source=x&fbclid=y#top'),
        ).toString(),
        'https://a.de/p?id=7#top',
      );
      expect(
        withoutTracking(Uri.parse('https://a.de/?utm_medium=x')).toString(),
        'https://a.de/',
      );
      expect(
        withoutTracking(Uri.parse('https://a.de/?q=1')).toString(),
        'https://a.de/?q=1',
      );
    });
  });

  group('JSON', () {
    test('Objekt und Liste werden eingerückt', () {
      final p = parseContent('{"a":1,"b":[true,null]}');
      expect(p.kind, ContentKind.json);
      expect(
        p[FieldLabel.json],
        '{\n  "a": 1,\n  "b": [\n    true,\n    null\n  ]\n}',
      );
      expect(parseContent('[1,2]').kind, ContentKind.json);
      expect(parseContent('{kein json').kind, ContentKind.text);
    });
  });

  group('Artikelnummern', () {
    test('Prüfziffer, UPC-E und Präfix', () {
      expect(gtinValid('4006381333931'), isTrue);
      expect(gtinValid('4006381333932'), isFalse);
      expect(gtinValid('036000291452'), isTrue);
      expect(upcEToUpcA('06543217'), '065100004327');
      expect(gtinValid(upcEToUpcA('06543217')!), isTrue);
      expect(gs1Prefix('4006381333931')!.countries, ['DE']);
      expect(gs1Prefix('9001234567890')!.countries, ['AT']);
      expect(gs1Prefix('2001234567890')!.range, Gs1Range.inStore);
      expect(gs1Prefix('9811234567890')!.range, Gs1Range.coupon);
      expect(flagEmoji('DE'), '🇩🇪');
    });

    test('ISBN und ISSN', () {
      expect(isbn10('9783161484100'), '316148410X');
      expect(isbn10('9790000000001'), isNull);
      expect(issn('9770317847001'), '0317-8471');
    });

    test('Parser: Produkt, Buch, Zeitschrift, nur bei Strichcodes', () {
      final p = parseContent('4006381333931', productCode: true);
      expect(p.kind, ContentKind.product);
      expect(p.fields.map((f) => '$f'), [
        'gtin: 4006381333931',
        'checkDigit: valid',
        'gs1Prefix: 🇩🇪 DE',
      ]);
      final b = parseContent('9783161484100', productCode: true);
      expect(b.kind, ContentKind.book);
      expect(b[FieldLabel.isbn10], '316148410X');
      expect(
        parseContent('9770317847001', productCode: true)[FieldLabel.issn],
        '0317-8471',
      );
      expect(
        parseContent('06543217', productCode: true)[FieldLabel.checkDigit],
        'valid',
      );
      expect(parseContent('4006381333931').kind, ContentKind.text);
    });
  });

  group('Deutsche Post', () {
    test('Sendungsnummer mit CRC-4 und Tracking-Link', () {
      final s = parsePostageStamp(stampBytes)!;
      expect(s.trackingNumber, '0A0B0C0D0EF010203046');
      expect(
        s.trackingUri.toString(),
        'https://www.deutschepost.de/de/s/sendungsverfolgung.html'
        '?piececode=0A0B0C0D0EF010203046',
      );
    });

    test('nur DEA5 mit 47 Bytes', () {
      expect(parsePostageStamp(stampBytes.sublist(0, 46)), isNull);
      expect(parsePostageStamp([0x41, ...stampBytes.skip(1)]), isNull);
    });

    test('nur bei Data Matrix', () {
      final hex = toHex(stampBytes);
      expect(postageStamp(hex, BarcodeFormat.dataMatrix, true), isNotNull);
      expect(postageStamp(hex, BarcodeFormat.qrCode, true), isNull);
    });
  });

  group('Ergebnisansicht', () {
    testWidgets('Telefon bietet Anrufen an', (tester) async {
      await tester.pumpWidget(
        testApp(
          const ResultPage(raw: 'tel:+495311234', type: BarcodeType.phone),
        ),
      );
      expect(find.text('Anrufen…'), findsOneWidget);
      expect(find.byTooltip('Teilen'), findsOneWidget);
    });

    testWidgets('Anrufen fragt vorher nach', (tester) async {
      await tester.pumpWidget(
        testApp(
          const ResultPage(raw: 'tel:+495311234', type: BarcodeType.phone),
        ),
      );
      await tester.tap(find.text('Anrufen…'));
      await tester.pumpAndSettle();
      expect(find.text('Link öffnen?'), findsOneWidget);
      expect(find.text('tel:+495311234'), findsWidgets);
      await tester.tap(find.text('Abbrechen'));
      await tester.pumpAndSettle();
      expect(find.text('Link öffnen?'), findsNothing);
    });

    testWidgets('2FA weist auf fehlenden Verlauf hin', (tester) async {
      await tester.pumpWidget(
        testApp(
          const ResultPage(
            raw: 'otpauth://totp/ACME:jo?secret=JBSWY3DPEHPK3PXP',
            type: BarcodeType.text,
          ),
        ),
      );
      expect(
        find.text('2FA-Codes werden nicht im Verlauf gespeichert.'),
        findsOneWidget,
      );
      expect(find.text('In Authenticator öffnen…'), findsOneWidget);
    });

    testWidgets('Post-Matrixcode zeigt Sendungsnummer und Hex-Dump', (
      tester,
    ) async {
      await tester.pumpWidget(
        testApp(
          ResultPage(
            raw: toHex(stampBytes),
            type: BarcodeType.text,
            format: BarcodeFormat.dataMatrix,
            binary: true,
          ),
        ),
      );
      expect(find.text('Briefmarke (Deutsche Post)'), findsNWidgets(2));
      expect(find.text('0A0B0C0D0EF010203046'), findsOneWidget);
      expect(find.text('Sendung verfolgen…'), findsOneWidget);
      expect(find.textContaining('DEA5'), findsOneWidget);
    });

    testWidgets('JSON eingerückt in Source Code Pro', (tester) async {
      await tester.pumpWidget(
        testApp(const ResultPage(raw: '{"a":1}', type: BarcodeType.text)),
      );
      final text = tester.widget<SelectableText>(
        find.ancestor(
          of: find.text('{\n  "a": 1\n}'),
          matching: find.byType(SelectableText),
        ),
      );
      expect(text.style?.fontFamily, kContentFont);
    });

    testWidgets('Info-Dialog erklärt Produkt und Websuche', (tester) async {
      await tester.pumpWidget(
        testApp(
          const ResultPage(
            raw: '4006381333931',
            type: BarcodeType.product,
            format: BarcodeFormat.ean13,
          ),
        ),
      );
      await tester.tap(find.byTooltip('Was sind das für Daten?'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Die Artikelnummer aus dem Barcode'),
        findsOne,
      );
      expect(find.textContaining('nur auf deinem Gerät'), findsOne);
      expect(
        find.textContaining(
          'Tippst du auf „Online nachschlagen“, öffnet dein Browser die '
          'Website duckduckgo.com.',
        ),
        findsOne,
      );
      await tester.tap(find.text('Schließen'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('Info-Texte', () {
    final l = lookupAppLocalizations(const Locale('de'));

    test('jede Inhaltsart hat eine Erklärung', () {
      for (final kind in ContentKind.values) {
        expect(kindInfo(kind, l), isNotEmpty);
      }
    });

    test('Karte und Anruf gehen an eine andere App', () {
      final geo = contentAction(
        parseContent('geo:52.1,10.5'),
        'geo:52.1,10.5',
        TargetPlatform.iOS,
      );
      expect(
        actionInfo(geo, l),
        startsWith('Tippst du auf „In Karten zeigen“'),
      );
      expect(actionInfo(geo, l), contains('andere App'));
      final tel = contentAction(parseContent('tel:123'), 'tel:123');
      expect(actionInfo(tel, l), contains('andere App'));
      expect(actionInfo(null, l), isNull);
    });

    test('Sendungsverfolgung nennt die Website', () {
      final post = ActionTarget.uri(
        ContentAction.track,
        PostageStamp('A0012345678901234B').trackingUri,
      );
      expect(actionInfo(post, l), contains('www.deutschepost.de'));
    });
  });
}
