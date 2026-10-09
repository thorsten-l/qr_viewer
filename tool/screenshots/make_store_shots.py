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

"""Erzeugt App-Store-Screenshots aus Gerätefotos.

Gestaltet wird auf 1290 x 2796; zusätzlich entstehen die Größen, die
App Store Connect für das mittlere iPhone mit Dynamic Island verlangt.

Aufruf (Pillow nötig):
    python tool/screenshots/make_store_shots.py
Quellen:  screenshots/source/<sprache>/*.png  (Bildschirmfotos vom iPhone)
Ergebnis: screenshots/app_store/<größe>/<sprache>/*.png
"""
import os
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = os.path.join(os.path.dirname(__file__), "..", "..")
W, H = 1290, 2796
STATUS_BAR = 170            # Pixel der iOS-Statusleiste im Gerätefoto
TOP, DARK = (19, 128, 120), (10, 44, 44)   # Verlauf in den App-Farben
FONT = "/System/Library/Fonts/Avenir Next.ttc"
BOLD, MEDIUM = 0, 5

# Datei -> (Überschrift, Unterzeile)
TEXTS = {
    "de": {
        "01_ergebnis.png": ("Erst sehen,\ndann öffnen", "Links öffnen sich nur nach Rückfrage"),
        "02_scanner_info.png": ("QR, Barcode,\nData Matrix & mehr", "Scan-Art einfach im Titel wählen"),
        "03_verlauf.png": ("Die letzten 10 Scans\nimmer griffbereit", "Aufrufen und kopieren mit einem Tipp"),
    },
}


def background():
    img = Image.new("RGB", (W, H))
    d = ImageDraw.Draw(img)
    for y in range(H):
        t = y / (H - 1)
        d.line([(0, y), (W, y)], fill=tuple(int(TOP[k] + (DARK[k] - TOP[k]) * t) for k in range(3)))
    return img


def fit(d, text, size, index, max_w):
    """Schriftgröße so weit verkleinern, bis jede Zeile in max_w passt."""
    while True:
        font = ImageFont.truetype(FONT, size, index=index)
        if all(d.textlength(l, font=font) <= max_w for l in text.split("\n")) or size <= 20:
            return font
        size -= 4


def centered(d, y, text, font, fill, spacing):
    for line in text.split("\n"):
        w = d.textlength(line, font=font)
        d.text(((W - w) / 2, y), line, font=font, fill=fill)
        y += font.size + spacing
    return y


SIZES = {"iphone_6.9": (1290, 2796), "iphone_6.1_1179x2556": (1179, 2556)}

# Google Play, Handy 9:16: Quellen in screenshots/source/<sprache>/android/
ANDROID_TEXTS = {
    "de": {
        "01_ergebnis.png": ("Erst sehen,\ndann öffnen", "Jeder Inhalt wird zuerst nur angezeigt"),
        "02_link_dialog.png": ("Links nur\nnach Rückfrage", "Du siehst vorher, wohin ein Code führt"),
        "03_scanner_menue.png": ("QR, Barcode,\nData Matrix & mehr", "Scan-Art einfach im Titel wählen"),
        "04_barcode.png": ("Auch Barcodes\nund Produktcodes", "EAN, UPC, ISBN, Code 128 und mehr"),
        "05_verlauf.png": ("Die letzten 10 Scans\nimmer griffbereit", "Aufrufen und kopieren mit einem Tipp"),
    },
}

# Google Play, Tablet 9:16 (7" und 10"): Quellen in screenshots/source/<sprache>/tablet/
# Ziel-Datei: (Quelldatei, Überschrift, Unterzeile)
TABLET_TEXTS = {
    "de": {
        "01_ergebnis.png": ("03_ergebnis_url.png", "Erst sehen,\ndann öffnen", "Links öffnen sich nur nach Rückfrage"),
        "02_scanner_menue.png": ("01_scanner_menue.png", "QR, Barcode,\nData Matrix & mehr", "Scan-Art einfach im Titel wählen"),
        "03_verlauf.png": ("02_verlauf.png", "Die letzten 10 Scans\nimmer griffbereit", "Aufrufen und kopieren mit einem Tipp"),
    },
}

