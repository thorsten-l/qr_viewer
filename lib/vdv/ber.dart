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

/// Ein BER-TLV-Element (Tag, Wert) und das Ende im Eingabepuffer.
class BerElement {
  const BerElement(this.tag, this.value, this.end);

  final int tag;
  final Uint8List value;
  final int end;
}

/// Liest ein BER-TLV-Element ab [offset]: 1- oder 2-Byte-Tags,
/// Länge kurz oder lang (0x81 / 0x82). Null bei ungültigen Daten.
BerElement? readBer(Uint8List data, int offset) {
  var o = offset;
  if (o >= data.length) return null;
  var tag = data[o++];
  if (tag & 0x1F == 0x1F) {
    if (o >= data.length) return null;
    tag = (tag << 8) | data[o++];
  }
  if (o >= data.length) return null;
  var length = data[o++];
  if (length & 0x80 != 0) {
    final n = length & 0x7F;
    if (n == 0 || n > 3 || o + n > data.length) return null;
    length = 0;
    for (var i = 0; i < n; i++) {
      length = (length << 8) | data[o++];
    }
  }
  if (o + length > data.length) return null;
  return BerElement(
    tag,
    Uint8List.sublistView(data, o, o + length),
    o + length,
  );
}

/// Liest alle aufeinanderfolgenden Elemente; bei Fehlern das bis dahin Gelesene.
Map<int, Uint8List> readAllBer(Uint8List data) {
  final result = <int, Uint8List>{};
  var o = 0;
  while (o < data.length) {
    final e = readBer(data, o);
    if (e == null) break;
    result[e.tag] = e.value;
    o = e.end;
  }
  return result;
}

/// Big-Endian-Zahl aus [bytes].
int readUint(List<int> bytes, int offset, int length) {
  var v = 0;
  for (var i = 0; i < length; i++) {
    v = (v << 8) | bytes[offset + i];
  }
  return v;
}
