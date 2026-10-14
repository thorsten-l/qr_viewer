# QR Viewer

**English** · [Deutsch](README_de.md)

QR code and barcode scanner for iPhone, iPad and Android that only shows
content first. Links and other actions start only after a confirmation.

## Features

- **Scan modes** from the menu in the title: QR code, barcode (EAN-13, EAN-8,
  UPC-A, UPC-E, Code 128, Code 39, Code 93, Codabar, ITF-14), Data Matrix,
  PDF417, Aztec or all codes at once. The chosen mode is remembered.
- **View only:** The content appears in Source Code Pro, together with the
  format, content type and, for links, the host. Nothing opens automatically.
- **Links** open only after a confirmation that shows the URL; known tracking
  parameters (`utm_*`, `fbclid`, …) are removed. Addresses without a scheme
  (`example.com/path`) and app links (`market://`, `fido:/`, …) are
  recognized as well.
- **Content detection:** contact (vCard, MECARD, BIZCARD), event (iCalendar),
  Wi-Fi, email, phone, SMS, location (`geo:`), link, bookmark (MEBKM), bank
  transfer (GiroCode),
  one-time password (`otpauth://`), JSON, product number (EAN/UPC/ITF-14 with
  check digit and GS1 country, ISBN, ISSN), Deutsche Post matrix code
  (tracking number) and Matter device (`MT:`, with manual pairing code) are
  shown as a card with labeled fields that can be
  copied individually; the raw content is shown below. An info button explains
  the data in plain words. Everything else is
  text.
- **Actions** per content type, always with a confirmation: write email,
  call, SMS, map, authenticator, look up online, track shipment. Contacts and
  events go to Contacts or Calendar as `.vcf`/`.ics` via the share sheet.
- **Copy and share** with a single tap.
- **Show code:** the QR code button at the bottom left shows the scanned code
  as an image, in its original format where possible (e.g. EAN-13, Data
  Matrix, Aztec), otherwise as a QR code – e.g. to pass it on to another
  device.
- **History** of the last 25 scans: reopen, copy, search, swipe away
  individually (with undo), clear all, export as CSV or JSON. 2FA secrets are
  not stored. The history is encrypted with AES-256; the key stays in the
  device Keychain or Android Keystore.
- **Binary codes** are shown as a hex dump with a text column. **VDV
  eTickets** (e.g. Deutschlandticket) are decoded as well: ticket number,
  product, validity, issue time, (masked) holder, date of birth, organization
  numbers, class, price and signature check. The raw data stays available as
  collapsible hex. Everything happens locally on the device.
- **About dialog** with developer, version and build date, plus buttons for
  support (GitHub issues), licenses and the [user guides](docs/).
- **Zoom levels** of the rear camera as in the camera app, derived from the
  device's lenses, e.g. Auto · 0.5× · 1× · 2× · 5× (iPhone 16 Pro Max) or
  0.6× · 1× · 2× (Pixel 9a). The selection is remembered.
- **Torch** with state indicator, vibration on detection, light and dark
  mode.
