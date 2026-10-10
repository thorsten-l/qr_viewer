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

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/qr_content.dart';
import 'package:qr_viewer/result_page.dart';

import 'test_app.dart';

/// Felder als "label: wert" für übersichtliche Vergleiche.
List<String> fields(String raw) =>
    parseContent(raw).fields.map((f) => f.toString()).toList();

ContentKind kind(String raw) => parseContent(raw).kind;

void main() {
  group('Kontakt', () {
    test('vCard 3.0 wie von iQR', () {
      const raw =
          'BEGIN:VCARD\r\n'
          'VERSION:3.0\r\n'
          'N:Müller;Jonas;;Dr.;\r\n'
          'FN:Dr. Jonas Müller\r\n'
          'ORG:Apple;Entwicklung\r\n'
          'TITLE:Ingenieur\r\n'
          'TEL;TYPE=CELL:08006645451\r\n'
          'TEL;TYPE=WORK,VOICE:+49 531 1234\r\n'
          'EMAIL;TYPE=INTERNET:j.muller@apple.com\r\n'
          'URL:linktr.ee/iqrcodes\r\n'
          'ADR;TYPE=HOME:;;Hauptstr. 1;Braunschweig;Niedersachsen;38100;Deutschland\r\n'
          'BDAY:1985-04-12\r\n'
          'NOTE:Zeile 1\\nZeile 2\\, mit Komma\r\n'
          'END:VCARD';
      expect(kind(raw), ContentKind.contact);
      expect(fields(raw), [
        'name: Dr. Jonas Müller',
        'organization: Apple, Entwicklung',
        'jobTitle: Ingenieur',
        'mobile: 08006645451',
        'workPhone: +49 531 1234',
        'email: j.muller@apple.com',
        'website: linktr.ee/iqrcodes',
        'address: Hauptstr. 1\n38100 Braunschweig\nNiedersachsen\nDeutschland',
        'birthday: 1985-04-12',
        'note: Zeile 1\nZeile 2, mit Komma',
      ]);
      final bday = parseContent(
        raw,
      ).fields.firstWhere((f) => f.label == FieldLabel.birthday);
      expect(bday.time, DateTime(1985, 4, 12));
      expect(bday.dateOnly, isTrue);
    });

    test('vCard 2.1 mit Quoted-Printable, Gruppen und gefalteten Zeilen', () {
      const raw =
          'BEGIN:VCARD\n'
          'VERSION:2.1\n'
          'N;CHARSET=UTF-8;ENCODING=QUOTED-PRINTABLE:M=C3=BCller;J=C3=B6rg\n'
          'TEL;CELL;PREF:+491701234567\n'
          'item1.EMAIL:joerg@example.org\n'
          'NOTE:sehr lange\n'
          ' Notiz\n'
          'END:VCARD';
      expect(fields(raw), [
        'name: Jörg Müller',
        'mobile: +491701234567',
        'email: joerg@example.org',
        'note: sehr langeNotiz',
      ]);
    });

    test('MECARD', () {
      const raw =
          r'MECARD:N:Müller,Jonas;TEL:08006645451;EMAIL:j.muller@apple.com;'
          r'URL:https\://example.org;ADR:,,Hauptstr. 1,Braunschweig,,38100,DE;'
          r'BDAY:19850412;NOTE:a\;b;;';
      expect(kind(raw), ContentKind.contact);
      expect(fields(raw), [
        'name: Jonas Müller',
        'phone: 08006645451',
        'email: j.muller@apple.com',
        'website: https://example.org',
        'address: Hauptstr. 1\n38100 Braunschweig\nDE',
        'birthday: 19850412',
        'note: a;b',
      ]);
    });

    test('BIZCARD', () {
      const raw =
          'BIZCARD:N:Sean;X:Owen;T:Software Engineer;C:Google;'
          'A:76 9th Avenue, New York;B:+12125551212;E:srowen@google.com;;';
      expect(fields(raw), [
        'name: Sean Owen',
        'organization: Google',
        'jobTitle: Software Engineer',
        'phone: +12125551212',
        'email: srowen@google.com',
        'address: 76 9th Avenue, New York',
      ]);
    });
  });

  group('Termin', () {
    test('VEVENT mit Zeitzone und UTC', () {
      const raw =
          'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nBEGIN:VEVENT\r\n'
          'SUMMARY:Teamtreffen\r\n'
          'DTSTART;TZID=Europe/Berlin:20261012T090000\r\n'
          'DTEND:20261012T083000Z\r\n'
          'LOCATION:Raum 1\\, Haus A\r\n'
          'DESCRIPTION:Agenda folgt\r\n'
          'END:VEVENT\r\nEND:VCALENDAR';
      final c = parseContent(raw);
      expect(c.kind, ContentKind.event);
      expect(c.fields.map((f) => f.label), [
        FieldLabel.title,
        FieldLabel.start,
        FieldLabel.end,
        FieldLabel.location,
        FieldLabel.description,
      ]);
      expect(c[FieldLabel.location], 'Raum 1, Haus A');
      final start = c.fields[1];
      expect(start.time, DateTime(2026, 10, 12, 9));
      expect(start.timeZone, 'Europe/Berlin');
      expect(c.fields[2].time, DateTime.utc(2026, 10, 12, 8, 30).toLocal());
    });

    test('Ganztägig', () {
      const raw =
          'BEGIN:VEVENT\nSUMMARY:Urlaub\nDTSTART;VALUE=DATE:20261224\nEND:VEVENT';
      final start = parseContent(raw).fields[1];
      expect(start.dateOnly, isTrue);
      expect(start.time, DateTime(2026, 12, 24));
    });
  });

  group('WLAN', () {
    test('WPA mit maskierten Zeichen', () {
      const raw = r'WIFI:T:WPA;S:Mein\;Netz;P:ge\:heim\\1;H:true;;';
      expect(kind(raw), ContentKind.wifi);
      expect(fields(raw), [
        'network: Mein;Netz',
        'security: WPA',
        r'password: ge:heim\1',
        'hidden: true',
      ]);
    });

    test('Offenes Netz, Reihenfolge egal', () {
      expect(fields('WIFI:S:Gast;T:nopass;P:;;'), [
        'network: Gast',
        'security: nopass',
      ]);
    });
  });

  group('E-Mail, Telefon, SMS, Ort', () {
    test('mailto mit Parametern', () {
      expect(
        fields('mailto:a@b.de?cc=c@d.de&subject=Hallo%20Welt&body=1+1%3D2'),
        ['to: a@b.de', 'cc: c@d.de', 'subject: Hallo Welt', 'message: 1+1=2'],
      );
    });

    test('MATMSG, SMTP und bloße Adresse', () {
      expect(fields('MATMSG:TO:a@b.de;SUB:Betreff;BODY:Text;;'), [
        'to: a@b.de',
        'subject: Betreff',
        'message: Text',
      ]);
      expect(fields('SMTP:a@b.de:Betreff:Text: mit Doppelpunkt'), [
        'to: a@b.de',
        'subject: Betreff',
        'message: Text: mit Doppelpunkt',
      ]);
      expect(kind('info@example.org'), ContentKind.email);
    });

    test('tel', () {
      expect(kind('tel:+4953112345'), ContentKind.phone);
      expect(fields('TEL:+49%20531%2012345'), ['number: +49 531 12345']);
    });

    test('SMS in beiden Schreibweisen', () {
      expect(fields('SMSTO:+491701234567:Hallo: du'), [
        'number: +491701234567',
        'message: Hallo: du',
      ]);
      expect(fields('sms:+491701234567?body=Hallo%20du'), [
        'number: +491701234567',
        'message: Hallo du',
      ]);
      expect(kind('sms:+491701234567'), ContentKind.sms);
    });

    test('geo', () {
      expect(fields('geo:52.2689,10.5268,80?q=Ostfalia'), [
        'latitude: 52.2689',
        'longitude: 10.5268',
        'altitude: 80',
        'query: Ostfalia',
      ]);
      expect(kind('geo:abc,def'), ContentKind.text);
      expect(kind('geo:95,10'), ContentKind.text);
    });
  });

  group('Links', () {
    test('http, https und www', () {
      expect(kind('https://www.ostfalia.de'), ContentKind.url);
      expect(kind('www.ostfalia.de'), ContentKind.url);
      expect(webUri('www.ostfalia.de').toString(), 'https://www.ostfalia.de');
      expect(webUri('ftp://example.org'), isNull);
      expect(kind('https://x.de und Text'), ContentKind.text);
    });

    test('MEBKM', () {
      expect(fields(r'MEBKM:TITLE:Ostfalia;URL:https\://ostfalia.de;;'), [
        'title: Ostfalia',
        'link: https://ostfalia.de',
      ]);
    });
  });

  group('Überweisung (EPC-QR)', () {
    test('GiroCode', () {
      const raw =
          'BCD\n002\n1\nSCT\nBFSWDE33BER\nWikimedia Foerdergesellschaft\n'
          'DE33100205000001194700\nEUR123.45\n\n\nSpende fuer Wikipedia';
      final c = parseContent(raw);
      expect(c.kind, ContentKind.payment);
      expect(c.fields.map((f) => f.toString()), [
        'recipient: Wikimedia Foerdergesellschaft',
        'iban: DE33100205000001194700',
        'bic: BFSWDE33BER',
        'amount: 123.45',
        'remittance: Spende fuer Wikipedia',
      ]);
      final amount = c.fields[3];
      expect((amount.amount, amount.currency), (123.45, 'EUR'));
    });

    test('Ohne SCT kein EPC', () {
      expect(kind('BCD\n002\n1\nXYZ\n\nName\nDE00'), ContentKind.text);
    });
  });

  group('Einmalpasswort (otpauth)', () {
    test('TOTP mit Anbieter im Label und Parametern', () {
      const raw =
          'otpauth://totp/ACME%20Co:john.doe@email.com?'
          'secret=HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ&issuer=ACME%20Co'
          '&algorithm=SHA256&digits=8&period=60';
      expect(kind(raw), ContentKind.otp);
      expect(fields(raw), [
        'issuer: ACME Co',
        'account: john.doe@email.com',
        'secret: HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ',
        'otpType: TOTP',
        'algorithm: SHA256',
        'digits: 8',
        'period: 60',
      ]);
    });

    test('Standardwerte und Anbieter nur im Label', () {
      expect(fields('otpauth://totp/GitHub:octocat?secret=JBSWY3DPEHPK3PXP'), [
        'issuer: GitHub',
        'account: octocat',
        'secret: JBSWY3DPEHPK3PXP',
        'otpType: TOTP',
        'algorithm: SHA1',
        'digits: 6',
        'period: 30',
      ]);
    });

    test('HOTP mit Zähler', () {
      expect(
        fields('otpauth://hotp/konto?secret=JBSWY3DPEHPK3PXP&counter=7'),
        contains('counter: 7'),
      );
    });

    test('Ohne Secret oder mit unbekanntem Typ: Text', () {
      expect(kind('otpauth://totp/GitHub:octocat'), ContentKind.text);
      expect(kind('otpauth://xotp/a?secret=ABC'), ContentKind.text);
    });
  });

  test('Alles andere ist Text', () {
    for (final raw in [
      'Hallo Welt',
      '4006381333931',
      'BEGIN:VCALENDAR\nEND:VCALENDAR',
      'WIFI:',
      'MECARD:;;',
      '',
    ]) {
      expect(kind(raw), ContentKind.text, reason: raw);
    }
  });

  testWidgets('Kontaktkarte mit kopierbaren Feldern und Rohinhalt', (
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
    const raw = 'MECARD:N:Müller,Jonas;TEL:08006645451;BDAY:19850412;;';
    await tester.pumpWidget(
      testApp(const ResultPage(raw: raw, type: BarcodeType.contactInfo)),
    );
    expect(find.text('Kontakt'), findsWidgets);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Jonas Müller'), findsOneWidget);
    expect(find.text('Geburtstag'), findsOneWidget);
    expect(find.text('12.4.1985'), findsOneWidget);
    expect(find.text('Rohinhalt'), findsOneWidget);
    expect(find.text(raw), findsOneWidget);

    await tester.tap(find.byTooltip('Telefon kopieren'));
    await tester.pump();
    expect(copied, '08006645451');
  });

  testWidgets('WLAN: offenes Netz und verstecktes Netz lesbar', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: 'WIFI:S:Gast;T:nopass;H:true;;',
          type: BarcodeType.wifi,
        ),
      ),
    );
    expect(find.text('Keine (offenes Netz)'), findsOneWidget);
    expect(find.text('Verstecktes Netz'), findsOneWidget);
    expect(find.text('Ja'), findsOneWidget);
  });

  testWidgets('Überweisung zeigt den Betrag als Währung', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: 'BCD\n002\n1\nSCT\n\nMax\nDE33100205000001194700\nEUR5',
          type: BarcodeType.text,
        ),
      ),
    );
    expect(find.text('Überweisung'), findsWidgets);
    expect(find.textContaining('5,00'), findsOneWidget);
  });

  testWidgets('Einmalpasswort-Karte', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: 'otpauth://totp/GitHub:octocat?secret=JBSWY3DPEHPK3PXP',
          type: BarcodeType.text,
        ),
      ),
    );
    expect(find.text('Einmalpasswort (2FA)'), findsWidgets);
    expect(find.text('Anbieter'), findsOneWidget);
    expect(find.text('Geheimer Schlüssel'), findsOneWidget);
    expect(find.text('JBSWY3DPEHPK3PXP'), findsOneWidget);
    expect(find.text('Intervall (Sekunden)'), findsOneWidget);
    expect(find.text('Öffnen …'), findsNothing);
  });

  testWidgets('Bloße URL: keine Karte, Öffnen bleibt', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(raw: 'https://www.ostfalia.de', type: BarcodeType.url),
      ),
    );
    expect(find.text('Rohinhalt'), findsNothing);
    expect(find.text('Öffnen …'), findsOneWidget);
  });

  testWidgets('MEBKM: Karte und Öffnen mit dem Link', (tester) async {
    await tester.pumpWidget(
      testApp(
        const ResultPage(
          raw: r'MEBKM:TITLE:Ostfalia;URL:https\://ostfalia.de;;',
          type: BarcodeType.text,
        ),
      ),
    );
    expect(find.text('Rohinhalt'), findsOneWidget);
    expect(find.text('Host: ostfalia.de'), findsOneWidget);
    expect(find.text('Öffnen …'), findsOneWidget);
  });
}
