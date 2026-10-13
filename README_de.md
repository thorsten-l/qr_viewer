# QR Viewer

[English](README.md) · **Deutsch**

Scanner für QR-Codes und Barcodes für iPhone, iPad und Android, der Inhalte
zuerst nur anzeigt. Links und andere Aktionen starten erst nach einer
Rückfrage.

## Funktionen

- **Scan-Arten** über das Menü im Titel: QR-Code, Barcode (EAN-13, EAN-8,
  UPC-A, UPC-E, Code 128, Code 39, Code 93, Codabar, ITF-14), Data Matrix,
  PDF417, Aztec oder alle Codes gleichzeitig. Die gewählte Art bleibt gespeichert.
- **Nur anzeigen:** Der Inhalt erscheint in Source Code Pro, zusammen mit
  Format, Inhaltstyp und bei Links dem Host. Nichts wird automatisch geöffnet.
- **Links** öffnen sich erst nach einer Rückfrage mit sichtbarer URL; bekannte
  Tracking-Parameter (`utm_*`, `fbclid`, …) fallen dabei weg. Auch Adressen
  ohne Schema (`beispiel.de/pfad`) und App-Links (`market://`, `fido:/`, …)
  werden erkannt.
- **Inhalte erkannt:** Kontakt (vCard, MECARD, BIZCARD), Termin (iCalendar),
  WLAN, E-Mail, Telefon, SMS, Ort (`geo:`), Link, Lesezeichen (MEBKM),
  Überweisung (GiroCode),
  Einmalpasswort (`otpauth://`), JSON, Artikelnummer (EAN/UPC/ITF-14 mit
  Prüfziffer und GS1-Land, ISBN, ISSN), Matrixcode der Deutschen Post
  (Sendungsnummer) und Matter-Gerät (`MT:`, mit manuellem Kopplungscode)
  erscheinen als Karte mit beschrifteten, einzeln
  kopierbaren Feldern; der Rohinhalt steht darunter. Ein Info-Knopf erklärt
  die Daten in einfachen Worten. Alles andere ist Text.
- **Aktionen** je Inhalt, immer mit Rückfrage: E-Mail schreiben, Anrufen,
  SMS, Karte, Authenticator, online nachschlagen, Sendung verfolgen. Kontakte
  und Termine gehen als `.vcf`/`.ics` über das Teilen-Menü an Kontakte bzw.
  Kalender.
- **Kopieren und Teilen** mit einem Tipp.
- **Verlauf** der letzten 25 Scans: erneut aufrufen, kopieren, durchsuchen,
  einzeln wegwischen (mit Rückgängig), alles löschen, als CSV oder JSON
  exportieren. 2FA-Schlüssel werden nicht gespeichert.
- **Binärcodes** werden als Hex-Dump mit Textspalte angezeigt. **VDV-eTickets** (z. B.
  Deutschlandticket) werden zusätzlich dekodiert: Ticketnummer, Produkt,
  Gültigkeit, Ausstellungszeit, (maskierter) Inhaber, Geburtsdatum,
  Organisationsnummern, Klasse, Preis und Signaturprüfung. Die Rohdaten
  bleiben als Hex aufklappbar. Alles lokal auf dem Gerät.
- **Info-Dialog** mit Entwickler, Version und Build-Datum sowie Knöpfen für
  Support (GitHub-Issues), Lizenzen und die [Anleitungen](docs/).
- **Zoomstufen** der Rückkamera wie in der Kamera-App, ermittelt aus den
  Objektiven des Geräts, z. B. Auto · 0,5× · 1× · 2× · 5× (iPhone 16 Pro Max)
  oder 0,6× · 1× · 2× (Pixel 9a). Die Auswahl bleibt gespeichert.
- **Taschenlampe** mit Statusanzeige, Vibration beim Erkennen, heller und
  dunkler Modus.
