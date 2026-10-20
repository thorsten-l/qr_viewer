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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_info.dart' show formatDateTime;
import 'binary_payload.dart';
import 'code_image.dart';
import 'content_actions.dart';
import 'deutsche_post.dart';
import 'gtin.dart';
import 'localization.dart';
import 'matter.dart';
import 'medication_plan.dart';
import 'qr_content.dart';
import 'scan_mode.dart';
import 'settings.dart';
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
  ContentKind.bookmark => l.typeBookmark,
  ContentKind.email => l.typeEmail,
  ContentKind.phone => l.typePhone,
  ContentKind.sms => l.typeSms,
  ContentKind.geo => l.typeGeo,
  ContentKind.contact => l.typeContact,
  ContentKind.event => l.typeCalendar,
  ContentKind.wifi => l.typeWifi,
  ContentKind.payment => l.typePayment,
  ContentKind.otp => l.typeOtp,
  ContentKind.product => l.typeProduct,
  ContentKind.book => l.typeIsbn,
  ContentKind.json => l.typeJson,
  ContentKind.matter => l.typeMatter,
  ContentKind.transparency => l.typeTransparency,
  ContentKind.postage => l.typePostage,
  ContentKind.text => l.typeText,
};

IconData kindIcon(ContentKind kind) => switch (kind) {
  ContentKind.url => Icons.link,
  ContentKind.bookmark => Icons.bookmark_outline,
  ContentKind.email => Icons.mail_outline,
  ContentKind.phone => Icons.phone_outlined,
  ContentKind.sms => Icons.sms_outlined,
  ContentKind.geo => Icons.place_outlined,
  ContentKind.contact => Icons.person_outline,
  ContentKind.event => Icons.event_outlined,
  ContentKind.wifi => Icons.wifi,
  ContentKind.payment => Icons.account_balance_outlined,
  ContentKind.otp => Icons.key_outlined,
  ContentKind.product => Icons.shopping_bag_outlined,
  ContentKind.book => Icons.menu_book_outlined,
  ContentKind.json => Icons.data_object,
  ContentKind.matter => Icons.home_outlined,
  ContentKind.transparency => Icons.verified_outlined,
  ContentKind.postage => Icons.local_post_office_outlined,
  ContentKind.text => Icons.notes,
};

/// Artikel-Strichcodes, deren Ziffern eine GTIN sind.
bool isProductFormat(BarcodeFormat format) => switch (format) {
  BarcodeFormat.ean13 ||
  BarcodeFormat.ean8 ||
  BarcodeFormat.upcA ||
  BarcodeFormat.upcE ||
  BarcodeFormat.itf14 => true,
  _ => false,
};

/// Erkannter Inhalt eines Codes, abhängig vom Format.
ParsedContent parseScan(String raw, BarcodeFormat format) =>
    parseContent(raw, productCode: isProductFormat(format));

/// Post-Matrixcode aus Binärdaten oder aus Text, den die Plattform als
/// Windows-1252 dekodiert hat; nur bei Data Matrix.
PostageStamp? postageStamp(String raw, BarcodeFormat format, bool binary) {
  if (format != BarcodeFormat.dataMatrix) return null;
  final bytes = binary ? fromHex(raw) : bytesFromCp1252(raw);
  return bytes == null ? null : parsePostageStamp(bytes);
}

String actionLabel(ContentAction a, AppLocalizations l) => switch (a) {
  ContentAction.open => l.openEllipsis,
  ContentAction.email => l.actionEmail,
  ContentAction.call => l.actionCall,
  ContentAction.sms => l.actionSms,
  ContentAction.map => l.actionMap,
  ContentAction.otp => l.actionOtp,
  ContentAction.lookUp => l.actionLookUp,
  ContentAction.addContact => l.actionAddContact,
  ContentAction.addEvent => l.actionAddEvent,
  ContentAction.track => l.actionTrack,
};

IconData actionIcon(ContentAction a) => switch (a) {
  ContentAction.open => Icons.open_in_new,
  ContentAction.email => Icons.mail_outline,
  ContentAction.call => Icons.call_outlined,
  ContentAction.sms => Icons.sms_outlined,
  ContentAction.map => Icons.map_outlined,
  ContentAction.otp => Icons.key_outlined,
  ContentAction.lookUp => Icons.search,
  ContentAction.addContact => Icons.person_add_alt,
  ContentAction.addEvent => Icons.event_available_outlined,
  ContentAction.track => Icons.local_shipping_outlined,
};

