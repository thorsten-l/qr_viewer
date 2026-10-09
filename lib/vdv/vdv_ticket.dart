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
import 'dart:typed_data';

import 'ber.dart';
import 'iso9796.dart';
import 'vdv_certificate.dart';

const _tagSignature = 0x9E;
const _tagSignatureRemainder = 0x9A;
const _tagCertificate = 0x7F21;
const _tagCaReference = 0x42;
const _tagProductData = 0x85;
const _tagBasicData = 0xDA;
const _tagTravelerData = 0xDB;

/// Bekannte Produktnummern (öffentliche Doku von TapConnect).
enum VdvProduct { deutschlandticket, jobticket, studentTicket, other }

VdvProduct productFor(int id) => switch (id) {
  9999 => VdvProduct.deutschlandticket,
  9998 => VdvProduct.jobticket,
  9995 => VdvProduct.studentTicket,
  _ => VdvProduct.other,
};

/// Lesbarer Inhalt einer statischen VDV-Berechtigung (VDV-KA).
class VdvTicket {
  const VdvTicket({
    required this.ticketNumber,
    required this.productId,
    required this.issuerId,
    required this.operatorId,
    required this.signatureValid,
    this.validFrom,
    this.validUntil,
    this.issuedAt,
    this.holderName,
    this.holderNameMasked = false,
    this.birthDate,
    this.serviceClass,
    this.priceCents,
  });

  final int ticketNumber;
  final int productId;

  /// Organisationsnummern von Kundenvertragspartner (KVP) und
  /// Produktverantwortlichem (PV).
  final int issuerId;
  final int operatorId;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final DateTime? issuedAt;
  final String? holderName;
  final bool holderNameMasked;
  final DateTime? birthDate;

  /// 1 = 1. Klasse, 2 = 2. Klasse, sonst null.
  final int? serviceClass;
  final int? priceCents;

  /// True, wenn Ticket- und Zertifikatssignatur rechnerisch stimmen.
  final bool signatureValid;

  VdvProduct get product => productFor(productId);
}

/// Ergebnis der Dekodierung: [ticket] ist null, wenn kein passender
/// öffentlicher Schlüssel vorliegt oder die Daten defekt sind.
class VdvDecodeResult {
  const VdvDecodeResult({this.ticket, this.caReference});

  final VdvTicket? ticket;

  /// CAR der ausstellenden CA als Hex, falls lesbar.
  final String? caReference;
}

/// Dekodiert einen VDV-Barcode. Wirft nie; Fehler ergeben ticket == null.
Future<VdvDecodeResult> decodeVdvTicket(
  Uint8List data, {
  CertificateLoader loader = assetCertificateLoader,
}) async {
  try {
    final top = readAllBer(data);
    final car = top[_tagCaReference];
    final carHex = car == null ? null : _hex(car);
    final signature = top[_tagSignature];
    final certificate = top[_tagCertificate];
    if (carHex == null || signature == null || certificate == null) {
      return VdvDecodeResult(caReference: carHex);
    }
    final ca = await loadCaKey(carHex, loader: loader);
    if (ca == null) return VdvDecodeResult(caReference: carHex);
    final cert = keyFromCertificate(certificate, ca.key);
    if (cert == null) return VdvDecodeResult(caReference: carHex);
    final recovered = recoverMessage(
      signature,
      cert.key.modulus,
      cert.key.exponent,
      top[_tagSignatureRemainder] ?? const [],
    );
    if (recovered == null) return VdvDecodeResult(caReference: carHex);
    final valid =
        recovered.hashValid &&
        cert.signatureValid != false &&
        ca.signatureValid != false;
    return VdvDecodeResult(
      ticket: parseTicketMessage(recovered.message, signatureValid: valid),
      caReference: carHex,
    );
  } catch (_) {
    return const VdvDecodeResult();
  }
}

