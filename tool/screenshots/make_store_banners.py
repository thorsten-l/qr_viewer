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

"""Erzeugt Bilder für "Kopfzeile und Suchergebnisse" in App Store Connect.

Aufruf (Pillow nötig):
    python tool/screenshots/make_store_banners.py
Quellen:  screenshots/source/<sprache>/*.png, tool/app_icon/icon_1024.png
Ergebnis: screenshots/app_store/banner/<sprache>/{kopfzeile,suchergebnisse}.png
Alles Wichtige liegt mittig, weil die Kopfzeile je nach Gerät beschnitten wird.
"""
import os
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = os.path.join(os.path.dirname(__file__), "..", "..")
STATUS_BAR = 170
TOP, DARK = (19, 128, 120), (10, 44, 44)
FONT = "/System/Library/Fonts/Avenir Next.ttc"
BOLD, DEMI, MEDIUM = 0, 2, 5
SHOTS = ["02_scanner_info.png", "01_ergebnis.png", "03_verlauf.png"]  # links, Mitte, rechts

TEXTS = {
    "de": ("Erst sehen, dann öffnen", "QR-Codes, Barcodes, Data Matrix, PDF417 und Aztec"),
}


def gradient(w, h):
    img = Image.new("RGB", (w, h))
    d = ImageDraw.Draw(img)
    for y in range(h):
        t = y / (h - 1)
        d.line([(0, y), (w, y)], fill=tuple(int(TOP[k] + (DARK[k] - TOP[k]) * t) for k in range(3)))
    # weicher heller Schein hinter den Geräten
    glow = Image.new("L", (w, h), 0)
    ImageDraw.Draw(glow).ellipse([w * 0.25, h * 0.35, w * 0.75, h * 1.2], fill=90)
    img.paste((40, 170, 160), (0, 0), glow.filter(ImageFilter.GaussianBlur(w // 12)))
    return img


def phone(src, width):
    shot = Image.open(src).convert("RGB")
    shot = shot.crop((0, STATUS_BAR, shot.width, shot.height))
    shot = shot.resize((width, round(shot.height * width / shot.width)), Image.LANCZOS)
    r, b = width // 16, width // 75
    out = Image.new("RGBA", (width + 2 * b, shot.height + 2 * b), (0, 0, 0, 0))
    ImageDraw.Draw(out).rounded_rectangle([0, 0, out.width - 1, out.height - 1], r + b, fill=(8, 28, 28, 255))
    m = Image.new("L", shot.size, 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, shot.width - 1, shot.height - 1], r, fill=255)
    out.paste(shot, (b, b), m)
    return out


def place(img, ph, cx, top):
    x = int(cx - ph.width / 2)
    sh = Image.new("L", img.size, 0)
    ImageDraw.Draw(sh).rounded_rectangle([x, top + 30, x + ph.width, top + ph.height + 30], ph.width // 14, fill=140)
    img.paste((0, 0, 0), (0, 0), sh.filter(ImageFilter.GaussianBlur(ph.width // 18)))
    img.paste(ph, (x, top), ph)


def text_c(d, w, y, s, font, fill):
    d.text(((w - d.textlength(s, font=font)) / 2, y), s, font=font, fill=fill)


def phones_row(img, lang, cx, top, width):
    src = lambda n: os.path.join(ROOT, "screenshots", "source", lang, n)
    side = int(width * 0.86)
    gap = int(width * 1.02)
    place(img, phone(src(SHOTS[0]), side), cx - gap, top + int(width * 0.18))
    place(img, phone(src(SHOTS[2]), side), cx + gap, top + int(width * 0.18))
    place(img, phone(src(SHOTS[1]), width), cx, top)


def icon(size):
    ic = Image.open(os.path.join(ROOT, "tool", "app_icon", "icon_1024.png")).convert("RGBA")
    ic = ic.resize((size, size), Image.LANCZOS)
    m = Image.new("L", (size, size), 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, size - 1, size - 1], int(size * 0.2237), fill=255)
    ic.putalpha(m)
    return ic


def header(lang, w=3840, h=1646):
    title, sub = TEXTS[lang]
    img = gradient(w, h)
    d = ImageDraw.Draw(img)
    text_c(d, w, 90, title, ImageFont.truetype(FONT, 150, index=BOLD), "white")
    text_c(d, w, 280, sub, ImageFont.truetype(FONT, 72, index=MEDIUM), (200, 236, 232))
    phones_row(img, lang, w // 2, 460, 560)
    return img


def search(lang, w=3840, h=2560):
    title, sub = TEXTS[lang]
    img = gradient(w, h)
    d = ImageDraw.Draw(img)
    ic = icon(300)
    name_font = ImageFont.truetype(FONT, 150, index=DEMI)
    name_w = d.textlength("QR Viewer", font=name_font)
    x0 = int((w - (300 + 60 + name_w)) / 2)
    img.paste(ic, (x0, 110), ic)
    d.text((x0 + 360, 175), "QR Viewer", font=name_font, fill="white")
    text_c(d, w, 500, title, ImageFont.truetype(FONT, 170, index=BOLD), "white")
    text_c(d, w, 720, sub, ImageFont.truetype(FONT, 84, index=MEDIUM), (200, 236, 232))
    phones_row(img, lang, w // 2, 960, 700)
    return img


if __name__ == "__main__":
    for lang in TEXTS:
        out = os.path.join(ROOT, "screenshots", "app_store", "banner", lang)
        os.makedirs(out, exist_ok=True)
        header(lang).save(os.path.join(out, "kopfzeile_3840x1646.png"), optimize=True)
        search(lang).save(os.path.join(out, "suchergebnisse_3840x2560.png"), optimize=True)
        print("ok", lang)
