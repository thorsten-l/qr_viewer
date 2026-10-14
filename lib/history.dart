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
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_info.dart' show formatDateTime;
import 'binary_payload.dart';
import 'history_crypto.dart';
import 'localization.dart';
import 'qr_content.dart';
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

/// Die letzten [maxEntries] gescannten Inhalte, dauerhaft und mit
/// AES-256 verschlüsselt gespeichert (siehe history_crypto.dart).
class ScanHistory extends ChangeNotifier {
  ScanHistory._(this._prefs, this._cipher, this._entries);

  static const maxEntries = 25;

  /// Verschlüsselter Verlauf ab Version 2.2.0.
  static const _key = 'scan_history_v2';

  /// Klartext-Verlauf bis Version 2.1.x; wird beim Laden übernommen und
  /// gelöscht.
  static const _legacyKey = 'scan_history_v1';

  final SharedPreferences _prefs;

  /// Null, wenn der Schlüsselspeicher nicht erreichbar ist: Der Verlauf
  /// gilt dann nur bis zum Beenden der App.
  final HistoryCipher? _cipher;
  final List<ScanEntry> _entries;

  List<ScanEntry> get entries => List.unmodifiable(_entries);

  static Future<ScanHistory> load() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await loadHistoryKey();
    final cipher = key == null ? null : HistoryCipher(key);
    if (cipher == null) return ScanHistory._(prefs, null, []);

    final stored = prefs.getString(_key);
    final legacy = prefs.getString(_legacyKey);
    // Ohne passenden Schlüssel (z. B. nach Wiederherstellung auf einem
    // anderen Gerät) ist der alte Geheimtext wertlos: leer beginnen.
    final json = stored != null ? cipher.decrypt(stored) : legacy;
    var entries = <ScanEntry>[];
    try {
      final list = jsonDecode(json ?? '[]');
      if (list is List) {
        entries = list.map(ScanEntry.fromJson).nonNulls.toList();
      }
    } on FormatException {
      // Beschädigte Daten: mit leerem Verlauf weitermachen.
    }
    final history = ScanHistory._(
      prefs,
      cipher,
      entries.take(maxEntries).toList(),
    );
    if (legacy != null) {
      if (stored == null) await history._save();
      await prefs.remove(_legacyKey);
    }
    return history;
  }

  /// Einmalpasswort-Schlüssel (2FA) landen nicht im Verlauf, wie bei
  /// BinaryEye: Wer den Code noch einmal braucht, scannt ihn erneut.
  static bool shouldStore(String raw, {bool binary = false}) =>
      binary || parseContent(raw).kind != ContentKind.otp;

  /// Fügt einen Inhalt oben ein. Ein bereits vorhandener gleicher Inhalt
  /// wird nach oben verschoben statt doppelt gespeichert. 2FA-Schlüssel
  /// werden nicht gespeichert, siehe [shouldStore].
  Future<void> add(
    String raw,
    BarcodeType type, {
    BarcodeFormat format = BarcodeFormat.qrCode,
    bool binary = false,
    DateTime? time,
  }) async {
    if (!shouldStore(raw, binary: binary)) return;
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

  /// Entfernt [entry] und liefert seine Position für [restore], oder -1.
  Future<int> remove(ScanEntry entry) async {
    final index = _entries.indexOf(entry);
    if (index < 0) return -1;
    _entries.removeAt(index);
    notifyListeners();
    await _save();
    return index;
  }

  /// Setzt einen mit [remove] gelöschten Eintrag wieder ein.
  Future<void> restore(int index, ScanEntry entry) async {
    if (_entries.contains(entry)) return;
    _entries.insert(index.clamp(0, _entries.length), entry);
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

  Future<void> _save() async {
    final cipher = _cipher;
    if (cipher == null) return;
    await _prefs.setString(
      _key,
      cipher.encrypt(jsonEncode(_entries.map((e) => e.toJson()).toList())),
    );
  }
}

/// Verlauf als CSV nach RFC 4180: Zeit, Format, Typ, Binär, Inhalt.
/// Binärinhalte stehen als Hex mit Leerzeichen darin.
String historyCsv(List<ScanEntry> entries) {
  String cell(String v) =>
      RegExp(r'[",\r\n]').hasMatch(v) ? '"${v.replaceAll('"', '""')}"' : v;
  final rows = [
    'time,format,type,binary,content',
    for (final e in entries)
      [
        e.time.toIso8601String(),
        e.format.name,
        e.type.name,
        '${e.binary}',
        e.binary ? toSpacedHex(fromHex(e.raw)) : e.raw,
      ].map(cell).join(','),
  ];
  return '${rows.join('\r\n')}\r\n';
}

/// Verlauf als JSON-Liste im Speicherformat.
String historyJson(List<ScanEntry> entries) => const JsonEncoder.withIndent(
  '  ',
).convert(entries.map((e) => e.toJson()).toList());

/// Sichtbarer Inhalt, Formatname und Typ eines Eintrags für die Suche.
(String, String, IconData) _describe(ScanEntry e, AppLocalizations l) {
  final shown = e.binary ? toSpacedHex(fromHex(e.raw)) : e.raw;
  final (kind, icon) = e.binary
      ? postageStamp(e.raw, e.format, true) != null
            ? (l.typePostage, kindIcon(ContentKind.postage))
            : (
                isVdvTicket(fromHex(e.raw)) ? l.vdvTicket : l.typeBinary,
                Icons.memory,
              )
      : contentKind(e.raw, e.type, l, format: e.format);
  return (shown, kind, icon);
}

/// Einträge, deren Inhalt, Format oder Typ [query] enthält.
List<ScanEntry> filterHistory(
  List<ScanEntry> entries,
  String query,
  AppLocalizations l,
) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return entries;
  return [
    for (final e in entries)
      if ([
        _describe(e, l).$1,
        _describe(e, l).$2,
        formatLabel(e.format, l),
      ].any((t) => t.toLowerCase().contains(q)))
        e,
  ];
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.history});

  final ScanHistory history;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