/// Liest die rückgewonnene Ticketnachricht (Big Endian).
VdvTicket? parseTicketMessage(Uint8List m, {required bool signatureValid}) {
  if (m.length < 18) return null;
  int? serviceClass;
  int? price;
  String? name;
  var masked = false;
  DateTime? birthDate;
  DateTime? issuedAt;

  final product = readBer(m, 18);
  if (product != null && product.tag == _tagProductData) {
    final elements = readAllBer(product.value);
    final basic = elements[_tagBasicData];
    if (basic != null && basic.length >= 17) {
      final c = basic[7];
      serviceClass = (c == 1 || c == 2) ? c : null;
      final p = readUint(basic, 8, 3);
      price = p > 0 ? p : null;
    }
    final traveler = elements[_tagTravelerData];
    if (traveler != null && traveler.length >= 5) {
      birthDate = decodeBcdDate(traveler.sublist(1, 5));
      if (traveler.length > 5) {
        (name, masked) = decodeTravelerName(traveler.sublist(5));
      }
    }
    // Gemeinsame Transaktionsdaten: Ausstellungszeit ab Byte 7.
    if (product.end + 11 <= m.length) {
      issuedAt = decodeDateTime(m.sublist(product.end + 7, product.end + 11));
    }
  }

  return VdvTicket(
    ticketNumber: readUint(m, 0, 4),
    issuerId: readUint(m, 4, 2),
    productId: readUint(m, 6, 2),
    operatorId: readUint(m, 8, 2),
    validFrom: decodeDateTime(m.sublist(10, 14)),
    validUntil: decodeDateTime(m.sublist(14, 18)),
    issuedAt: issuedAt,
    holderName: name,
    holderNameMasked: masked,
    birthDate: birthDate,
    serviceClass: serviceClass,
    priceCents: price,
    signatureValid: signatureValid,
  );
}

/// VdvDateTimeCompact: Jahr ab 1990 (7 Bit), Monat, Tag, Stunde, Minute,
/// Sekunde in 2-Sekunden-Schritten.
DateTime? decodeDateTime(List<int> b) {
  if (b.length < 4) return null;
  final v = readUint(b, 0, 4);
  if (v == 0) return null;
  final month = (v >> 21) & 0x0F;
  final day = (v >> 16) & 0x1F;
  final hour = (v >> 11) & 0x1F;
  final minute = (v >> 5) & 0x3F;
  final second = (v & 0x1F) * 2;
  if (month < 1 || month > 12 || day < 1 || hour > 23 || minute > 59) {
    return null;
  }
  return DateTime(1990 + (v >> 25), month, day, hour, minute, second);
}

/// BCD-Datum JJJJMMTT.
DateTime? decodeBcdDate(List<int> b) {
  if (b.length < 4) return null;
  int bcd(int x) => (x >> 4) * 10 + (x & 0x0F);
  final year = bcd(b[0]) * 100 + bcd(b[1]);
  final month = bcd(b[2]);
  final day = bcd(b[3]);
  if (year == 0 || month < 1 || month > 12 || day < 1 || day > 31) {
    return null;
  }
  return DateTime(year, month, day);
}

/// Name des Reisenden: "Vorname#Nachname" im Klartext oder maskiert
/// ("G7e@M8n": erster Buchstabe, Anzahl, letzter Buchstabe).
(String?, bool) decodeTravelerName(List<int> bytes) {
  final end = bytes.indexOf(0);
  final raw = bytes.sublist(0, end < 0 ? bytes.length : end);
  if (raw.isEmpty) return (null, false);
  String text;
  try {
    text = utf8.decode(raw);
  } on FormatException {
    text = latin1.decode(raw);
  }
  text = text.trim();
  if (text.contains('#')) {
    return (text.split('#').map((s) => s.trim()).join(' ').trim(), false);
  }
  if (text.contains('@')) {
    final pattern = RegExp(r'^(\D)\d+(\D)$');
    final parts = text.split('@').map((p) {
      final s = p.replaceAll('*', '');
      final m = pattern.firstMatch(s);
      return m == null ? s : '${m[1]}…${m[2]}';
    });
    return (parts.where((p) => p.isNotEmpty).join(' '), true);
  }
  return (text, false);
}

String _hex(List<int> b) =>
    b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
