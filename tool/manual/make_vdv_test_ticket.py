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

"""Erzeugt ein VDV-Test-Ticket mit unmaskiertem Namen ("Max Mustermann").

Das Ticket ist wie ein echtes aufgebaut (ISO 9796-2, Zertifikat, CAR),
aber mit selbst erzeugten Test-Schlüsseln einer erfundenen CA
"XXTEST26" signiert. QR Viewer kennt diese CA nicht und meldet deshalb
"Kein öffentlicher Schlüssel für diesen Herausgeber". Mit dem öffentlichen
Schlüssel aus vdv_test_ca.vdv-cert lässt es sich vollständig lesen; das
prüft render_screens_test.dart.

Die Ticketdaten stammen aus dem Muster-Ticket (vdv_sample.hex); geändert
sind Ticketnummer, Produkt (Deutschlandticket), Name und Geburtsdatum.

Aufruf (benötigt die öffentlichen VDV-Schlüssel in assets/vdv_certs/):
    python3 tool/manual/make_vdv_test_ticket.py
"""

import hashlib
import random
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TOOL = ROOT / "tool" / "manual"
CERTS = ROOT / "assets" / "vdv_certs"

TEST_CAR = b"XXTEST26"
NAME = "Max#Mustermann"
BIRTH_BCD = bytes.fromhex("19900101")
TICKET_NUMBER = 123456789
PRODUCT_DEUTSCHLANDTICKET = 9999
E = 65537


# --- BER --------------------------------------------------------------------

def read_tlv(d, i):
    t = d[i]
    i += 1
    if t & 0x1F == 0x1F:
        t = (t << 8) | d[i]
        i += 1
    n = d[i]
    i += 1
    if n & 0x80:
        k = n & 0x7F
        n = int.from_bytes(d[i:i + k], "big")
        i += k
    return t, n, i


def read_all(d):
    out, i = {}, 0
    while i < len(d):
        t, n, j = read_tlv(d, i)
        out[t] = d[j:j + n]
        i = j + n
    return out


def tlv(tag, value):
    t = tag.to_bytes(2 if tag > 0xFF else 1, "big")
    n = len(value)
    if n < 0x80:
        length = bytes([n])
    elif n < 0x100:
        length = bytes([0x81, n])
    else:
        length = bytes([0x82]) + n.to_bytes(2, "big")
    return t + length + value


# --- RSA und ISO 9796-2 -----------------------------------------------------

