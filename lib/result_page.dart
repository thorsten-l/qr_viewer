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
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_info.dart' show formatDateTime;
import 'binary_payload.dart';
import 'localization.dart';
import 'qr_content.dart';
import 'scan_mode.dart';
import 'vdv/vdv_ticket.dart';

/// Schrift für die Anzeige des QR-Inhalts (Source Code Pro, SIL OFL 1.1).
const kContentFont = 'SourceCodePro';

String typeLabel(BarcodeType type, AppLocalizations l) => switch (type) {
  BarcodeType.url => l.typeUrl,
  BarcodeType.wifi => l.typeWifi,
  BarcodeType.contactInfo => l.typeContact,
  BarcodeType.email => l.typeEmail,
  BarcodeType.phone => l.typePhone,
  BarcodeType.sms => l.typeSms,
  BarcodeType.geo => l.typeGeo,
  BarcodeType.calendarEvent => l.typeCalendar,
  BarcodeType.isbn => l.typeIsbn,
  BarcodeType.product => l.typeProduct,
  BarcodeType.driverLicense => l.typeDriverLicense,
  _ => l.typeText,
};

IconData typeIcon(BarcodeType type) => switch (type) {
  BarcodeType.url => Icons.link,
  BarcodeType.wifi => Icons.wifi,
  BarcodeType.contactInfo => Icons.person_outline,
  BarcodeType.email => Icons.mail_outline,
  BarcodeType.phone => Icons.phone_outlined,
  BarcodeType.sms => Icons.sms_outlined,
  BarcodeType.geo => Icons.place_outlined,
  BarcodeType.calendarEvent => Icons.event_outlined,
  BarcodeType.isbn => Icons.menu_book_outlined,
  BarcodeType.product => Icons.shopping_bag_outlined,
  BarcodeType.driverLicense => Icons.badge_outlined,
  _ => Icons.notes,
};

String kindLabel(ContentKind kind, AppLocalizations l) => switch (kind) {
  ContentKind.url => l.typeUrl,
  ContentKind.email => l.typeEmail,
  ContentKind.phone => l.typePhone,
  ContentKind.sms => l.typeSms,
  ContentKind.geo => l.typeGeo,
  ContentKind.contact => l.typeContact,
  ContentKind.event => l.typeCalendar,
  ContentKind.wifi => l.typeWifi,
  ContentKind.payment => l.typePayment,
  ContentKind.otp => l.typeOtp,
  ContentKind.text => l.typeText,
};

IconData kindIcon(ContentKind kind) => switch (kind) {
  ContentKind.url => Icons.link,
  ContentKind.email => Icons.mail_outline,
  ContentKind.phone => Icons.phone_outlined,
  ContentKind.sms => Icons.sms_outlined,
  ContentKind.geo => Icons.place_outlined,
  ContentKind.contact => Icons.person_outline,
  ContentKind.event => Icons.event_outlined,
  ContentKind.wifi => Icons.wifi,
  ContentKind.payment => Icons.account_balance_outlined,
  ContentKind.otp => Icons.key_outlined,
  ContentKind.text => Icons.notes,
};

/// Bezeichnung und Symbol eines Inhalts: das erkannte Format, sonst der
/// Typ, den die Plattform meldet (z. B. Produktcode bei EAN-13).
(String, IconData) contentKind(
  String raw,
  BarcodeType type,
  AppLocalizations l,
) {
  final kind = parseContent(raw).kind;
  return kind == ContentKind.text
      ? (typeLabel(type, l), typeIcon(type))
      : (kindLabel(kind, l), kindIcon(kind));
}

