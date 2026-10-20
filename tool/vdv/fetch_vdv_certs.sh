#!/usr/bin/env bash
# Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Lädt die öffentlichen CA-Schlüssel der VDV-Kernapplikation direkt aus dem
# LDAP-Verzeichnis der VDV-PKI nach assets/vdv_certs/.
#
# Ablauf wie beim Downloader von KDE KItinerary
# (src/lib/vdv/certs/cert-downloader.cpp), aber ohne KDE-Werkzeuge:
#   1. alle Einträge mit cACertificate per ldapsearch holen,
#   2. jede Signatur mit dem Schlüssel der ausstellenden CA prüfen: offene
#      Schlüssel (5F4E) per PKCS #1 v1.5, signierte per ISO/IEC 9796-2
#      (jeweils SHA-1); dabei entpacken,
#   2a. abweichend vom Original: Ist ein Eintrag nur die Kopie eines anderen
#      (seine CHR nennt einen anderen Eintrag), bleibt die vorhandene Datei
#      erhalten, sofern sie den Schlüssel zu ihrem Namen enthält,
#   3. Unter-CAs, die vor 2019 abgelaufen sind, verwerfen,
#   4. nur den Schlüssel als 7F21{5F4E{…}} speichern (ohne Signatur) und
#      assets/vdv_certs/ damit abgleichen.
#
# Benötigt: ldapsearch (OpenLDAP, unter macOS vorhanden), python3.
# Aufruf:   tool/vdv/fetch_vdv_certs.sh [--dry-run]
set -euo pipefail

PROJECT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$PROJECT/assets/vdv_certs"
LDAP_URL="ldap://ldap-vdv-ion.telesec.de:389"
BASE_DN="ou=VDV KA,o=VDV Kernapplikations GmbH,c=de"
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

command -v ldapsearch >/dev/null || {
  echo "ldapsearch fehlt (Paket openldap-clients bzw. ldap-utils)" >&2
  exit 1
}

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

ldapsearch -x -LLL -o ldif-wrap=no -H "$LDAP_URL" -b "$BASE_DN" \
  "(cACertificate=*)" cn cACertificate >"$WORK/certs.ldif"

python3 -I - "$WORK/certs.ldif" "$WORK/keys" "$OUT" <<'PY'
import base64, hashlib, os, sys

ldif, out, current = sys.argv[1], sys.argv[2], sys.argv[3]
ROOT = "4555564456100106"  # CAR der Wurzel-CA "EU VDV"
MODULUS_SIZE = {3: 192, 4: 128, 7: 248}  # nach Zertifikatsprofil
OID_START = 1 + 8 + 12 + 7 + 4  # Profil, CAR, CHR, CHA, Ablaufdatum
SHA1_INFO = bytes.fromhex("3021300906052b0e03021a05000414")  # DigestInfo


def read_tlv(data, i):
    tag = data[i]
    i += 1
    if tag & 0x1F == 0x1F:  # zweibytige Tags wie 7F21, 5F4E
        tag = (tag << 8) | data[i]
        i += 1
    length = data[i]
    i += 1
    if length & 0x80:
        n = length & 0x7F
        length = int.from_bytes(data[i:i + n], "big")
        i += n
    return tag, data[i:i + length], i + length


def children(value):
    parts, i = {}, 0
    while i < len(value):
        tag, v, i = read_tlv(value, i)
        parts[tag] = v
    return parts


def tlv(tag, value):
    n = len(value)
    size = bytes([n]) if n < 0x80 else (
        bytes([0x81, n]) if n < 0x100 else bytes([0x82]) + n.to_bytes(2, "big"))
    return tag.to_bytes(2, "big") + size + value


def car(body):
    return body[1:9].hex().upper()


def chr_(body):
    return body[13:21].hex().upper()  # letzte 8 Bytes der 12-Byte-CHR


def end_year(body):
    return int(body[OID_START - 4:OID_START - 2].hex())  # Datum in BCD


def rsa_key(body):
    size = MODULUS_SIZE[body[0]]
    m = OID_START + (9 if body[OID_START] == 0x2A else 7)
    return (int.from_bytes(body[m:m + size], "big"),
            int.from_bytes(body[m + size:m + size + 4], "big"))


def rsa(signature, key):
    n, e = key
    return pow(int.from_bytes(signature, "big"), e, n).to_bytes(len(signature), "big")


def check_pkcs1(body, signature, key):
    """Offener Schlüssel (5F4E) mit PKCS #1 v1.5, SHA-1 über den Körper."""
    m = rsa(signature, key)
    digest = SHA1_INFO + hashlib.sha1(body).digest()
    expected = b"\x00\x01" + b"\xff" * (len(m) - len(digest) - 3) + b"\x00" + digest
    if m != expected:
        raise ValueError("PKCS-#1-Signatur ungültig")


def recover(signature, remainder, key):
    """ISO/IEC 9796-2, Schema 1 mit SHA-1: Kopf 6A, Hash, Ende BC."""
    m = rsa(signature, key)
    if m[0] != 0x6A or m[-1] != 0xBC:
        raise ValueError("Signatur passt nicht zum CA-Schlüssel")
    message = m[1:-21] + remainder
    if hashlib.sha1(message).digest() != m[-21:-1]:
        raise ValueError("Hash der Signatur stimmt nicht")
    return message