def is_prime(n, rnd):
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
    d, s = n - 1, 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for _ in range(40):
        x = pow(rnd.randrange(2, n - 1), d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = pow(x, 2, n)
            if x == n - 1:
                break
        else:
            return False
    return True


def prime(bits, rnd):
    while True:
        p = rnd.getrandbits(bits) | (3 << (bits - 2)) | 1
        if (p - 1) % E and is_prime(p, rnd):
            return p


def rsa_key(bits, rnd):
    """Test-Schlüssel, nicht für den Ernstfall."""
    p, q = prime(bits // 2, rnd), prime(bits // 2, rnd)
    n = p * q
    return n, pow(E, -1, (p - 1) * (q - 1))


def sign(message, n, d):
    """ISO 9796-2 Schema 1 mit SHA-1: (Signatur, nicht rückgewinnbarer Rest)."""
    k = (n.bit_length() + 7) // 8
    m1, m2 = message[:k - 22], message[k - 22:]
    f = b"\x6a" + m1 + hashlib.sha1(message).digest() + b"\xbc"
    return pow(int.from_bytes(f, "big"), d, n).to_bytes(k, "big"), m2


def recover(signature, n, e, remainder=b""):
    k = len(signature)
    m = pow(int.from_bytes(signature, "big"), e, n).to_bytes(k, "big")
    assert m[0] == 0x6A and m[-1] == 0xBC
    message = m[1:k - 21] + remainder
    assert hashlib.sha1(message).digest() == m[k - 21:k - 1]
    return message


def key_body_parts(body):
    """(Kopf bis einschließlich OID, Modulus, Exponent)."""
    size = {3: 192, 4: 128, 7: 248}[body[0]]
    o = 1 + 8 + 12 + 7 + 4
    o += 9 if body[o] == 0x2A else 7
    return (body[:o], int.from_bytes(body[o:o + size], "big"),
            int.from_bytes(body[o + size:o + size + 4], "big"))


def ca_key(car_hex):
    f = (CERTS / f"{car_hex}.vdv-cert").read_bytes()
    _, n, j = read_tlv(f, 0)
    parts = read_all(f[j:j + n])
    if 0x5F4E in parts:
        return key_body_parts(parts[0x5F4E])[1:]
    root_n, root_e = ca_key("4555564456100106")
    body = recover(parts[0x5F37], root_n, root_e, parts.get(0x5F38, b""))
    return key_body_parts(body)[1:]


# --- Ticket -----------------------------------------------------------------

def main():
    sample = bytes.fromhex((TOOL / "vdv_sample.hex").read_text()
                           .replace("\n", ""))
    top = read_all(sample)
    n, e = ca_key(top[0x42].hex().upper())
    cert = read_all(top[0x7F21])
    cert_body = recover(cert[0x5F37], n, e, cert.get(0x5F38, b""))
    head, tn, te = key_body_parts(cert_body)
    message = recover(top[0x9E], tn, te, top[0x9A])

    # Ticketnachricht: Kopf ändern, Reisendendaten im Klartext.
    msg = bytearray(message)
    msg[0:4] = TICKET_NUMBER.to_bytes(4, "big")
    msg[6:8] = PRODUCT_DEUTSCHLANDTICKET.to_bytes(2, "big")
    tag, length, start = read_tlv(msg, 18)
    assert tag == 0x85
    product = bytearray()
    i = 0
    value = bytes(msg[start:start + length])
    while i < len(value):
        t, n_, j = read_tlv(value, i)
        v = value[j:j + n_]
        if t == 0xDB:
            v = v[:1] + BIRTH_BCD + NAME.encode()
        product += tlv(t, v)
        i = j + n_
    new_message = bytes(msg[:18]) + tlv(0x85, bytes(product)) \
        + bytes(msg[start + length:])

    rnd = random.Random("QR Viewer VDV-Testticket")
    ca_n, ca_d = rsa_key(1536, rnd)
    tk_n, tk_d = rsa_key(1024, rnd)

    # Öffentlicher Schlüssel der Test-CA, nur zum Prüfen.
    chr_ca = bytes(4) + TEST_CAR
    ca_body = (bytes([3]) + TEST_CAR + chr_ca + head[21:]
               + ca_n.to_bytes(192, "big") + E.to_bytes(4, "big"))
    (TOOL / "vdv_test_ca.vdv-cert").write_bytes(
        tlv(0x7F21, tlv(0x5F4E, ca_body)))

    # Zertifikat des Ticket-Schlüssels, signiert von der Test-CA.
    tk_body = (bytes([4]) + TEST_CAR + head[9:]
               + tk_n.to_bytes(128, "big") + E.to_bytes(4, "big"))
    cert_sig, cert_rest = sign(tk_body, ca_n, ca_d)
    certificate = tlv(0x5F37, cert_sig) + tlv(0x5F38, cert_rest)

    signature, rest = sign(new_message, tk_n, tk_d)
    ticket = (tlv(0x9E, signature) + tlv(0x9A, rest)
              + tlv(0x7F21, certificate) + tlv(0x42, TEST_CAR))

    # Gegenprobe wie in der App.
    assert recover(signature, tk_n, E, rest) == new_message
    assert recover(cert_sig, ca_n, E, cert_rest) == tk_body

    h = ticket.hex().upper()
    (TOOL / "vdv_test_ticket.hex").write_text(
        "\n".join(h[i:i + 64] for i in range(0, len(h), 64)) + "\n")
    print(f"vdv_test_ticket.hex: {len(ticket)} Bytes, CA {TEST_CAR.hex().upper()}")


if __name__ == "__main__":
    main()