enum _Export { csv, json }

class _HistoryPageState extends State<HistoryPage> {
  final _search = TextEditingController();
  bool _searching = false;

  ScanHistory get history => widget.history;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

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

  Future<void> _export(BuildContext context, _Export kind) async {
    final entries = history.entries;
    final (text, name, mime) = switch (kind) {
      _Export.csv => (historyCsv(entries), 'qr-viewer-history.csv', 'text/csv'),
      _Export.json => (
        historyJson(entries),
        'qr-viewer-history.json',
        'application/json',
      ),
    };
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(utf8.encode(text), mimeType: mime)],
        fileNameOverrides: [name],
        sharePositionOrigin: shareOrigin(context),
      ),
    );
  }

  Future<void> _delete(BuildContext context, ScanEntry e) async {
    final messenger = ScaffoldMessenger.of(context);
    final l = context.l10n;
    final index = await history.remove(e);
    if (index < 0) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l.historyEntryDeleted),
          action: SnackBarAction(
            label: l.undo,
            onPressed: () => history.restore(index, e),
          ),
        ),
      );
  }

  void _toggleSearch() => setState(() {
    _searching = !_searching;
    if (!_searching) _search.clear();
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([history, _search]),
    builder: (context, _) {
      final l = context.l10n;
      final all = history.entries;
      final entries = filterHistory(all, _search.text, l);
      final locale = Localizations.localeOf(context).toString();
      return Scaffold(
        appBar: AppBar(
          title: _searching
              ? TextField(
                  controller: _search,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: l.historySearch,
                    border: InputBorder.none,
                  ),
                )
              : Text(l.history),
          actions: [
            if (all.isNotEmpty || _searching)
              IconButton(
                tooltip: l.historySearch,
                icon: Icon(_searching ? Icons.close : Icons.search),
                onPressed: _toggleSearch,
              ),
            if (all.isNotEmpty && !_searching) ...[
              PopupMenuButton<_Export>(
                tooltip: l.historyExport,
                icon: const Icon(Icons.ios_share),
                onSelected: (k) => _export(context, k),
                itemBuilder: (_) => [
                  PopupMenuItem(value: _Export.csv, child: Text(l.exportCsv)),
                  PopupMenuItem(value: _Export.json, child: Text(l.exportJson)),
                ],
              ),
              IconButton(
                tooltip: l.historyClear,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmClear(context),
              ),
            ],
          ],
        ),
        body: all.isEmpty
            ? Center(child: Text(l.historyEmpty))
            : entries.isEmpty
            ? Center(child: Text(l.historyNoMatches))
            : ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = entries[i];
                  final (shown, kind, icon) = _describe(e, l);
                  return Dismissible(
                    key: ObjectKey(e),
                    background: Container(
                      color: Theme.of(context).colorScheme.errorContainer,
                      alignment: AlignmentDirectional.centerEnd,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _delete(context, e),
                    child: ListTile(
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
                    ),
                  );
                },
              ),
      );
    },
  );
}
