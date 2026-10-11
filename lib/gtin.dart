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

/// Hilfen für Artikelnummern (GTIN): EAN-13, EAN-8, UPC-A, UPC-E, ITF-14.
library;

/// Was das GS1-Präfix über eine GTIN aussagt.
enum Gs1Range { country, inStore, coupon, isbn, issn, global }

/// GS1-Präfix: entweder ein Land (ISO-3166-Codes) oder eine Sonderart.
class Gs1Prefix {
  const Gs1Prefix(this.range, [this.countries = const []]);

  final Gs1Range range;
  final List<String> countries;

  /// Länder als Flagge und Code, z. B. "🇩🇪 DE".
  String get countryText =>
      countries.map((c) => '${flagEmoji(c)} $c').join(', ');
}

/// Flaggen-Emoji aus einem ISO-3166-Code, z. B. "DE" → 🇩🇪.
String flagEmoji(String code) => String.fromCharCodes(
  code.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41),
);

/// Gewichtete Summe nach GS1 (von rechts 3, 1, 3, …) ist durch 10 teilbar.
bool gtinValid(String digits) {
  if (!RegExp(r'^\d{8,14}$').hasMatch(digits)) return false;
  var sum = 0;
  for (var i = 0; i < digits.length; i++) {
    final d = digits.codeUnitAt(digits.length - 1 - i) - 0x30;
    sum += i.isOdd ? d * 3 : d;
  }
  return sum % 10 == 0;
}

/// UPC-E (8 Stellen mit Zahlensystem und Prüfziffer) als UPC-A.
String? upcEToUpcA(String e) {
  if (!RegExp(r'^[01]\d{7}$').hasMatch(e)) return null;
  final ns = e[0];
  final d = e.substring(1, 7);
  final check = e[7];
  final body = switch (d[5]) {
    '0' || '1' || '2' => '${d.substring(0, 2)}${d[5]}0000${d.substring(2, 5)}',
    '3' => '${d.substring(0, 3)}00000${d.substring(3, 5)}',
    '4' => '${d.substring(0, 4)}00000${d[4]}',
    _ => '${d.substring(0, 5)}0000${d[5]}',
  };
  return '$ns$body$check';
}

/// GTIN als 13 Stellen für die Präfix-Suche; null, wenn nicht ableitbar.
String? gtin13(String digits) => switch (digits.length) {
  8 when digits.startsWith('0') || digits.startsWith('1') =>
    upcEToUpcA(digits) == null ? null : '0${upcEToUpcA(digits)}',
  12 => '0$digits',
  13 => digits,
  14 => digits.substring(1),
  _ => null,
};

/// GS1-Präfix der ersten drei Stellen einer GTIN-13.
Gs1Prefix? gs1Prefix(String gtin13) {
  if (gtin13.length != 13) return null;
  final p = int.tryParse(gtin13.substring(0, 3));
  if (p == null) return null;
  if (p == 977) return const Gs1Prefix(Gs1Range.issn);
  if (p == 978 || p == 979) return const Gs1Prefix(Gs1Range.isbn);
  if (p == 950) return const Gs1Prefix(Gs1Range.global);
  if ((p >= 20 && p <= 29) || (p >= 40 && p <= 49) || (p >= 200 && p <= 299)) {
    return const Gs1Prefix(Gs1Range.inStore);
  }
  if ((p >= 50 && p <= 59) || (p >= 980 && p <= 999)) {
    return const Gs1Prefix(Gs1Range.coupon);
  }
  for (final (from, to, countries) in _countries) {
    if (p >= from && p <= to) return Gs1Prefix(Gs1Range.country, countries);
  }
  return null;
}

/// ISBN-10 zu einer ISBN-13 mit Präfix 978; 979 hat keine ISBN-10.
String? isbn10(String isbn13) {
  if (isbn13.length != 13 || !isbn13.startsWith('978')) return null;
  final body = isbn13.substring(3, 12);
  var sum = 0;
  for (var i = 0; i < 9; i++) {
    sum += (10 - i) * (body.codeUnitAt(i) - 0x30);
  }
  final check = (11 - sum % 11) % 11;
  return '$body${check == 10 ? 'X' : check}';
}

