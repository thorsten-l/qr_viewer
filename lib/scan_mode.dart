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
import 'package:mobile_scanner/mobile_scanner.dart';

import 'localization.dart';

/// Auswählbare Scan-Arten. Jede Art beschränkt den Scanner auf ihre Formate,
/// das macht die Erkennung schneller und vermeidet Fehltreffer.
enum ScanMode {
  qr(Icons.qr_code_2, [BarcodeFormat.qrCode]),
  barcode(Icons.view_week_outlined, [
    BarcodeFormat.ean13,
    BarcodeFormat.ean8,
    BarcodeFormat.upcA,
    BarcodeFormat.upcE,
    BarcodeFormat.code128,
    BarcodeFormat.code39,
    BarcodeFormat.code93,
    BarcodeFormat.codabar,
    BarcodeFormat.itf14,
  ]),
  dataMatrix(Icons.grid_on, [BarcodeFormat.dataMatrix]),
  pdf417(Icons.horizontal_split_outlined, [BarcodeFormat.pdf417]),
  aztec(Icons.filter_center_focus, [BarcodeFormat.aztec]),
  all(Icons.select_all, []);

  const ScanMode(this.icon, this.formats);

  final IconData icon;

  /// Leere Liste bedeutet: alle Formate.
  final List<BarcodeFormat> formats;

  String label(AppLocalizations l) => switch (this) {
    qr => l.modeQr,
    barcode => l.modeBarcode,
    dataMatrix => 'Data Matrix',
    pdf417 => 'PDF417',
    aztec => 'Aztec',
    all => l.modeAll,
  };

  String hint(AppLocalizations l) => switch (this) {
    qr => l.hintQr,
    barcode => 'EAN, UPC, Code 128, Code 39 …',
    dataMatrix => l.hintDataMatrix,
    pdf417 => l.hintPdf417,
    aztec => l.hintAztec,
    all => l.hintAll,
  };

  String title(AppLocalizations l) => switch (this) {
    qr => l.scanTitleQr,
    barcode => l.scanTitleBarcode,
    dataMatrix => l.scanTitleDataMatrix,
    pdf417 => l.scanTitlePdf417,
    aztec => l.scanTitleAztec,
    all => l.scanTitleAll,
  };

  static ScanMode fromName(String? name) =>
      ScanMode.values.asNameMap()[name] ?? ScanMode.qr;
}

/// Formatnamen sind überwiegend Eigennamen und werden nicht übersetzt.
String formatLabel(BarcodeFormat format, AppLocalizations l) =>
    switch (format) {
      BarcodeFormat.qrCode => l.modeQr,
      BarcodeFormat.microQrCode => l.formatMicroQr,
      BarcodeFormat.ean13 => 'EAN-13',
      BarcodeFormat.ean8 => 'EAN-8',
      BarcodeFormat.upcA => 'UPC-A',
      BarcodeFormat.upcE => 'UPC-E',
      BarcodeFormat.code128 => 'Code 128',
      BarcodeFormat.code39 => 'Code 39',
      BarcodeFormat.code93 => 'Code 93',
      BarcodeFormat.codabar => 'Codabar',
      BarcodeFormat.itf14 => 'ITF-14',
      BarcodeFormat.itf2of5 || BarcodeFormat.itf2of5WithChecksum => 'ITF',
      BarcodeFormat.dataMatrix => 'Data Matrix',
      BarcodeFormat.pdf417 => 'PDF417',
      BarcodeFormat.aztec => 'Aztec',
      BarcodeFormat.maxiCode => 'MaxiCode',
      BarcodeFormat.dataBar ||
      BarcodeFormat.dataBarExpanded ||
      BarcodeFormat.dataBarLimited => 'GS1 DataBar',
      _ => l.formatUnknown,
    };