- **13 Sprachen**, siehe [Sprachen](#sprachen).

Was sich in welcher Version geändert hat, steht im [Changelog](CHANGELOG_de.md).

## Anleitung

Eine Anleitung für Alltagsnutzer erklärt Scannen, Ergebnisseite, Aktionen,
Verlauf und Datenschutz in einfachen Worten. Im Anhang steht jede unterstützte
Codeart auf einer eigenen Seite, mit einem scanbaren Beispielcode und der
passenden Ergebnisseite der App:

- Deutsch: [QR-Viewer-Anleitung.pdf](docs/QR-Viewer-Anleitung.pdf)
  ([ODT](docs/QR-Viewer-Anleitung.odt))
- Englisch: [QR-Viewer-Manual.pdf](docs/QR-Viewer-Manual.pdf)
  ([ODT](docs/QR-Viewer-Manual.odt))

Die Anleitungen entstehen mit den Skripten in `tool/manual/`:

```sh
MANUAL_LANG=de flutter test tool/manual/render_screens_test.dart  # App-Ansichten
/tmp/qrv-venv/bin/python tool/manual/make_manual.py de              # ODT + PDF
```

Die Python-Umgebung braucht `odfpy`, `zxing-cpp`, `pillow`, `numpy`,
`pypdfium2`, `ppf-datamatrix` und `aztec_code_generator`; LibreOffice erzeugt
die Seitenzahlen und das PDF. Für die englische Anleitung `en` statt `de`
angeben.

## Datenschutz

Die App erhebt keine personenbezogenen Daten. Details stehen in der
[Datenschutzerklärung](PRIVACY.md). Fragen und Fehlerberichte gerne über die
[Issues](https://github.com/thorsten-l/qr_viewer/issues).

## Entwicklung

```sh
flutter pub get
flutter analyze
flutter test
flutter run --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)
```

Ohne `BUILD_DATE` zeigt der Info-Dialog statt des Build-Datums den
Installationszeitpunkt.

### Projektstruktur

| Pfad | Inhalt |
|---|---|
| `lib/main.dart` | App, Scanner-Seite und Auswahlmenü |
| `lib/scan_mode.dart` | Scan-Arten und ihre Codeformate |
| `lib/camera_lens.dart` | Zoomstufen der Rückkamera und Umschalter (native Abfrage in `AppDelegate.swift` und `MainActivity.kt`) |
| `lib/result_page.dart` | Ergebnisansicht mit Kopieren, Teilen, Aktionen und Rückfrage |
| `lib/qr_content.dart` | Parser für QR-Inhaltsformate (vCard, WIFI, EPC, otpauth, JSON, Links, …) |
| `lib/content_actions.dart` | Aktionen je Inhalt (mailto, tel, sms, Karte, …), vCard-/iCalendar-Export |
| `lib/gtin.dart` | Artikelnummern: Prüfziffer, UPC-E, GS1-Präfix, ISBN, ISSN |
| `lib/deutsche_post.dart` | Matrixcode der Deutschen Post (Sendungsnummer) |
| `lib/matter.dart` | Matter-Onboarding-Code (`MT:`, Base38) und manueller Kopplungscode |
| `lib/history.dart` | Verlauf der letzten 25 Scans mit Suche und CSV/JSON-Export |
| `lib/binary_payload.dart` | Erkennung von Binärinhalten, Hex-Darstellung |
| `lib/vdv/` | VDV-eTicket: BER, ISO 9796-2, Zertifikate, Ticketdaten |
| `assets/vdv_certs/` | Öffentliche VDV-CA-Schlüssel (CC0), siehe `tool/vdv/README.md` |
| `lib/app_info.dart` | Info-Dialog mit Support-, Lizenz- und Anleitungs-Knopf |
| `lib/localization.dart`, `lib/l10n/` | Übersetzungen (generiert) |
| `test/` | Widget- und Unit-Tests, auch für alle Sprachen |
| `tool/vdv/` | Update-Skript und Herkunft der VDV-Schlüssel |
| `tool/manual/` | Generator der Anleitungen (Beispielcodes, App-Ansichten, ODT/PDF) |
| `tool/` | Skripte für Icon, Übersetzungen, Store-Grafiken, Lizenzköpfe, Release-Schlüssel |
| `screenshots/` | Quellbilder und fertige Grafiken für App Store und Google Play |
| `docs/` | Anleitungen: `QR-Viewer-Anleitung.odt`/`.pdf` (Deutsch), `QR-Viewer-Manual.odt`/`.pdf` (Englisch) |

## Version

Aktuell: **2.1.2** (Build 13). Version und Build-Nummer stehen in
`pubspec.yaml`, z. B. `version: 2.1.2+13`. Für jeden Upload zu TestFlight oder
Google Play muss die Build-Nummer hinter dem `+` steigen. Jede neue Version
bekommt einen Eintrag in [CHANGELOG.md](CHANGELOG.md) (englisch) und
[CHANGELOG_de.md](CHANGELOG_de.md) (deutsch).

## Release

Ablauf für eine neue Version:

1. Version in `pubspec.yaml` erhöhen (Build-Nummer immer +1).
2. Eintrag in [CHANGELOG.md](CHANGELOG.md) und
   [CHANGELOG_de.md](CHANGELOG_de.md), README.md, README_de.md und ggf.
   [PRIVACY.md](PRIVACY.md) anpassen (Datum „Stand“).
3. Prüfen: `flutter analyze`, `flutter test`,
   `python3 tool/license/add_headers.py --check`.
4. iOS und Android wie unten bauen und hochladen.
5. Committen und taggen, z. B. `git tag v2.1.2`.

### iOS / TestFlight

Signiert wird automatisch mit dem Team `49MFGU6N6W`. Bauen und direkt zu
App Store Connect hochladen:

```sh
flutter build ipa --release \
  --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M) \
  --export-options-plist=ios/export/ExportOptions-TestFlight.plist
```

Flutter meldet danach einen Fehler, weil es eine lokale `.ipa` sucht, die
beim direkten Upload nicht entsteht. Ob der Upload geklappt hat, steht im
Xcode-Protokoll (`UPLOAD SUCCEEDED`) bzw. in App Store Connect.

### Android

Release-Builds werden mit dem Upload-Schlüssel aus `android/key.properties`
signiert (nicht im Repository). Einmalig anlegen:

```sh
tool/create_release_key.sh
```

Das Skript fragt ein Passwort ab und legt `~/keystores/qr_viewer-upload.jks`
sowie `android/key.properties` an. Beides sicher aufbewahren. Fehlt
`key.properties`, wird mit dem Debug-Schlüssel signiert.

```sh
BD=$(date +%Y-%m-%dT%H:%M)
flutter build appbundle --release --dart-define=BUILD_DATE=$BD            # Google Play
flutter build apk --release --split-per-abi --dart-define=BUILD_DATE=$BD  # direkt installierbar
```

## Sprachen

Englisch, Deutsch, Spanisch, Französisch, Portugiesisch, Russisch, Chinesisch
(vereinfacht), Hindi, Arabisch, Japanisch, Italienisch, Polnisch und
Ukrainisch. Die App folgt der Gerätesprache; andere Sprachen fallen auf
Englisch zurück. Arabisch wird von rechts nach links dargestellt.

Alle Texte, auch die iOS-Kamera-Rückfrage, stehen in `tool/l10n/strings.py`.
Nach einer Änderung:

```sh
python3 tool/l10n/strings.py   # erzeugt lib/l10n/*.arb und ios/Runner/*.lproj/InfoPlist.strings
flutter gen-l10n               # erzeugt lib/l10n/app_localizations*.dart
```

Eine neue Sprache muss zusätzlich in `ios/Runner/Info.plist`
(`CFBundleLocalizations`), im Xcode-Projekt und in
`android/app/src/main/res/xml/locales_config.xml` eingetragen werden.

## Grafiken

Die Skripte brauchen Pillow und qrcode, am besten in einer eigenen Umgebung:

```sh
python3 -m venv /tmp/qrv-venv && /tmp/qrv-venv/bin/pip install pillow qrcode
```

| Skript | Erzeugt |
|---|---|
| `tool/app_icon/make_icon.py`, `install_icons.py` | App-Icon und Startbildschirm für iOS und Android (siehe `tool/app_icon/README.md`) |
| `tool/screenshots/make_store_shots.py` | Screenshots für App Store (iPhone, iPad 13") und Google Play (Handy 9:16) |
| `tool/screenshots/make_store_banners.py` | App-Store-Kopfzeile und -Suchergebnisse, Play-Store-Feature-Graphic und 512er-Icon |

Quellbilder liegen unter `screenshots/source/<sprache>/` (iPhone direkt,
`ipad/`, `android/`), Ergebnisse unter `screenshots/app_store/` und
`screenshots/play_store/`.

## Plattform-Hinweise

- **iOS:** Die Codeerkennung nutzt Apples Vision-Framework. Die Kamera-Rückfrage
  ist in `ios/Runner/*.lproj/InfoPlist.strings` übersetzt.
  `ITSAppUsesNonExemptEncryption` ist auf `false` gesetzt. Die Zoomstufen
  fragt `ios/Runner/AppDelegate.swift` über den Kanal
  `de.l9g.qr_viewer/camera` bei AVFoundation ab.
- **Android:** Die Codeerkennung nutzt Google ML Kit (in die App eingebaut).
  ML Kit bringt die Berechtigungen `INTERNET` und `ACCESS_NETWORK_STATE` mit und
  kann Diagnosedaten an Google senden; das ist in der Datenschutzerklärung
  beschrieben. Die `<queries>` für `http`/`https` in `AndroidManifest.xml`
  braucht `url_launcher`. Ab Android 13 ist die Sprache pro App wählbar.
  Die Zoomstufen ermittelt `MainActivity.kt` über Camera2
  (`CameraCharacteristics`). Eine selbst signierte APK lässt sich nicht über
  eine Play-Store-Installation installieren (andere Signatur); dafür die App
  vorher deinstallieren.

## Lizenz

Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)

Lizenziert unter der [Apache License 2.0](LICENSE). Jede Quelldatei trägt den
Lizenzkopf; neue Dateien ergänzt bzw. prüft:

```sh
python3 tool/license/add_headers.py          # fehlende Köpfe einfügen
python3 tool/license/add_headers.py --check  # nur prüfen
```

Die Schrift Source Code Pro steht unter der SIL Open Font License 1.1
(`assets/fonts/SourceCodePro-OFL.txt`).

Die öffentlichen VDV-Schlüssel in `assets/vdv_certs/` stehen unter CC0-1.0
(Quelle: KDE KItinerary, ursprünglich VDV-PKI), siehe `tool/vdv/README.md`.
Der Dekoder in `lib/vdv/` ist eine eigene Umsetzung nach dem dokumentierten
Format und enthält keinen KItinerary-Code.

Die Berechnung der Sendungsnummer in `lib/deutsche_post.dart` folgt
`DeutschePostParser.kt` aus [BinaryEye](https://github.com/markusfisch/BinaryEye)
(Markus Fisch, MIT-Lizenz, `assets/licenses/BinaryEye-MIT.txt`). Eine
Übersicht aller Fremdbestandteile steht in [NOTICE](NOTICE).