/// ISSN aus einer GTIN-13 mit Präfix 977, z. B. "0317-8471".
String? issn(String gtin13) {
  if (gtin13.length != 13 || !gtin13.startsWith('977')) return null;
  final body = gtin13.substring(3, 10);
  var sum = 0;
  for (var i = 0; i < 7; i++) {
    sum += (8 - i) * (body.codeUnitAt(i) - 0x30);
  }
  final check = (11 - sum % 11) % 11;
  final s = '$body${check == 10 ? 'X' : check}';
  return '${s.substring(0, 4)}-${s.substring(4)}';
}

/// Präfixbereiche der GS1-Länderorganisationen (Auszug, Stand 2026).
/// Das Präfix nennt das Land, in dem die Nummer vergeben wurde, nicht
/// zwingend das Herkunftsland der Ware.
const List<(int, int, List<String>)> _countries = [
  (0, 19, ['US', 'CA']),
  (30, 39, ['US']),
  (60, 139, ['US', 'CA']),
  (300, 379, ['FR']),
  (380, 380, ['BG']),
  (383, 383, ['SI']),
  (385, 385, ['HR']),
  (387, 387, ['BA']),
  (389, 389, ['ME']),
  (400, 440, ['DE']),
  (450, 459, ['JP']),
  (460, 469, ['RU']),
  (470, 470, ['KG']),
  (471, 471, ['TW']),
  (474, 474, ['EE']),
  (475, 475, ['LV']),
  (476, 476, ['AZ']),
  (477, 477, ['LT']),
  (478, 478, ['UZ']),
  (479, 479, ['LK']),
  (480, 480, ['PH']),
  (481, 481, ['BY']),
  (482, 482, ['UA']),
  (484, 484, ['MD']),
  (485, 485, ['AM']),
  (486, 486, ['GE']),
  (487, 487, ['KZ']),
  (488, 488, ['TJ']),
  (489, 489, ['HK']),
  (490, 499, ['JP']),
  (500, 509, ['GB']),
  (520, 521, ['GR']),
  (528, 528, ['LB']),
  (529, 529, ['CY']),
  (530, 530, ['AL']),
  (531, 531, ['MK']),
  (535, 535, ['MT']),
  (539, 539, ['IE']),
  (540, 549, ['BE', 'LU']),
  (560, 560, ['PT']),
  (569, 569, ['IS']),
  (570, 579, ['DK']),
  (590, 590, ['PL']),
  (594, 594, ['RO']),
  (599, 599, ['HU']),
  (600, 601, ['ZA']),
  (608, 608, ['BH']),
  (609, 609, ['MU']),
  (611, 611, ['MA']),
  (613, 613, ['DZ']),
  (615, 615, ['NG']),
  (616, 616, ['KE']),
  (619, 619, ['TN']),
  (621, 621, ['SY']),
  (622, 622, ['EG']),
  (625, 625, ['JO']),
  (626, 626, ['IR']),
  (627, 627, ['KW']),
  (628, 628, ['SA']),
  (629, 629, ['AE']),
  (640, 649, ['FI']),
  (690, 699, ['CN']),
  (700, 709, ['NO']),
  (729, 729, ['IL']),
  (730, 739, ['SE']),
  (746, 746, ['DO']),
  (750, 750, ['MX']),
  (754, 755, ['CA']),
  (759, 759, ['VE']),
  (760, 769, ['CH', 'LI']),
  (770, 771, ['CO']),
  (773, 773, ['UY']),
  (775, 775, ['PE']),
  (777, 777, ['BO']),
  (778, 779, ['AR']),
  (780, 780, ['CL']),
  (784, 784, ['PY']),
  (786, 786, ['EC']),
  (789, 790, ['BR']),
  (800, 839, ['IT', 'SM', 'VA']),
  (840, 849, ['ES', 'AD']),
  (850, 850, ['CU']),
  (858, 858, ['SK']),
  (859, 859, ['CZ']),
  (860, 860, ['RS']),
  (865, 865, ['MN']),
  (867, 867, ['KP']),
  (868, 869, ['TR']),
  (870, 879, ['NL']),
  (880, 881, ['KR']),
  (884, 884, ['KH']),
  (885, 885, ['TH']),
  (888, 888, ['SG']),
  (890, 890, ['IN']),
  (893, 893, ['VN']),
  (896, 896, ['PK']),
  (899, 899, ['ID']),
  (900, 919, ['AT']),
  (930, 939, ['AU']),
  (940, 949, ['NZ']),
  (955, 955, ['MY']),
  (958, 958, ['MO']),
];