/// Erklärt in einfachen Worten, was für Daten [kind] sind.
String kindInfo(ContentKind kind, AppLocalizations l) => switch (kind) {
  ContentKind.text => l.infoKindText,
  ContentKind.url => l.infoKindUrl,
  ContentKind.bookmark => l.infoKindBookmark,
  ContentKind.email => l.infoKindEmail,
  ContentKind.phone => l.infoKindPhone,
  ContentKind.sms => l.infoKindSms,
  ContentKind.geo => l.infoKindGeo,
  ContentKind.contact => l.infoKindContact,
  ContentKind.event => l.infoKindEvent,
  ContentKind.wifi => l.infoKindWifi,
  ContentKind.payment => l.infoKindPayment,
  ContentKind.otp => l.infoKindOtp,
  ContentKind.product => l.infoKindProduct,
  ContentKind.book => l.infoKindBook,
  ContentKind.json => l.infoKindJson,
  ContentKind.matter => l.infoKindMatter,
  ContentKind.transparency => l.infoKindTransparency,
  ContentKind.postage => l.infoKindPostage,
};

/// Was beim Tippen auf die Aktion nach außen geht: Websites (Nachschlagen,
/// Sendungsverfolgung, Links) bekommen die Anfrage, sonst übernimmt eine
/// andere App die Daten. Null ohne Aktion.
String? actionInfo(ActionTarget? target, AppLocalizations l) {
  if (target == null) return null;
  final label = actionLabel(target.action, l).replaceAll('…', '').trim();
  final uri = target.uri;
  final web =
      uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      target.action != ContentAction.map;
  return web ? l.infoOnline(label, uri.host) : l.infoOtherApp(label);
}

/// Info-Knopf oben rechts in einer Datenkarte; öffnet [kindInfo], den
/// Hinweis zur lokalen Auswertung und ggf. [actionInfo].
class DataInfoButton extends StatelessWidget {
  const DataInfoButton({
    super.key,
    required this.title,
    required this.about,
    this.action,
  });