String fieldLabel(FieldLabel label, AppLocalizations l) => switch (label) {
  FieldLabel.name => l.fieldName,
  FieldLabel.nickname => l.fieldNickname,
  FieldLabel.organization => l.fieldOrganization,
  FieldLabel.jobTitle => l.fieldJobTitle,
  FieldLabel.phone => l.fieldPhone,
  FieldLabel.mobile => l.fieldMobile,
  FieldLabel.workPhone => l.fieldWorkPhone,
  FieldLabel.homePhone => l.fieldHomePhone,
  FieldLabel.fax => l.fieldFax,
  FieldLabel.email => l.fieldEmail,
  FieldLabel.website => l.fieldWebsite,
  FieldLabel.address => l.fieldAddress,
  FieldLabel.birthday => l.fieldBirthday,
  FieldLabel.note => l.fieldNote,
  FieldLabel.to => l.fieldTo,
  FieldLabel.cc => l.fieldCc,
  FieldLabel.bcc => l.fieldBcc,
  FieldLabel.subject => l.fieldSubject,
  FieldLabel.message => l.fieldMessage,
  FieldLabel.number => l.fieldNumber,
  FieldLabel.latitude => l.fieldLatitude,
  FieldLabel.longitude => l.fieldLongitude,
  FieldLabel.altitude => l.fieldAltitude,
  FieldLabel.query => l.fieldQuery,
  FieldLabel.title => l.fieldTitle,
  FieldLabel.link => l.fieldLink,
  FieldLabel.start => l.fieldStart,
  FieldLabel.end => l.fieldEnd,
  FieldLabel.location => l.fieldLocation,
  FieldLabel.description => l.fieldDescription,
  FieldLabel.network => l.fieldNetwork,
  FieldLabel.password => l.fieldPassword,
  FieldLabel.security => l.fieldSecurity,
  FieldLabel.hidden => l.fieldHidden,
  FieldLabel.eapMethod => l.fieldEapMethod,
  FieldLabel.identity => l.fieldIdentity,
  FieldLabel.recipient => l.fieldRecipient,
  FieldLabel.iban => l.fieldIban,
  FieldLabel.bic => l.fieldBic,
  FieldLabel.amount => l.fieldAmount,
  FieldLabel.purpose => l.fieldPurpose,
  FieldLabel.reference => l.fieldReference,
  FieldLabel.remittance => l.fieldRemittance,
  FieldLabel.info => l.fieldInfo,
  FieldLabel.issuer => l.fieldIssuer,
  FieldLabel.account => l.fieldAccount,
  FieldLabel.secret => l.fieldSecret,
  FieldLabel.otpType => l.fieldOtpType,
  FieldLabel.algorithm => l.fieldAlgorithm,
  FieldLabel.digits => l.fieldDigits,
  FieldLabel.period => l.fieldPeriod,
  FieldLabel.counter => l.fieldCounter,
};

/// Anzeigewert: Datum und Betrag passend zur Sprache, sonst der Text.
String fieldValue(ContentField f, AppLocalizations l, String locale) {
  final time = f.time;
  if (time != null) {
    final text = f.dateOnly
        ? DateFormat.yMd(locale).format(time)
        : formatDateTime(time, locale);
    return f.timeZone == null ? text : '$text (${f.timeZone})';
  }
  if (f.amount != null) {
    return NumberFormat.simpleCurrency(
      locale: locale,
      name: f.currency,
    ).format(f.amount);
  }
  return switch (f.label) {
    FieldLabel.hidden => l.valueYes,
    FieldLabel.security when f.value == 'nopass' => l.valueOpenNetwork,
    _ => f.value,
  };
}

Future<void> copyWithFeedback(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.copied)));
  }
}

// ---------------------------------------------------------------------------
// Ergebnis – zeigt nur an, öffnet nichts von selbst
// ---------------------------------------------------------------------------

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.raw,
    required this.type,
    this.format = BarcodeFormat.qrCode,
    this.binary = false,
  });

  /// Inhalt als Text; bei [binary] die Bytes als kompakter Hex-Text.
  final String raw;
  final BarcodeType type;
  final BarcodeFormat format;
  final bool binary;

  Future<void> _open(BuildContext context, Uri uri) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.openLinkTitle),
        content: SelectableText(
          uri.toString(),
          style: const TextStyle(fontFamily: kContentFont),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.l10n.open),
          ),
        ],
      ),
    );
    if (ok == true) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    final bytes = binary ? fromHex(raw) : null;
    final parsed = bytes == null ? parseContent(raw) : ParsedContent.text;
    final link = parsed.kind == ContentKind.url
        ? parsed[FieldLabel.link]
        : null;
    final uri = link == null ? null : webUri(link);
    // Eine bloße URL braucht keine Karte; sie steht schon im Rohinhalt.
    final showCard =
        parsed.kind != ContentKind.text &&
        !(parsed.kind == ContentKind.url && parsed.fields.length == 1);
    final title = bytes != null
        ? (isVdvTicket(bytes) ? l.vdvTicket : l.typeBinary)
        : parsed.kind != ContentKind.text
        ? kindLabel(parsed.kind, l)
        : typeLabel(type, l);
    final rawText = SelectableText(
      raw,
      style: const TextStyle(fontFamily: kContentFont, fontSize: 20),
    );
    final copyText = bytes == null ? raw : toSpacedHex(bytes);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l.formatLine(formatLabel(format, l)),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              if (bytes != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${l.typeBinary} · ${l.byteCount('${bytes.length}')}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
              const SizedBox(height: 8),
              if (uri != null) ...[
                Text(
                  l.hostLine(uri.host),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: Material(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: bytes == null
                        ? showCard
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ContentCard(content: parsed),
                                    const Divider(height: 32),
                                    Text(
                                      l.rawContent,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                    const SizedBox(height: 8),
                                    rawText,
                                  ],
                                )
                              : rawText
                        : isVdvTicket(bytes)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _VdvTicketCard(bytes: bytes),
                              ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                title: Text(l.rawData),
                                children: [_HexDump(bytes: bytes)],
                              ),
                            ],
                          )
                        : _HexDump(bytes: bytes),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: Text(l.copy),
                      onPressed: () => copyWithFeedback(context, copyText),
                    ),
                  ),
                  if (uri != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.open_in_new),
                        label: Text(l.openEllipsis),
                        onPressed: () => _open(context, uri),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Erkannte Felder eines Inhalts, jedes einzeln kopierbar.
