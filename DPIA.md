# Data Protection Impact Assessment – QR Viewer

[Deutsch](DPIA_de.md) · **English**

| | |
|---|---|
| App | QR Viewer 2.3.1 (build 16), iOS/iPadOS and Android |
| Code base | `main`, audit on commit `b25767c` ("release 2.1.2"); measures for F2 and F6 in 2.2.0; settings and "Scan from photo" added in 2.3.0, medication plan and Amazon Transparency code in 2.3.1 |
| Controller / author | Thorsten Ludewig, t.ludewig@gmail.com |
| Date | 20 October 2026 (created 14 October 2026) |
| Basis | Art. 35 GDPR, § 25 TDDDG (German Telecommunications Digital Services Data Protection Act) |
| Status | Assessment complete; F2 and F6 implemented in 2.2.0, 2.3.0 and 2.3.1 reassessed, other measures open (section 8) |

This document combines a technical security audit of the app with a data
protection impact assessment (DPIA). It is not legal advice.

---

## 1. Summary

QR Viewer is a scanner for QR codes and barcodes. It shows the content
first and opens links or other actions only after the user confirms. The app
has no account, no server of its own, no advertising and no analytics. The
app code itself makes **no network connections**. All recognition and
parsing happens on the device.

**Is a DPIA required?** Most likely not. The developer does not receive any
personal data. Nothing is processed on a large scale or used for profiling.
None of the cases in Art. 35(3) GDPR or on the German DSK list applies.
This assessment is voluntary and documents why the risk is low.

**Result:** The risk for data subjects is **low**. Two points need
attention:

1. On Android, Google ML Kit sends technical usage data to Google (finding
   F1). This is disclosed in the privacy policy, but under § 25 TDDDG it is
   questionable whether that is enough without consent.
2. Up to 2.1.2 the scan history was stored unencrypted and was part of
   operating system backups (finding F2). Scanned codes can contain Wi-Fi
   passwords, Matter setup codes, or ticket data with a name and date of
   birth. **Implemented in 2.2.0:** the history is encrypted with
   AES-256-CBC + HMAC-SHA256; the key stays on the device; Android backup is
   off.

**New in 2.3.0:** The actions on the result page (open, call, look up,
etc.) are turned off by default and can be turned on in the settings.
Without them, no content leaves the app unless you copy or share it. With
"Scan from photo" (off by default) the app reads codes from a picture you
choose in the system photo picker. It only gets that picture, needs no read
permission for the library and does not store it. The risk stays low.

**New in 2.3.1:** The app recognizes the German federal medication plan and
shows it as a card. It contains health data (Art. 9 GDPR) and is never stored
in the history; older entries are removed at startup. The app does not look
up medicines online. It also recognizes Amazon anti-counterfeiting codes
("Transparency") without passing on any data.

No high residual risk remains. Prior consultation with a supervisory
authority under Art. 36 GDPR is not necessary.

---

## 2. Scope and method

**Examined:**
- Dart source code in `lib/` (about 4,200 lines plus `lib/vdv/`).
- The merged Android release manifest (`build/app/intermediates/merged_manifests/release`).
- `ios/Runner/Info.plist`.
- Dependencies in `pubspec.yaml` / `pubspec.lock` (`flutter pub outdated`).
- The privacy manifests of the plugins.
- The existing privacy policy `PRIVACY.md`.

**Not examined:**
- Penetration tests on devices.
- Checks against vulnerability databases (OSV/CVE).
- The internals of ML Kit and Apple Vision (closed source).
- Data that Apple and Google collect as store operators.

**Risk scale:** likelihood × severity, each rated low / medium / high, based
on the German Standard Data Protection Model (SDM).

---

## 3. Description of the processing

### 3.1 Purpose

The app reads the content of optical codes and shows it in a way people can
understand. Examples are links, contacts, Wi-Fi access data, GiroCode bank
transfers, 2FA keys, VDV tickets, Deutsche Post codes and Matter setup codes.
It protects users from harmful codes ("quishing") because nothing is opened
automatically.

### 3.2 Data subjects and categories of data

| Data subject | Data | Source |
|---|---|---|
| User | Camera image (live only, not stored) | Camera |
| User | Scan history (last 25 contents with time, format, type) | Scans |
| User | Photo chosen by the user (only with "Scan from photo", not stored) | System photo picker |
| User | Settings: scan mode, zoom level, "Enable actions", "Scan from photo" | App |
| Third parties in codes | Names, phone numbers, email and postal addresses (vCard/MECARD), appointments | Code content |
| Ticket holder | Name (plain or masked), date of birth, ticket number, validity | VDV ticket (Deutschlandticket) |
| User / third parties | Wi-Fi passwords, 2FA secrets, Matter setup PIN, IBAN/name (GiroCode) | Code content |
| User (Android) | Device model, OS version, package name and version, ML Kit performance metrics | ML Kit SDK |

