# Changelog

**English** · [Deutsch](CHANGELOG_de.md)

All notable changes to QR Viewer. Versions follow
[Semantic Versioning](https://semver.org/), the build number follows the `+`.

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
