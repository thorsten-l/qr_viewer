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

"""Erzeugt die Anleitung als ODT und PDF:
docs/QR-Viewer-Anleitung.odt (Deutsch, texts.py) und
docs/QR-Viewer-Manual.odt (Englisch, texts_en.py).

Vorher die App-Ansichten in der Sprache rendern:
    MANUAL_LANG=de flutter test tool/manual/render_screens_test.dart
Dann (benötigt odfpy, zxing-cpp, pillow, numpy, pypdfium2, ppf-datamatrix,
aztec_code_generator):
    python3 tool/manual/make_manual.py [de|en]
Für die Seitenzahlen im Inhaltsverzeichnis wird das Dokument mit
LibreOffice (headless) in ein PDF umgewandelt; daneben entsteht
docs/QR-Viewer-Anleitung.pdf.
"""

import codecs
import importlib
import importlib.util
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

import aztec_code_generator
import numpy as np
import pypdfium2
import zxingcpp
from odf import draw, style, table, text
from odf.opendocument import OpenDocumentText
from PIL import Image
from ppf.datamatrix import DataMatrix

sys.path.insert(0, str(Path(__file__).parent))

# Sprachabhängig, gesetzt in main().
texts = None
SCREENS = None
OUT = None

ROOT = Path(__file__).resolve().parents[2]
TOOL = ROOT / "tool" / "manual"
BUILD = ROOT / "build" / "manual"
CODES = BUILD / "codes"

TEAL = "#00695c"
TEAL_LIGHT = "#e0f2f1"
SOFFICE = "/Applications/LibreOffice.app/Contents/MacOS/soffice"
FONT = "Liberation Sans"
MONO = "Liberation Mono"

# Breite der Beispielcodes in cm: 2D-Codes quadratisch, Strichcodes breit.
CODE_WIDTH = {"MicroQRCode": 2.6, "DataMatrix": 4.6, "Aztec": 5.4,
              "QRCode": 5.0, "PDF417": 9.0}
LINEAR_WIDTH = 7.5


# --- Codes und Bilder --------------------------------------------------------

def example_data(e):
    if "hex_file" in e:
        return bytes.fromhex((TOOL / e["hex_file"]).read_text().replace("\n", ""))
    if "hex" in e:
        return bytes.fromhex(e["hex"])
    return e["raw"]


def _latin1_codewords(msg):
    """Data-Matrix-ASCII-Modus mit Upper Shift für Bytes über 127."""
    out, i = [], 0
    while i < len(msg):
        c = ord(msg[i])
        if msg[i:i + 2].isdigit() and len(msg[i:i + 2]) == 2:
            out.append(130 + int(msg[i:i + 2]))
            i += 2
            continue
        out += [235, c - 127] if c > 127 else [c + 1]
        i += 1
    return bytes(out), len(msg)


codecs.register(lambda name: codecs.CodecInfo(
    _latin1_codewords, None, name=name)
    if name == "datamatrix.latin1" else None)


def datamatrix_image(data):
    """Quadratischer Data-Matrix-Code ohne ECI-Kennung, wie auf Briefmarken.

    zxing-cpp setzt bei Binärdaten ECI 899 und wählt ein Rechteck; das
    lesen Android nur als Binärdaten und iOS gar nicht.
    """
    dm = DataMatrix(data.decode("latin-1"))
    dm.codecs = ["datamatrix.latin1"]
    a = np.array(dm.matrix, dtype=np.uint8)
    img = np.pad(np.where(a == 1, 0, 255).astype(np.uint8), 2,
                 constant_values=255)
    return Image.fromarray(img).resize(
        (img.shape[1] * 12, img.shape[0] * 12), Image.NEAREST)