  final String title;
  final String about;
  final String? action;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return IconButton(
      tooltip: l.dataInfo,
      icon: const Icon(Icons.info_outline),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(about),
                const SizedBox(height: 12),
                Text(l.infoLocal),
                if (action != null) ...[
                  const SizedBox(height: 12),
                  Text(action!),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l.close),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bezeichnung und Symbol eines Inhalts: das erkannte Format, sonst der
/// Typ, den die Plattform meldet (z. B. Produktcode bei EAN-13).
(String, IconData) contentKind(
  String raw,
  BarcodeType type,
  AppLocalizations l, {
  BarcodeFormat format = BarcodeFormat.qrCode,
}) {
  if (postageStamp(raw, format, false) != null) {
    return (l.typePostage, kindIcon(ContentKind.postage));
  }
  final kind = parseScan(raw, format).kind;
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
  FieldLabel.gtin => l.fieldGtin,
  FieldLabel.checkDigit => l.fieldCheckDigit,
  FieldLabel.gs1Prefix => l.fieldGs1Prefix,
  FieldLabel.isbn => l.fieldIsbn,
  FieldLabel.isbn10 => l.fieldIsbn10,
  FieldLabel.issn => l.fieldIssn,
  FieldLabel.json => l.typeJson,
  FieldLabel.trackingNumber => l.fieldTrackingNumber,
  FieldLabel.serialNumber => l.fieldSerialNumber,
  FieldLabel.vendorId => l.fieldVendorId,
  FieldLabel.productId => l.fieldProductId,
  FieldLabel.discriminator => l.fieldDiscriminator,
  FieldLabel.setupCode => l.fieldSetupCode,
  FieldLabel.manualCode => l.fieldManualCode,
  FieldLabel.discovery => l.fieldDiscovery,
  FieldLabel.flow => l.fieldFlow,
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
    FieldLabel.checkDigit => f.value == 'valid' ? l.valueValid : l.valueInvalid,
    FieldLabel.gs1Prefix => switch (Gs1Range.values.asNameMap()[f.value]) {
      Gs1Range.inStore => l.valueInStore,
      Gs1Range.coupon => l.valueCoupon,
      Gs1Range.global => l.valueGs1Global,
      _ => f.value,
    },
    FieldLabel.flow => switch (MatterFlow.values.asNameMap()[f.value]) {
      MatterFlow.standard => l.valueFlowStandard,
      MatterFlow.userAction => l.valueFlowUserAction,
      MatterFlow.custom => l.valueFlowCustom,
      null => f.value,
    },
    FieldLabel.discovery =>
      f.value
          .split(',')
          .map(
            (name) => switch (MatterDiscovery.values.asNameMap()[name]) {
              MatterDiscovery.softAp => l.valueDiscoverySoftAp,
              MatterDiscovery.ble => 'Bluetooth LE',
              MatterDiscovery.onNetwork => l.valueDiscoveryOnNetwork,
              MatterDiscovery.wifiPaf => 'Wi-Fi PAF',
              null => name,
            },
          )
          .join(', '),
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

  /// Fragt nach und übergibt den Link an die zuständige App. Bei Web-Links
  /// fallen Tracking-Parameter weg.
  Future<void> _open(BuildContext context, Uri uri) async {
    final target = withoutTracking(uri);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.openLinkTitle),
        content: SelectableText(
          target.toString(),
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
    if (ok != true) return;
    var launched = false;
    try {
      launched = await launchUrl(target, mode: LaunchMode.externalApplication);
    } on PlatformException {
      launched = false;
    }
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.l10n.noAppFound)));
    }
  }

  Future<void> _run(BuildContext context, ActionTarget target) async {
    final uri = target.uri;
    if (uri != null) return _open(context, uri);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(utf8.encode(target.file!), mimeType: target.mimeType),
        ],
        fileNameOverrides: [target.fileName!],
        sharePositionOrigin: shareOrigin(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    final bytes = binary ? fromHex(raw) : null;
    final stamp = postageStamp(raw, format, binary);
    final parsed = stamp != null
        ? ParsedContent(ContentKind.postage, [
            ContentField(FieldLabel.trackingNumber, stamp.trackingNumber),
          ])
        : bytes == null
        ? parseScan(raw, format)
        : ParsedContent.text;
    final target = contentAction(parsed, raw);
    // Ohne freigeschaltete Aktionen zeigt die Seite nur an.
    final action = SettingsScope.actionsEnabled(context) ? target : null;
    final uri = target?.uri;
    final webHost = uri != null && uri.scheme.startsWith('http')
        ? uri.host
        : null;
    // Eine bloße URL braucht keine Karte; sie steht schon im Rohinhalt.
    final showCard =
        parsed.kind != ContentKind.text &&
        !(parsed.kind == ContentKind.url && parsed.fields.length == 1);
    final text = bytes != null ? latin1.decode(bytes) : raw;
    final medicationPlan = isMedicationPlan(text);
    final plan = medicationPlan ? parseMedicationPlan(text) : null;
    final title = medicationPlan
        ? l.typeMedicationPlan
        : parsed.kind != ContentKind.text
        ? kindLabel(parsed.kind, l)
        : bytes != null
        ? (isVdvTicket(bytes) ? l.vdvTicket : l.typeBinary)
        : typeLabel(type, l);
    final rawText = SelectableText(
      raw,
      style: const TextStyle(fontFamily: kContentFont, fontSize: 20),
    );
    final copyText = bytes == null ? raw : toSpacedHex(bytes);
    final hexDump = bytes == null ? null : _HexDump(bytes: bytes);

    final Widget body;
    if (plan != null) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MedicationPlanCard(plan: plan),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(bytes == null ? l.rawContent : l.rawData),
            children: [hexDump ?? rawText],
          ),
        ],
      );
    } else if (bytes != null && isVdvTicket(bytes)) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VdvTicketCard(bytes: bytes),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(l.rawData),
            children: [hexDump!],
          ),
        ],
      );
    } else if (showCard) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContentCard(content: parsed, action: action),
          const Divider(height: 32),
          Text(
            bytes == null ? l.rawContent : l.rawData,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          hexDump ?? rawText,
        ],
      );
    } else {
      body = hexDump ?? rawText;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Builder(
            builder: (context) => IconButton(
              tooltip: l.share,
              icon: const Icon(Icons.share_outlined),
              onPressed: () => SharePlus.instance.share(
                ShareParams(
                  text: copyText,
                  sharePositionOrigin: shareOrigin(context),
                ),
              ),
            ),
          ),
        ],
      ),
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
              if (parsed.kind == ContentKind.otp) ...[
                const SizedBox(height: 4),
                Text(
                  l.otpNotSaved,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
              if (medicationPlan) ...[
                const SizedBox(height: 4),
                Text(
                  l.medicationPlanNotSaved,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
              const SizedBox(height: 8),
              if (webHost != null) ...[
                Text(
                  l.hostLine(webHost),
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
                    child: body,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton.outlined(
                    tooltip: l.showCode,
                    icon: const Icon(Icons.qr_code_2),
                    onPressed: () => showCodeImage(
                      context,
                      raw: raw,
                      format: format,
                      bytes: bytes,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: Text(l.copy),
                      onPressed: () => copyWithFeedback(context, copyText),
                    ),
                  ),
                  if (action != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Builder(
                        builder: (context) => FilledButton.icon(
                          icon: Icon(actionIcon(action.action)),
                          label: Text(
                            actionLabel(action.action, l),
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () => _run(context, action),
                        ),
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

/// Ausgangspunkt des Teilen-Menüs; das iPad braucht ihn für das Popover.
Rect? shareOrigin(BuildContext context) {
  final box = context.findRenderObject();
  if (box is! RenderBox || !box.hasSize) return null;
  return box.localToGlobal(Offset.zero) & box.size;
}

/// Erkannte Felder eines Inhalts, jedes einzeln kopierbar.
class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.content, this.action});

  final ParsedContent content;

  /// Hauptaktion der Ergebnisseite; der Info-Dialog erklärt, was sie tut.
  final ActionTarget? action;

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
            Expanded(
              child: Text(
                kindLabel(content.kind, l),
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataInfoButton(
              title: kindLabel(content.kind, l),
              about: kindInfo(content.kind, l),
              action: actionInfo(action, l),
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
                            style: f.label == FieldLabel.json
                                ? const TextStyle(
                                    fontFamily: kContentFont,
                                    fontSize: 14,
                                  )
                                : theme.textTheme.bodyLarge,
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

/// Hex-Dump mit Textspalte, der so viele Bytes pro Zeile zeigt, wie in die
/// Breite passen (16 oder 8, dafür notfalls kleinere Schrift). Zeilen werden
/// nie umgebrochen, damit der Text immer rechts neben den Hex-Werten steht;
/// ist es zu schmal, lässt sich der Dump waagerecht scrollen.
class _HexDump extends StatelessWidget {
  const _HexDump({required this.bytes});

  final List<int> bytes;

  static TextStyle _style(double size) =>
      TextStyle(fontFamily: kContentFont, fontSize: size);

  /// Gemessene Breite einer Zeile mit [perLine] Bytes.
  static double _lineWidth(BuildContext context, int perLine, double size) {
    final painter = TextPainter(
      // Wie SelectableText: Stil des Umfelds (z. B. Zeichenabstand) plus
      // Schrift und Größe des Dumps.
      text: TextSpan(
        text: '0' * hexDumpWidth(perLine),
        style: DefaultTextStyle.of(context).style.merge(_style(size)),
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final width = painter.width;
    painter.dispose();
    return width;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final (perLine, size) = [(16, 16.0), (8, 16.0), (8, 14.0)].firstWhere(
        (c) => _lineWidth(context, c.$1, c.$2) <= constraints.maxWidth,
        orElse: () => (8, 12.0),
      );
      // Etwas Luft gegen Rundungsfehler, damit nichts umbricht.
      final width = _lineWidth(context, perLine, size).ceilToDouble() + 4;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: width < constraints.maxWidth ? constraints.maxWidth : width,
          child: SelectableText(
            hexDump(bytes, perLine: perLine),
            style: _style(size),
          ),
        ),
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
          Row(
            children: [
              Expanded(
                child: Text(l.ticketData, style: theme.textTheme.titleMedium),
              ),
              DataInfoButton(title: l.vdvTicket, about: l.infoKindVdv),
            ],
          ),
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

/// Lesbarer bundeseinheitlicher Medikationsplan (BMP). Überschriften,
/// Darreichungsformen und Einheiten stehen im Wortlaut der KBV, wie auf dem
/// Papierplan; Medikamente nur mit PZN lassen sich offline nicht benennen.
class _MedicationPlanCard extends StatelessWidget {
  const _MedicationPlanCard({required this.plan});

  final MedicationPlan plan;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final label = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final value = theme.textTheme.bodyMedium;

    Widget table(List<(String, String?)> rows) => Table(
      columnWidths: const {0: IntrinsicColumnWidth()},
      children: [
        for (final (name, v) in rows)
          if (v != null && v.isNotEmpty)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 6),
                  child: Text(name, style: label),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: SelectableText(v, style: value),
                ),
              ],
            ),
      ],
    );

    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );

    String? date(DateTime? d) =>
        d == null ? null : DateFormat.yMd(locale).format(d);
    final p = plan.parameters;
    final page = plan.root['a'];
    final pages = plan.root['z'];
    String? unit(String? v, String u) => v == null ? null : '$v $u';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.medication_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l.typeMedicationPlan,
                style: theme.textTheme.titleMedium,
              ),
            ),
            DataInfoButton(
              title: l.typeMedicationPlan,
              about: l.infoKindMedicationPlan,
            ),
          ],
        ),
        if (page != null && pages != null)
          Text(l.planPage(page, pages), style: label),
        heading(l.planPatient),
        table([
          (l.fieldName, plan.patientName),
          (l.birthDate, date(plan.birthDate) ?? plan.patient['b']),
          (l.planAllergies, p['ai']),
          (l.planPregnant, p['p'] == '1' ? '✓' : null),
          (l.planBreastfeeding, p['b'] == '1' ? '✓' : null),
          (l.planWeight, unit(p['w'], 'kg')),
          (l.planHeight, unit(p['h'], 'cm')),
          (l.planCreatinine, unit(p['c'], 'mg/dl')),
          (l.planMoreInfo, p['x'] == null ? null : planText(p['x']!)),
        ]),
        heading(l.planIssuedBy),
        table([
          (l.fieldName, plan.author['n']),
          (l.fieldAddress, plan.authorAddress),
          (l.fieldPhone, plan.author['p']),
          (l.fieldEmail, plan.author['e']),
          (
            l.planPrinted,
            plan.printedAt == null
                ? plan.author['t']
                : formatDateTime(plan.printedAt!, locale),
          ),
        ]),
        for (final s in plan.sections) ...[
          if (s.title != null)
            heading(s.title!)
          else
            const SizedBox(height: 12),
          for (final e in s.entries)
            switch (e) {
              PlanMedication() => _MedicationTile(med: e),
              PlanText() => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SelectableText(
                  e.extra == null ? e.text : '${e.text}\n${e.extra}',
                  style: value?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            },
        ],
      ],
    );
  }
}

/// Ein Medikationseintrag: Name, Form, Dosierung, Hinweis, Grund, PZN.
class _MedicationTile extends StatelessWidget {
  const _MedicationTile({required this.med});

  final PlanMedication med;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final weekday = med.weekday == null
        ? null
        // Der 1. Januar 2024 war ein Montag.
        : DateFormat.EEEE(locale).format(DateTime(2024, 1, med.weekday!));
    final scheme = med.scheme;
    final dosage = scheme == null
        ? null
        : [
            if (weekday != null) '$weekday:',
            scheme,
            if (med.unit != null) med.unit,
          ].join(' ');
    final title = med.name ?? (med.pzn == null ? '–' : 'PZN ${med.pzn}');
    final details = [
      if (med.form != null) med.form!,
      if (med.name != null && med.pzn != null) 'PZN ${med.pzn}',
    ].join(' · ');

    Widget line(String name, String? v) => v == null
        ? const SizedBox.shrink()
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '$name: ', style: muted),
                TextSpan(text: planText(v)),
              ],
            ),
          );

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Nur die PZN: Nachschlagen überlässt die App dem Nutzer.
              if (med.pzn != null)
                IconButton(
                  tooltip: l.copyField('PZN'),
                  icon: const Icon(Icons.copy, size: 20),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => copyWithFeedback(context, med.pzn!),
                ),
            ],
          ),
          if (details.isNotEmpty) Text(details, style: muted),
          const SizedBox(height: 4),
          line(l.planDosage, dosage),
          line(l.planHint, med['i']),
          line(l.planReason, med['r']),
          if (med['x'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                planText(med['x']!),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
        ],
      ),
    );
  }
}
