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
import 'dart:typed_data';

import 'package:mobile_scanner/mobile_scanner.dart';

/// Rückabbildung der Windows-1252-Zeichen für die Bytes 0x80–0x9F.
///
/// Apple Vision dekodiert Aztec, Data Matrix, PDF417 und Strichcodes als
/// Windows-1252-Text. mobile_scanner kann diese Bytes deshalb nicht als
/// Rohdaten zurückgeben; hier werden sie aus dem Text rekonstruiert.
const Map<int, int> _cp1252 = {
  0x20AC: 0x80,
  0x201A: 0x82,
  0x0192: 0x83,
  0x201E: 0x84,
  0x2026: 0x85,
  0x2020: 0x86,
  0x2021: 0x87,
  0x02C6: 0x88,
  0x2030: 0x89,
  0x0160: 0x8A,
  0x2039: 0x8B,
  0x0152: 0x8C,
  0x017D: 0x8E,
  0x2018: 0x91,
  0x2019: 0x92,
  0x201C: 0x93,
  0x201D: 0x94,
  0x2022: 0x95,
  0x2013: 0x96,
  0x2014: 0x97,
  0x02DC: 0x98,
  0x2122: 0x99,
  0x0161: 0x9A,
  0x203A: 0x9B,
  0x0153: 0x9C,
  0x017E: 0x9E,
  0x0178: 0x9F,
};

/// Wandelt Windows-1252-Text zurück in Bytes, oder null, wenn ein Zeichen
/// nicht abbildbar ist.
Uint8List? bytesFromCp1252(String text) {
  final out = <int>[];
  for (final rune in text.runes) {
    if (rune <= 0xFF) {
      out.add(rune);
    } else {
      final b = _cp1252[rune];
      if (b == null) return null;
      out.add(b);
    }
  }
  return Uint8List.fromList(out);
}

/// Rohbytes eines Codes, soweit die Plattform sie liefert.
Uint8List? barcodeBytes(Barcode barcode) {
  final decoded = barcode.rawDecodedBytes;
  final bytes = switch (decoded) {
    DecodedBarcodeBytes(:final bytes) => bytes,
    DecodedVisionBarcodeBytes(:final bytes) => bytes,
    null => null,
  };
  if (bytes != null && bytes.isNotEmpty) return bytes;
  final raw = barcode.rawValue;
  if (raw == null || raw.isEmpty) return null;
  return bytesFromCp1252(raw);
}

/// True, wenn die Bytes kein sinnvoller Text sind: Steuerzeichen außer
/// Tab/Zeilenumbruch, oder ungültiges UTF-8 mit Bytes aus 0x80–0x9F.
bool looksBinary(List<int> bytes) {
  for (final b in bytes) {
    final control =
        (b < 0x20 && b != 0x09 && b != 0x0A && b != 0x0D) || b == 0x7F;
    if (control) return true;
  }
  if (bytes.any((b) => b >= 0x80 && b <= 0x9F)) {
    try {
      utf8.decode(bytes);
    } on FormatException {
      return true;
    }
  }
  return false;
}

/// Liefert die Bytes, wenn der Code Binärdaten enthält, sonst null.
Uint8List? binaryContent(Barcode barcode) {
  final bytes = barcodeBytes(barcode);
  if (bytes == null) return null;
  final raw = barcode.rawValue;
  if (raw == null || raw.isEmpty || looksBinary(bytes)) return bytes;
  return null;
}

/// Kompakte Hex-Darstellung ohne Leerzeichen, z. B. "9E8180".
String toHex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join().toUpperCase();

/// Hex-Darstellung mit Leerzeichen, z. B. "9E 81 80".
String toSpacedHex(List<int> bytes) => bytes
    .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
    .join(' ');

/// Wandelt kompakten Hex-Text zurück in Bytes.
Uint8List fromHex(String hex) {
  final clean = hex.replaceAll(RegExp(r'\s'), '');
  return Uint8List.fromList([
    for (var i = 0; i + 1 < clean.length; i += 2)
      int.parse(clean.substring(i, i + 2), radix: 16),
  ]);
}

/// Hex-Dump mit Offset und, wenn [text] gesetzt ist, einer Textspalte wie
/// bei `xxd`: "0000  44 45 41 35 1F  DEA5.". Nicht druckbare Bytes
/// erscheinen dort als Punkt.
String hexDump(List<int> bytes, {int perLine = 8, bool text = true}) {
  final lines = <String>[];
  final width = perLine * 3 - 1;
  for (var i = 0; i < bytes.length; i += perLine) {
    final end = i + perLine < bytes.length ? i + perLine : bytes.length;
    final chunk = bytes.sublist(i, end);
    final offset = i.toRadixString(16).padLeft(4, '0').toUpperCase();
    final hex = toSpacedHex(chunk);
    lines.add(
      text
          ? '$offset  ${hex.padRight(width)}  ${printableAscii(chunk)}'
          : '$offset  $hex',
    );
  }
  return lines.join('\n');
}

/// Druckbares ASCII (0x20–0x7E) bleibt, alles andere wird zu ".".
String printableAscii(List<int> bytes) =>
    String.fromCharCodes(bytes.map((b) => b >= 0x20 && b <= 0x7E ? b : 0x2E));

/// Zeichen pro Zeile eines [hexDump] mit [perLine] Bytes.
int hexDumpWidth(int perLine, {bool text = true}) =>
    6 + perLine * 3 - 1 + (text ? 2 + perLine : 0);

/// VDV-Barcode des deutschen eTickets (VDV-Kernapplikation): beginnt mit
/// dem Signatur-Tag 9E 81 80.
bool isVdvTicket(List<int> bytes) =>
    bytes.length >= 3 &&
    bytes[0] == 0x9E &&
    bytes[1] == 0x81 &&
    bytes[2] == 0x80;