def make_code(e):
    """Schreibt den Code als PNG und prüft, dass er sich wieder lesen lässt."""
    data = example_data(e)
    if "image" in e:
        # Vorgegebenes Originalbild, unverändert übernommen.
        path = TOOL / e["image"]
        found = zxingcpp.read_barcodes(Image.open(path))
        if not found or found[0].bytes != data:
            sys.exit(f"Bild {path.name} enthält nicht die Beispieldaten")
        return path
    if e["zxing"] == "DataMatrix" and isinstance(data, bytes):
        img = datamatrix_image(data)
    elif e["zxing"] == "Aztec":
        # zxing-cpp nimmt nur rund 26 % Fehlerkorrektur; Handy-Tickets
        # haben über 50 %, und so liest die Kamera den Code zuverlässig.
        img = aztec_code_generator.AztecCode(data, ec_percent=50).image(
            module_size=12, border=2).convert("L")
    else:
        fmt = getattr(zxingcpp.BarcodeFormat, e["zxing"])
        barcode = zxingcpp.create_barcode(data, fmt)
        img = Image.fromarray(
            np.array(zxingcpp.write_barcode_to_image(barcode, scale=8)))
    found = zxingcpp.read_barcodes(img)
    if not found or (found[0].bytes != data if isinstance(data, bytes)
                     else found[0].text.replace("(01)", "01") not in
                     (data, "0" + data, expand_upce(data))):
        sys.exit(f"Code {e['id']} lässt sich nicht zurücklesen")
    path = CODES / f"{e['id']}.png"
    path.parent.mkdir(parents=True, exist_ok=True)
    img.save(path)
    return path


def expand_upce(code):
    """UPC-E nach UPC-A, nur für die Rücklese-Prüfung."""
    if len(code) != 8 or not code.isdigit():
        return code
    s, d, c = code[0], code[1:7], code[7]
    last = d[5]
    if last in "012":
        mid = d[0:2] + last + "0000" + d[2:5]
    elif last == "3":
        mid = d[0:3] + "00000" + d[3:5]
    elif last == "4":
        mid = d[0:4] + "00000" + d[4]
    else:
        mid = d[0:5] + "0000" + last
    return "0" + s + mid + c


def crop_to_content(src, dst, pad=24):
    """Schneidet den hellen Hintergrund um einen Dialog weg."""
    im = Image.open(src).convert("RGB")
    bg = im.getpixel((5, 5))
    arr = np.array(im).astype(int)
    diff = np.abs(arr - np.array(bg)).sum(axis=2) > 12
    ys, xs = np.nonzero(diff)
    box = (max(xs.min() - pad, 0), max(ys.min() - pad, 0),
           min(xs.max() + pad, im.width), min(ys.max() + pad, im.height))
    im.crop(box).save(dst)
    return dst


def image_size(path):
    with Image.open(path) as im:
        return im.size


# --- Dokument ---------------------------------------------------------------