**Special categories under Art. 9 GDPR** are not processed on purpose. A
code can contain such data by chance, for example a text about health. The
app shows it just like any other text. It recognizes one exception on
purpose: the German federal medication plan (BMP, XML with `<MP …>` as a
Data Matrix on the paper plan, KBV specification, annex 3 to § 31a SGB V).
It contains name, date of birth, doctor and medicines. Since 2.3.1 the app
only shows it and never stores it in the history; older history entries
containing a plan are removed at startup.

### 3.3 Storage locations

| Data | Location | Protection | Deletion |
|---|---|---|---|
| History (`scan_history_v2`) | SharedPreferences (Android XML in the app sandbox) / NSUserDefaults (iOS) | OS sandbox, device encryption; **AES-256-CBC + HMAC-SHA256** since 2.2.0 | Single entry, "Clear history", uninstall; max. 25 entries |
| History key (32 bytes, random) | iOS Keychain (`AfterFirstUnlockThisDeviceOnly`, not synced) / Android Keystore | Hardware-backed where available; never in backups | Uninstall |
| 2FA keys, medication plans | **not stored** | – | – |
| Scan mode, zoom, settings | SharedPreferences / NSUserDefaults | Sandbox | Uninstall |
| Camera image | Memory only | – | Immediately |
| Chosen photo | Copy from `image_picker` in the app's temporary folder; scaled-down versions in a separate temporary folder | Sandbox | The app deletes both right after the analysis |
| Export files (CSV/JSON), vCard/iCalendar | Temporary file from `share_plus` in the app cache, then the target app | Sandbox; in the target app, its own rules apply | Cache is cleared by the OS |

### 3.4 Data flows and recipients

| # | Flow | Trigger | Recipient |
|---|---|---|---|
| D1 | Camera image → barcode recognition | Scanning | On the device: Apple Vision (iOS) or ML Kit (Android) |
| D1a | Chosen photo → barcode recognition | User picks a photo ("Scan from photo") | On the device: Apple Vision (iOS) or ML Kit (Android) |
| D2 | ML Kit telemetry | Automatic, Android only | Google (Firelog/CCT via `com.google.android.datatransport`) |
| D3 | Open a link | Only with "Enable actions"; user confirms the dialog | Browser or app that handles the scheme, then the website |
| D4 | Email, call, SMS, map, authenticator | Only with "Enable actions"; user confirms | The matching system app |
| D5 | "Look up online" | Only with "Enable actions"; user confirms | DuckDuckGo (GTIN) / Open Library (ISBN) |
| D6 | "Track shipment" | Only with "Enable actions"; user confirms | Deutsche Post (`deutschepost.de`, tracking number in the URL) |
| D7 | Copy, share, contact, calendar, history export | User taps | Clipboard / app chosen in the system share sheet |
| D8 | Support, manuals | User taps | GitHub |
| D9 | Backup | Operating system | iOS: iCloud/device backup, history only as ciphertext. Android: none since 2.2.0 (`allowBackup="false"`) |

### 3.5 Permissions

| Platform | Permission | Origin | Use |
|---|---|---|---|
| iOS | Camera (`NSCameraUsageDescription`) | App | Scanning |
| iOS | Photo library (`NSPhotoLibraryUsageDescription`) | `image_picker` | Required text for the photo picker; the prompt never appears because PHPicker works without library access (`requestFullMetadata: false`) |
| Android | `CAMERA` | mobile_scanner | Scanning |
| Android | `INTERNET`, `ACCESS_NETWORK_STATE` | ML Kit / datatransport (not used by app code) | Telemetry D2 |
| Android | `DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` | AndroidX | Internal |
| Android | – (none) | `image_picker` | Android Photo Picker, on older devices via Google Play services; no storage or media permission |

The app does **not** request location, contacts, calendar, storage, photos,
microphone or Bluetooth. Contacts and appointments are passed on as `.vcf` or
`.ics` through the share sheet, so no contacts or calendar permission is needed.

---

## 4. Legal assessment

- **Processing by the user:** Scanning, the history and passing data to
  other apps happen on the user's own device for personal purposes. This is
  the household exemption in Art. 2(2)(c) GDPR.
- **Developer:** Receives no personal data. They decide which SDKs are
  built into the app. For ML Kit telemetry (D2) this probably makes them
  jointly responsible with Google (see CJEU C-40/17 "Fashion ID").
- **Legal basis for D2:**
  - Art. 6(1)(f) GDPR (legitimate interest in a working, maintained
    library).
  - Reading device information also falls under **§ 25(1) TDDDG**. This
    needs consent unless it is *strictly necessary* for the service
    (§ 25(2) no. 2).
  - The scanning would also work without the telemetry, so "strictly
    necessary" is doubtful. → Finding F1.
