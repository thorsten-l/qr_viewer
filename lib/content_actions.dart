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

import 'package:flutter/foundation.dart';

import 'deutsche_post.dart';
import 'qr_content.dart';

/// Was die Ergebnisseite mit einem erkannten Inhalt anbieten kann. Jede
/// Aktion startet erst nach Rückfrage eine andere App.
enum ContentAction {
  open,
  email,
  call,
  sms,
  map,
  otp,
  lookUp,
  addContact,
  addEvent,
  track,
}

/// Aktion mit Ziel: ein Link für [open] … [lookUp] und [track], sonst eine
/// Datei (vCard oder iCalendar), die über das Teilen-Menü an Kontakte bzw.
/// Kalender geht.
class ActionTarget {
  const ActionTarget.uri(this.action, Uri this.uri)
    : file = null,
      fileName = null,
      mimeType = null;

  const ActionTarget.file(
    this.action,
    String this.file,
    String this.fileName,
    String this.mimeType,
  ) : uri = null;

  final ContentAction action;
  final Uri? uri;
  final String? file;
  final String? fileName;
  final String? mimeType;
}

/// Hauptaktion zu [content]; [raw] ist der unveränderte Inhalt.
ActionTarget? contentAction(
  ParsedContent content,
  String raw, [
  TargetPlatform? platform,
]) {
  platform ??= defaultTargetPlatform;
  Uri? uri;
  switch (content.kind) {
    case ContentKind.url:
      final link = content[FieldLabel.link];
      final u = link == null ? null : linkUri(link);
      if (u != null) return ActionTarget.uri(ContentAction.open, u);
    case ContentKind.email:
      uri = mailtoUri(content);
      if (uri != null) return ActionTarget.uri(ContentAction.email, uri);
    case ContentKind.phone:
      final n = _dialable(content[FieldLabel.number]);
      if (n != null) {
        return ActionTarget.uri(ContentAction.call, Uri.parse('tel:$n'));
      }
    case ContentKind.sms:
      uri = smsUri(content, platform);
      if (uri != null) return ActionTarget.uri(ContentAction.sms, uri);
    case ContentKind.geo:
      uri = mapUri(content, platform);
      if (uri != null) return ActionTarget.uri(ContentAction.map, uri);
    case ContentKind.otp:
      final u = Uri.tryParse(raw.trim());
      if (u != null) return ActionTarget.uri(ContentAction.otp, u);
    case ContentKind.product:
      final gtin = content[FieldLabel.gtin];
      if (gtin != null) {
        return ActionTarget.uri(
          ContentAction.lookUp,
          Uri.https('duckduckgo.com', '/', {'q': gtin}),
        );
      }
    case ContentKind.book:
      final isbn = content[FieldLabel.isbn];
      if (isbn != null) {
        return ActionTarget.uri(
          ContentAction.lookUp,
          Uri.https('openlibrary.org', '/isbn/$isbn'),
        );
      }
    case ContentKind.postage:
      final n = content[FieldLabel.trackingNumber];
      if (n != null) {
        return ActionTarget.uri(
          ContentAction.track,
          PostageStamp(n).trackingUri,
        );
      }
    case ContentKind.contact:
      return ActionTarget.file(
        ContentAction.addContact,
        toVCard(raw, content),
        'contact.vcf',
        'text/vcard',
      );
    case ContentKind.event:
      final ics = toICalendar(raw);
      if (ics != null) {
        return ActionTarget.file(
          ContentAction.addEvent,
          ics,
          'event.ics',
          'text/calendar',
        );
      }
    case ContentKind.text ||
        ContentKind.wifi ||
        ContentKind.payment ||
        ContentKind.json:
      break;
  }
  return null;
}

/// Nur Ziffern, `+`, `*` und `#`; Leerzeichen und Trenner fallen weg.
String? _dialable(String? number) {
  if (number == null) return null;
  final n = number.replaceAll(RegExp(r'[^0-9+*#]'), '');
  return n.isEmpty ? null : n;
}

String _query(Map<String, String?> params) => [
  for (final MapEntry(:key, :value) in params.entries)
    if (value != null && value.isNotEmpty) '$key=${Uri.encodeComponent(value)}',
].join('&');

/// `mailto:` nach RFC 6068 aus Empfänger, Kopie, Betreff und Text.
Uri? mailtoUri(ParsedContent c) {
  final to = c[FieldLabel.to];
  if (to == null) return null;
  final address = to
      .split(',')
      .map((a) => Uri.encodeComponent(a.trim()).replaceAll('%40', '@'))
      .join(',');
  final q = _query({
    'cc': c[FieldLabel.cc],
    'bcc': c[FieldLabel.bcc],
    'subject': c[FieldLabel.subject],
    'body': c[FieldLabel.message],
  });
  return Uri.parse('mailto:$address${q.isEmpty ? '' : '?$q'}');
}

