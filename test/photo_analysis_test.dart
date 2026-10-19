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
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_viewer/main.dart';
import 'package:qr_viewer/photo_scan.dart';

import 'test_app.dart';

void main() {
  testWidgets('Dialog zeigt das Foto, Fortschritt und Hinweis', (tester) async {
    await tester.pumpWidget(
      testApp(PhotoAnalysisDialog(image: FileImage(File('foto.png')))),
    );
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('Foto wird ausgewertet …'), findsOneWidget);
  });

  group('scanPhoto', () {
    /// Schreibt ein leeres PNG mit [width] × [height] Pixeln.
    Future<String> png(Directory dir, int width, int height) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final image = await recorder.endRecording().toImage(width, height);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('${dir.path}/foto_${width}x$height.png');
      await file.writeAsBytes(data!.buffer.asUint8List());
      return file.path;
    }

    testWidgets('Treffer im Original: keine weiteren Versuche', (tester) async {
      await tester.runAsync(() async {
        final dir = Directory.systemTemp.createTempSync('qrv');
        addTearDown(() => dir.deleteSync(recursive: true));
        final path = await png(dir, 2400, 1800);
        final calls = <String>[];
        final found = await scanPhoto(path, (p) async {
          calls.add(p);
          return 'Code';
        });
        expect(found, 'Code');
        expect(calls, [path]);
      });
    });

    testWidgets('Ohne Treffer: verkleinert in der festen Reihenfolge', (
      tester,
    ) async {
      await tester.runAsync(() async {
        final dir = Directory.systemTemp.createTempSync('qrv');
        addTearDown(() => dir.deleteSync(recursive: true));
        final path = await png(dir, 2400, 1800);
        final widths = <int>[];
        final found = await scanPhoto(path, (p) async {
          if (p == path) return null;
          final codec = await ui.instantiateImageCodec(
            await File(p).readAsBytes(),
          );
          final frame = await codec.getNextFrame();
          widths.add(frame.image.width);
          expect(frame.image.height * 4, frame.image.width * 3);
          return widths.length == 3 ? 'Code' : null;
        });
        expect(found, 'Code');
        // 1600, 1024, 2000 – beim dritten Versuch gefunden.
        expect(widths, [1600, 1024, 2000]);
      });
    });

    testWidgets('Kleines Bild: nur Größen unterhalb der Bildgröße', (
      tester,
    ) async {
      await tester.runAsync(() async {
        final dir = Directory.systemTemp.createTempSync('qrv');
        addTearDown(() => dir.deleteSync(recursive: true));
        final path = await png(dir, 1200, 900);
        var calls = 0;
        final found = await scanPhoto<String>(path, (p) async {
          calls++;
          return null;
        });
        expect(found, isNull);
        // Original, 1024 und 800; 1600 und 2000 entfallen.
        expect(calls, 3);
      });
    });
  });
}