- **13 languages**, see [Languages](#languages).

What changed in which version is listed in the [changelog](CHANGELOG.md).

## User guide

A user guide for everyday users explains scanning, the result page, actions,
the history and privacy in plain words. Its appendix shows every supported
kind of code on its own page, with a scannable example code and the matching
result page of the app:

- English: [QR-Viewer-Manual.pdf](docs/QR-Viewer-Manual.pdf)
  ([ODT](docs/QR-Viewer-Manual.odt))
- German: [QR-Viewer-Anleitung.pdf](docs/QR-Viewer-Anleitung.pdf)
  ([ODT](docs/QR-Viewer-Anleitung.odt))

The guides are generated with the scripts in `tool/manual/`:

```sh
MANUAL_LANG=en flutter test tool/manual/render_screens_test.dart  # app screens
/tmp/qrv-venv/bin/python tool/manual/make_manual.py en              # ODT + PDF
```

The Python environment needs `odfpy`, `zxing-cpp`, `pillow`, `numpy`,
`pypdfium2`, `ppf-datamatrix` and `aztec_code_generator`; LibreOffice is used
for the page numbers and the PDF. Use `de` instead of `en` for the German
guide.

## Privacy

The app does not collect any personal data. Details are in the
[privacy policy](PRIVACY.md). Questions and bug reports are welcome via the
[issues](https://github.com/thorsten-l/qr_viewer/issues).

## Development

```sh
flutter pub get
flutter analyze
flutter test
flutter run --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)
```

Without `BUILD_DATE`, the about dialog shows the installation time instead of
the build date.

### Project structure

| Path | Content |
|---|---|
| `lib/main.dart` | App, scanner page and mode menu |
| `lib/scan_mode.dart` | Scan modes and their code formats |
| `lib/camera_lens.dart` | Rear camera zoom levels and switcher (native query in `AppDelegate.swift` and `MainActivity.kt`) |
| `lib/result_page.dart` | Result view with code image, copy, share, actions and confirmation |
| `lib/code_image.dart` | "Show code" dialog: draws the content in its original format or as a QR code (`barcode_widget`) |
| `lib/qr_content.dart` | Parser for QR content formats (vCard, WIFI, EPC, otpauth, JSON, links, …) |
| `lib/content_actions.dart` | Actions per content type (mailto, tel, sms, map, …), vCard/iCalendar export |
| `lib/gtin.dart` | Product numbers: check digit, UPC-E, GS1 prefix, ISBN, ISSN |
| `lib/deutsche_post.dart` | Deutsche Post matrix code (tracking number) |
| `lib/matter.dart` | Matter onboarding code (`MT:`, Base38) and manual pairing code |
| `lib/history.dart` | History of the last 25 scans with search and CSV/JSON export, stored encrypted |
| `lib/history_crypto.dart` | AES-256-CBC + HMAC-SHA256 for the history; key per installation in the Keychain / Android Keystore |
| `lib/binary_payload.dart` | Detection of binary content, hex display |
| `lib/vdv/` | VDV eTicket: BER, ISO 9796-2, certificates, ticket data |
| `assets/vdv_certs/` | Public VDV CA keys (CC0), see `tool/vdv/README.md` |
| `lib/app_info.dart` | About dialog with support, license and manuals buttons |
| `lib/localization.dart`, `lib/l10n/` | Translations (generated) |
| `test/` | Widget and unit tests, including all languages |
| `tool/vdv/` | Update script and origin of the VDV keys |
| `tool/manual/` | Generator for the user guides (example codes, app screens, ODT/PDF) |
| `tool/` | Scripts for icon, translations, store graphics, license headers, release key |
| `screenshots/` | Source images and final graphics for the App Store and Google Play |
| `docs/` | User guides: `QR-Viewer-Manual.odt`/`.pdf` (English), `QR-Viewer-Anleitung.odt`/`.pdf` (German) |

## Version

Current: **2.2.0** (build 14). Version and build number are set in
`pubspec.yaml`, e.g. `version: 2.2.0+14`. Every upload to TestFlight or
Google Play needs a higher build number after the `+`. Every new version gets
an entry in [CHANGELOG.md](CHANGELOG.md) (English) and
[CHANGELOG_de.md](CHANGELOG_de.md) (German).

## Release

Steps for a new version:

1. Bump the version in `pubspec.yaml` (always build number +1).
2. Update [CHANGELOG.md](CHANGELOG.md) and
   [CHANGELOG_de.md](CHANGELOG_de.md), README.md, README_de.md and, if
   needed, [PRIVACY.md](PRIVACY.md) (date "Last updated").
3. Check: `flutter analyze`, `flutter test`,
   `python3 tool/license/add_headers.py --check`.
4. Build and upload for iOS and Android as described below.
5. Commit and tag, e.g. `git tag v2.2.0`.

### iOS / TestFlight

Signing is automatic with team `49MFGU6N6W`. Build and upload directly to
App Store Connect:

```sh
flutter build ipa --release \
  --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M) \
  --export-options-plist=ios/export/ExportOptions-TestFlight.plist
```

Flutter reports an error afterwards because it looks for a local `.ipa`,
which is not created by a direct upload. Whether the upload succeeded is
shown in the Xcode log (`UPLOAD SUCCEEDED`) or in App Store Connect.

### Android

Release builds are signed with the upload key from `android/key.properties`
(not in the repository). Create it once:

```sh
tool/create_release_key.sh
```

The script asks for a password and creates `~/keystores/qr_viewer-upload.jks`
and `android/key.properties`. Keep both safe. Without `key.properties`, the
debug key is used.

```sh
BD=$(date +%Y-%m-%dT%H:%M)
flutter build appbundle --release --dart-define=BUILD_DATE=$BD            # Google Play
flutter build apk --release --split-per-abi --dart-define=BUILD_DATE=$BD  # directly installable
```

## Languages

English, German, Spanish, French, Portuguese, Russian, Chinese (Simplified),
Hindi, Arabic, Japanese, Italian, Polish and Ukrainian. The app follows the
device language; other languages fall back to English. Arabic is displayed
right to left.

All texts, including the iOS camera permission prompt, are in
`tool/l10n/strings.py`. After a change:

```sh
python3 tool/l10n/strings.py   # creates lib/l10n/*.arb and ios/Runner/*.lproj/InfoPlist.strings
flutter gen-l10n               # creates lib/l10n/app_localizations*.dart
```

A new language must also be added to `ios/Runner/Info.plist`
(`CFBundleLocalizations`), the Xcode project and
`android/app/src/main/res/xml/locales_config.xml`.

## Graphics

The scripts need Pillow and qrcode, preferably in a separate environment:

```sh
python3 -m venv /tmp/qrv-venv && /tmp/qrv-venv/bin/pip install pillow qrcode
```

| Script | Creates |
|---|---|
| `tool/app_icon/make_icon.py`, `install_icons.py` | App icon and launch screen for iOS and Android (see `tool/app_icon/README.md`) |
| `tool/screenshots/make_store_shots.py` | Screenshots for the App Store (iPhone, iPad 13") and Google Play (phone 9:16) |
| `tool/screenshots/make_store_banners.py` | App Store header and search results, Play Store feature graphic and 512 px icon |

Source images are in `screenshots/source/<language>/` (iPhone directly,
`ipad/`, `android/`), results in `screenshots/app_store/` and
`screenshots/play_store/`.

## Platform notes

- **iOS:** Code detection uses Apple's Vision framework. The camera
  permission prompt is translated in `ios/Runner/*.lproj/InfoPlist.strings`.
  `ITSAppUsesNonExemptEncryption` is set to `false`. The zoom levels are
  queried from AVFoundation by `ios/Runner/AppDelegate.swift` via the channel
  `de.l9g.qr_viewer/camera`.
- **Android:** Code detection uses Google ML Kit (bundled with the app).
  ML Kit adds the permissions `INTERNET` and `ACCESS_NETWORK_STATE` and may
  send diagnostic data to Google; this is described in the privacy policy.
  The `<queries>` for `http`/`https` in `AndroidManifest.xml` are required by
  `url_launcher`. From Android 13, the language can be chosen per app.
  `MainActivity.kt` determines the zoom levels via Camera2
  (`CameraCharacteristics`). A self-signed APK cannot be installed over a
  Play Store installation (different signature); uninstall the app first.

## License

Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)

Licensed under the [Apache License 2.0](LICENSE). Every source file carries
the license header; add or check missing headers with:

```sh
python3 tool/license/add_headers.py          # add missing headers
python3 tool/license/add_headers.py --check  # check only
```

The Source Code Pro font is licensed under the SIL Open Font License 1.1
(`assets/fonts/SourceCodePro-OFL.txt`).

The public VDV keys in `assets/vdv_certs/` are licensed under CC0-1.0
(source: KDE KItinerary, originally VDV PKI), see `tool/vdv/README.md`.
The decoder in `lib/vdv/` is an independent implementation based on the
documented format and contains no KItinerary code.

The tracking number calculation in `lib/deutsche_post.dart` follows
`DeutschePostParser.kt` from [BinaryEye](https://github.com/markusfisch/BinaryEye)
(Markus Fisch, MIT license, `assets/licenses/BinaryEye-MIT.txt`). An
overview of all third-party components is in [NOTICE](NOTICE).
