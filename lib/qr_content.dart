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

import 'gtin.dart';
import 'matter.dart';

/// Erkennt die üblichen Inhaltsformate von QR-Codes, wie sie z. B. in der
/// ZXing-Liste "Barcode Contents" gesammelt sind:
///
/// * Kontakt: vCard (RFC 2426/6350), MECARD (NTT Docomo), BIZCARD
/// * Termin: iCalendar VEVENT (RFC 5545)
/// * WLAN: `WIFI:` (ZXing, Wi-Fi Alliance)
/// * E-Mail: `mailto:` (RFC 6068), MATMSG, `SMTP:`, bloße Adresse
/// * Telefon: `tel:` (RFC 3966)
/// * SMS: `sms:` (RFC 5724), `SMSTO:`, `mms:`
/// * Ort: `geo:` (RFC 5870)
/// * Link: `http(s)://`, `www.`, `URL:`, `beispiel.de/pfad` und andere
///   Schemata wie `market://` oder `fido:/`
/// * Lesezeichen: MEBKM (NTT Docomo) mit Titel und Link
/// * Überweisung: EPC-QR/GiroCode (EPC069-12)
/// * Einmalpasswort (2FA): `otpauth://` (Google Authenticator Key Uri Format)
/// * Smart-Home-Gerät: `MT:` (Matter-Onboarding-Code)
/// * JSON-Objekte und -Listen
/// * Artikelnummern (EAN/UPC/ITF-14) mit ISBN und ISSN, nur bei Strichcodes
///
/// Alles andere ist einfacher Text.
enum ContentKind {
  text,
  url,
  bookmark,
  email,
  phone,
  sms,
  geo,
  contact,
  event,
  wifi,
  payment,
  otp,
  product,
  book,
  json,
  matter,

  /// Echtheitscode aus Amazons Programm „Transparency“ (`AZ:` + Seriennummer).
  transparency,

  /// Matrixcode der Deutschen Post; entsteht aus Binärdaten, nicht hier.
  postage,
}

/// Bedeutung eines Feldes; der angezeigte Name kommt aus der Übersetzung.
enum FieldLabel {
  name,
  nickname,
  organization,
  jobTitle,
  phone,
  mobile,
  workPhone,
  homePhone,
  fax,
  email,
  website,
  address,
  birthday,
  note,
  to,
  cc,
  bcc,
  subject,
  message,
  number,
  latitude,
  longitude,
  altitude,
  query,
  title,
  link,
  start,
  end,
  location,
  description,
  network,
  password,
  security,
  hidden,
  eapMethod,
  identity,
  recipient,
  iban,
  bic,
  amount,
  purpose,
  reference,
  remittance,
  info,
  issuer,
  account,
  secret,
  otpType,
  algorithm,
  digits,
  period,
  counter,
  gtin,
  checkDigit,
  gs1Prefix,
  isbn,
  isbn10,
  issn,
  json,
  trackingNumber,
  serialNumber,
  vendorId,
  productId,
  discriminator,
  setupCode,
  manualCode,
  discovery,
  flow,
}

/// Ein Feld des erkannten Inhalts. Datum und Betrag werden beim Anzeigen
/// passend zur Sprache formatiert, alles andere steht in [value].
class ContentField {
  const ContentField(
    this.label,
    this.value, {
    this.time,
    this.dateOnly = false,
    this.timeZone,
    this.amount,
    this.currency,
  });

  final FieldLabel label;
  final String value;
  final DateTime? time;
  final bool dateOnly;
  final String? timeZone;
  final double? amount;
  final String? currency;

  @override
  String toString() => '${label.name}: $value';
}

class ParsedContent {
  const ParsedContent(this.kind, [this.fields = const []]);

  static const text = ParsedContent(ContentKind.text);

  final ContentKind kind;
  final List<ContentField> fields;

  /// Erster Wert zu [label], sonst null.
  String? operator [](FieldLabel label) {
    for (final f in fields) {
      if (f.label == label) return f.value;
    }
    return null;
  }
}

