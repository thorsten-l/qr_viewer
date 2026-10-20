# Changelog

**English** · [Deutsch](CHANGELOG_de.md)

All notable changes to QR Viewer. Versions follow
[Semantic Versioning](https://semver.org/), the build number follows the `+`.

## [2.3.1+16] – 2026-10-20

### Added

- **Medication plan** (German federal plan, BMP): card with patient, author
  and all medicines with dosage, note and reason; PZN via copy icon. **Never
  stored in the history.**
- **Amazon Transparency code** (`AZ:…`): card with serial number.
- Manual: appendix pages for both codes.

### Security

- VDV keys now come directly from the VDV PKI directory, every signature is
  verified; the wrong key `4445564456110416` has been replaced.
- At startup the app removes history entries that must not be stored (e.g.
  older medication plans).

### Changed

- Scan from photo: the loading dialog appears right after picking.
- Privacy policy, DPIA and manuals updated.

## [2.3.0+15] – 2026-10-19

### Added

- **Menu** (☰) with History, Settings and Info.
- **Settings:** "Enable actions" and "Scan from photo", both off by default.
- **Scan from photo** via the system photo picker, no photo permission;
  difficult codes are searched at several image sizes.
- Dependency `image_picker`.

### Changed

- Actions (open, call …) are off by default.
- The copy of the chosen photo is deleted after analysis.
- Privacy policy, DPIA and manuals updated.

## [2.2.0+14] – 2026-10-14

### Security

- **Encrypted history** (AES-256-CBC + HMAC-SHA256); key only in the Keychain
  or Android Keystore, never in backups. The old history is migrated.
- Android: no more Google backup (`allowBackup="false"`).

### Added

- **Show code** as an image, in its original format or as a QR code.
- Data protection impact assessment (`DPIA.md`, `DPIA_de.md`).

### Changed

- Privacy policy updated.
- Dependencies `flutter_secure_storage`, `pointycastle`, `barcode_widget`.

## [2.1.2+13] – 2026-10-13

### Added

- **Matter codes** (`MT:`) with pairing code, PIN, vendor and discovery
  methods.
- **Bookmarks** (MEBKM) as their own card.
- **Manual** (DE/EN, ODT/PDF) with an example code per code type; "Manuals"
  button in the info dialog.

### Changed

- Info dialog: four buttons of equal width.

## [2.1.1+12] – 2026-10-12

### Added

- **Info button** on every data card explains the data and the action.

## [2.1.0+11] – 2026-10-11

Ideas taken from [BinaryEye](https://github.com/markusfisch/BinaryEye).

### Added

- **Actions** with confirmation: email, call, SMS, map, authenticator, look
  up, track shipment; contact and event as `.vcf`/`.ics`.
- **Share**; history with swipe to delete, search and export (CSV/JSON).
- Product numbers with check digit and country, ISBN/ISSN, Deutsche Post
  matrix code, JSON, links without scheme.
- Hex dump with text column, vibration, torch state.

### Changed

- 2FA keys are no longer stored.
- Tracking parameters are removed from links.

## [2.0.1+10] – 2026-10-10

### Added

- **One-time password** (`otpauth://`) as a card.
- Info dialog with "Support" and "Licenses".

## [2.0.0+9] – 2026-10-10

### Added

- **Content recognized:** contact, event, Wi-Fi, email, phone, SMS, location,
  link, GiroCode – as a card with individually copyable fields.

### Changed

- History: 25 instead of 10 scans.

## [1.4.0+8] – 2026-10-10

### Added

- **Zoom levels** of the rear camera as in the camera app.

## [1.3.0+7] – 2026-10-09

### Added

- **VDV eTickets** (e.g. Deutschlandticket) readable, with signature check.
- Public VDV CA keys and update script; dependency `crypto`.

## [1.2.0+6] – 2026-10-09

### Added

- **Binary codes** as a hex dump.

## [1.1.0+5] – 2026-10-09

### Added

- **Scan types:** QR, barcode, Data Matrix, PDF417, Aztec, all.
- **13 languages**; privacy policy and Apache 2.0 license.

## [1.0.1+4/5] – 2026-10-09

### Added

- **History** of the last 10 scans; content in Source Code Pro.

## [1.0.0+1–3] – 2026-10-08

### Added

- First version: scan and show QR codes, open links after confirmation,
  copy, torch, info dialog, app icon.
