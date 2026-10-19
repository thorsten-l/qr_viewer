# Changelog

**English** · [Deutsch](CHANGELOG_de.md)

All notable changes to QR Viewer. Versions follow
[Semantic Versioning](https://semver.org/), the build number follows the `+`.

## [2.3.0+15] – 2026-10-19

### Added

- **Menu on the scanner page:** The info button has been replaced by a menu
  button (☰) at the far right of the top bar. The menu contains "History",
  "Settings" and "Info"; the history button has moved into the menu as
  well.
- **Settings** with the switch "Enable actions". It shows the action buttons
  on the result page (Open, Call, Email, SMS, Maps, Look up, Track, Add
  contact or event, one-time password). **Default: off** – the app then only
  displays content; Copy, Share and "Show code" are always available.
- **Scan from photo** (setting, **default: off**): a photo button appears
  to the left of the flashlight. With it you pick a picture from your photos;
  the app reads the first code in it (all formats, regardless of the scan
  type) and shows the result just like a camera scan. While it is analyzed,
  a dialog shows the chosen photo with a progress bar. If the app finds no
  code in the original, it checks scaled-down versions (1600, 1024, 2000,
  800 px long side). Vision and ML Kit often read difficult codes, e.g.
  engraved or with a logo, only at certain sizes. If it finds no code, it
  says "No code was found in the photo." Picking uses the system photo picker
  (PHPicker or Android Photo Picker): the app only gets the chosen picture
  and needs no read access to the library, so no permission prompt appears.
  The `NSPhotoLibraryUsageDescription` text required by Apple is in
  Info.plist.
- New dependency `image_picker` (BSD-3-Clause) for picking photos.

### Changed

- Privacy policy: sections on "Scan from photo" and on actions being off by
  default; applies from 2.3.0.
- The app deletes the temporary copy of the chosen photo right after the
  analysis.
- DPIA reassessed for 2.3.0: new data flows, permissions and protective
  measures; risk stays low.
- Manuals (DE/EN) for 2.3.0: menu, new chapter "Settings", reading a code
  from a photo, actions off by default; new pictures of the menu, the
  settings and the photo scan.

## [2.2.0+14] – 2026-10-14

### Security

- **Encrypted history:** The history is stored with AES-256-CBC and
  HMAC-SHA256 (encrypt-then-MAC, new random IV on every save). The 32-byte
  key is created randomly per installation. It is kept only in the iOS
  Keychain (`AfterFirstUnlockThisDeviceOnly`, not synced to iCloud) or the
  Android Keystore and is never part of a backup. Without the key, a copy of
  the history is useless.
- The plain-text history of earlier versions is taken over and encrypted on
  the first start, then the plain-text copy is deleted. If the key is missing,
  e.g. after restoring onto another device, the history starts empty.
- Android: app data is no longer included in Google backups
  (`allowBackup="false"`).

### Added

- **Show code:** a small QR code button on the far left of the action row
  shows the scanned code as an image in a dialog, in its original format
  where possible, otherwise as a QR code.
- Data protection impact assessment with a security audit (`DPIA.md`,
  `DPIA_de.md`).

### Changed

- Privacy policy: encrypted history; VDV tickets show the name in plain text
  or masked, depending on the ticket.
- New dependencies: `flutter_secure_storage`, `pointycastle`,
  `barcode_widget`.

## [2.1.2+13] – 2026-10-13

### Added

- **Matter codes** (smart home, starting with `MT:`) are recognized and shown
  as a “Matter device” card: manual pairing code (11 or 21 digits with
  Verhoeff check digit, to type into Apple Home, Google Home etc.), setup code
  (PIN), vendor and product ID, discriminator, discovery methods (Bluetooth
  LE, Wi-Fi access point, existing network, Wi-Fi PAF) and setup flow. Invalid
  codes stay text. The info button points out that anyone with the code can
  pair the device while it is in setup mode.
- **Info dialog:** “Manuals” button to the left of “Close”; it opens
  github.com/thorsten-l/qr_viewer/tree/main/docs in the browser.
- **Bookmarks (MEBKM)** get their own “Bookmark” card with title and link
  instead of “URL”. The `¥` escape character from the Docomo specification is
  understood, title or link may be missing; without a link there is no open
  button.
- **User guide** for everyday users as ODT and PDF in German and English
  (`docs/`), with one page and a scannable example code per kind of code, a
  privacy chapter and the generator in `tool/manual/`.
- 17 new texts in all 13 languages.

### Changed

- **Info dialog:** Support, Licenses, Manuals and Close are four buttons of
  equal width in two rows; Close has an icon. Long labels shrink slightly
  instead of wrapping.
- Privacy policy: setup codes of Matter devices are only processed on the
  device and stay in the history like any other content; the “Manuals”
  button opens a page on GitHub.

## [2.1.1+12] – 2026-10-12

### Added

- **Info button** at the top right of every data card (including VDV
  tickets). The dialog explains in plain words what kind of data the code
  contains, that it was read only on the device, and what happens when you
  tap the action: a website such as DuckDuckGo, Open Library or Deutsche Post
  then sees the request and your internet address, and its information comes
  from outside the app; other actions hand the data to another app.
- 20 new texts in all 13 languages.

## [2.1.0+11] – 2026-10-11

Ideas adopted from [BinaryEye](https://github.com/markusfisch/BinaryEye).

### Added

- **Actions per content type**, each only after a confirmation showing the
  target: write email, call (only opens the dialer), write SMS, show on map
  (Apple Maps or `geo:`), pass 2FA secrets to the authenticator app, look up
  a product or book online (DuckDuckGo or Open Library), track shipment.
- **Add contact and event** via the share sheet as `.vcf` or `.ics`. MECARD
  and BIZCARD are converted to vCard 3.0, a single VEVENT is wrapped in a
  VCALENDAR.
- **Share** the content from the result page.
- **History:** swipe to delete individual entries (with "Undo"), search by
  content, format and type, and export as CSV or JSON via the share sheet.
- **Product numbers** (EAN-13, EAN-8, UPC-A, UPC-E, ITF-14): check digit,
  country of number allocation (GS1 prefix), internal numbers and coupons.
  ISBN with ISBN-10, ISSN for periodicals.
- **Deutsche Post matrix code** (stamp, Internetmarke): tracking number with
  check digit and a link to shipment tracking.
- **JSON** is shown indented in Source Code Pro.
- **Links without a scheme** such as `example.com/path`, the `URL:` prefix
  and other app links (`market://`, `itms-apps://`, `fido:/`, …) are
  recognized as links. Local and script schemes (`file:`, `javascript:`,
  `intent:`, …) remain excluded.
- **Hex dump with text column** like `xxd`. The text column is always to the
  right of the hex values: 16 or 8 bytes per line, using a smaller font if
  necessary; if it is still too narrow, the dump scrolls horizontally.
- Short vibration when a code is detected.
- The torch shows whether it is on.
- 33 new texts in all 13 languages.

### Changed

- **2FA secrets (`otpauth://`) are no longer stored in the history**; the
  result page points this out.
- Known tracking parameters (`utm_*`, `fbclid`, `gclid`, …) are removed when
  opening web links; the confirmation shows the cleaned link.
- Privacy policy: added actions, sharing, export and the 2FA exclusion.
- NOTICE file and license entry for BinaryEye (MIT).

## [2.0.1+10] – 2026-10-10

### Added

- **One-time password (2FA):** `otpauth://totp/…` and `otpauth://hotp/…`
  (Key Uri Format) are shown as a card with issuer, account, secret,
  type, algorithm, digits and period or counter. Missing values show the
  defaults (SHA1, 6 digits, 30 seconds).
- **About dialog:** "Support" (with link icon, opens
  github.com/thorsten-l/qr_viewer/issues) and "Licenses" buttons side by side
  below the details; only "Close" remains at the bottom.
- 10 new texts in all 13 languages.

### Changed

- Privacy policy: section on content detection (Wi-Fi passwords and 2FA
  secrets also stay on the device), support link, stored zoom level.

## [2.0.0+9] – 2026-10-10

### Added

- **QR content is detected and formatted.** Own parser for the common
  formats (see ZXing "Barcode Contents"):
  - Contact: vCard 2.1/3.0/4.0 (incl. quoted-printable), MECARD, BIZCARD
  - Event: iCalendar VEVENT (time zones, UTC, all-day)
  - Wi-Fi: `WIFI:` (WPA/WEP/open, hidden network, EAP)
  - Email: `mailto:`, MATMSG, `SMTP:`, plain address
  - Phone `tel:`, SMS `sms:`/`SMSTO:`/`mms:`, location `geo:`
  - Link: `http(s)://`, `www.`, MEBKM (bookmark with title)
  - Bank transfer: EPC QR/GiroCode (recipient, IBAN, BIC, amount,
    remittance information)
  - everything else stays plain text
- The detected fields are shown in a card with readable labels; each field
  can be copied individually. Dates and amounts are formatted for the
  language. The raw content is still shown below.
- The result page title and the history icon follow the detected format,
  also on iOS (Apple Vision does not provide a content type).
- 49 new texts in all 13 languages.

### Changed

- The history now keeps the last 25 instead of 10 scans.

## [1.4.0+8] – 2026-10-10

### Added

- **Rear camera zoom levels** as in the camera app, as round toggles above
  the camera image. The app determines the device's levels:
  - iOS: factors from the switch-over points of the multi-camera and the
    sensor crops of the 48 MP main sensor, e.g. "Auto · 0.5× · 1× · 2× · 5×"
    on the iPhone 16 Pro Max. "Auto" leaves the choice to the system
    (including macro switching).
  - Android: factors from the 35 mm equivalent focal lengths; for logical
    multi-cameras (e.g. Pixel) ultra-wide and telephoto via the zoom ratio,
    plus a digital 2×, e.g. "0.6× · 1× · 2×" on the Pixel 9a.
  - The selection is remembered; devices with only one level show no
    switcher.
- 7 new texts in all 13 languages.

## [1.3.0+7] – 2026-10-09

### Added

- **VDV eTickets readable** (e.g. Deutschlandticket, semester ticket): the
  ticket data is recovered from the signature (ISO 9796-2) and shown as a
  table: ticket number, product, valid from/to, issue time, holder (masked,
  as stored in the ticket), date of birth, organization numbers, class and,
  if present, price.
- **Signature check** of the ticket and issuer certificate, shown as
  "Signature valid" or "Signature invalid".
- 31 public VDV CA keys (CC0) in `assets/vdv_certs/`, with the update script
  `tool/vdv/fetch_vdv_certs.sh`. For an unknown issuer, the app names the CA
  reference and shows only the raw data.
- 21 new texts in all 13 languages.

### Changed

- The raw data of a ticket is in a collapsible "Raw data (hex)" section
  below the ticket data.
- Privacy policy: section on electronic tickets. The data is decoded only
  locally on the device.
- New dependency `crypto` (SHA-1 for the signature check).

## [1.2.0+6] – 2026-10-09

### Added

- **Binary codes** are shown as a hex dump with offset; copying yields hex
  text. VDV eTickets are recognized as "VDV eTicket (signed)".
- On iOS, the bytes are reconstructed from Apple Vision's Windows-1252 text.
- The history remembers whether an entry is binary.

## [1.1.0+5] – 2026-10-09

### Added

- **Scan modes** via a menu in the title: QR code, barcode, Data Matrix,
  PDF417, Aztec or all codes. The selection is remembered.
- **13 languages**: English, German, Spanish, French, Portuguese, Russian,
  Chinese (Simplified), Hindi, Arabic, Japanese, Italian, Polish and
  Ukrainian.
- Privacy policy, Apache 2.0 license and license headers in all source
  files.

## [1.0.1+4/5] – 2026-10-09

### Added

- **History** of the last 10 scans to reopen and copy (build 5).

### Changed

- Content in Source Code Pro, 20 pt (build 4).

## [1.0.0+1–3] – 2026-10-08

### Added

- First version: scan QR codes and only display them, open links only after
  a confirmation, copy, torch, light and dark mode.
- About dialog with developer, version and build date.
- App icon (QR code with eye), also used as the launch screen from build 3.