class Manual:
    def __init__(self):
        self.doc = OpenDocumentText()
        self._styles()
        self._pictures = 0
        self.headings = []

    def _styles(self):
        d = self.doc
        for name in (FONT, MONO):
            d.fontfacedecls.addElement(style.FontFace(
                name=name, fontfamily=f"'{name}'", fontfamilygeneric="swiss"
                if name == FONT else "modern", fontpitch="variable"))

        dflt = style.DefaultStyle(family="paragraph")
        dflt.addElement(style.TextProperties(
            fontname=FONT, fontsize="11pt", language=texts.UI["language"],
            country=texts.UI["country"]))
        dflt.addElement(style.ParagraphProperties(
            margintop="0cm", marginbottom="0.2cm", lineheight="125%"))
        d.styles.addElement(dflt)

        def pstyle(name, auto=False, parent=None, text_props=None,
                   para_props=None, **kw):
            st = style.Style(name=name, family="paragraph", **kw)
            if parent:
                st.setAttribute("parentstylename", parent)
            if text_props:
                st.addElement(style.TextProperties(**text_props))
            if para_props:
                st.addElement(style.ParagraphProperties(**para_props))
            (d.automaticstyles if auto else d.styles).addElement(st)
            return st

        self.s_body = pstyle("Text body", displayname="Text body",
                             para_props=dict(textalign="justify",
                                             marginbottom="0.22cm"))
        self.s_h1 = pstyle("Heading 1", displayname="Heading 1",
                           defaultoutlinelevel="1",
                           text_props=dict(fontsize="20pt", fontweight="bold",
                                           color=TEAL),
                           para_props=dict(margintop="0.7cm",
                                           marginbottom="0.35cm",
                                           keepwithnext="always"))
        self.s_h1_page = pstyle("Heading 1 Page", displayname="Heading 1 Page",
                                parent="Heading 1", defaultoutlinelevel="1",
                                para_props=dict(breakbefore="page",
                                                margintop="0cm"))
        self.s_h2 = pstyle("Heading 2", displayname="Heading 2",
                           defaultoutlinelevel="2",
                           text_props=dict(fontsize="15pt", fontweight="bold",
                                           color=TEAL),
                           para_props=dict(margintop="0.5cm",
                                           marginbottom="0.25cm",
                                           keepwithnext="always"))
        self.s_h2_page = pstyle("Heading 2 Page", displayname="Heading 2 Page",
                                parent="Heading 2", defaultoutlinelevel="2",
                                para_props=dict(breakbefore="page",
                                                margintop="0cm"))
        self.s_h3 = pstyle("Heading 3", displayname="Heading 3",
                           defaultoutlinelevel="3",
                           text_props=dict(fontsize="12pt", fontweight="bold",
                                           color=TEAL),
                           para_props=dict(margintop="0.35cm",
                                           marginbottom="0.12cm",
                                           keepwithnext="always"))
        self.s_label = pstyle("Label", displayname="Label",
                              text_props=dict(fontsize="10.5pt",
                                              fontweight="bold", color=TEAL),
                              para_props=dict(margintop="0.25cm",
                                              marginbottom="0.05cm",
                                              keepwithnext="always"))
        self.s_small = pstyle("Small", displayname="Small",
                              text_props=dict(fontsize="10pt"),
                              para_props=dict(marginbottom="0.12cm"))
        self.s_meta = pstyle("Meta", displayname="Meta",
                             text_props=dict(fontsize="10pt", color="#455a64",
                                             fontstyle="italic"),
                             para_props=dict(marginbottom="0.3cm"))
        self.s_caption = pstyle("Caption", displayname="Caption",
                                text_props=dict(fontsize="9pt",
                                                fontstyle="italic",
                                                color="#455a64"),
                                para_props=dict(textalign="center",
                                                margintop="0.1cm",
                                                marginbottom="0.3cm"))
        self.s_center = pstyle("Centered", displayname="Centered",
                               para_props=dict(textalign="center",
                                               marginbottom="0cm"))
        self.s_note = pstyle("Note", displayname="Note",
                             text_props=dict(fontsize="10.5pt"),
                             para_props=dict(backgroundcolor=TEAL_LIGHT,
                                             padding="0.25cm",
                                             borderleft=f"0.12cm solid {TEAL}",
                                             margintop="0.15cm",
                                             marginbottom="0.35cm"))
        self.s_title = pstyle("Title", displayname="Title",
                              text_props=dict(fontsize="40pt",
                                              fontweight="bold", color=TEAL),
                              para_props=dict(textalign="center",
                                              margintop="3cm",
                                              marginbottom="0.4cm"))
        self.s_subtitle = pstyle("Subtitle", displayname="Subtitle",
                                 text_props=dict(fontsize="18pt",
                                                 color="#37474f"),
                                 para_props=dict(textalign="center",
                                                 marginbottom="1.2cm"))
        self.s_toc_title = pstyle("Contents Heading",
                                  displayname="Contents Heading",
                                  text_props=dict(fontsize="20pt",
                                                  fontweight="bold",
                                                  color=TEAL),
                                  para_props=dict(breakbefore="page",
                                                  marginbottom="0.45cm"))
        self.s_contents = {}
        for lvl, indent in ((1, "0cm"), (2, "0.6cm")):
            st = pstyle(f"Contents {lvl}", displayname=f"Contents {lvl}",
                        text_props=dict(fontweight="bold") if lvl == 1
                        else dict(fontsize="10pt"),
                        para_props=dict(marginleft=indent,
                                        margintop="0.14cm" if lvl == 1
                                        else "0cm",
                                        marginbottom="0.02cm"))
            pp = st.getElementsByType(style.ParagraphProperties)[0]
            stops = style.TabStops()
            stops.addElement(style.TabStop(
                position=f"{16.6 - float(indent[:-2]):.1f}cm", type="right",
                leaderstyle="dotted", leadertext="."))
            pp.addElement(stops)
            self.s_contents[lvl] = st

        self.t_bold = style.Style(name="Strong", family="text")
        self.t_bold.addElement(style.TextProperties(fontweight="bold"))
        d.styles.addElement(self.t_bold)
        self.t_code = style.Style(name="Code", family="text")
        self.t_code.addElement(style.TextProperties(fontname=MONO,
                                                    fontsize="10pt"))
        d.styles.addElement(self.t_code)
        self.t_footer = style.Style(name="Footer", family="paragraph")
        self.t_footer.addElement(style.TextProperties(fontsize="9pt",
                                                      color="#607d8b"))
        self.t_footer.addElement(style.ParagraphProperties(textalign="center"))
        d.styles.addElement(self.t_footer)

        # Aufzählung
        self.s_list = text.ListStyle(name="Bullets")
        lvl = text.ListLevelStyleBullet(level="1", bulletchar="•")
        lvl.addElement(style.ListLevelProperties(
            listlevelpositionandspacemode="label-alignment"))
        lvl.firstChild.addElement(style.ListLevelLabelAlignment(
            labelfollowedby="listtab", listtabstopposition="0.6cm",
            textindent="-0.4cm", marginleft="0.6cm"))
        self.s_list.addElement(lvl)
        d.styles.addElement(self.s_list)
        self.s_list_p = pstyle("List Paragraph", displayname="List Paragraph",
                               para_props=dict(marginbottom="0.1cm"))

        # Seiten: A4, Fußzeile mit Seitenzahl
        pl = style.PageLayout(name="A4")
        pl.addElement(style.PageLayoutProperties(
            pagewidth="21cm", pageheight="29.7cm", margintop="1.8cm",
            marginbottom="1.4cm", marginleft="2.2cm", marginright="2.2cm",
            printorientation="portrait"))
        fs = style.FooterStyle()
        fs.addElement(style.HeaderFooterProperties(minheight="0.6cm",
                                                   margintop="0.4cm"))
        pl.addElement(fs)
        d.automaticstyles.addElement(pl)
        mp = style.MasterPage(name="Standard", pagelayoutname=pl)
        footer = style.Footer()
        fp = text.P(stylename=self.t_footer, text=texts.UI["footer"])
        fp.addElement(text.PageNumber(selectpage="current", text="1"))
        footer.addElement(fp)
        mp.addElement(footer)
        d.masterstyles.addElement(mp)

        # Rahmen für Bilder und Tabellen
        self.g_image = style.Style(name="ImageFrame", family="graphic")
        self.g_image.addElement(style.GraphicProperties(
            anchortype="as-char", verticalpos="top", verticalrel="baseline",
            border="none", padding="0cm", wrap="none"))
        d.automaticstyles.addElement(self.g_image)
        self.g_shot = style.Style(name="ShotFrame", family="graphic")
        self.g_shot.addElement(style.GraphicProperties(
            anchortype="as-char", verticalpos="top", verticalrel="baseline",
            border="0.03cm solid #b0bec5", padding="0cm", wrap="none"))
        d.automaticstyles.addElement(self.g_shot)

        self.tbl_cell = style.Style(name="CellTop", family="table-cell")
        self.tbl_cell.addElement(style.TableCellProperties(
            verticalalign="top", padding="0.1cm", border="none"))
        d.automaticstyles.addElement(self.tbl_cell)
        self.tbl_grid = style.Style(name="CellGrid", family="table-cell")
        self.tbl_grid.addElement(style.TableCellProperties(
            verticalalign="top", padding="0.08cm",
            border="0.03cm solid #b0bec5"))
        d.automaticstyles.addElement(self.tbl_grid)
        self.tbl_head = style.Style(name="CellHead", family="table-cell")
        self.tbl_head.addElement(style.TableCellProperties(
            verticalalign="top", padding="0.08cm", backgroundcolor=TEAL_LIGHT,
            border="0.03cm solid #b0bec5"))
        d.automaticstyles.addElement(self.tbl_head)

    # --- Bausteine

    def rich(self, para, s):
        """Fügt Text mit **fett** und `Code` in den Absatz ein."""
        for part in re.split(r"(\*\*.+?\*\*|`.+?`)", s):
            if not part:
                continue
            if part.startswith("**"):
                para.addElement(text.Span(stylename=self.t_bold, text=part[2:-2]))
            elif part.startswith("`"):
                para.addElement(text.Span(stylename=self.t_code, text=part[1:-1]))
            else:
                para.addText(part)
        return para

    def p(self, s, st=None, parent=None):
        para = self.rich(text.P(stylename=st or self.s_body), s)
        (parent or self.doc.text).addElement(para)
        return para

    def h(self, s, level, st=None):
        para = text.H(outlinelevel=level, stylename=st or
                      {1: self.s_h1, 2: self.s_h2, 3: self.s_h3}[level])
        para.addText(s)
        self.doc.text.addElement(para)
        if level <= 2:
            self.headings.append((level, s))

    def bullets(self, items, parent=None, st=None):
        lst = text.List(stylename=self.s_list)
        for item in items:
            li = text.ListItem()
            li.addElement(self.rich(text.P(stylename=st or self.s_list_p), item))
            lst.addElement(li)
        (parent or self.doc.text).addElement(lst)

    def frame(self, path, width_cm, shot=False):
        w, h = image_size(path)
        height_cm = width_cm * h / w
        href = self.doc.addPicture(str(path))
        self._pictures += 1
        fr = draw.Frame(stylename=self.g_shot if shot else self.g_image,
                        width=f"{width_cm:.2f}cm", height=f"{height_cm:.2f}cm",
                        anchortype="as-char", name=f"Bild{self._pictures}")
        fr.addElement(draw.Image(href=href))
        return fr

    def image(self, path, width_cm, caption=None, shot=True, parent=None):
        target = parent or self.doc.text
        para = text.P(stylename=self.s_center)
        para.addElement(self.frame(path, width_cm, shot))
        target.addElement(para)
        if caption:
            target.addElement(text.P(stylename=self.s_caption, text=caption))

    def table(self, widths_cm, name):
        tst = style.Style(name=f"{name}Tbl", family="table")
        tst.addElement(style.TableProperties(
            width=f"{sum(widths_cm):.2f}cm", align="center"))
        self.doc.automaticstyles.addElement(tst)
        t = table.Table(name=name, stylename=tst)
        for i, w in enumerate(widths_cm):
            cst = style.Style(name=f"{name}C{i}", family="table-column")
            cst.addElement(style.TableColumnProperties(columnwidth=f"{w}cm"))
            self.doc.automaticstyles.addElement(cst)
            t.addElement(table.TableColumn(stylename=cst))
        self.doc.text.addElement(t)
        return t

    def blocks(self, items):
        for b in items:
            if isinstance(b, str):
                self.p(b)
            elif isinstance(b, list):
                self.bullets(b)
            elif b[0] == "note":
                self.p(b[1], self.s_note)
            elif b[0] == "h3":
                self.h(b[1], 3)
            elif b[0] == "img":
                self.image(SCREENS / b[1], b[2], b[3])
            elif b[0] == "imgpair":
                t = self.table([8.2, 8.2], f"Paar{self._pictures}")
                row = table.TableRow()
                for f in (b[1], b[2]):
                    cell = table.TableCell(stylename=self.tbl_cell)
                    para = text.P(stylename=self.s_center)
                    para.addElement(self.frame(SCREENS / f, b[3], shot=True))
                    cell.addElement(para)
                    row.addElement(cell)
                t.addElement(row)
                self.p(b[4], self.s_caption)

    def toc(self, entries, pages):
        toc = text.TableOfContent(name="TOC", protected="true")
        src = text.TableOfContentSource(outlinelevel="2")
        src.addElement(text.IndexTitleTemplate(
            stylename=self.s_toc_title, text=texts.UI["contents"]))
        for lvl in (1, 2):
            tpl = text.TableOfContentEntryTemplate(
                outlinelevel=str(lvl), stylename=f"Contents {lvl}")
            tpl.addElement(text.IndexEntryLinkStart())
            tpl.addElement(text.IndexEntryText())
            tpl.addElement(text.IndexEntryTabStop(type="right",
                                                  leaderchar="."))
            tpl.addElement(text.IndexEntryPageNumber())
            tpl.addElement(text.IndexEntryLinkEnd())
            src.addElement(tpl)
        toc.addElement(src)
        body = text.IndexBody()
        title = text.IndexTitle(name="TOC_Head")
        title.addElement(text.P(stylename=self.s_toc_title,
                                text=texts.UI["contents"]))
        body.addElement(title)
        for level, heading in entries:
            para = text.P(stylename=self.s_contents[level], text=heading)
            para.addElement(text.Tab())
            para.addText(str(pages.get(heading, "")))
            body.addElement(para)
        toc.addElement(body)
        self.doc.text.addElement(toc)

    def save(self, path):
        path.parent.mkdir(parents=True, exist_ok=True)
        self.doc.save(str(path))


