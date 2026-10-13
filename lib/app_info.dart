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
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'localization.dart';

/// Wird beim Bauen gesetzt, z. B.
/// `--dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)`.
const _buildDateDefine = String.fromEnvironment('BUILD_DATE');

const appAuthor = 'Thorsten Ludewig';

/// Fragen und Fehlerberichte; dieselbe Adresse steht im App Store.
final supportUri = Uri.parse('https://github.com/thorsten-l/qr_viewer/issues');

/// Anleitungen (PDF/ODT, Deutsch und Englisch) im Repository.
final manualsUri = Uri.parse(
  'https://github.com/thorsten-l/qr_viewer/tree/main/docs',
);

/// Datum und Uhrzeit im Format der jeweiligen Sprache.
String formatDateTime(DateTime d, String locale) =>
    DateFormat.yMd(locale).add_Hm().format(d.toLocal());

Future<void> showAppInfo(BuildContext context) async {
  final info = await PackageInfo.fromPlatform();
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (_) => AppInfoDialog(
      info: info,
      buildDate: DateTime.tryParse(_buildDateDefine),
    ),
  );
}

class AppInfoDialog extends StatelessWidget {
  const AppInfoDialog({super.key, required this.info, this.buildDate});

  final PackageInfo info;
  final DateTime? buildDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final (dateLabel, date) = buildDate != null
        ? (l.infoBuildDate, buildDate)
        : (l.infoInstalled, info.updateTime);

    TableRow row(String label, String value) => TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(value, style: theme.textTheme.bodyMedium),
        ),
      ],
    );

    return AlertDialog(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset('assets/app_icon.png', width: 64, height: 64),
      ),
      title: const Text('QR Viewer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              row(l.infoDeveloper, appAuthor),
              row(
                l.infoVersion,
                l.infoVersionValue(info.version, info.buildNumber),
              ),
              row(
                dateLabel,
                date != null ? formatDateTime(date, locale) : l.valueUnknown,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Vier gleich breite Knöpfe in zwei Reihen; Schließen unten rechts.
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.link),
                  label: _label(l.infoSupport),
                  style: _compact,
                  onPressed: () => launchUrl(
                    supportUri,
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.description_outlined),
                  label: _label(l.licenses),
                  style: _compact,
                  onPressed: () => showLicensePage(
                    context: context,
                    applicationName: 'QR Viewer',
                    applicationVersion: info.version,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.menu_book_outlined),
                  label: _label(l.infoManuals),
                  style: _compact,
                  onPressed: () => launchUrl(
                    manualsUri,
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.close),
                  label: _label(l.close),
                  style: _compact,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Knöpfe im Info-Dialog: gleich breit, daher wenig Innenabstand.
const _compact = ButtonStyle(
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
);

/// Beschriftung bleibt einzeilig und wird bei langen Übersetzungen kleiner.
Widget _label(String text) => FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(text, maxLines: 1, softWrap: false),
);