- **D3–D8:** Data goes to third parties only after an explicit action by the
  user. From then on, the recipients are responsible themselves.
- **Information duties (Art. 13 GDPR):** Met through `PRIVACY.md`, which is
  linked in the stores and the README. One detail is inaccurate (F6).

---

## 5. Necessity and proportionality

| Principle | Assessment |
|---|---|
| Purpose limitation | Data is used only to display it and for actions the user starts. |
| Data minimisation | Camera images and chosen photos are not stored. History is limited to 25 entries. 2FA keys and medication plans are not stored. Tracking parameters are removed from links. There are no unnecessary permissions. **But:** Wi-Fi passwords and Matter PINs end up in the history. |
| Storage limitation | Only 25 entries; entries can be deleted one by one or all at once. |
| Transparency | Privacy policy in German/English; info button on every data card; a confirmation dialog shows the full target. |
| Integrity / confidentiality | OS sandbox; no network code in the app; no WebView; parsers check lengths. See F2–F5. |
| Data subject rights | The developer holds no data. The user controls everything locally. |

---

## 6. Security audit – findings

Severity: **High / Medium / Low / Info**.

| ID | Severity | Finding | Recommendation |
|---|---|---|---|
| F1 | Medium | **ML Kit telemetry on Android.** `mobile_scanner` uses `com.google.mlkit:barcode-scanning`. The release manifest therefore contains `INTERNET` as well as `TransportBackendDiscovery` with `CctBackendFactory`. Google receives device and usage data without the user taking any action. This is disclosed in `PRIVACY.md`, but there is no consent (§ 25 TDDDG). | (a) Have the legal question reviewed. (b) Look for an alternative recognition library without telemetry (e.g. ZXing-based) for a "no network" Android build. (c) At least: make sure the Play "Data safety" section reports the data correctly. |
| F2 | Medium → **implemented in 2.2.0** | **History unencrypted and included in backups.** `scan_history_v1` is plain JSON in SharedPreferences/NSUserDefaults. Android Auto Backup is active because `android:allowBackup` is not set (default `true`). iOS includes UserDefaults in iCloud/device backups. The history can contain Wi-Fi passwords, Matter PINs, GiroCode data (IBAN, name) and VDV tickets (name, date of birth). | (a) Exclude history from backups: Android `allowBackup="false"` or `dataExtractionRules`/`fullBackupContent` without `sharedpref`; on iOS, store the history in a file with `isExcludedFromBackup`. (b) Like 2FA keys, do not store Wi-Fi passwords and Matter codes, or store them only masked. (c) Optional: a setting "Keep history" on/off. |
| F3 | Low | **Clipboard without a "sensitive" flag.** "Copy" puts passwords and secrets on the clipboard in plain text. Android 13+ shows them in the preview and in keyboard clipboard histories. iOS can sync them through Universal Clipboard. | On Android, set `ClipDescription.EXTRA_IS_SENSITIVE` for password/secret fields (platform channel). On iOS, use `UIPasteboard` with `localOnly` and `expirationDate`. |
| F4 | Low | **App switcher / screenshots.** Results with secrets are visible in the task preview. Neither `FLAG_SECURE` nor an iOS privacy overlay is used. Since 2.2.0, "Show code" displays the content as a scannable image; anyone nearby can capture it with a camera (e.g. Wi-Fi password, 2FA secret). You start this display deliberately. | Optional: hide the preview while the result page shows a password or secret. |
| F5 | Low | **History export in plain text.** CSV/JSON contain all entries without protection. Storage then depends on the target app (cloud, email). The user starts the export on purpose. | Mention in the export dialog that sensitive content is included (e.g. Wi-Fi passwords). |
| F6 | Info → **fixed in 2.2.0** | **Privacy policy inaccurate about VDV tickets.** `PRIVACY.md` says "masked name". The parser (`decodeTravelerName`) also shows names in plain text (`First#Last`) when the ticket contains them. | Update the wording: "name (plain or masked, depending on the ticket)". |
| F7 | Info | **No app-level privacy manifest on iOS.** `ios/Runner/PrivacyInfo.xcprivacy` is missing. The plugins (`shared_preferences_foundation`, `mobile_scanner`, `url_launcher_ios`, `package_info_plus`, `share_plus`, `flutter_secure_storage`) ship their own, so App Store requirements are met. | Optional: add an app manifest with `NSPrivacyTracking = false` and no collected data types, for completeness. |
| F8 | Info | **Blocklist instead of allowlist for URL schemes.** `linkUri` blocks `file`, `content`, `data`, `javascript`, `vbscript`, `intent`, `about`, `blob` and `chrome`. Other schemes with `//` and `fido`, `magnet`, `bitcoin`, `lightning`, `ethereum` are allowed, after a confirmation that shows the full target. | Acceptable. If needed, switch to an allowlist (http, https, market, itms-apps, …). |
| F9 | Info | **Parsing untrusted input.** The BER parser checks every length and limits the length field to 3 bytes. VDV decoding is wrapped in `try/catch`, and so are the binary and Deutsche Post parsers. RSA (`modPow`) works only on data that fits in a QR code (a few KB), so there is no significant risk of a denial-of-service attack. There is no WebView, no dynamic code and no deep links. The only exported components are the launcher activity and the `ProfileInstallReceiver`, which is protected by the `DUMP` permission. | No action needed. Keep the fuzz/edge-case tests. |
| F10 | Info | **Dependencies.** All direct dependencies are up to date except `cupertino_icons` (1.0.9 → 2.0.0, icons only). Some transitive packages lag by patch versions. New in 2.2.0: `flutter_secure_storage` (Keychain/Keystore), `pointycastle` and `barcode_widget` (pure Dart, no network, no permissions). New in 2.3.0: `image_picker` (BSD-3-Clause, Flutter team) for "Scan from photo" via the system photo picker, without read access to the library. No check against vulnerability databases was done. | Run `flutter pub upgrade` regularly. Add `osv-scanner` to the release checklist. |

