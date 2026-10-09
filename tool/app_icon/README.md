# App-Icon

Symbolischer QR-Code mit Auge in der Mitte. Der Code muss nicht scannbar sein.

Neu erzeugen (benötigt Pillow und qrcode in einer eigenen Python-Umgebung):

```sh
python3 -m venv /tmp/iconenv && /tmp/iconenv/bin/pip install pillow qrcode
mkdir -p /tmp/icon
/tmp/iconenv/bin/python tool/app_icon/make_icon.py /tmp/icon
/tmp/iconenv/bin/python tool/app_icon/install_icons.py /tmp/icon .
```
