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


import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeFormat;
import 'package:qr_viewer/code_image.dart';

void main() {
  test('QR-Code bleibt QR-Code', () {
    final (b, fallback) = chooseBarcode(BarcodeFormat.qrCode, 'hallo', null);
    expect(b.name, Barcode.qrCode().name);
    expect(fallback, isFalse);
  });

  test('gültige EAN-13 wird als EAN-13 gezeichnet', () {
    final (b, fallback) = chooseBarcode(
      BarcodeFormat.ean13,
      '4006381333931',
      null,
    );
    expect(b.name, Barcode.ean13().name);
    expect(fallback, isFalse);
  });

  test('ungültiger Inhalt für das Format ergibt QR-Code', () {
    final (b, fallback) = chooseBarcode(BarcodeFormat.ean13, 'abc', null);
    expect(b.name, Barcode.qrCode().name);
    expect(fallback, isTrue);
  });

  test('nicht zeichenbares Format ergibt QR-Code', () {
    expect(barcodeFor(BarcodeFormat.maxiCode), isNull);
    final (_, fallback) = chooseBarcode(BarcodeFormat.maxiCode, 'x', null);
    expect(fallback, isTrue);
  });

  test('Binärinhalt im Data Matrix bleibt Data Matrix', () {
    final bytes = Uint8List.fromList([0, 1, 2, 255, 128]);
    final (b, fallback) = chooseBarcode(BarcodeFormat.dataMatrix, '', bytes);
    expect(b.name, Barcode.dataMatrix().name);
    expect(fallback, isFalse);
  });
}
