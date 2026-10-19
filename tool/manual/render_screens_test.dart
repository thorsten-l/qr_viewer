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

// Rendert die Ergebnisseite der App für jedes Beispiel aus examples.json
// sowie Scan-Bildschirm, Verlauf und Info-Dialog als PNG nach
// build/manual/screens/<Sprache>/. Aufruf aus dem Projektordner:
//
//   MANUAL_LANG=de flutter test tool/manual/render_screens_test.dart
//   MANUAL_LANG=en flutter test tool/manual/render_screens_test.dart
//
// Liegt bewusst nicht in test/, damit `flutter test` es nicht mitläuft.

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_viewer/app_info.dart';
import 'package:qr_viewer/binary_payload.dart';
import 'package:qr_viewer/camera_lens.dart';
import 'package:qr_viewer/history.dart';
import 'package:qr_viewer/localization.dart';
import 'package:qr_viewer/main.dart';
import 'package:qr_viewer/scan_mode.dart';
import 'package:qr_viewer/result_page.dart';
import 'package:qr_viewer/settings.dart';
import 'package:qr_viewer/vdv/vdv_ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _lang = Platform.environment['MANUAL_LANG'] ?? 'de';
final _out = 'build/manual/screens/$_lang';
final _l = lookupAppLocalizations(Locale(_lang));

/// Logische Größe und Pixeldichte eines Pixel 9a.
const _size = Size(412, 915);
const _ratio = 2.625;

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final f in files) {
    final bytes = File(f).readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

Future<void> _loadFonts() async {
  final flutterRoot = Platform.environment['FLUTTER_ROOT']!;
  final m = '$flutterRoot/bin/cache/artifacts/material_fonts';
  await _loadFont('Roboto', [
    for (final w in ['Regular', 'Medium', 'Bold']) '$m/Roboto-$w.ttf',
  ]);
  await _loadFont('MaterialIcons', ['$m/MaterialIcons-Regular.otf']);
  await _loadFont('SourceCodePro', ['assets/fonts/SourceCodePro-Regular.ttf']);
  // Für die Länderflaggen bei Produktnummern.
  await _loadFont('Emoji', ['/System/Library/Fonts/Apple Color Emoji.ttc']);
}

Widget _app(Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  locale: Locale(_lang),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: kSupportedLocales,
  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
    fontFamilyFallback: const ['Emoji'],
  ),
  // Die Anleitung zeigt die Aktionsknöpfe, also mit eingeschalteten Aktionen.
  builder: (context, child) =>
      SettingsScope(settings: AppSettings(actionsEnabled: true), child: child!),
  home: home,
);

void _phone(WidgetTester tester) {
  tester.view.physicalSize = _size * _ratio;
  tester.view.devicePixelRatio = _ratio;
  addTearDown(tester.view.reset);
}

BarcodeFormat _format(String name) =>
    BarcodeFormat.values.firstWhere((f) => f.name == name);

String _hex(Map<String, dynamic> e) {
  if (e['hex'] != null) return e['hex'] as String;
  return File(
    'tool/manual/${e['hex_file']}',
  ).readAsStringSync().replaceAll(RegExp(r'\s'), '').toUpperCase();
}

Future<void> _capture(WidgetTester tester, GlobalKey key, String name) async {
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: _ratio);
    final png = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$_out/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(png!.buffer.asUint8List());
  });
}

