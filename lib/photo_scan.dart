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

/// Code-Suche in einem gewählten Foto.
library;

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Lange Bildseite der verkleinerten Fassungen, in dieser Reihenfolge.
///
/// Schwierige Codes (z. B. graviert, mit Logo) erkennt Vision bzw. ML Kit
/// nur bei manchen Bildgrößen; in voller Kameraauflösung stört oft die
/// Oberflächenstruktur. Welche Größe klappt, schwankt von Foto zu Foto; mit
/// dieser Reihe wurden alle Testbilder erkannt (gravierter QR-Code mit Logo).
const kPhotoScanSizes = [1600, 1024, 2000, 800];

/// Sucht mit [analyze] einen Code im Foto unter [path]: erst im Original,
/// dann in verkleinerten Fassungen ([sizes]); das erste Ergebnis gilt.
Future<T?> scanPhoto<T extends Object>(
  String path,
  Future<T?> Function(String path) analyze, {
  List<int> sizes = kPhotoScanSizes,
}) async {
  final found = await analyze(path);
  if (found != null || sizes.isEmpty) return found;
  final bytes = await File(path).readAsBytes();
  final dir = await Directory.systemTemp.createTemp('qrv_photo');
  try {
    for (final size in sizes) {
      final png = await scaledPng(bytes, size);
      if (png == null) continue;
      final file = File('${dir.path}/scan_$size.png');
      await file.writeAsBytes(png);
      final result = await analyze(file.path);
      if (result != null) return result;
    }
    return null;
  } finally {
    await dir.delete(recursive: true);
  }
}

/// Verkleinert ein Bild auf [longSide] Pixel an der langen Seite (als PNG).
/// Null, wenn es schon so klein ist oder sich nicht dekodieren lässt.
Future<Uint8List?> scaledPng(Uint8List encoded, int longSide) async {
  final buffer = await ui.ImmutableBuffer.fromUint8List(encoded);
  final ui.ImageDescriptor descriptor;
  try {
    descriptor = await ui.ImageDescriptor.encoded(buffer);
  } on Exception {
    buffer.dispose();
    return null;
  }
  try {
    final long = max(descriptor.width, descriptor.height);
    if (longSide >= long) return null;
    // Nur die Breite vorgeben, damit das Seitenverhältnis erhalten bleibt.
    final codec = await descriptor.instantiateCodec(
      targetWidth: (descriptor.width * longSide / long).round(),
    );
    final frame = await codec.getNextFrame();
    codec.dispose();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    frame.image.dispose();
    return data?.buffer.asUint8List();
  } finally {
    descriptor.dispose();
    buffer.dispose();
  }
}
