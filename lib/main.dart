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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_info.dart';
import 'binary_payload.dart';
import 'camera_lens.dart';
import 'history.dart';
import 'photo_scan.dart';
import 'localization.dart';
import 'result_page.dart';
import 'scan_mode.dart';
import 'settings.dart';

const _scanModeKey = 'scan_mode';
const _zoomKey = 'camera_zoom';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString(
      'assets/fonts/SourceCodePro-OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(['Source Code Pro'], text);
    // Sendungsnummer des Post-Matrixcodes, siehe lib/deutsche_post.dart.
    yield LicenseEntryWithLineBreaks([
      'BinaryEye',
    ], await rootBundle.loadString('assets/licenses/BinaryEye-MIT.txt'));
  });
  final history = await ScanHistory.load();
  final settings = await AppSettings.load();
  final prefs = await SharedPreferences.getInstance();
  final mode = ScanMode.fromName(prefs.getString(_scanModeKey));
  // Auto bedeutet nur auf iOS etwas anderes als 1× (Makro-Umschaltung).
  final zooms = zoomChoices(
    await detectZoomSteps(),
    withAuto: defaultTargetPlatform == TargetPlatform.iOS,
  );
  final zoom = zoomStepFromId(prefs.getString(_zoomKey), zooms);
  runApp(
    QrViewerApp(
      history: history,
      settings: settings,
      initialMode: mode,
      zooms: zooms,
      initialZoom: zoom,
    ),
  );
}

class QrViewerApp extends StatelessWidget {
  const QrViewerApp({
    super.key,
    required this.history,
    required this.settings,
    this.initialMode = ScanMode.qr,
    this.zooms = const [],
    this.initialZoom = ZoomStep.auto,
  });