/// Erkennt das Format von [raw]; unbekannte Inhalte sind [ParsedContent.text].
/// [productCode] gibt an, dass der Inhalt aus einem Artikel-Strichcode
/// (EAN, UPC, ITF-14) stammt.
ParsedContent parseContent(String raw, {bool productCode = false}) {
  final s = raw.trim();
  if (s.isEmpty) return ParsedContent.text;
  final upper = s.toUpperCase();
  ParsedContent? result;
  try {
    if (productCode && RegExp(r'^\d{8}$|^\d{12,14}$').hasMatch(s)) {
      result = _product(s);
    } else if (upper.startsWith('BEGIN:VCARD')) {
      result = _vCard(s);
    } else if (upper.startsWith('MECARD:')) {
      result = _meCard(s.substring(7));
    } else if (upper.startsWith('BIZCARD:')) {
      result = _bizCard(s.substring(8));
    } else if (upper.startsWith('BEGIN:VCALENDAR') ||
        upper.startsWith('BEGIN:VEVENT')) {
      result = _event(s);
    } else if (upper.startsWith('WIFI:')) {
      result = _wifi(s.substring(5));
    } else if (upper.startsWith('MAILTO:')) {
      result = _mailto(s.substring(7));
    } else if (upper.startsWith('MATMSG:')) {
      result = _matMsg(s.substring(7));
    } else if (upper.startsWith('SMTP:')) {
      result = _smtp(s.substring(5));
    } else if (upper.startsWith('TEL:')) {
      result = _tel(s.substring(4));
    } else if (RegExp(r'^(SMS|SMSTO|MMS|MMSTO):').hasMatch(upper)) {
      result = _sms(s.substring(s.indexOf(':') + 1));
    } else if (upper.startsWith('GEO:')) {
      result = _geo(s.substring(4));
    } else if (upper.startsWith('MEBKM:')) {
      result = _meBookmark(s.substring(6));
    } else if (upper.startsWith('MT:')) {
      result = _matter(s);
    } else if (_transparency.hasMatch(s)) {
      result = ParsedContent(ContentKind.transparency, [
        ContentField(FieldLabel.serialNumber, s.substring(3)),
      ]);
    } else if (upper.startsWith('OTPAUTH://')) {
      result = _otpAuth(s.substring(10));
    } else if (upper.startsWith('BCD\n') || upper.startsWith('BCD\r')) {
      result = _epc(s);
    } else if (upper.startsWith('URL:') && linkUri(s.substring(4)) != null) {
      result = ParsedContent(ContentKind.url, [
        ContentField(FieldLabel.link, s.substring(4).trim()),
      ]);
    } else if (linkUri(s) != null) {
      result = ParsedContent(ContentKind.url, [
        ContentField(FieldLabel.link, s),
      ]);
    } else if (_email.hasMatch(s)) {
      result = ParsedContent(ContentKind.email, [
        ContentField(FieldLabel.to, s),
      ]);
    } else if (s.startsWith('{') || s.startsWith('[')) {
      result = _json(s);
    }
  } on Object {
    result = null;
  }
  if (result == null || result.fields.isEmpty) return ParsedContent.text;
  return result;
}

/// Link für den Öffnen-Dialog: nur http(s). `www.` und Adressen ohne
/// Schema wie `beispiel.de/pfad` werden zu https.
Uri? webUri(String link) {
  final s = link.trim();
  if (s.contains(RegExp(r'\s'))) return null;
  final bare = !s.contains('://') && _colloquialUrl.hasMatch(s);
  final uri = Uri.tryParse(bare ? 'https://$s' : s);
  if (uri == null || uri.host.isEmpty) return null;
  return (uri.scheme == 'http' || uri.scheme == 'https') ? uri : null;
}

/// Wie [webUri], dazu Links mit anderen Schemata, die eine App öffnen
/// kann, z. B. `market://`, `itms-apps://` oder `fido:/…`. Schemata, die
/// lokale Daten oder Code ansprechen, sind ausgeschlossen.
Uri? linkUri(String link) {
  final web = webUri(link);
  if (web != null) return web;
  final s = link.trim();
  if (s.contains(RegExp(r'\s'))) return null;
  final m = RegExp(r'^([a-zA-Z][a-zA-Z0-9+.-]{1,31}):(.*)$').firstMatch(s);
  if (m == null) return null;
  final scheme = m[1]!.toLowerCase();
  if (_blockedSchemes.contains(scheme)) return null;
  if (!m[2]!.startsWith('//') && !_opaqueSchemes.contains(scheme)) {
    return null;
  }
  return Uri.tryParse(s);
}

/// Adresse ohne Schema: mindestens drei Zeichen, Punkt, Top-Level-Domain
/// aus Buchstaben, danach optional Pfad (wie BinaryEye).
final _colloquialUrl = RegExp(
  r'^[A-Za-z0-9.-]{3,}\.[A-Za-z]{2,}(?:[/?#:][^\s]*)?$',
);

/// Diese Schemata öffnen wir nie: lokale Dateien, Skripte, Intents.
const _blockedSchemes = {
  'file',
  'content',
  'data',
  'javascript',
  'vbscript',
  'intent',
  'about',
  'blob',
  'chrome',
};

