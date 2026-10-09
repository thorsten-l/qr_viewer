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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_info.dart';
import 'binary_payload.dart';
import 'history.dart';
import 'localization.dart';
import 'result_page.dart';
import 'scan_mode.dart';

const _scanModeKey = 'scan_mode';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString(
      'assets/fonts/SourceCodePro-OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(['Source Code Pro'], text);
  });
  final history = await ScanHistory.load();
  final prefs = await SharedPreferences.getInstance();
  final mode = ScanMode.fromName(prefs.getString(_scanModeKey));
  runApp(QrViewerApp(history: history, initialMode: mode));
}

class QrViewerApp extends StatelessWidget {
  const QrViewerApp({
    super.key,
    required this.history,
    this.initialMode = ScanMode.qr,
  });

  final ScanHistory history;
  final ScanMode initialMode;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'QR Viewer',
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: kSupportedLocales,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      brightness: Brightness.dark,
    ),
    home: ScannerPage(history: history, initialMode: initialMode),
  );
}

// ---------------------------------------------------------------------------
// Scanner
// ---------------------------------------------------------------------------

class ScannerPage extends StatefulWidget {
  const ScannerPage({
    super.key,
    required this.history,
    this.initialMode = ScanMode.qr,
  });

  final ScanHistory history;
  final ScanMode initialMode;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late ScanMode _mode = widget.initialMode;
  late MobileScannerController _controller = _createController(_mode);
  bool _handling = false;

  static MobileScannerController _createController(ScanMode mode) =>
      MobileScannerController(
        formats: mode.formats,
        detectionSpeed: DetectionSpeed.noDuplicates,
      );

  /// Die Formate eines Scanners sind fest. Beim Wechsel wird der alte
  /// gestoppt und freigegeben, bevor der neue die Kamera übernimmt.
  Future<void> _setMode(ScanMode mode) async {
    if (mode == _mode) return;
    final old = _controller;
    await old.stop();
    await old.dispose();
    if (!mounted) return;
    setState(() {
      _mode = mode;
      _controller = _createController(mode);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_scanModeKey, mode.name);
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;
    // Binärinhalte (z. B. VDV-eTickets) werden als Hex-Text weitergereicht.
    final bytes = binaryContent(barcode);
    final binary = bytes != null;
    final raw = binary ? toHex(bytes) : barcode.rawValue;
    if (raw == null || raw.isEmpty) return;

    _handling = true;
    await widget.history.add(
      raw,
      barcode.type,
      format: barcode.format,
      binary: binary,
    );
    await _pauseScannerFor(
      (_) => ResultPage(
        raw: raw,
        type: barcode.type,
        format: barcode.format,
        binary: binary,
      ),
    );
    _handling = false;
  }

  /// Stoppt die Kamera, zeigt die Seite und startet die Kamera danach wieder.
  Future<void> _pauseScannerFor(WidgetBuilder builder) async {
    final controller = _controller;
    await controller.stop();
    if (!mounted) return;
    await Navigator.of(context).push(MaterialPageRoute(builder: builder));
    if (mounted && identical(controller, _controller)) {
      await controller.start();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 4,
      title: ScanModeMenu(selected: _mode, onSelected: _setMode),
      actions: [
        IconButton(
          tooltip: context.l10n.history,
          icon: const Icon(Icons.history),
          onPressed: () =>
              _pauseScannerFor((_) => HistoryPage(history: widget.history)),
        ),
        IconButton(
          tooltip: context.l10n.info,
          icon: const Icon(Icons.info_outline),
          onPressed: () => showAppInfo(context),
        ),
        IconButton(
          tooltip: context.l10n.torch,
          icon: const Icon(Icons.flashlight_on_outlined),
          onPressed: () => _controller.toggleTorch(),
        ),
      ],
    ),
    body: MobileScanner(
      key: ValueKey(_mode),
      controller: _controller,
      onDetect: _onDetect,
    ),
  );
}

/// Titel der Scanner-Seite als Auswahlmenü für die Scan-Art.
class ScanModeMenu extends StatelessWidget {
  const ScanModeMenu({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ScanMode selected;
  final ValueChanged<ScanMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l10n;
    return PopupMenuButton<ScanMode>(
      tooltip: l.chooseScanType,
      initialValue: selected,
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      itemBuilder: (_) => [
        for (final m in ScanMode.values)
          PopupMenuItem(
            value: m,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(m.icon),
              title: Text(m.label(l)),
              subtitle: Text(m.hint(l)),
              trailing: m == selected ? const Icon(Icons.check) : null,
            ),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                selected.title(l),
                overflow: TextOverflow.ellipsis,
                style:
                    theme.appBarTheme.titleTextStyle ??
                    theme.textTheme.titleLarge,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
