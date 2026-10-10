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
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_info.dart' show formatDateTime;
import 'binary_payload.dart';
import 'localization.dart';
import 'result_page.dart';
import 'scan_mode.dart';

class ScanEntry {
  const ScanEntry({
    required this.raw,
    required this.type,
    required this.time,
    this.format = BarcodeFormat.qrCode,
    this.binary = false,
  });

  /// Inhalt als Text; bei [binary] die Bytes als kompakter Hex-Text.
  final String raw;
  final bool binary;
  final BarcodeType type;
  final BarcodeFormat format;
  final DateTime time;

  Map<String, Object> toJson() => {
    'raw': raw,
    'type': type.name,
    'format': format.name,
    'time': time.toIso8601String(),
    if (binary) 'binary': true,
  };

  static ScanEntry? fromJson(Object? json) {
    if (json is! Map) return null;
    final raw = json['raw'];
    final time = DateTime.tryParse('${json['time']}');
    if (raw is! String || time == null) return null;
    final type =
        BarcodeType.values.asNameMap()[json['type']] ?? BarcodeType.text;
    // Einträge aus Version 1.0.x haben kein Format; das war immer QR.
    final format =
        BarcodeFormat.values.asNameMap()[json['format']] ??
        BarcodeFormat.qrCode;
    return ScanEntry(
      raw: raw,
      type: type,
      format: format,
      time: time,
      binary: json['binary'] == true,
    );
  }
}

/// Die letzten [maxEntries] gescannten Inhalte, dauerhaft gespeichert.
class ScanHistory extends ChangeNotifier {
  ScanHistory._(this._prefs, this._entries);

  static const maxEntries = 25;
  static const _key = 'scan_history_v1';

  final SharedPreferences _prefs;
  final List<ScanEntry> _entries;

  List<ScanEntry> get entries => List.unmodifiable(_entries);

  static Future<ScanHistory> load() async {
    final prefs = await SharedPreferences.getInstance();
    var entries = <ScanEntry>[];
    try {
      final list = jsonDecode(prefs.getString(_key) ?? '[]');
      if (list is List) {
        entries = list.map(ScanEntry.fromJson).nonNulls.toList();
      }
    } on FormatException {
      // Beschädigte Daten: mit leerem Verlauf weitermachen.
    }
    return ScanHistory._(prefs, entries.take(maxEntries).toList());
  }

  /// Fügt einen Inhalt oben ein. Ein bereits vorhandener gleicher Inhalt
  /// wird nach oben verschoben statt doppelt gespeichert.
  Future<void> add(
    String raw,
    BarcodeType type, {
    BarcodeFormat format = BarcodeFormat.qrCode,
    bool binary = false,
    DateTime? time,
  }) async {
    _entries
      ..removeWhere((e) => e.raw == raw)
      ..insert(
        0,
        ScanEntry(
          raw: raw,
          type: type,
          format: format,
          time: time ?? DateTime.now(),
          binary: binary,
        ),
      );
    if (_entries.length > maxEntries) {
      _entries.removeRange(maxEntries, _entries.length);
    }
    notifyListeners();
    await _save();
  }

  Future<void> clear() async {
    _entries.clear();
    notifyListeners();
    await _save();
  }

  Future<void> _save() => _prefs.setString(
    _key,
    jsonEncode(_entries.map((e) => e.toJson()).toList()),
  );
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.history});

  final ScanHistory history;

  Future<void> _confirmClear(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.historyClearTitle),
        content: Text(ctx.l10n.historyClearBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.l10n.delete),
          ),
        ],
      ),
    );
    if (ok == true) await history.clear();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: history,
    builder: (context, _) {
      final entries = history.entries;
      final l = context.l10n;
      final locale = Localizations.localeOf(context).toString();
      return Scaffold(
        appBar: AppBar(
          title: Text(l.history),
          actions: [
            if (entries.isNotEmpty)
              IconButton(
                tooltip: l.historyClear,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmClear(context),
              ),
          ],
        ),
        body: entries.isEmpty
            ? Center(child: Text(l.historyEmpty))
            : ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = entries[i];
                  final shown = e.binary ? toSpacedHex(fromHex(e.raw)) : e.raw;
                  final (kind, icon) = e.binary
                      ? (
                          isVdvTicket(fromHex(e.raw))
                              ? l.vdvTicket
                              : l.typeBinary,
                          Icons.memory,
                        )
                      : contentKind(e.raw, e.type, l);
                  return ListTile(
                    leading: Icon(icon),
                    title: Text(
                      shown,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: kContentFont),
                    ),
                    subtitle: Text(
                      '${formatLabel(e.format, l)} · $kind · '
                      '${formatDateTime(e.time, locale)}',
                    ),
                    trailing: IconButton(
                      tooltip: l.copy,
                      icon: const Icon(Icons.copy),
                      onPressed: () => copyWithFeedback(context, shown),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          raw: e.raw,
                          type: e.type,
                          format: e.format,
                          binary: e.binary,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    },
  );
}
