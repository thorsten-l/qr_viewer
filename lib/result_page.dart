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
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'localization.dart';
import 'scan_mode.dart';

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
  });

  final String raw;
  final BarcodeType type;
  final BarcodeFormat format;

  Uri? get _webUri {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null || uri.host.isEmpty) return null;
    return (uri.scheme == 'http' || uri.scheme == 'https') ? uri : null;
  }

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
    final uri = _webUri;
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(typeLabel(type, l))),
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
              const SizedBox(height: 8),
              if (uri != null) ...[
                Text(
                  l.hostLine(uri.host),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      raw,
                      style: const TextStyle(
                        fontFamily: kContentFont,
                        fontSize: 20,
                      ),
                    ),
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
                      onPressed: () => copyWithFeedback(context, raw),
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
