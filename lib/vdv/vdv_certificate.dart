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

import 'package:flutter/services.dart';

import 'ber.dart';
import 'iso9796.dart';

const _tagCertificate = 0x7F21;
const _tagCertSignature = 0x5F37;
const _tagCertRemainder = 0x5F38;
const _tagCertContent = 0x5F4E;

/// CAR der VDV-Wurzel-CA ("EU VDV").
const vdvRootCar = '4555564456100106';

/// Öffentlicher RSA-Schlüssel aus einem VDV-Zertifikat.
class VdvKey {
  const VdvKey(this.modulus, this.exponent, this.holderReference);

  final BigInt modulus;
  final BigInt exponent;

  /// CHR, 12 Bytes; die letzten 8 Bytes sind die CAR, unter der dieser
  /// Schlüssel selbst als CA auftritt.
  final Uint8List holderReference;
}

/// Liest den Schlüsselkörper: Profil · CAR(8) · CHR(12) · CHA(7) ·
/// Datum(4) · OID(7 oder 9) · Modulus · Exponent(4).
VdvKey? parseKeyBody(Uint8List body) {
  const oidStart = 1 + 8 + 12 + 7 + 4;
  if (body.length <= oidStart) return null;
  final modulusSize = switch (body[0]) {
    3 => 192,
    4 => 128,
    7 => 248,
    _ => 0,
  };
  if (modulusSize == 0) return null;
  final oidSize = body[oidStart] == 0x2A ? 9 : 7;
  final m = oidStart + oidSize;
  if (body.length < m + modulusSize + 4) return null;
  return VdvKey(
    bytesToBigInt(body.sublist(m, m + modulusSize)),
    bytesToBigInt(body.sublist(m + modulusSize, m + modulusSize + 4)),
    Uint8List.fromList(body.sublist(9, 21)),
  );
}

/// Ergebnis beim Entschlüsseln eines Zertifikats.
class CertificateKey {
  const CertificateKey(this.key, this.signatureValid);

  final VdvKey key;

  /// Null bei unsignierten (bereits entpackten) Zertifikaten.
  final bool? signatureValid;
}

/// Entpackt ein Zertifikat (Inhalt von Tag 7F21). Signierte Zertifikate
/// werden mit [ca] per ISO 9796-2 zurückgewonnen.
CertificateKey? keyFromCertificate(Uint8List certificate, VdvKey? ca) {
  final parts = readAllBer(certificate);
  final raw = parts[_tagCertContent];
  if (raw != null) {
    final key = parseKeyBody(raw);
    return key == null ? null : CertificateKey(key, null);
  }
  final signature = parts[_tagCertSignature];
  if (signature == null || ca == null) return null;
  final recovered = recoverMessage(
    signature,
    ca.modulus,
    ca.exponent,
    parts[_tagCertRemainder] ?? const [],
  );
  if (recovered == null) return null;
  final key = parseKeyBody(recovered.message);
  return key == null ? null : CertificateKey(key, recovered.hashValid);
}

/// Lädt eine CA-Datei anhand der CAR (16 Hex-Zeichen), oder null.
typedef CertificateLoader = Future<Uint8List?> Function(String carHex);

/// Lädt die mitgelieferten öffentlichen CA-Schlüssel aus den Assets.
Future<Uint8List?> assetCertificateLoader(String carHex) async {
  try {
    final data = await rootBundle.load('assets/vdv_certs/$carHex.vdv-cert');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  } catch (_) {
    return null;
  }
}

/// Liefert den Schlüssel der CA mit der CAR [carHex], bei Bedarf über die
/// Wurzel-CA entpackt.
Future<CertificateKey?> loadCaKey(
  String carHex, {
  CertificateLoader loader = assetCertificateLoader,
}) async {
  final file = await loader(carHex);
  if (file == null) return null;
  final cert = readBer(file, 0);
  if (cert == null || cert.tag != _tagCertificate) return null;
  final direct = keyFromCertificate(cert.value, null);
  if (direct != null) return direct;
  if (carHex == vdvRootCar) return null;
  final root = await loadCaKey(vdvRootCar, loader: loader);
  if (root == null) return null;
  return keyFromCertificate(cert.value, root.key);
}