# --- Inhalt -----------------------------------------------------------------

PROJECT_URL = "https://github.com/thorsten-l/qr_viewer"


def title_icon():
    """App-Symbol (QR-Code mit Auge) mit der Projekt-URL als Inhalt.

    Zeichnet mit tool/app_icon/make_icon.py; nur der Inhalt ist anders,
    daher eine größere QR-Version. Das Auge verdeckt Module, die die
    Fehlerkorrektur H ausgleicht – geprüft wird in mehreren Größen.
    """
    import qrcode
    spec = importlib.util.spec_from_file_location(
        "make_icon", ROOT / "tool" / "app_icon" / "make_icon.py")
    icon = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(icon)

    def matrix(text=None):
        qr = qrcode.QRCode(error_correction=qrcode.constants.ERROR_CORRECT_H,
                           border=0)
        qr.add_data(PROJECT_URL)
        qr.make(fit=True)
        return qr.get_matrix()

    icon.matrix = matrix
    img = icon.render(1024, 0.08).convert("RGB")
    for size in (1024, 400, 200):
        found = zxingcpp.read_barcodes(img.resize((size, size), Image.LANCZOS))
        if not found or found[0].text != PROJECT_URL:
            sys.exit(f"Titel-QR-Code in {size} px nicht lesbar")
    path = BUILD / "title_qr.png"
    path.parent.mkdir(parents=True, exist_ok=True)
    img.save(path)
    return path