  final ScanHistory history;
  final AppSettings settings;
  final ScanMode initialMode;
  final List<ZoomStep> zooms;
  final ZoomStep initialZoom;

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
    // Über dem Navigator, damit jede Seite die Einstellungen sieht.
    builder: (context, child) =>
        SettingsScope(settings: settings, child: child!),
    home: ScannerPage(
      history: history,
      initialMode: initialMode,
      zooms: zooms,
      initialZoom: initialZoom,
    ),
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
    this.zooms = const [],
    this.initialZoom = ZoomStep.auto,
  });

  final ScanHistory history;
  final ScanMode initialMode;

  /// Wählbare Zoomstufen der Rückkamera, leer bei nur einer Stufe.
  final List<ZoomStep> zooms;
  final ZoomStep initialZoom;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late ScanMode _mode = widget.initialMode;
  late ZoomStep _zoom = widget.initialZoom;
  late MobileScannerController _controller = _createController();
  bool _handling = false;

  MobileScannerController _createController() => MobileScannerController(
    formats: _mode.formats,
    lensType: _zoom.lens,
    initialZoom: _zoom.initialZoom(defaultTargetPlatform),
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  /// Formate, Objektiv und Startzoom eines Scanners sind fest. Beim Wechsel wird der
  /// alte gestoppt und freigegeben, bevor der neue die Kamera übernimmt.
  Future<void> _replaceController(VoidCallback change) async {
    final old = _controller;
    await old.stop();
    await old.dispose();
    if (!mounted) return;
    setState(() {
      change();
      _controller = _createController();
    });
  }

  Future<void> _setMode(ScanMode mode) async {
    if (mode == _mode) return;
    await _replaceController(() => _mode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_scanModeKey, mode.name);
  }

  Future<void> _setZoom(ZoomStep zoom) async {
    if (zoom == _zoom) return;
    await _replaceController(() => _zoom = zoom);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_zoomKey, zoom.id);
  }

  /// Inhalt eines Codes als Text und ob er binär ist; null ohne Inhalt.
  /// Binärinhalte (z. B. VDV-eTickets) werden als Hex-Text weitergereicht.
  static (String, bool)? _contentOf(Barcode barcode) {
    final bytes = binaryContent(barcode);
    final raw = bytes != null ? toHex(bytes) : barcode.rawValue;
    if (raw == null || raw.isEmpty) return null;
    return (raw, bytes != null);
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;
    final content = _contentOf(barcode);
    if (content == null) return;

    _handling = true;
    HapticFeedback.mediumImpact();
    await _showResult(barcode, content);
    _handling = false;
  }

  /// Wählt ein Bild über die Fotoauswahl des Systems (ohne Leserecht auf die
  /// Mediathek) und liest den ersten Code darin, unabhängig von der Scan-Art.
  Future<void> _scanPhoto() async {
    if (_handling) return;
    _handling = true;
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );
      if (file == null || !mounted) return;
      final navigator = Navigator.of(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => PhotoAnalysisDialog(image: FileImage(File(file.path))),
      );
      final (found, _) = await (
        scanPhoto(file.path, _analyze),
        // Damit der Dialog bei schneller Auswertung nicht nur aufblitzt.
        Future<void>.delayed(const Duration(milliseconds: 800)),
      ).wait;
      navigator.pop();
      // Die Kopie der Fotoauswahl wird nicht mehr gebraucht.
      File(file.path).delete().ignore();
      if (found == null) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l.noCodeInPhoto)));
        return;
      }
      HapticFeedback.mediumImpact();
      await _showResult(found.$1, found.$2);
    } finally {
      _handling = false;
    }
  }

  /// Erster Code mit Inhalt in der Bilddatei; null, wenn keiner da ist.
  Future<(Barcode, (String, bool))?> _analyze(String path) async {
    final BarcodeCapture? capture;
    try {
      capture = await _controller.analyzeImage(path);
    } on MobileScannerBarcodeException {
      return null;
    }
    for (final barcode in capture?.barcodes ?? const <Barcode>[]) {
      final content = _contentOf(barcode);
      if (content != null) return (barcode, content);
    }
    return null;
  }

  /// Legt den Code im Verlauf ab und zeigt die Ergebnisseite.
  Future<void> _showResult(Barcode barcode, (String, bool) content) async {
    final (raw, binary) = content;
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
        if (SettingsScope.maybeOf(context)?.scanFromPhoto ?? false)
          IconButton(
            tooltip: context.l10n.pickPhoto,
            icon: const Icon(Icons.photo_outlined),
            onPressed: _scanPhoto,
          ),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, state, _) => IconButton(
            tooltip: context.l10n.torch,
            isSelected: state.torchState == TorchState.on,
            icon: const Icon(Icons.flashlight_off_outlined),
            selectedIcon: const Icon(Icons.flashlight_on),
            onPressed: state.torchState == TorchState.unavailable
                ? null
                : () => _controller.toggleTorch(),
          ),
        ),
        ScannerMenu(
          onSelected: (item) => switch (item) {
            ScannerMenuItem.history => _pauseScannerFor(
              (_) => HistoryPage(history: widget.history),
            ),
            ScannerMenuItem.settings => _pauseScannerFor(
              (_) => const SettingsPage(),
            ),
            ScannerMenuItem.info => showAppInfo(context),
          },
        ),
      ],
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: MobileScanner(
            key: ObjectKey(_controller),
            controller: _controller,
            onDetect: _onDetect,
          ),
        ),
        if (widget.zooms.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: SafeArea(
              child: Center(
                child: ZoomSelector(
                  choices: widget.zooms,
                  selected: _zoom,
                  onSelected: _setZoom,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

/// Zeigt das gewählte Foto, solange es nach Codes durchsucht wird.
class PhotoAnalysisDialog extends StatelessWidget {
  const PhotoAnalysisDialog({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
          const SizedBox(height: 12),
          Text(context.l10n.analyzingPhoto),
        ],
      ),
    ),
  );
}

/// Einträge des Menüs oben rechts auf der Scanner-Seite.
enum ScannerMenuItem {
  history(Icons.history),
  settings(Icons.settings_outlined),
  info(Icons.info_outline);

  const ScannerMenuItem(this.icon);

  final IconData icon;

  String label(AppLocalizations l) => switch (this) {
    history => l.history,
    settings => l.settings,
    info => l.info,
  };
}

/// Menü (☰) ganz rechts in der Kopfzeile der Scanner-Seite.
class ScannerMenu extends StatelessWidget {
  const ScannerMenu({super.key, required this.onSelected});

  final ValueChanged<ScannerMenuItem> onSelected;

  @override
  Widget build(BuildContext context) => PopupMenuButton<ScannerMenuItem>(
    tooltip: context.l10n.menu,
    icon: const Icon(Icons.menu),
    position: PopupMenuPosition.under,
    onSelected: onSelected,
    itemBuilder: (context) => [
      for (final item in ScannerMenuItem.values)
        PopupMenuItem(
          value: item,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(item.icon),
            title: Text(item.label(context.l10n)),
          ),
        ),
    ],
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