class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.content});

  final ParsedContent content;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final labelStyle = theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(kindIcon(content.kind), color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              kindLabel(content.kind, l),
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final f in content.fields)
          Builder(
            builder: (context) {
              final name = fieldLabel(f.label, l);
              final value = fieldValue(f, l, locale);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: labelStyle),
                          SelectableText(
                            value,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: l.copyField(name),
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () => copyWithFeedback(context, value),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

/// Hex-Dump, der so viele Bytes pro Zeile zeigt, wie in die Breite passen.
class _HexDump extends StatelessWidget {
  const _HexDump({required this.bytes});

  final List<int> bytes;

  static const _fontSize = 16.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      // Source Code Pro: Zeichenbreite etwa 0,6 × Schriftgröße.
      final chars = constraints.maxWidth / (_fontSize * 0.6);
      final perLine = [
        16,
        8,
        4,
      ].firstWhere((n) => 6 + n * 3 - 1 <= chars, orElse: () => 4);
      return SelectableText(
        hexDump(bytes, perLine: perLine),
        style: const TextStyle(fontFamily: kContentFont, fontSize: _fontSize),
      );
    },
  );
}

/// Lesbare Ticketdaten einer statischen VDV-Berechtigung.
class _VdvTicketCard extends StatefulWidget {
  const _VdvTicketCard({required this.bytes});

  final List<int> bytes;

  @override
  State<_VdvTicketCard> createState() => _VdvTicketCardState();
}

class _VdvTicketCardState extends State<_VdvTicketCard> {
  late final Future<VdvDecodeResult> _result = decodeVdvTicket(
    Uint8List.fromList(widget.bytes),
  );

  @override
  Widget build(BuildContext context) => FutureBuilder<VdvDecodeResult>(
    future: _result,
    builder: (context, snap) {
      if (!snap.hasData) return const LinearProgressIndicator();
      final l = context.l10n;
      final t = snap.data!.ticket;
      if (t == null) {
        return Text(l.unknownIssuer(snap.data!.caReference ?? '?'));
      }
      final theme = Theme.of(context);
      final locale = Localizations.localeOf(context).toString();
      String? date(DateTime? d) => d == null ? null : formatDateTime(d, locale);
      final product = switch (t.product) {
        VdvProduct.deutschlandticket => l.productDeutschlandticket,
        VdvProduct.jobticket => l.productJobticket,
        VdvProduct.studentTicket => l.productStudentTicket,
        VdvProduct.other => null,
      };
      final rows = <(String, String?)>[
        (l.ticketNumber, '${t.ticketNumber}'),
        (
          l.ticketProduct,
          product == null ? '${t.productId}' : '$product (${t.productId})',
        ),
        (l.validFrom, date(t.validFrom)),
        (l.validUntil, date(t.validUntil)),
        (l.issuedAt, date(t.issuedAt)),
        (
          l.ticketHolder,
          t.holderName == null
              ? null
              : t.holderNameMasked
              ? '${t.holderName} (${l.nameMasked})'
              : t.holderName,
        ),
        (
          l.birthDate,
          t.birthDate == null
              ? null
              : DateFormat.yMd(locale).format(t.birthDate!),
        ),
        (l.organizations, '${t.issuerId} / ${t.operatorId}'),
        (
          l.travelClass,
          switch (t.serviceClass) {
            1 => l.firstClass,
            2 => l.secondClass,
            _ => null,
          },
        ),
        (
          l.ticketPrice,
          t.priceCents == null
              ? null
              : NumberFormat.simpleCurrency(
                  locale: locale,
                  name: 'EUR',
                ).format(t.priceCents! / 100),
        ),
      ];
      final label = theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.ticketData, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Table(
            columnWidths: const {0: IntrinsicColumnWidth()},
            children: [
              for (final (name, value) in rows)
                if (value != null)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 6),
                        child: Text(name, style: label),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: SelectableText(
                          value,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                t.signatureValid
                    ? Icons.verified_outlined
                    : Icons.gpp_bad_outlined,
                size: 18,
                color: t.signatureValid
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
              const SizedBox(width: 6),
              Text(t.signatureValid ? l.signatureValid : l.signatureInvalid),
            ],
          ),
        ],
      );
    },
  );
}