def title_page(m):
    m.p(texts.TITLE, m.s_title)
    m.p(texts.SUBTITLE, m.s_subtitle)
    m.image(title_icon(), 5.0, shot=False)
    m.p(PROJECT_URL, m.s_center)
    m.p("", m.s_center)
    m.p(texts.VERSION_LINE, m.s_subtitle)
    m.p(texts.UI["platforms"], m.s_center)


def appendix(m, examples):
    ui = texts.UI
    m.h(ui["appendix"], 1, m.s_h1_page)
    m.blocks(texts.APPENDIX_INTRO)

    t = m.table([1.2, 5.6, 5.0, 4.6], "Uebersicht")
    head = table.TableRow()
    for s in ui["columns"]:
        c = table.TableCell(stylename=m.tbl_head)
        c.addElement(m.rich(text.P(stylename=m.s_small), f"**{s}**"))
        head.addElement(c)
    t.addElement(head)
    for i, key in enumerate(texts.ORDER, 1):
        page = texts.PAGES[key]
        row = table.TableRow()
        for s in (f"A.{i}", page["title"], page["mode"], page["devices"]):
            c = table.TableCell(stylename=m.tbl_grid)
            c.addElement(text.P(stylename=m.s_small, text=s))
            row.addElement(c)
        t.addElement(row)

    for i, key in enumerate(texts.ORDER, 1):
        e = examples[key]
        page = texts.PAGES[key]
        m.h(f"A.{i} {page['title']}", 2, m.s_h2_page)
        m.p(ui["meta"].format(mode=page["mode"], devices=page["devices"]),
            m.s_meta)

        t = m.table([10.3, 6.3], f"Seite{i}")
        row = table.TableRow()
        left = table.TableCell(stylename=m.tbl_cell)
        code = make_code(e)
        width = CODE_WIDTH.get(e["zxing"], LINEAR_WIDTH)
        m.image(code, width, ui["try_code"], shot=False,
                parent=left)
        for label, key2 in ((ui["what"], "what"), (ui["where"], "where"),
                            (ui["example"], "example")):
            left.addElement(text.P(stylename=m.s_label, text=label))
            m.p(page[key2], m.s_small, parent=left)
        right = table.TableCell(stylename=m.tbl_cell)
        m.image(SCREENS / f"{key}.png", 5.9, ui["shown"],
                parent=right)
        row.addElement(left)
        row.addElement(right)
        t.addElement(row)

        for label, key2 in ((ui["app"], "app"), (ui["do"], "do")):
            m.p(label, m.s_label)
            m.p(page[key2], m.s_small)
        m.p(f"**{ui['care']}** " + page["care"], m.s_note)