/// Wartet, bis asynchron geladene Inhalte (VDV-Schlüssel) da sind.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final examples =
      (jsonDecode(File('tool/manual/examples.json').readAsStringSync()) as List)
          .cast<Map<String, dynamic>>();

  setUpAll(_loadFonts);

  for (final e in examples) {
    testWidgets('Bildschirm ${e['id']}', (tester) async {
      _phone(tester);
      final binary = e['binary'] == true;
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: _app(
            ResultPage(
              raw: binary ? _hex(e) : e['raw'] as String,
              type: BarcodeType.text,
              // Wie das Gerät das Format meldet, falls abweichend.
              format: _format((e['shown_format'] ?? e['format']) as String),
              binary: binary,
            ),
          ),
        ),
      );
      await _settle(tester);
      await _capture(tester, key, e['id'] as String);

      // Zusätzlich Info-Dialog und Link-Rückfrage für den Hauptteil.
      if (e['id'] == 'qr_url' || e['id'] == 'qr_contact') {
        final info = find.byIcon(Icons.info_outline);
        if (info.evaluate().isNotEmpty) {
          await tester.tap(info.first);
          await tester.pumpAndSettle();
          await _capture(tester, key, '${e['id']}_info');
          await tester.tap(find.text(_l.close));
          await tester.pumpAndSettle();
        }
      }
      if (e['id'] == 'qr_url') {
        await tester.tap(find.byIcon(Icons.qr_code_2));
        await tester.pumpAndSettle();
        await _capture(tester, key, 'qr_url_code');
        await tester.tap(find.text(_l.close));
        await tester.pumpAndSettle();
        await tester.tap(find.text(_l.openEllipsis));
        await tester.pumpAndSettle();
        await _capture(tester, key, 'qr_url_confirm');
      }
    });
  }

  test('Test-Ticket lässt sich mit dem Test-CA-Schlüssel lesen', () async {
    final hex = _hex({'hex_file': 'vdv_test_ticket.hex'});
    final ca = File('tool/manual/vdv_test_ca.vdv-cert').readAsBytesSync();
    final result = await decodeVdvTicket(
      fromHex(hex),
      loader: (car) async => car == '5858544553543236' ? ca : null,
    );
    final t = result.ticket!;
    expect(t.holderName, 'Max Mustermann');
    expect(t.holderNameMasked, isFalse);
    expect(t.birthDate, DateTime(1990, 1, 1));
    expect(t.ticketNumber, 123456789);
    expect(t.signatureValid, isTrue);
    // Ohne den Test-Schlüssel, wie in der App.
    final unknown = await decodeVdvTicket(
      fromHex(hex),
      loader: (_) async => null,
    );
    expect(unknown.ticket, isNull);
    expect(unknown.caReference, '5858544553543236');
  });

  testWidgets('Bildschirm Verlauf', (tester) async {
    _phone(tester);
    // Liegt außerhalb von test/, daher hält der Analyzer es nicht für einen Test.
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    // ignore: invalid_use_of_visible_for_testing_member
    FlutterSecureStorage.setMockInitialValues({});
    final history = (await tester.runAsync(ScanHistory.load))!;
    var time = DateTime(2026, 10, 13, 9, 0);
    for (final id in [
      'ean13_isbn',
      'qr_geo',
      'datamatrix_post',
      'qr_wifi',
      'aztec_vdv',
      'qr_contact',
      'ean13',
      'qr_url',
    ]) {
      final e = examples.firstWhere((x) => x['id'] == id);
      final binary = e['binary'] == true;
      time = time.add(const Duration(minutes: 7));
      await tester.runAsync(
        () => history.add(
          binary ? _hex(e) : e['raw'] as String,
          BarcodeType.text,
          format: _format(e['format'] as String),
          binary: binary,
          time: time,
        ),
      );
    }
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: _app(HistoryPage(history: history)),
      ),
    );
    await tester.pumpAndSettle();
    await _capture(tester, key, 'history');
  });

  testWidgets('Bildschirm Scanner', (tester) async {
    _phone(tester);
    final key = GlobalKey();
    // Nachgestelltes Kamerabild: ein Code auf einem Tisch.
    final camera = DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
        ),
      ),
      child: Center(
        child: Transform.rotate(
          angle: -0.08,
          child: Container(
            width: 210,
            padding: const EdgeInsets.all(18),
            color: Colors.white,
            child: Image.memory(File('assets/app_icon.png').readAsBytesSync()),
          ),
        ),
      ),
    );
    const zooms = [
      ZoomStep(CameraLensType.wide, factor: 0.6),
      ZoomStep(CameraLensType.normal, factor: 1),
      ZoomStep(CameraLensType.normal, factor: 2, digitalZoom: 2),
    ];
    // Scan-Bildschirm wie in der App; mit [photo] samt Foto-Knopf.
    Widget scanner({bool photo = false}) => RepaintBoundary(
      key: key,
      child: _app(
        Scaffold(
          appBar: AppBar(
            titleSpacing: 4,
            title: ScanModeMenu(selected: ScanMode.qr, onSelected: (_) {}),
            actions: [
              if (photo)
                IconButton(
                  icon: const Icon(Icons.photo_outlined),
                  onPressed: () {},
                ),
              IconButton(
                icon: const Icon(Icons.flashlight_off_outlined),
                onPressed: () {},
              ),
              ScannerMenu(onSelected: (_) {}),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(child: camera),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: Center(
                  child: ZoomSelector(
                    choices: zooms,
                    selected: zooms[1],
                    onSelected: (_) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Future<void> loadImages() => tester.runAsync(() async {
      for (final element in find.byType(Image).evaluate()) {
        await precacheImage((element.widget as Image).image, element);
      }
    });

    await tester.pumpWidget(scanner());
    await loadImages();
    await tester.pumpAndSettle();
    await _capture(tester, key, 'scanner');
    await tester.tap(find.byType(ScanModeMenu));
    await tester.pumpAndSettle();
    await _capture(tester, key, 'scanner_menu');
    await tester.tapAt(const Offset(200, 600));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ScannerMenu));
    await tester.pumpAndSettle();
    await _capture(tester, key, 'scanner_app_menu');

    // Foto-Scan: Knopf eingeschaltet, Dialog während der Auswertung.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(scanner(photo: true));
    final photo = File('build/manual/codes/qr_url.png');
    if (!photo.existsSync()) {
      fail('build/manual/codes fehlt: erst make_manual.py ausführen');
    }
    final context = tester.element(find.byType(Scaffold));
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          PhotoAnalysisDialog(image: MemoryImage(photo.readAsBytesSync())),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await loadImages();
    // Der Fortschrittsbalken läuft endlos, daher kein pumpAndSettle.
    await tester.pump(const Duration(milliseconds: 300));
    await _capture(tester, key, 'photo_scan');
  });

  testWidgets('Bildschirm Einstellungen', (tester) async {
    _phone(tester);
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: _app(
          // Ab Werk: alles aus.
          SettingsScope(settings: AppSettings(), child: const SettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _capture(tester, key, 'settings');
  });

  testWidgets('Bildschirm Info-Dialog', (tester) async {
    _phone(tester);
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: _app(
          Scaffold(
            body: AppInfoDialog(
              info: PackageInfo(
                appName: 'QR Viewer',
                packageName: 'de.l9g.qr_viewer',
                version: '2.3.0',
                buildNumber: '15',
              ),
              buildDate: DateTime(2026, 10, 19, 8, 0),
            ),
          ),
        ),
      ),
    );
    // App-Symbol laden, sonst bleibt die Fläche leer.
    await tester.runAsync(() async {
      for (final element in find.byType(Image).evaluate()) {
        await precacheImage((element.widget as Image).image, element);
      }
    });
    await tester.pumpAndSettle();
    await _capture(tester, key, 'about');
  });
}
