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

/// Matter-Onboarding-Code (Smart Home), Matter Core Specification 5.1.3:
/// `MT:` gefolgt von Base38-kodierten Bits, LSB zuerst:
/// Version (3) · Vendor-ID (16) · Product-ID (16) · Ablauf (2) ·
/// Verbindungsarten (8) · Diskriminator (12) · Passcode (27) · Füllbits (4).
/// Danach können optionale TLV-Daten folgen; die werden ignoriert. Mehrere
/// Geräte in einem Code sind mit `*` verbunden.
library;

/// Einrichtungsablauf des Geräts.
enum MatterFlow {
  /// Gerät ist nach dem Einschalten bereit.
  standard,

  /// Gerät muss erst aktiviert werden, z. B. per Tastendruck.
  userAction,

  /// Einrichtung nur mit der App des Herstellers.
  custom,
}

/// Wege, über die das Gerät beim Einrichten erreichbar ist.
enum MatterDiscovery { softAp, ble, onNetwork, wifiPaf }

class MatterPayload {
  const MatterPayload({
    required this.vendorId,
    required this.productId,
    required this.flow,
    required this.discovery,
    required this.discriminator,
    required this.passcode,
    this.devices = 1,
  });

  final int vendorId;
  final int productId;
  final MatterFlow flow;
  final Set<MatterDiscovery> discovery;

  /// 12 Bit, unterscheidet Geräte beim Suchen.
  final int discriminator;

  /// Einrichtungscode (Setup-PIN), 27 Bit.
  final int passcode;

  /// Anzahl der Geräte im Code; angezeigt wird nur das erste.
  final int devices;

  /// Manueller Kopplungscode (11 Ziffern, mit Vendor-/Product-ID 21), wie
  /// ihn Home-Apps zum Eintippen anbieten, z. B. "3497-011-2332".
  String get manualCode {
    final long = flow != MatterFlow.standard;
    final short = discriminator >> 8;
    final digits = StringBuffer()
      ..write(((long ? 1 : 0) << 2) | (short >> 2))
      ..write(
        (((short & 0x3) << 14) | (passcode & 0x3FFF)).toString().padLeft(
          5,
          '0',
        ),
      )
      ..write((passcode >> 14).toString().padLeft(4, '0'));
    if (long) {
      digits
        ..write(vendorId.toString().padLeft(5, '0'))
        ..write(productId.toString().padLeft(5, '0'));
    }
    final code = '$digits${verhoeffCheckDigit(digits.toString())}';
    final groups = long ? [4, 3, 4, 5, 5] : [4, 3, 4];
    final parts = <String>[];
    var i = 0;
    for (final g in groups) {
      parts.add(code.substring(i, i + g));
      i += g;
    }
    return parts.join('-');
  }
}

const _base38 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-.';

/// Bekannte ungültige Passcodes laut Spezifikation.
const _invalidPasscodes = {
  0, 11111111, 22222222, 33333333, 44444444, 55555555, //
  66666666, 77777777, 88888888, 99999999, 12345678, 87654321,
};

/// Liest einen Matter-Code, oder null, wenn [text] keiner ist.
MatterPayload? parseMatter(String text) {
  final s = text.trim();
  if (s.length < 5 || s.substring(0, 3).toUpperCase() != 'MT:') return null;
  final payloads = s.substring(3).split('*');
  final bytes = _base38Decode(payloads.first.toUpperCase());
  if (bytes == null || bytes.length < 11) return null;

  int bits(int offset, int count) {
    var v = 0;
    for (var i = 0; i < count; i++) {
      final bit = offset + i;
      if ((bytes[bit >> 3] >> (bit & 7)) & 1 == 1) v |= 1 << i;
    }
    return v;
  }

  if (bits(0, 3) != 0) return null;
  final flowBits = bits(35, 2);
  if (flowBits > 2) return null;
  final passcode = bits(57, 27);
  if (passcode > 99999998 || _invalidPasscodes.contains(passcode)) return null;
  final capabilities = bits(37, 8);
  return MatterPayload(
    vendorId: bits(3, 16),
    productId: bits(19, 16),
    flow: MatterFlow.values[flowBits],
    discovery: {
      for (final d in MatterDiscovery.values)
        if (capabilities & (1 << d.index) != 0) d,
    },
    discriminator: bits(45, 12),
    passcode: passcode,
    devices: payloads.length,
  );
}

/// Base38 nach Matter: je 5 Zeichen 3 Bytes, 4 Zeichen 2 Bytes, 2 Zeichen
/// 1 Byte; Ziffern und Bytes jeweils niederwertig zuerst.
List<int>? _base38Decode(String s) {
  final out = <int>[];
  for (var i = 0; i < s.length; i += 5) {
    final chunk = s.substring(i, i + 5 > s.length ? s.length : i + 5);
    final size = switch (chunk.length) {
      5 => 3,
      4 => 2,
      2 => 1,
      _ => 0,
    };
    if (size == 0) return null;
    var v = 0;
    for (var j = chunk.length - 1; j >= 0; j--) {
      final d = _base38.indexOf(chunk[j]);
      if (d < 0) return null;
      v = v * 38 + d;
    }
    if (v >= 1 << (8 * size)) return null;
    for (var b = 0; b < size; b++) {
      out.add(v & 0xFF);
      v >>= 8;
    }
  }
  return out;
}

const _verhoeffD = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
  [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
  [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
  [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
  [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
  [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
  [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
  [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
  [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
];
const _verhoeffP = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
  [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
  [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
  [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
  [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
  [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
  [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
];
const _verhoeffInv = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9];

/// Verhoeff-Prüfziffer, wie sie der manuelle Matter-Code verwendet.
int verhoeffCheckDigit(String digits) {
  var c = 0;
  final n = digits.length;
  for (var i = 0; i < n; i++) {
    final d = digits.codeUnitAt(n - 1 - i) - 0x30;
    c = _verhoeffD[c][_verhoeffP[(i + 1) % 8][d]];
  }
  return _verhoeffInv[c];
}