# Kapitel, die immer auf einer neuen Seite beginnen (nach dem Inhalt).
NEW_PAGE = ("1 ",)


def build(examples, entries, pages, breaks=frozenset()):
    """breaks: Kapitel, die wegen ihrer Lage im unteren Seitendrittel auf
    eine neue Seite rücken."""
    m = Manual()
    title_page(m)
    m.toc(entries, pages)
    for heading, blocks in texts.CHAPTERS:
        new_page = heading.startswith(NEW_PAGE) or heading in breaks
        m.h(heading, 1, m.s_h1_page if new_page else None)
        m.blocks(blocks)
    appendix(m, examples)
    m.save(OUT)
    return m.headings


def to_pdf(odt, outdir):
    subprocess.run([SOFFICE, "--headless", "--norestore", "--convert-to",
                    "pdf", "--outdir", str(outdir), str(odt)],
                   check=True, capture_output=True)
    return Path(outdir) / (odt.stem + ".pdf")


def heading_pages(pdf_path, entries):
    """Seite jeder Überschrift: die erste Seite (nach dem Inhaltsverzeichnis),
    deren Text die Überschrift enthält. Dazu die Kapitel (Ebene 1), die im
    unteren Drittel ihrer Seite beginnen."""
    norm = lambda t: re.sub(r"\s+", " ", t).strip()
    pdf = pypdfium2.PdfDocument(str(pdf_path))
    texts_ = [norm(pdf[i].get_textpage().get_text_range())
              for i in range(len(pdf))]
    pages, low, start = {}, set(), 2
    for level, heading in entries:
        h = norm(heading)
        for i in range(start, len(texts_)):
            # Anhangsseiten beginnen mit ihrer Überschrift; so zählt die
            # Übersichtstabelle nicht als Fundstelle.
            if (texts_[i].startswith(h) if level == 2 else h in texts_[i]):
                pages[heading] = i + 1
                start = i
                if level == 1 and _in_lower_third(pdf[i], heading):
                    low.add(heading)
                break
    return pages, low


