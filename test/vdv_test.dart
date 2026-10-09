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

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/binary_payload.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:qr_viewer/vdv/ber.dart';
import 'package:qr_viewer/vdv/vdv_ticket.dart';

import 'test_app.dart';

/// Echtes Muster-Ticket (Deutschlandsemesterticket, "Geraldine Mustermann"),
/// 352 Bytes aus dem Aztec-Code.
const sampleTicketHex =
    '9e8180d7a472228d5cecfd6bc85ae56bd76acc06c29ae0cb765617d4b9be7886'
    '567e83e2d811aaed0d3e13acd43d64a364316a9342f00749ce008abc495c4807'
    '06e913c6132f941f7b5f164e69e9031e89dea9e4802378724f170a4fd628e0cf'
    'eafaca704ac64cd149e2eb911b2a64aa029bafc5a7956eb2b756425a870ac22c'
    'f616809a0556445614007f2181c85f3781c06322f0cbf45d940e0e58a708309c'
    'd7187b8683907eb2bef76b49e80c18c32f1fd92ce559f7849f9e4ac3907cf5ec'
    '0a9db63be98963c1c1668b6a34404580986dbe48af8e5501a5a42ee8c7f4b99e'
    '6dba877c0aafd592ac534d468c0fcf98dc00d1ac862ba1d3bdd9e97501170d80'
    'b5ca5ad7559330f1a9b4393b53749b582c60581d1ff3a624d93749ca9c1fed7d'
    '0c7b690612c882e7e9e5e54a2689cfea028ff8d0ebcb31c8e9684443a45540d2'
    '49ee87d5e3506fa9cc1b04c8bc174dafabee5f38018142084445564456110221';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final sample = fromHex(sampleTicketHex);

  test('Fixture hat 352 Bytes und VDV-Kennung', () {
    expect(sample.length, 352);
    expect(isVdvTicket(sample), isTrue);
  });

  group('Grundbausteine', () {
    test('BER mit 1- und 2-Byte-Tags und langer Länge', () {
      final data = Uint8List.fromList([
        0x9E, 0x81, 0x02, 0xAA, 0xBB, //
        0x7F, 0x21, 0x01, 0xCC,
        0x42, 0x00,
      ]);
      final all = readAllBer(data);
      expect(all[0x9E], [0xAA, 0xBB]);
      expect(all[0x7F21], [0xCC]);
      expect(all[0x42], isEmpty);
      expect(readBer(Uint8List.fromList([0x9E, 0x05, 0x01]), 0), isNull);
    });

    test('Kompaktes Datum und BCD-Datum', () {
      // 2026-09-17 13:33:20
      final v =
          ((2026 - 1990) << 25) |
          (9 << 21) |
          (17 << 16) |
          (13 << 11) |
          (33 << 5) |
          10;
      final b = [v >> 24 & 0xFF, v >> 16 & 0xFF, v >> 8 & 0xFF, v & 0xFF];
      expect(decodeDateTime(b), DateTime(2026, 9, 17, 13, 33, 20));
      expect(decodeDateTime([0, 0, 0, 0]), isNull);
      expect(decodeBcdDate([0x19, 0x89, 0x12, 0x12]), DateTime(1989, 12, 12));
      expect(decodeBcdDate([0, 0, 0, 0]), isNull);
    });

    test('Namensformate', () {
      expect(decodeTravelerName('Max#Muster'.codeUnits), ('Max Muster', false));
      expect(decodeTravelerName('G7e@M8n'.codeUnits), ('G…e M…n', true));
      expect(decodeTravelerName('E1a*@*K0s'.codeUnits), ('E…a K…s', true));
      expect(decodeTravelerName(const []), (null, false));
    });
  });

  group('Muster-Ticket', () {
    test('wird vollständig gelesen, Signaturen stimmen', () async {
      final result = await decodeVdvTicket(sample);
      final t = result.ticket!;
      expect(result.caReference, '4445564456110221');
      expect(t.ticketNumber, 100962593);
      expect(t.productId, 9996);
      expect(t.issuerId, 6861);
      expect(t.operatorId, 3000);
      expect(t.validFrom, DateTime(2026, 9, 1, 0, 0, 2));
      expect(t.validUntil, DateTime(2027, 2, 28, 23, 59, 58));
      expect(t.issuedAt, DateTime(2026, 9, 17, 13, 33, 20));
      expect(t.birthDate, DateTime(1989, 12, 12));
      expect(t.holderName, 'G…e M…n');
      expect(t.holderNameMasked, isTrue);
      expect(t.serviceClass, 2);
      expect(t.priceCents, isNull);
      expect(t.signatureValid, isTrue);
    });

    test('ohne passenden Schlüssel: kein Ticket, aber CA bekannt', () async {
      final result = await decodeVdvTicket(sample, loader: (_) async => null);
      expect(result.ticket, isNull);
      expect(result.caReference, '4445564456110221');
    });

    test('veränderte Daten: lesbar, Signatur ungültig', () async {
      // Letztes Byte des unverschlüsselten Rests (Trailer-Version) ändern.
      final tampered = Uint8List.fromList(sample);
      final rest = readBer(tampered, readBer(tampered, 0)!.end)!;
      tampered[rest.end - 1] ^= 0x01;
      final t = (await decodeVdvTicket(tampered)).ticket!;
      expect(t.ticketNumber, 100962593);
      expect(t.signatureValid, isFalse);
    });

    test('Müll ergibt kein Ticket und keine Exception', () async {
      final result = await decodeVdvTicket(Uint8List.fromList([1, 2, 3]));
      expect(result.ticket, isNull);
    });
  });

  testWidgets('Ergebnisansicht zeigt Ticketdaten des Muster-Tickets', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(
        ResultPage(
          raw: toHex(sample),
          type: BarcodeType.unknown,
          format: BarcodeFormat.aztec,
          binary: true,
        ),
      ),
    );
    // Schlüssel aus den Assets laden und RSA rechnen lassen.
    for (
      var i = 0;
      i < 20 && find.text('Ticketdaten').evaluate().isEmpty;
      i++
    ) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
    }
    expect(find.text('VDV-eTicket (signiert)'), findsOneWidget);
    expect(find.text('Ticketdaten'), findsOneWidget);
    expect(find.text('100962593'), findsOneWidget);
    expect(find.text('G…e M…n (maskiert)'), findsOneWidget);
    expect(find.text('12.12.1989'), findsOneWidget);
    expect(find.text('1.9.2026 00:00'), findsOneWidget);
    expect(find.text('28.2.2027 23:59'), findsOneWidget);
    expect(find.text('17.9.2026 13:33'), findsOneWidget);
    expect(find.text('2. Klasse'), findsOneWidget);
    expect(find.text('6861 / 3000'), findsOneWidget);
    expect(find.text('Signatur gültig'), findsOneWidget);
    expect(find.text('Rohdaten (Hex)'), findsOneWidget);
    expect(find.textContaining('0000  9E 81 80'), findsNothing);
  });
}