/// Bekannte Schemata ohne `//`; andere `name:wert` sind meist Text.
const _opaqueSchemes = {'fido', 'magnet', 'bitcoin', 'lightning', 'ethereum'};

/// Tracking-Parameter, die beim Öffnen entfernt werden (wie BinaryEye).
const _trackingParams = {
  'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content', //
  'utm_id', 'utm_name', 'utm_referrer', 'utm_brand', 'utm_social',
  'fbclid', 'gclid', 'dclid', 'gclsrc', 'yclid', 'msclkid',
  'mc_eid', 'mc_cid', '_ga', '_gl', 'ga_source', 'ga_medium',
  'igshid', 'igsh', 'hsa_acc', 'hsa_cam', 'hsa_grp', 'hsa_ad', 'hsa_src',
  'hsa_tgt', 'hsa_kw', 'hsa_mt', 'hsa_net', 'hsa_ver',
  'spm', 'scm', 'vero_id', 'vero_conv',
};

/// Entfernt bekannte Tracking-Parameter aus http(s)-Links.
Uri withoutTracking(Uri uri) {
  if (uri.scheme != 'http' && uri.scheme != 'https') return uri;
  if (!uri.hasQuery) return uri;
  final parts = uri.query.split('&');
  final kept = parts.where((p) {
    final name = p.split('=').first.toLowerCase();
    return !_trackingParams.contains(Uri.decodeQueryComponent(name));
  }).toList();
  if (kept.length == parts.length) return uri;
  final text = uri.toString();
  final q = text.indexOf('?');
  final hash = uri.hasFragment ? '#${uri.fragment}' : '';
  final base = text.substring(0, q);
  return Uri.parse(
    kept.isEmpty ? '$base$hash' : '$base?${kept.join('&')}$hash',
  );
}

final _email = RegExp(r'^[^\s@:;,]+@[^\s@:;,]+\.[^\s@:;,]+$');

// ---------------------------------------------------------------------------
// Hilfen
// ---------------------------------------------------------------------------

List<ContentField> _nonEmpty(Iterable<ContentField?> fields) => [
  for (final f in fields)
    if (f != null && f.value.trim().isNotEmpty) f,
];

ContentField? _field(FieldLabel label, String? value) =>
    value == null ? null : ContentField(label, value.trim());

/// Teilt an [sep], aber nicht an mit `\` maskierten Stellen; die Masken
/// bleiben erhalten.
List<String> _splitUnescaped(String s, String sep) {
  final parts = <String>[];
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (c == r'\' && i + 1 < s.length) {
      buf
        ..write(c)
        ..write(s[++i]);
    } else if (c == sep) {
      parts.add(buf.toString());
      buf.clear();
    } else {
      buf.write(c);
    }
  }
  parts.add(buf.toString());
  return parts;
}

/// Entfernt `\`-Masken; bei vCard/iCal steht `\n` für einen Zeilenumbruch.
String _unescape(String s, {bool newlines = false}) {
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (c == r'\' && i + 1 < s.length) {
      final n = s[++i];
      buf.write(newlines && (n == 'n' || n == 'N') ? '\n' : n);
    } else {
      buf.write(c);
    }
  }
  return buf.toString();
}

/// `KEY:VALUE;KEY:VALUE;;` wie bei MECARD, MATMSG, WIFI und MEBKM.
List<(String, String)> _docomoFields(String body) => [
  for (final part in _splitUnescaped(body, ';'))
    if (part.contains(':'))
      (
        part.substring(0, part.indexOf(':')).trim().toUpperCase(),
        _unescape(part.substring(part.indexOf(':') + 1)),
      ),
];

String _decodePercent(String s) {
  try {
    // "+" bleibt "+" (RFC 6068/3966), z. B. in Telefonnummern.
    return Uri.decodeComponent(s);
  } on Object {
    return s;
  }
}

