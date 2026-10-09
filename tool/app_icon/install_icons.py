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

import sys, os, json
from PIL import Image, ImageDraw
src, proj = sys.argv[1], sys.argv[2]
master = Image.open(os.path.join(src, "icon_1024.png")).convert("RGB")
fg = Image.open(os.path.join(src, "foreground_432.png")).convert("RGBA")

# iOS: alle Einträge aus Contents.json, ohne Alphakanal
setdir = os.path.join(proj, "ios/Runner/Assets.xcassets/AppIcon.appiconset")
for e in json.load(open(os.path.join(setdir, "Contents.json")))["images"]:
    px = round(float(e["size"].split("x")[0]) * int(e["scale"][0]))
    master.resize((px, px), Image.LANCZOS).save(os.path.join(setdir, e["filename"]))
    print("ios", e["filename"], px)

# Android: Legacy-Icon (abgerundetes Quadrat) und Adaptive-Vordergrund
res = os.path.join(proj, "android/app/src/main/res")
dens = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}
big = master.convert("RGBA").resize((768, 768), Image.LANCZOS)
mask = Image.new("L", (768, 768), 0)
ImageDraw.Draw(mask).rounded_rectangle([0, 0, 767, 767], radius=150, fill=255)
legacy = Image.new("RGBA", (768, 768), (0, 0, 0, 0)); legacy.paste(big, (0, 0), mask)
for name, f in dens.items():
    d = os.path.join(res, f"mipmap-{name}"); os.makedirs(d, exist_ok=True)
    legacy.resize((round(48 * f),) * 2, Image.LANCZOS).save(os.path.join(d, "ic_launcher.png"))
    fg.resize((round(108 * f),) * 2, Image.LANCZOS).save(os.path.join(d, "ic_launcher_foreground.png"))
    print("android", name, round(48 * f), round(108 * f))

os.makedirs(os.path.join(res, "mipmap-anydpi-v26"), exist_ok=True)
open(os.path.join(res, "mipmap-anydpi-v26/ic_launcher.xml"), "w").write(
'''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''')
open(os.path.join(res, "values/colors.xml"), "w").write(
'''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#FFFFFF</color>
</resources>
''')

# Startbildschirm: Icon mit abgerundeten Ecken, 160 pt/dp groß
def launch_image(px):
    img = master.convert("RGBA").resize((px * 4, px * 4), Image.LANCZOS)
    m = Image.new("L", img.size, 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, px * 4 - 1, px * 4 - 1], radius=round(px * 4 * 0.2237), fill=255)
    out = Image.new("RGBA", img.size, (0, 0, 0, 0)); out.paste(img, (0, 0), m)
    return out.resize((px, px), Image.LANCZOS)

LAUNCH = 160
launch_dir = os.path.join(proj, "ios/Runner/Assets.xcassets/LaunchImage.imageset")
for scale, name in [(1, "LaunchImage.png"), (2, "LaunchImage@2x.png"), (3, "LaunchImage@3x.png")]:
    launch_image(LAUNCH * scale).save(os.path.join(launch_dir, name))
    print("ios launch", name, LAUNCH * scale)
for name, f in dens.items():
    d = os.path.join(res, f"drawable-{name}"); os.makedirs(d, exist_ok=True)
    launch_image(round(LAUNCH * f)).save(os.path.join(d, "launch_image.png"))
    print("android launch", name, round(LAUNCH * f))
