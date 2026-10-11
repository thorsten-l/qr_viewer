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

/// Matrixcode der Deutschen Post (Briefmarke, Internetmarke) als Data
/// Matrix: 47 Bytes, beginnt mit "DEA5". Die Sendungsnummer setzt sich aus
/// einzelnen Bytes und einer CRC-4-Prüfziffer zusammen.
///
/// Das Verfahren folgt `DeutschePostParser.kt` aus BinaryEye
/// (Markus Fisch, MIT-Lizenz), siehe NOTICE.
class PostageStamp {
  const PostageStamp(this.trackingNumber);

  /// Sendungsnummer in Hex, z. B. "A0012345678901234B".
  final String trackingNumber;

  /// Sendungsverfolgung auf deutschepost.de.
  Uri get trackingUri => Uri.https(
    'www.deutschepost.de',
    '/de/s/sendungsverfolgung.html',
    {'piececode': trackingNumber},
  );
}

/// Erkennt einen Post-Matrixcode; sonst null.
PostageStamp? parsePostageStamp(List<int> bytes) {
  if (bytes.length < 47 || latin1.decode(bytes.sublist(0, 4)) != 'DEA5') {
    return null;
  }
  var data = bytes;
  if (data.length > 47) {
    // Manche Leser liefern die Bytes als UTF-8-Text; zurück nach Latin-1.
    try {
      data = latin1.encode(utf8.decode(bytes));
    } on Object {
      return null;
    }
  }
  if (data.length != 47) return null;
  String hex(int b) => b.toRadixString(16).padLeft(2, '0').toUpperCase();
  final number = [
    for (final i in [9, 10, 11, 12, 13]) hex(data[i]),
    (data[4] & 0x0F).toRadixString(16).toUpperCase(),
    for (final i in [5, 6, 7, 8]) hex(data[i]),
  ].join();
  final check = _crc4(latin1.encode(number)).toRadixString(16).toUpperCase();
  return PostageStamp('$number$check');
}

/// CRC-4 mit dem Polynom x⁴ + x + 1.
int _crc4(List<int> input) {
  var crc = 0;
  for (final c in input) {
    for (var j = 0x80; j != 0; j >>= 1) {
      var bit = crc & 0x8;
      crc <<= 1;
      if (c & j != 0) bit ^= 0x8;
      if (bit != 0) crc ^= 0x3;
    }
  }
  return crc & 0xF;
}
