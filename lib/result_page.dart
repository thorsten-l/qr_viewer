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

import 'binary_payload.dart';
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
    this.binary = false,
  });

  /// Inhalt als Text; bei [binary] die Bytes als kompakter Hex-Text.
  final String raw;
  final BarcodeType type;
  final BarcodeFormat format;
  final bool binary;

  Uri? get _webUri {
    if (binary) return null;
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
    final bytes = binary ? fromHex(raw) : null;
    final title = bytes == null
        ? typeLabel(type, l)
        : (isVdvTicket(bytes) ? l.vdvTicket : l.typeBinary);
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
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: bytes == null
                        ? SelectableText(
                            raw,
                            style: const TextStyle(
                              fontFamily: kContentFont,
                              fontSize: 20,
                            ),
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