/// `sms:` mit Text; iOS erwartet `&body=` statt `?body=`.
Uri? smsUri(ParsedContent c, TargetPlatform platform) {
  final n = _dialable(c[FieldLabel.number]);
  if (n == null) return null;
  final body = c[FieldLabel.message];
  if (body == null || body.isEmpty) return Uri.parse('sms:$n');
  final sep = platform == TargetPlatform.iOS ? '&' : '?';
  return Uri.parse('sms:$n${sep}body=${Uri.encodeComponent(body)}');
}

/// Karte: Apple Karten unter iOS, sonst `geo:` für die Karten-App.
Uri? mapUri(ParsedContent c, TargetPlatform platform) {
  final lat = c[FieldLabel.latitude];
  final lon = c[FieldLabel.longitude];
  if (lat == null || lon == null) return null;
  final query = c[FieldLabel.query];
  if (platform == TargetPlatform.iOS) {
    return Uri.https('maps.apple.com', '/', {
      'll': '$lat,$lon',
      'q': query ?? '$lat,$lon',
    });
  }
  final q = query == null
      ? '$lat,$lon'
      : '$lat,$lon(${Uri.encodeComponent(query)})';
  return Uri.parse('geo:$lat,$lon?q=$q');
}

// ---------------------------------------------------------------------------
// Dateien für Kontakte und Kalender
// ---------------------------------------------------------------------------

String _vEscape(String s) => s
    .replaceAll(r'\', r'\\')
    .replaceAll(';', r'\;')
    .replaceAll(',', r'\,')
    .replaceAll('\n', r'\n');

/// vCard für das Adressbuch. Eine echte vCard bleibt unverändert, MECARD
/// und BIZCARD werden aus den erkannten Feldern als vCard 3.0 gebaut.
String toVCard(String raw, ParsedContent c) {
  final s = raw.trim();
  if (s.toUpperCase().startsWith('BEGIN:VCARD')) return _crlf(s);
  final lines = ['BEGIN:VCARD', 'VERSION:3.0'];
  final name = c[FieldLabel.name] ?? '';
  final parts = name.split(' ');
  final family = parts.length > 1 ? parts.last : name;
  final given = parts.length > 1 ? parts.take(parts.length - 1).join(' ') : '';
  lines
    ..add('N:${_vEscape(family)};${_vEscape(given)};;;')
    ..add('FN:${_vEscape(name)}');
  for (final f in c.fields) {
    final v = _vEscape(f.value);
    final line = switch (f.label) {
      FieldLabel.nickname => 'NICKNAME:$v',
      FieldLabel.organization => 'ORG:$v',
      FieldLabel.jobTitle => 'TITLE:$v',
      FieldLabel.phone => 'TEL:$v',
      FieldLabel.mobile => 'TEL;TYPE=CELL:$v',
      FieldLabel.workPhone => 'TEL;TYPE=WORK:$v',
      FieldLabel.homePhone => 'TEL;TYPE=HOME:$v',
      FieldLabel.fax => 'TEL;TYPE=FAX:$v',
      FieldLabel.email => 'EMAIL:$v',
      FieldLabel.website => 'URL:${f.value}',
      // Die Adresse ist schon aufbereitet; sie kommt ins Feld Straße.
      FieldLabel.address => 'ADR:;;$v;;;;',
      FieldLabel.birthday => 'BDAY:${f.value}',
      FieldLabel.note => 'NOTE:$v',
      _ => null,
    };
    if (line != null) lines.add(line);
  }
  lines.add('END:VCARD');
  return '${lines.join('\r\n')}\r\n';
}

/// iCalendar-Datei; ein einzelnes VEVENT wird in VCALENDAR verpackt.
String? toICalendar(String raw) {
  final s = raw.trim();
  final upper = s.toUpperCase();
  if (upper.startsWith('BEGIN:VCALENDAR')) return _crlf(s);
  if (!upper.startsWith('BEGIN:VEVENT')) return null;
  return _crlf(
    'BEGIN:VCALENDAR\nVERSION:2.0\nPRODID:-//l9g.de//QR Viewer//EN\n'
    '$s\nEND:VCALENDAR',
  );
}

/// Zeilenenden nach RFC 5545/6350 (CRLF), auch für die letzte Zeile.
String _crlf(String s) =>
    '${s.replaceAll('\r\n', '\n').replaceAll('\r', '\n').split('\n').join('\r\n')}\r\n';
