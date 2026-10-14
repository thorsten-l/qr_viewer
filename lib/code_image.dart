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

/// Grafische Anzeige des gescannten Codes in einem Dialog.
library;

import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeFormat;

import 'localization.dart';
import 'scan_mode.dart';

/// Zeichenbares Gegenstück zum gescannten Format; null, wenn es keins gibt
/// (Micro QR, MaxiCode, GS1 DataBar, unbekannt).
Barcode? barcodeFor(BarcodeFormat format) => switch (format) {
  BarcodeFormat.qrCode => Barcode.qrCode(),
  BarcodeFormat.ean13 => Barcode.ean13(drawEndChar: true),
  BarcodeFormat.ean8 => Barcode.ean8(),
  BarcodeFormat.upcA => Barcode.upcA(),
  BarcodeFormat.upcE => Barcode.upcE(),
  BarcodeFormat.code128 => Barcode.code128(),
  BarcodeFormat.code39 => Barcode.code39(),
  BarcodeFormat.code93 => Barcode.code93(),
  BarcodeFormat.codabar => Barcode.codabar(),
  BarcodeFormat.itf14 => Barcode.itf14(),
  BarcodeFormat.itf2of5 || BarcodeFormat.itf2of5WithChecksum => Barcode.itf(),
  BarcodeFormat.dataMatrix => Barcode.dataMatrix(),
  BarcodeFormat.pdf417 => Barcode.pdf417(),
  BarcodeFormat.aztec => Barcode.aztec(),
  _ => null,
};

/// Wählt das Originalformat, sofern es den Inhalt darstellen kann,
/// sonst einen QR-Code. Der zweite Wert sagt, ob ersatzweise QR gilt.
(Barcode, bool) chooseBarcode(
  BarcodeFormat format,
  String raw,
  Uint8List? bytes,
) {
  final original = barcodeFor(format);
  if (original != null) {
    final ok = bytes != null
        ? original.isValidBytes(bytes)
        : original.isValid(raw);
    if (ok) return (original, false);
  }
  return (Barcode.qrCode(), format != BarcodeFormat.qrCode);
}

/// Zeigt [raw] (bzw. [bytes] bei Binärinhalt) als Code im Dialog.
Future<void> showCodeImage(
  BuildContext context, {
  required String raw,
  required BarcodeFormat format,
  Uint8List? bytes,
}) {
  final l = context.l10n;
  final (barcode, fallback) = chooseBarcode(format, raw, bytes);
  final twoD =
      barcode.name == Barcode.qrCode().name ||
      barcode.name == Barcode.dataMatrix().name ||
      barcode.name == Barcode.aztec().name;
  Widget error(BuildContext ctx, String _) =>
      Text(l.codeTooLarge, textAlign: TextAlign.center);
  // Weißer Rand als Ruhezone, auch im dunklen Design lesbar.
  final image = bytes != null
      ? BarcodeWidget.fromBytes(
          barcode: barcode,
          data: bytes,
          drawText: false,
          errorBuilder: error,
        )
      : BarcodeWidget(
          barcode: barcode,
          data: raw,
          drawText: !twoD && barcode.name != Barcode.pdf417().name,
          style: const TextStyle(color: Colors.black),
          errorBuilder: error,
        );
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(formatLabel(fallback ? BarcodeFormat.qrCode : format, l)),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: AspectRatio(aspectRatio: twoD ? 1 : 2, child: image),
            ),
            if (fallback) ...[
              const SizedBox(height: 12),
              Text(l.shownAsQr(formatLabel(format, l))),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.close)),
      ],
    ),
  );
}
