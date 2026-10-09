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

import 'localization.dart';

/// Wird beim Bauen gesetzt, z. B.
/// `--dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)`.
const _buildDateDefine = String.fromEnvironment('BUILD_DATE');

const appAuthor = 'Thorsten Ludewig';

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
      content: Table(
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
      actions: [
        TextButton(
          onPressed: () => showLicensePage(
            context: context,
            applicationName: 'QR Viewer',
            applicationVersion: info.version,
          ),
          child: Text(l.licenses),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.close),
        ),
      ],
    );
  }
}