### Existing protective measures (positive)

- Nothing is opened automatically. Actions are turned off by default (since
  2.3.0); when turned on, every action shows the target and asks for
  confirmation.
- "Scan from photo" is off by default and uses the system photo picker: the
  app only gets the chosen picture, never the library, and deletes its copy
  after the analysis.
- Known tracking parameters (`utm_*`, `fbclid`, `gclid`, …) are removed
  before a link is opened.
- 2FA keys (`otpauth://`) and medication plans are never stored in the history.
- The history is limited to 25 entries and can be deleted.
- No account, no own backend, no analytics, no advertising, no crash
  reporting in the app code.
- On iOS, recognition runs entirely on the device (Apple Vision), with no third party.
- Minimal permissions. Contacts and calendar are passed on via the share
  sheet without access permissions.
- VDV signatures are checked offline with bundled public keys.
- Info buttons explain in plain language what data a code contains and
  where it goes when an action is used.

---

## 7. Risks to data subjects

Likelihood (L) and severity (S): low / medium / high.

| Risk | Cause | L | S | Before measures | After measures (section 8) |
|---|---|---|---|---|---|
| R1 Google learns about app use | ML Kit telemetry (F1) | high (Android) | low (no content, no images) | **medium** | low (with an alternative library) / unchanged (disclosure only) |
| R2 Someone reads secrets from the history | Unlocked or lost device, backup account compromised (F2) | low | medium | **low–medium** | low (encrypted since 2.2.0; on an unlocked device the app still shows the history) |
| R3 Secrets leak via the clipboard | Clipboard history, keyboard apps, Universal Clipboard (F3) | low | medium | low | low |
| R4 Phishing / malware via codes | Harmful link in a QR code | medium | high | **low** (confirmation, full target shown, scheme blocklist) | low (actions off by default since 2.3.0) |
| R5 Lookup services learn product or tracking numbers | User taps "Look up online" / "Track shipment" | medium | low | low | low |
| R6 Shoulder surfing / screenshots | Task preview (F4) | low | low | low | low |
| R7 Export ends up in an insecure place | Plain-text export (F5) | low | medium | low | low |

---

## 8. Measures plan

| Priority | Measure | Finding | Status |
|---|---|---|---|
| 1 | Encrypt the history (AES-256-CBC + HMAC, key in Keychain/Keystore) and disable Android backup | F2 | **done (2.2.0)** |
| 2 | Do not store Wi-Fi passwords and Matter setup codes in the history (like 2FA), or mask them | F2 | open |
| 3 | Check and, if needed, align the Play Console "Data safety" with ML Kit telemetry; legal review of § 25 TDDDG | F1 | open |
| 4 | Evaluate an Android recognition library without telemetry | F1 | open |
| 5 | Correct `PRIVACY.md` on VDV names | F6 | **done (2.2.0)** |
| 6 | Mark sensitive clipboard content | F3 | open |
| 7 | Note about sensitive content in the history export | F5 | open |
| 8 | Optional: hide the task preview, add an iOS app privacy manifest, use an allowlist for schemes | F4, F7, F8 | open |
| 9 | `osv-scanner` / `flutter pub outdated` in the release checklist | F10 | open |

---

## 9. Result and review

- **Overall risk:** low. With measures 1–3, it is low without reservation.
- **Prior consultation (Art. 36 GDPR):** not required.
- **Next review:** with every release that adds new data types, permissions
  or SDKs, at the latest in October 2027.

| Role | Name | Date |
|---|---|---|
| Controller | Thorsten Ludewig | |
