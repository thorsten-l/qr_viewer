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

"""Zeichnet das QR-Viewer-Icon: echter QR-Code (ECC H) mit Auge in der Mitte."""
import sys, json, os
import qrcode
from PIL import Image, ImageDraw, ImageChops

DARK = (14, 59, 59, 255)        # Module, Lidrand
IRIS_OUT = (11, 122, 115, 255)  # Iris außen
IRIS_IN = (32, 178, 166, 255)   # Iris innen
PUPIL = (8, 28, 28, 255)
WHITE = (255, 255, 255, 255)
SS = 4  # Supersampling
RF = 1.0  # Rundungsfaktor der Eckmarken

def matrix(text="QR Viewer"):
    qr = qrcode.QRCode(version=2, error_correction=qrcode.constants.ERROR_CORRECT_H, border=0)
    qr.add_data(text); qr.make(fit=False)
    return qr.get_matrix()

def almond(size, cx, cy, w, h):
    """Mandelform als Schnitt zweier Kreise, als L-Maske."""
    s = h / 2
    R = (w * w / 4 + s * s) / (2 * s)
    a = Image.new("L", size, 0); b = Image.new("L", size, 0)
    ImageDraw.Draw(a).ellipse(
        [cx - R, (cy + R - s) - R, cx + R, (cy + R - s) + R], fill=255)
    ImageDraw.Draw(b).ellipse([cx - R, (cy - R + s) - R, cx + R, (cy - R + s) + R], fill=255)
    return ImageChops.multiply(a, b)

def render(px, margin_frac, bg=WHITE):
    """px: Kantenlänge; margin_frac: Rand je Seite relativ zu px."""
    n = px * SS
    img = Image.new("RGBA", (n, n), bg)
    d = ImageDraw.Draw(img)
    m = matrix(); N = len(m)
    margin = n * margin_frac
    ms = (n - 2 * margin) / N
    X = lambda c: margin + c * ms

    finder = lambda r, c: (r < 7 and c < 7) or (r < 7 and c >= N - 7) or (r >= N - 7 and c < 7)
    for r in range(N):
        for c in range(N):
            if m[r][c] and not finder(r, c):
                d.rectangle([X(c), X(r), X(c + 1) - 1, X(r + 1) - 1], fill=DARK)
    for (r0, c0) in [(0, 0), (0, N - 7), (N - 7, 0)]:
        x, y = X(c0), X(r0)
        d.rounded_rectangle([x, y, x + 7 * ms, y + 7 * ms], radius=RF * 1.8 * ms, fill=DARK)
        d.rounded_rectangle([x + ms, y + ms, x + 6 * ms, y + 6 * ms], radius=RF * 1.1 * ms, fill=bg)
        d.rounded_rectangle([x + 2 * ms, y + 2 * ms, x + 5 * ms, y + 5 * ms], radius=RF * 0.8 * ms, fill=DARK)

    # Auge
    cx = cy = n / 2
    W, H = 15.5 * ms, 9.2 * ms
    pad, stroke = 1.1 * ms, 0.7 * ms
    clear = almond((n, n), cx, cy, W + 2 * pad, H + 2 * pad)
    img.paste(Image.new("RGBA", (n, n), bg), (0, 0), clear)
    outer = almond((n, n), cx, cy, W, H)
    img.paste(Image.new("RGBA", (n, n), DARK), (0, 0), outer)
    inner = almond((n, n), cx, cy, W - 2.4 * stroke, H - 2 * stroke)
    img.paste(Image.new("RGBA", (n, n), WHITE), (0, 0), inner)

    iris = Image.new("RGBA", (n, n), (0, 0, 0, 0)); di = ImageDraw.Draw(iris)
    ri = 3.5 * ms
    steps = 40
    for i in range(steps):
        t = i / (steps - 1); r = ri * (1 - t * 0.55)
        col = tuple(int(IRIS_OUT[k] + (IRIS_IN[k] - IRIS_OUT[k]) * t) for k in range(3)) + (255,)
        di.ellipse([cx - r, cy - r, cx + r, cy + r], fill=col)
    rp = 1.6 * ms
    di.ellipse([cx - rp, cy - rp, cx + rp, cy + rp], fill=PUPIL)
    rh = 0.6 * ms; hx, hy = cx - 1.05 * ms, cy - 1.1 * ms
    di.ellipse([hx - rh, hy - rh, hx + rh, hy + rh], fill=WHITE)
    img.paste(iris, (0, 0), ImageChops.multiply(iris.getchannel("A"), inner))
    return img.resize((px, px), Image.LANCZOS)

if __name__ == "__main__":
    out = sys.argv[1]
    master = render(1024, 0.11).convert("RGB")
    master.save(os.path.join(out, "icon_1024.png"))
    # Android-Adaptive-Vordergrund: 108dp-Leinwand, QR auf ~46dp
    fg = render(432, (432 - 432 * 46 / 108) / 2 / 432, bg=(255, 255, 255, 0))
    fg.save(os.path.join(out, "foreground_432.png"))