/// Datum JJJJMMTT oder JJJJ-MM-TT.
DateTime? _date(String s) {
  final m = RegExp(r'^(\d{4})-?(\d{2})-?(\d{2})$').firstMatch(s.trim());
  if (m == null) return null;
  return DateTime(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
}

ContentField _dateField(FieldLabel label, String value) {
  final d = _date(value);
  return ContentField(label, value.trim(), time: d, dateOnly: d != null);
}

// ---------------------------------------------------------------------------
// vCard und iCalendar
// ---------------------------------------------------------------------------

class _Property {
  _Property(this.name, this.params, this.value);

  final String name;
  final Map<String, List<String>> params;
  final String value;

  /// Werte von TYPE, auch die bloßen Parameter aus vCard 2.1 (TEL;CELL).
  Set<String> get types => {
    ...?params['TYPE']?.map((t) => t.toUpperCase()),
    ...?params['']?.map((t) => t.toUpperCase()),
  };
}

List<_Property> _properties(String text) {
  final lines = <String>[];
  for (final line in text.replaceAll('\r\n', '\n').split(RegExp('[\r\n]'))) {
    final folded = line.startsWith(' ') || line.startsWith('\t');
    if (folded && lines.isNotEmpty) {
      lines.last += line.substring(1);
    } else if (lines.isNotEmpty &&
        lines.last.endsWith('=') &&
        lines.last.toUpperCase().contains('QUOTED-PRINTABLE')) {
      // Weicher Zeilenumbruch in Quoted-Printable (vCard 2.1).
      lines.last = lines.last.substring(0, lines.last.length - 1) + line;
    } else {
      lines.add(line);
    }
  }
  final props = <_Property>[];
  for (final line in lines) {
    final colon = _valueColon(line);
    if (colon < 0) continue;
    final head = _splitUnescaped(line.substring(0, colon), ';');
    var name = head.first.trim().toUpperCase();
    if (name.contains('.')) name = name.substring(name.lastIndexOf('.') + 1);
    final params = <String, List<String>>{};
    for (final p in head.skip(1)) {
      final eq = p.indexOf('=');
      final key = eq < 0 ? '' : p.substring(0, eq).trim().toUpperCase();
      final values = (eq < 0 ? p : p.substring(eq + 1))
          .replaceAll('"', '')
          .split(',');
      params.putIfAbsent(key, () => []).addAll(values.map((v) => v.trim()));
    }
    var value = line.substring(colon + 1);
    final encoding = {
      ...?params['ENCODING'],
      ...?params[''],
    }.map((e) => e.toUpperCase());
    if (encoding.contains('QUOTED-PRINTABLE')) {
      value = _quotedPrintable(value, params['CHARSET']?.first);
    }
    props.add(_Property(name, params, value));
  }
  return props;
}

/// Doppelpunkt zwischen Name/Parametern und Wert, außerhalb von "…".
int _valueColon(String line) {
  var quoted = false;
  for (var i = 0; i < line.length; i++) {
    if (line[i] == '"') quoted = !quoted;
    if (line[i] == ':' && !quoted) return i;
  }
  return -1;
}

String _quotedPrintable(String s, String? charset) {
  final bytes = <int>[];
  for (var i = 0; i < s.length; i++) {
    if (s[i] == '=' && i + 2 < s.length) {
      final b = int.tryParse(s.substring(i + 1, i + 3), radix: 16);
      if (b != null) {
        bytes.add(b);
        i += 2;
        continue;
      }
    }
    bytes.addAll(utf8.encode(s[i]));
  }
  final cs = charset?.toUpperCase();
  if (cs == 'ISO-8859-1' || cs == 'LATIN1' || cs == 'WINDOWS-1252') {
    return latin1.decode(bytes, allowInvalid: true);
  }
  return utf8.decode(bytes, allowMalformed: true);
}

List<String> _components(String value) => [
  for (final c in _splitUnescaped(value, ';'))
    _unescape(c, newlines: true).trim(),
];

/// ADR: Postfach; Zusatz; Straße; Ort; Region; PLZ; Land.
String _address(List<String> c) {
  String at(int i) => i < c.length ? c[i] : '';
  final city = [at(5), at(3)].where((p) => p.isNotEmpty).join(' ');
  return [
    at(0),
    at(1),
    at(2),
    city,
    at(4),
    at(6),
  ].where((p) => p.isNotEmpty).join('\n');
}

FieldLabel _phoneLabel(Set<String> types) {
  if (types.contains('FAX')) return FieldLabel.fax;
  if (types.contains('CELL') || types.contains('MOBILE')) {
    return FieldLabel.mobile;
  }
  if (types.contains('WORK')) return FieldLabel.workPhone;
  if (types.contains('HOME')) return FieldLabel.homePhone;
  return FieldLabel.phone;
}

ParsedContent _vCard(String s) {
  final props = _properties(s);
  String? fn;
  String? n;
  final fields = <ContentField?>[];
  final later = <ContentField?>[];
  for (final p in props) {
    switch (p.name) {
      case 'FN':
        fn = _unescape(p.value, newlines: true);
      case 'N':
        final c = _components(p.value);
        String at(int i) => i < c.length ? c[i] : '';
        n = [
          at(3),
          at(1),
          at(2),
          at(0),
          at(4),
        ].where((x) => x.isNotEmpty).join(' ');
      case 'NICKNAME':
        fields.add(_field(FieldLabel.nickname, _unescape(p.value)));
      case 'ORG':
        fields.add(
          _field(
            FieldLabel.organization,
            _components(p.value).where((x) => x.isNotEmpty).join(', '),
          ),
        );
      case 'TITLE':
        fields.add(_field(FieldLabel.jobTitle, _unescape(p.value)));
      case 'TEL':
        fields.add(_field(_phoneLabel(p.types), _stripScheme(p.value, 'tel:')));
      case 'EMAIL':
        fields.add(_field(FieldLabel.email, _unescape(p.value)));
      case 'URL':
        fields.add(_field(FieldLabel.website, _unescape(p.value)));
      case 'ADR':
        later.add(_field(FieldLabel.address, _address(_components(p.value))));
      case 'BDAY':
        later.add(_dateField(FieldLabel.birthday, p.value));
      case 'NOTE':
        later.add(_field(FieldLabel.note, _unescape(p.value, newlines: true)));
    }
  }
  final name = (fn != null && fn.trim().isNotEmpty) ? fn : n;
  return ParsedContent(
    ContentKind.contact,
    _nonEmpty([_field(FieldLabel.name, name), ...fields, ...later]),
  );
}

String _stripScheme(String value, String scheme) {
  final v = value.trim();
  return v.toLowerCase().startsWith(scheme) ? v.substring(scheme.length) : v;
}

ParsedContent? _event(String s) {
  final props = _properties(s);
  final begin = props.indexWhere(
    (p) => p.name == 'BEGIN' && p.value.trim().toUpperCase() == 'VEVENT',
  );
  if (begin < 0) return null;
  final fields = <FieldLabel, ContentField?>{};
  for (final p in props.skip(begin + 1)) {
    if (p.name == 'END' && p.value.trim().toUpperCase() == 'VEVENT') break;
    switch (p.name) {
      case 'SUMMARY':
        fields[FieldLabel.title] = _field(
          FieldLabel.title,
          _unescape(p.value, newlines: true),
        );
      case 'DTSTART':
        fields[FieldLabel.start] = _eventTime(FieldLabel.start, p);
      case 'DTEND':
        fields[FieldLabel.end] = _eventTime(FieldLabel.end, p);
      case 'LOCATION':
        fields[FieldLabel.location] = _field(
          FieldLabel.location,
          _unescape(p.value, newlines: true),
        );
      case 'DESCRIPTION':
        fields[FieldLabel.description] = _field(
          FieldLabel.description,
          _unescape(p.value, newlines: true),
        );
      case 'URL':
        fields[FieldLabel.link] = _field(FieldLabel.link, p.value);
    }
  }
  return ParsedContent(
    ContentKind.event,
    _nonEmpty([
      for (final l in [
        FieldLabel.title,
        FieldLabel.start,
        FieldLabel.end,
        FieldLabel.location,
        FieldLabel.description,
        FieldLabel.link,
      ])
        fields[l],
    ]),
  );
}

/// DTSTART/DTEND: JJJJMMTT (ganztägig) oder JJJJMMTTTHHMMSS, mit Z in UTC.
ContentField _eventTime(FieldLabel label, _Property p) {
  final v = p.value.trim();
  final m = RegExp(
    r'^(\d{4})(\d{2})(\d{2})(?:T(\d{2})(\d{2})(\d{2})?(Z)?)?$',
  ).firstMatch(v);
  if (m == null) return ContentField(label, v);
  int at(int i) => int.parse(m[i] ?? '0');
  if (m[4] == null) {
    return ContentField(
      label,
      v,
      time: DateTime(at(1), at(2), at(3)),
      dateOnly: true,
    );
  }
  final utc = m[7] != null;
  final time = utc
      ? DateTime.utc(at(1), at(2), at(3), at(4), at(5), at(6)).toLocal()
      : DateTime(at(1), at(2), at(3), at(4), at(5), at(6));
  return ContentField(
    label,
    v,
    time: time,
    timeZone: utc ? null : p.params['TZID']?.first,
  );
}

// ---------------------------------------------------------------------------
// Docomo-Formate
// ---------------------------------------------------------------------------

ParsedContent _meCard(String body) {
  final fields = <ContentField?>[];
  final later = <ContentField?>[];
  String? name;
  for (final (key, value) in _docomoFields(body)) {
    switch (key) {
      case 'N':
        final parts = value.split(',');
        name = parts.length == 2
            ? '${parts[1].trim()} ${parts[0].trim()}'.trim()
            : value;
      case 'NICKNAME':
        fields.add(_field(FieldLabel.nickname, value));
      case 'ORG':
        fields.add(_field(FieldLabel.organization, value));
      case 'TEL' || 'TEL-AV':
        fields.add(_field(FieldLabel.phone, value));
      case 'EMAIL':
        fields.add(_field(FieldLabel.email, value));
      case 'URL':
        fields.add(_field(FieldLabel.website, value));
      case 'ADR':
        final c = value.split(',');
        later.add(
          _field(
            FieldLabel.address,
            c.length == 7 ? _address(c.map((x) => x.trim()).toList()) : value,
          ),
        );
      case 'BDAY':
        later.add(_dateField(FieldLabel.birthday, value));
      case 'NOTE':
        later.add(_field(FieldLabel.note, value));
    }
  }
  return ParsedContent(
    ContentKind.contact,
    _nonEmpty([_field(FieldLabel.name, name), ...fields, ...later]),
  );
}

ParsedContent _bizCard(String body) {
  final f = {for (final (k, v) in _docomoFields(body)) k: v};
  final name = [f['N'], f['X']].whereType<String>().join(' ');
  return ParsedContent(
    ContentKind.contact,
    _nonEmpty([
      _field(FieldLabel.name, name),
      _field(FieldLabel.organization, f['C']),
      _field(FieldLabel.jobTitle, f['T']),
      _field(FieldLabel.phone, f['B']),
      _field(FieldLabel.mobile, f['M']),
      _field(FieldLabel.fax, f['F']),
      _field(FieldLabel.email, f['E']),
      _field(FieldLabel.address, f['A']),
    ]),
  );
}

ParsedContent _matMsg(String body) {
  final f = {for (final (k, v) in _docomoFields(body)) k: v};
  return ParsedContent(
    ContentKind.email,
    _nonEmpty([
      _field(FieldLabel.to, f['TO']),
      _field(FieldLabel.subject, f['SUB']),
      _field(FieldLabel.message, f['BODY']),
    ]),
  );
}

/// MEBKM: `MEBKM:TITLE:Name;URL:http\://beispiel.de;;`. Beide Felder
/// dürfen leer sein. Docomo schreibt das Escape-Zeichen als `¥` (in
/// Shift-JIS derselbe Code wie `\`); als Unicode kommt es mitunter als
/// echtes `¥` an.
ParsedContent _meBookmark(String body) {
  final escaped = body.replaceAllMapped(
    RegExp(r'¥([:;,\\¥])'),
    (m) => '\\${m[1]}',
  );
  final f = {for (final (k, v) in _docomoFields(escaped)) k: v};
  return ParsedContent(
    ContentKind.bookmark,
    _nonEmpty([
      _field(FieldLabel.title, f['TITLE']),
      _field(FieldLabel.link, f['URL']),
    ]),
  );
}

ParsedContent? _wifi(String body) {
  final f = {for (final (k, v) in _docomoFields(body)) k: v};
  final type = (f['T'] ?? '').trim();
  final password = f['P'] ?? '';
  if ((f['S'] ?? '').trim().isEmpty) return null;
  final open =
      type.toLowerCase() == 'nopass' || (type.isEmpty && password.isEmpty);
  return ParsedContent(
    ContentKind.wifi,
    _nonEmpty([
      _field(FieldLabel.network, f['S']),
      ContentField(FieldLabel.security, open ? 'nopass' : type),
      if (!open) _field(FieldLabel.password, password),
      if ((f['H'] ?? '').toLowerCase() == 'true')
        const ContentField(FieldLabel.hidden, 'true'),
      _field(FieldLabel.eapMethod, f['E']),
      _field(FieldLabel.identity, f['I']),
    ]),
  );
}

// ---------------------------------------------------------------------------
// URI-Schemata
// ---------------------------------------------------------------------------

/// Teilt `adresse?key=value&…` in Adresse und Parameter.
(String, Map<String, String>) _uriParts(String s) {
  final q = s.indexOf('?');
  final address = _decodePercent(q < 0 ? s : s.substring(0, q));
  final params = <String, String>{};
  if (q >= 0) {
    for (final pair in s.substring(q + 1).split('&')) {
      final eq = pair.indexOf('=');
      if (eq <= 0) continue;
      final key = pair.substring(0, eq).toLowerCase();
      final value = _decodePercent(pair.substring(eq + 1));
      params[key] = params.containsKey(key) ? '${params[key]}, $value' : value;
    }
  }
  return (address.trim(), params);
}

ParsedContent _mailto(String s) {
  final (address, p) = _uriParts(s);
  final to = [
    if (address.isNotEmpty) address,
    if (p['to'] != null) p['to']!,
  ].join(', ');
  return ParsedContent(
    ContentKind.email,
    _nonEmpty([
      _field(FieldLabel.to, to),
      _field(FieldLabel.cc, p['cc']),
      _field(FieldLabel.bcc, p['bcc']),
      _field(FieldLabel.subject, p['subject']),
      _field(FieldLabel.message, p['body']),
    ]),
  );
}

/// ZXing: `SMTP:adresse:betreff:text`.
ParsedContent _smtp(String s) {
  final parts = s.split(':');
  return ParsedContent(
    ContentKind.email,
    _nonEmpty([
      _field(FieldLabel.to, parts[0]),
      if (parts.length > 1) _field(FieldLabel.subject, parts[1]),
      if (parts.length > 2)
        _field(FieldLabel.message, parts.sublist(2).join(':')),
    ]),
  );
}

ParsedContent _tel(String s) => ParsedContent(ContentKind.phone, [
  ContentField(FieldLabel.number, _decodePercent(s).trim()),
]);

/// `sms:nummer?body=text` (RFC 5724) oder `SMSTO:nummer:text` (Docomo).
ParsedContent _sms(String s) {
  String number;
  String? message;
  final colon = s.indexOf(':');
  if (!s.contains('?') && colon >= 0) {
    number = s.substring(0, colon);
    message = s.substring(colon + 1);
  } else {
    final (address, p) = _uriParts(s);
    number = address;
    message = p['body'];
  }
  return ParsedContent(
    ContentKind.sms,
    _nonEmpty([
      _field(FieldLabel.number, number),
      _field(FieldLabel.message, message),
    ]),
  );
}

/// `geo:breite,länge[,höhe][;u=…][?q=…]`.
ParsedContent? _geo(String s) {
  final (address, p) = _uriParts(s);
  final coords = address.split(';').first.split(',');
  if (coords.length < 2) return null;
  final lat = double.tryParse(coords[0].trim());
  final lon = double.tryParse(coords[1].trim());
  if (lat == null || lon == null || lat.abs() > 90 || lon.abs() > 180) {
    return null;
  }
  return ParsedContent(
    ContentKind.geo,
    _nonEmpty([
      ContentField(FieldLabel.latitude, coords[0].trim()),
      ContentField(FieldLabel.longitude, coords[1].trim()),
      if (coords.length > 2) _field(FieldLabel.altitude, coords[2]),
      _field(FieldLabel.query, p['q']),
    ]),
  );
}

// ---------------------------------------------------------------------------
// EPC-QR (GiroCode)
// ---------------------------------------------------------------------------

/// Zeilen: BCD · Version · Zeichensatz · SCT · BIC · Name · IBAN ·
/// Betrag (EUR12.34) · Zweck-Code · Referenz · Verwendungszweck · Hinweis.
ParsedContent? _epc(String s) {
  final l = s.split(RegExp(r'\r?\n'));
  if (l.length < 7 || l[3].trim() != 'SCT') return null;
  String at(int i) => i < l.length ? l[i].trim() : '';
  final amountText = at(7);
  final m = RegExp(r'^([A-Z]{3})(\d+(?:\.\d{1,2})?)$').firstMatch(amountText);
  return ParsedContent(
    ContentKind.payment,
    _nonEmpty([
      _field(FieldLabel.recipient, at(5)),
      _field(FieldLabel.iban, at(6)),
      _field(FieldLabel.bic, at(4)),
      if (m != null)
        ContentField(
          FieldLabel.amount,
          m[2]!,
          amount: double.parse(m[2]!),
          currency: m[1],
        )
      else
        _field(FieldLabel.amount, amountText),
      _field(FieldLabel.remittance, at(10)),
      _field(FieldLabel.reference, at(9)),
      _field(FieldLabel.purpose, at(8)),
      _field(FieldLabel.info, at(11)),
    ]),
  );
}

// ---------------------------------------------------------------------------
// Einmalpasswort (otpauth)
// ---------------------------------------------------------------------------

/// `otpauth://totp/Anbieter:Konto?secret=…&issuer=…&algorithm=SHA1&digits=6
/// &period=30`; bei HOTP `counter` statt `period`. Fehlende Werte haben die
/// Standardwerte des Key Uri Format (SHA1, 6 Stellen, 30 Sekunden).
ParsedContent? _otpAuth(String s) {
  final slash = s.indexOf('/');
  if (slash <= 0) return null;
  final type = s.substring(0, slash).toLowerCase();
  if (type != 'totp' && type != 'hotp') return null;
  final (label, p) = _uriParts(s.substring(slash + 1));
  final secret = p['secret'];
  if (secret == null || secret.isEmpty) return null;
  final colon = label.indexOf(':');
  final labelIssuer = colon < 0 ? null : label.substring(0, colon).trim();
  final account = colon < 0 ? label : label.substring(colon + 1).trim();
  return ParsedContent(
    ContentKind.otp,
    _nonEmpty([
      _field(FieldLabel.issuer, p['issuer'] ?? labelIssuer),
      _field(FieldLabel.account, account),
      ContentField(FieldLabel.secret, secret),
      ContentField(FieldLabel.otpType, type.toUpperCase()),
      ContentField(
        FieldLabel.algorithm,
        (p['algorithm'] ?? 'SHA1').toUpperCase(),
      ),
      ContentField(FieldLabel.digits, p['digits'] ?? '6'),
      if (type == 'totp')
        ContentField(FieldLabel.period, p['period'] ?? '30')
      else
        _field(FieldLabel.counter, p['counter']),
    ]),
  );
}

// ---------------------------------------------------------------------------
// JSON
// ---------------------------------------------------------------------------

ParsedContent? _json(String s) {
  final Object? value;
  try {
    value = jsonDecode(s);
  } on FormatException {
    return null;
  }
  if (value is! Map && value is! List) return null;
  return ParsedContent(ContentKind.json, [
    ContentField(
      FieldLabel.json,
      const JsonEncoder.withIndent('  ').convert(value),
    ),
  ]);
}

// ---------------------------------------------------------------------------
// Artikelnummern
// ---------------------------------------------------------------------------

/// EAN-13, EAN-8, UPC-A, UPC-E, ITF-14. Präfix 978/979 ist ein Buch (ISBN),
/// 977 eine Zeitschrift (ISSN).
ParsedContent _product(String digits) {
  final g13 = gtin13(digits);
  final upcE = digits.length == 8 ? upcEToUpcA(digits) : null;
  // EAN-8 und UPC-E sind gleich lang; UPC-E prüft man über die Langform.
  final valid = gtinValid(digits) || (upcE != null && gtinValid(upcE));
  final prefix = digits.length == 8 ? null : gs1Prefix(g13 ?? '');
  final book = prefix?.range == Gs1Range.isbn;
  return ParsedContent(book ? ContentKind.book : ContentKind.product, [
    ContentField(book ? FieldLabel.isbn : FieldLabel.gtin, digits),
    if (book && isbn10(digits) != null)
      ContentField(FieldLabel.isbn10, isbn10(digits)!),
    if (prefix?.range == Gs1Range.issn)
      ContentField(FieldLabel.issn, issn(g13!)!),
    ContentField(FieldLabel.checkDigit, valid ? 'valid' : 'invalid'),
    if (prefix != null && !book && prefix.range != Gs1Range.issn)
      ContentField(
        FieldLabel.gs1Prefix,
        prefix.range == Gs1Range.country
            ? prefix.countryText
            : prefix.range.name,
      ),
  ]);
}

// ---------------------------------------------------------------------------
// Matter (Smart Home)
// ---------------------------------------------------------------------------

/// Verbindungsarten und Ablauf stehen als Namen in den Feldern und werden
/// beim Anzeigen übersetzt.
/// Bundeseinheitlicher Medikationsplan (BMP, KBV-Spezifikation, Anlage 3
/// zu § 31a SGB V): XML mit dem Wurzelelement `<MP v="…">` im
/// Data-Matrix-Code. Gesundheitsdaten – kommt nie in den Verlauf.
bool isMedicationPlan(String text) => _medicationPlan.hasMatch(text);

final _medicationPlan = RegExp(r'^\s*(<\?xml[^>]*\?>\s*)?<MP\s[^>]*\bv="\d+"');

/// Amazon-Transparency-Code: `AZ:` und eine zufällige alphanumerische
/// Seriennummer (meist 26 Zeichen); mehr steht nicht im Code.
final _transparency = RegExp(r'^AZ:[A-Za-z0-9]{10,40}$');

ParsedContent? _matter(String s) {
  final m = parseMatter(s);
  if (m == null) return null;
  String id(int v) =>
      '0x${v.toRadixString(16).toUpperCase().padLeft(4, '0')} ($v)';
  return ParsedContent(ContentKind.matter, [
    ContentField(FieldLabel.manualCode, m.manualCode),
    ContentField(FieldLabel.setupCode, m.passcode.toString().padLeft(8, '0')),
    ContentField(FieldLabel.vendorId, id(m.vendorId)),
    ContentField(FieldLabel.productId, id(m.productId)),
    ContentField(FieldLabel.discriminator, '${m.discriminator}'),
    if (m.discovery.isNotEmpty)
      ContentField(
        FieldLabel.discovery,
        m.discovery.map((d) => d.name).join(','),
      ),
    ContentField(FieldLabel.flow, m.flow.name),
  ]);
}