def _in_lower_third(page, heading):
    """True, wenn die Überschrift im unteren Drittel der Seite steht."""
    found = page.get_textpage().search(heading[:18], match_case=True)
    hit = found.get_next()
    if hit is None:
        return False
    _, _, _, top = page.get_textpage().get_charbox(hit[0])
    return top < page.get_height() / 3


def main():
    global texts, SCREENS, OUT
    lang = sys.argv[1] if len(sys.argv) > 1 else "de"
    texts = importlib.import_module("texts" if lang == "de" else f"texts_{lang}")
    SCREENS = BUILD / "screens" / lang
    OUT = ROOT / "docs" / texts.UI["file"]
    examples = {e["id"]: e for e in
                json.loads((TOOL / "examples.json").read_text())}
    missing = [k for k in texts.ORDER if not (SCREENS / f"{k}.png").exists()]
    if missing:
        sys.exit("Fehlende App-Ansichten, erst rendern: " + ", ".join(missing))
    crop_to_content(SCREENS / "about.png", SCREENS / "about_crop.png")

    entries = build(examples, [], {})
    pages, breaks = {}, set()
    with tempfile.TemporaryDirectory() as tmp:
        for _ in range(8):
            new, low = heading_pages(to_pdf(OUT, tmp), entries)
            if new == pages and low <= breaks:
                break
            pages, breaks = new, breaks | low
            build(examples, entries, pages, frozenset(breaks))
    missing = [h for _, h in entries if h not in pages]
    if missing:
        sys.exit("Seitenzahl nicht gefunden: " + ", ".join(missing))
    to_pdf(OUT, OUT.parent)
    print(f"{OUT.relative_to(ROOT)} + .pdf, {max(pages.values())} Seiten, "
          f"Umbruch vor: {', '.join(sorted(breaks)) or '-'}")


if __name__ == "__main__":
    main()
