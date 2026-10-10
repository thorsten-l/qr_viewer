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
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_viewer/camera_lens.dart';

import 'test_app.dart';

const _wide = ZoomStep(CameraLensType.wide, factor: 0.5);
const _main = ZoomStep(CameraLensType.normal, factor: 1);
const _crop2 = ZoomStep(CameraLensType.normal, factor: 2, digitalZoom: 2);
const _tele5 = ZoomStep(CameraLensType.zoom, factor: 5);

/// So meldet iOS ein iPhone 16 Pro Max (Reihenfolge wie AVFoundation).
const _proMax = [
  {'lens': 0, 'zoom': 1.0, 'factor': 1.0},
  {'lens': 1, 'zoom': 1.0, 'factor': 0.5},
  {'lens': 2, 'zoom': 1.0, 'factor': 5.0},
  {'lens': 0, 'zoom': 2.0, 'factor': 2.0},
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('de.l9g.qr_viewer/camera');

  void mockSteps(List<Map<String, Object>>? steps) =>
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            channel,
            steps == null ? null : (call) async => steps,
          );

  tearDown(() => mockSteps(null));

  group('Zoomstufen', () {
    test('iPhone 16 Pro Max: Auto · 0,5× · 1× · 2× · 5×', () async {
      mockSteps(_proMax);
      final choices = zoomChoices(await detectZoomSteps());
      expect(choices, [ZoomStep.auto, _wide, _main, _crop2, _tele5]);
    });

    test('Unbekannter Tele-Faktor steht zuletzt', () {
      const tele = ZoomStep(CameraLensType.zoom);
      expect(zoomChoices([tele, _main, _wide]), [
        ZoomStep.auto,
        _wide,
        _main,
        tele,
      ]);
    });

    test('Nur eine Stufe: nichts umzuschalten', () async {
      expect(zoomChoices([_main]), isEmpty);
      expect(zoomChoices([_main, _main]), isEmpty);
      mockSteps(const []);
      // Ohne native Stufen und ohne Kamera-Plugin: keine Stufen.
      expect(await detectZoomSteps(), isEmpty);
    });

    test('Ohne native Abfrage keine Stufen', () async {
      expect(await detectZoomSteps(), isEmpty);
    });

    test('Gespeicherte Stufe nur, wenn vorhanden', () {
      final choices = zoomChoices([_wide, _main, _crop2]);
      expect(_crop2.id, 'normal@2');
      expect(zoomStepFromId('normal@2', choices), _crop2);
      expect(zoomStepFromId('zoom@1', choices), ZoomStep.auto);
      expect(zoomStepFromId(null, choices), ZoomStep.auto);
    });

    test('Pixel 9a: logische Kamera mit 0,55× und digitalem 2×', () {
      const ultra = ZoomStep(
        CameraLensType.normal,
        factor: 0.55,
        digitalZoom: 0.55,
      );
      const digital2 = ZoomStep(
        CameraLensType.normal,
        factor: 2,
        digitalZoom: 2,
      );
      final choices = zoomChoices([_main, ultra, digital2], withAuto: false);
      expect(choices, [ultra, _main, digital2]);
      // Android: 0 = kleinstes Verhältnis, also Ultraweitwinkel.
      expect(ultra.initialZoom(TargetPlatform.android), 0);
      expect(zoomStepFromId(null, choices), _main);
    });

    test('Gleicher Faktor: eigenes Objektiv vor digitalem Zoom', () {
      const viaRatio = ZoomStep(
        CameraLensType.normal,
        factor: 0.5,
        digitalZoom: 0.5,
      );
      expect(zoomChoices([viaRatio, _main, _wide]), [
        ZoomStep.auto,
        _wide,
        _main,
      ]);
    });

    test('Startzoom je Plattform', () {
      expect(_main.initialZoom(TargetPlatform.iOS), isNull);
      // iOS: Skala 0–1 entspricht 1×–5×.
      expect(_crop2.initialZoom(TargetPlatform.iOS), 0.25);
      expect(_crop2.initialZoom(TargetPlatform.android), 2);
    });
  });

  testWidgets('Umschalter zeigt Faktoren und meldet die Auswahl', (
    tester,
  ) async {
    ZoomStep? picked;
    await tester.pumpWidget(
      testApp(
        Scaffold(
          body: Center(
            child: ZoomSelector(
              choices: zoomChoices([_wide, _main, _crop2, _tele5]),
              selected: ZoomStep.auto,
              onSelected: (s) => picked = s,
            ),
          ),
        ),
      ),
    );
    for (final label in ['Auto', '0,5×', '1×', '2×', '5×']) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.bySemanticsLabel('Ultraweitwinkel 0,5×'), findsOneWidget);
    expect(find.bySemanticsLabel('Teleobjektiv 5×'), findsOneWidget);

    await tester.tap(find.text('2×'));
    expect(picked, _crop2);
  });

  testWidgets('Englisch: Dezimalpunkt, ohne Faktor "Tele"', (tester) async {
    await tester.pumpWidget(
      testApp(
        Scaffold(
          body: ZoomSelector(
            choices: zoomChoices([
              _wide,
              _main,
              const ZoomStep(CameraLensType.zoom),
            ]),
            selected: _wide,
            onSelected: (_) {},
          ),
        ),
        locale: const Locale('en'),
      ),
    );
    expect(find.text('0.5×'), findsOneWidget);
    expect(find.text('Tele'), findsOneWidget);
  });
}