def local_body(cn):
    """Vorhandene Datei, wenn sie den Schlüssel zu ihrem Namen enthält."""
    # Nur als Ersatz für fehlerhafte Einträge; ihre Signatur ist bereits
    # entfernt und lässt sich nicht mehr prüfen.
    path = os.path.join(current, cn + ".vdv-cert")
    try:
        data = open(path, "rb").read()
        tag, value, _ = read_tlv(data, 0)
        body = children(value)[0x5F4E]
    except (OSError, IndexError, KeyError):
        return None
    return body if tag == 0x7F21 and chr_(body) == cn else None


# LDIF: Einträge durch Leerzeilen getrennt, Reihenfolge der Attribute offen.
certs = {}
for block in open(ldif, encoding="ascii").read().split("\n\n"):
    attrs = dict(line.split(": ", 1) for line in block.splitlines()
                 if ": " in line)
    if "cn" in attrs and "cACertificate:" in attrs:
        certs[attrs["cn"]] = base64.b64decode(attrs["cACertificate:"])
if ROOT not in certs:
    sys.exit(f"Wurzel-CA {ROOT} fehlt im Verzeichnis")

# Prüfen und entpacken. Jede Signatur wird mit dem Schlüssel der
# ausstellenden CA geprüft; die Wurzel signiert sich selbst.
bodies, pending, problems = {}, dict(certs), 0
while pending:
    progress = False
    for cn, raw in list(pending.items()):
        tag, value, _ = read_tlv(raw, 0)
        parts = children(value) if tag == 0x7F21 else {}
        body = parts.get(0x5F4E)
        issuer = car(body) if body else parts.get(0x42, bytes.fromhex(ROOT)).hex().upper()
        if issuer != cn and issuer not in bodies:
            continue  # erst die ausstellende CA
        del pending[cn]
        progress = True
        try:
            if 0x5F37 not in parts:
                raise ValueError("ohne Signatur")
            if body is not None:
                key = rsa_key(body if issuer == cn else bodies[issuer])
                check_pkcs1(body, parts[0x5F37], key)
            else:
                body = recover(parts[0x5F37], parts.get(0x5F38, b""),
                               rsa_key(bodies[issuer]))
            # Eine abweichende CHR allein ist erlaubt (z. B. 4C55… mit
            # CHR 4445…). Zeigt sie aber auf einen anderen Eintrag, ist dieser
            # Eintrag nur eine Kopie davon.
            if chr_(body) != cn and chr_(body) in certs:
                raise ValueError(f"Kopie des Eintrags {chr_(body)}")
        except (KeyError, ValueError) as err:
            problems += 1
            body = local_body(cn)
            note = "vorhandene Datei bleibt" if body else "ausgelassen"
            print(f"WARNUNG {cn}: {err}; {note}", file=sys.stderr)
            if body is None:
                continue
        bodies[cn] = body
    if not progress:
        sys.exit("Ohne passende CA: " + ", ".join(sorted(pending)))
if ROOT not in bodies:
    sys.exit("Wurzel-CA ungültig")

os.makedirs(out)
kept = skipped = 0
for cn in sorted(bodies):
    body = bodies[cn]
    if cn != ROOT and end_year(body) < 2019:
        print(f"verworfen (abgelaufen {end_year(body)}): {cn}")
        skipped += 1
        continue
    with open(os.path.join(out, cn + ".vdv-cert"), "wb") as f:
        f.write(tlv(0x7F21, tlv(0x5F4E, body)))
    kept += 1
print(f"{len(certs)} Zertifikate im Verzeichnis, {kept} Schlüssel behalten, "
      f"{skipped} abgelaufen, {problems} mit Warnung")
PY

# Abgleich mit assets/vdv_certs/: neue, geänderte und entfallene Dateien.
added=0 changed=0 removed=0
for f in "$WORK"/keys/*.vdv-cert; do
  name="$(basename "$f")"
  if [[ ! -e "$OUT/$name" ]]; then
    echo "neu:      $name"; added=$((added + 1))
  elif ! cmp -s "$f" "$OUT/$name"; then
    echo "geändert: $name"; changed=$((changed + 1))
  fi
done
for f in "$OUT"/*.vdv-cert; do
  [[ -e "$f" ]] || continue
  name="$(basename "$f")"
  if [[ ! -e "$WORK/keys/$name" ]]; then
    echo "entfällt: $name"; removed=$((removed + 1))
  fi
done
echo "$added neu, $changed geändert, $removed entfallen"

if [[ $DRY_RUN -eq 1 ]]; then
  echo "Probelauf: $OUT bleibt unverändert"
  exit 0
fi
mkdir -p "$OUT"
rm -f "$OUT"/*.vdv-cert
cp "$WORK"/keys/*.vdv-cert "$OUT/"
echo "$(ls "$OUT"/*.vdv-cert | wc -l | tr -d ' ') Schlüssel in $OUT"