# iPad 13": Quellen in screenshots/source/<sprache>/ipad/
IPAD_TEXTS = {
    "de": {
        "01_ergebnis.png": ("Erst sehen,\ndann öffnen", "Links öffnen sich nur nach Rückfrage"),
        "02_scanner_menue.png": ("QR, Barcode,\nData Matrix & mehr", "Scan-Art einfach im Titel wählen"),
        "03_verlauf.png": ("Die letzten 10 Scans\nimmer griffbereit", "Aufrufen und kopieren mit einem Tipp"),
    },
}


# Gestaltung je Gerät: Leinwand, Statusleiste, Bildschirmbreite, Schriftgrößen, Abstände
IPHONE = dict(w=1290, h=2796, status=STATUS_BAR, sw=1040, title=112, sub=54, ty=150, top=720, radius=64)
ANDROID = dict(w=1080, h=1920, status=140, sw=680, title=84, sub=40, ty=90, top=420, radius=44)
TABLET = dict(w=1440, h=2560, status=70, sw=1240, title=110, sub=52, ty=130, top=560, radius=52)
IPAD = dict(w=2064, h=2752, status=64, sw=1440, title=150, sub=72, ty=140, top=830, radius=48)


def make(src, title, subtitle, dst, L=IPHONE):
    global W, H
    W, H = L["w"], L["h"]
    shot = Image.open(src).convert("RGB")
    shot = shot.crop((0, L["status"], shot.width, shot.height))
    sw = L["sw"]
    shot = shot.resize((sw, round(shot.height * sw / shot.width)), Image.LANCZOS)

    img = background()
    d = ImageDraw.Draw(img)
    max_w = W * 0.9
    y = centered(d, L["ty"], title, fit(d, title, L["title"], BOLD, max_w), "white", 18)
    centered(d, y + 30, subtitle, fit(d, subtitle, L["sub"], MEDIUM, max_w), (200, 236, 232), 10)

    x, top = (W - sw) // 2, L["top"]
    radius = L["radius"]
    # Schatten
    shadow = Image.new("L", (W, H), 0)
    ImageDraw.Draw(shadow).rounded_rectangle([x, top + 24, x + sw, top + shot.height + 24], radius, fill=150)
    img.paste((0, 0, 0), (0, 0), shadow.filter(ImageFilter.GaussianBlur(40)))
    # Rahmen und Bildschirm mit runden Ecken
    ImageDraw.Draw(img).rounded_rectangle(
        [x - 14, top - 14, x + sw + 14, top + shot.height + 14], radius + 14, fill=(8, 28, 28))
    mask = Image.new("L", shot.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, sw - 1, shot.height - 1], radius, fill=255)
    img.paste(shot, (x, top), mask)
    return img


if __name__ == "__main__":
    for lang, files in TEXTS.items():
        for name, (title, sub) in files.items():
            img = make(os.path.join(ROOT, "screenshots", "source", lang, name), title, sub, None)
            for folder, size in SIZES.items():
                out = os.path.join(ROOT, "screenshots", "app_store", folder, lang)
                os.makedirs(out, exist_ok=True)
                img.resize(size, Image.LANCZOS).save(os.path.join(out, name), optimize=True)
                print(folder, lang, name)
    for lang, files in IPAD_TEXTS.items():
        out = os.path.join(ROOT, "screenshots", "app_store", "ipad_13", lang)
        os.makedirs(out, exist_ok=True)
        for name, (title, sub) in files.items():
            src = os.path.join(ROOT, "screenshots", "source", lang, "ipad", name)
            make(src, title, sub, None, IPAD).save(os.path.join(out, name), optimize=True)
            print("ipad_13", lang, name)
    for lang, files in ANDROID_TEXTS.items():
        out = os.path.join(ROOT, "screenshots", "play_store", "phone", lang)
        os.makedirs(out, exist_ok=True)
        for name, (title, sub) in files.items():
            src = os.path.join(ROOT, "screenshots", "source", lang, "android", name)
            make(src, title, sub, None, ANDROID).save(os.path.join(out, name), optimize=True)
            print("play phone", lang, name)
    for lang, files in TABLET_TEXTS.items():
        out = os.path.join(ROOT, "screenshots", "play_store", "tablet", lang)
        os.makedirs(out, exist_ok=True)
        for name, (src_name, title, sub) in files.items():
            src = os.path.join(ROOT, "screenshots", "source", lang, "tablet", src_name)
            make(src, title, sub, None, TABLET).save(os.path.join(out, name), optimize=True)
            print("play tablet", lang, name)
