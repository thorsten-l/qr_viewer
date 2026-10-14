# Datenschutzerklärung / Privacy Policy – QR Viewer

[Deutsch](#deutsch) · [English](#english)

Stand / Last updated: 14. Oktober 2026 / October 14, 2026\
Gilt ab / Applies from: QR Viewer 2.2.0

---

## Deutsch

### Verantwortlicher

Thorsten Ludewig\
E-Mail: t.ludewig@gmail.com

### Kurzfassung

QR Viewer erhebt, speichert und überträgt keine personenbezogenen Daten an
den Entwickler. Die App hat kein Benutzerkonto, keine Werbung, keine
Analyse- oder Tracking-Funktionen und keine eigenen Server.

### Kamera

Die App benötigt Zugriff auf die Kamera, um Codes zu scannen. Das Kamerabild
wird ausschließlich auf deinem Gerät ausgewertet. Es werden keine Fotos oder
Videos gespeichert oder übertragen. Den Kamerazugriff kannst du jederzeit in
den Einstellungen deines Geräts widerrufen.

### Verlauf und Einstellungen

Die Inhalte der letzten 25 gescannten Codes sowie die zuletzt gewählte
Scan-Art und Zoomstufe werden lokal auf deinem Gerät gespeichert, damit du
sie später erneut aufrufen kannst. Diese Daten verlassen das Gerät nicht durch die App.
Der Verlauf wird verschlüsselt gespeichert (AES-256). Der Schlüssel wird für
jede Installation zufällig erzeugt und liegt nur im Schlüsselbund (iOS) bzw.
im Android Keystore deines Geräts; er wird weder mit iCloud synchronisiert
noch in Sicherungen übernommen.
Du kannst einzelne Einträge oder den ganzen Verlauf jederzeit in der App
löschen. Einmalpasswort-Schlüssel (2FA, `otpauth://`) werden grundsätzlich
nicht im Verlauf gespeichert. Beim Löschen der App
werden alle Daten entfernt. Unter Android nimmt die App nicht an der
Google-Sicherung teil. Eine iCloud- oder Gerätesicherung unter iOS kann den
verschlüsselten Verlauf enthalten; ohne den Schlüssel, der auf dem Gerät
bleibt, ist er nicht lesbar.

### Erkennung von Inhalten

Die App erkennt übliche Inhaltsformate wie Kontakte, Termine, WLAN-Zugänge,
Überweisungsdaten (GiroCode) oder Einmalpasswort-Schlüssel (2FA) und zeigt sie
aufbereitet an, ebenso Artikelnummern (EAN, ISBN), den Matrixcode der
Deutschen Post und Einrichtungscodes von Smart-Home-Geräten (Matter). Das
geschieht ausschließlich auf deinem Gerät. Beachte, dass solche Codes
vertrauliche Angaben enthalten können, etwa WLAN-Passwörter oder den
Einrichtungscode eines Matter-Geräts; sie stehen wie jeder Inhalt im Verlauf,
bis du ihn löschst. 2FA-Schlüssel
werden nicht gespeichert.

### Elektronische Tickets

Enthält ein Code ein elektronisches Ticket nach VDV-Standard (z. B.
Deutschlandticket), liest die App die darin enthaltenen Angaben wie Gültigkeit,
Namen (je nach Ticket im Klartext oder maskiert) und Geburtsdatum ausschließlich auf deinem Gerät aus. Dafür
nutzt sie mitgelieferte öffentliche Schlüssel; es werden keine Daten
übertragen.

### Öffnen von Links und Aktionen

Enthält ein Code einen Link, öffnet die App ihn nur nach deiner
ausdrücklichen Bestätigung in deinem Browser bzw. der zuständigen App.
Bekannte Tracking-Parameter (z. B. `utm_source`, `fbclid`) entfernt sie dabei.
Dasselbe gilt für die Aktionen der Ergebnisseite: E-Mail schreiben, Anrufen,
SMS, Karte und Authenticator übergeben den Inhalt erst nach Bestätigung an die
jeweilige App. „Online nachschlagen“ übermittelt die Artikelnummer an
DuckDuckGo bzw. die ISBN an Open Library, „Sendung verfolgen“ die
Sendungsnummer an die Deutsche Post. Für die aufgerufene Website oder App gilt
die Datenschutzerklärung ihres jeweiligen Anbieters. Der Knopf „Support“ im
Info-Dialog öffnet die Seite https://github.com/thorsten-l/qr_viewer/issues,
der Knopf „Anleitungen“ die Seite
https://github.com/thorsten-l/qr_viewer/tree/main/docs in deinem Browser;
dort gilt die Datenschutzerklärung von GitHub.

### Zwischenablage, Teilen und Export

Inhalte werden nur dann in die Zwischenablage kopiert, wenn du auf
„Kopieren“ tippst. Über „Teilen“, „Zu Kontakten“, „Zum Kalender“ und den
Export des Verlaufs (CSV oder JSON) gibst du Inhalte über das Teilen-Menü des
Betriebssystems an eine App deiner Wahl weiter; vorher wird nichts
übertragen. „Code anzeigen“ zeichnet den Inhalt nur auf dem Bildschirm
deines Geräts als Grafik; dabei wird nichts gespeichert oder übertragen.

### Besonderheit unter Android: Google ML Kit

Unter Android verwendet die App zur Erkennung der Codes die Bibliothek
„ML Kit Barcode Scanning“ von Google. Die Erkennung selbst erfolgt auf dem
Gerät; Kamerabilder werden nicht an Google gesendet. ML Kit kann jedoch
technische Nutzungs- und Diagnosedaten an Google übermitteln, etwa
Gerätemodell, Betriebssystemversion, App-Paketname und -Version sowie
Leistungskennzahlen. Google verwendet diese Daten nach eigenen Angaben, um
ML Kit zu betreiben und zu verbessern. Weitere Informationen:
https://developers.google.com/ml-kit/terms und
https://policies.google.com/privacy

Unter iOS und iPadOS erfolgt die Erkennung mit Apples Vision-Framework auf dem
Gerät, ohne Beteiligung von Drittanbietern.

### Deine Rechte

Da der Entwickler keine personenbezogenen Daten von dir verarbeitet, liegen
ihm keine Daten vor, über die er Auskunft geben, die er berichtigen oder
löschen könnte. Bei Fragen zum Datenschutz kannst du dich jederzeit an die
oben genannte E-Mail-Adresse wenden. Du hast außerdem das Recht, dich bei
einer Datenschutz-Aufsichtsbehörde zu beschweren.

### Änderungen

Diese Datenschutzerklärung kann angepasst werden, wenn sich die App ändert.
Die jeweils aktuelle Fassung findest du unter
https://github.com/thorsten-l/qr_viewer/blob/main/PRIVACY.md

---

## English

### Controller

Thorsten Ludewig\
Email: t.ludewig@gmail.com

### Summary

QR Viewer does not collect, store or transmit any personal data to the
developer. The app has no user account, no advertising, no analytics or
tracking, and no servers of its own.

### Camera

The app needs camera access to scan codes. The camera image is processed
solely on your device. No photos or videos are stored or transmitted. You can
revoke camera access at any time in your device settings.

### History and settings

The contents of the last 25 scanned codes and the most recently selected
scan type and zoom level are stored locally on your device so that you can
open them again later. The app does not send this data off the device.
The history is stored encrypted (AES-256). The key is created randomly for
each installation and is kept only in your device's Keychain (iOS) or
Android Keystore; it is neither synced to iCloud nor included in backups. You can clear the
history or single entries in the app at any time. One-time password keys
(2FA, `otpauth://`) are never stored in the history. Deleting the app removes
all of its data.
On Android, the app does not take part in Google backups. An iCloud or
device backup on iOS may contain the encrypted history; without the key,
which stays on the device, it cannot be read.

### Content recognition

The app recognizes common content formats such as contacts, events, Wi-Fi
credentials, bank transfer data (GiroCode) or one-time password keys (2FA) and
displays them in a readable form, as well as item numbers (EAN, ISBN), the
Deutsche Post matrix code and setup codes of smart home devices (Matter).
This happens solely on your device. Please note that such codes can contain
confidential information, for example Wi-Fi passwords or the setup code of a
Matter device; like any content, they remain in the history until you clear
it.
2FA keys are not stored.

### Electronic tickets

If a code contains an electronic ticket according to the VDV standard (e.g.
Deutschlandticket), the app reads the included details such as validity, name
(plain or masked, depending on the ticket) and date of birth solely on your device. It uses bundled public keys for
this; no data is transmitted.

### Opening links and actions

If a code contains a link, the app opens it in your browser or the
responsible app only after you explicitly confirm. Known tracking parameters
(e.g. `utm_source`, `fbclid`) are removed. The same applies to the actions on
the result page: write email, call, SMS, map and authenticator hand the
content to the respective app only after you confirm. “Look up online” sends
the item number to DuckDuckGo or the ISBN to Open Library, “Track shipment”
sends the tracking number to Deutsche Post. The privacy policy of the
respective website or app applies. The “Support” button in the info dialog opens
https://github.com/thorsten-l/qr_viewer/issues, the “Manuals” button
https://github.com/thorsten-l/qr_viewer/tree/main/docs in your browser;
GitHub's privacy policy applies there.

### Clipboard, sharing and export

Content is copied to the clipboard only when you tap “Copy”. With “Share”,
“Add to contacts”, “Add to calendar” and the history export (CSV or JSON) you
pass content to an app of your choice via the operating system's share
sheet; nothing is transmitted before that. “Show code” only draws the
content as an image on your device's screen; nothing is stored or
transmitted.

### Android only: Google ML Kit

On Android, the app uses Google's “ML Kit Barcode Scanning” library to
recognize codes. Recognition happens on the device; camera images are not
sent to Google. ML Kit may, however, send technical usage and diagnostic data
to Google, such as device model, operating system version, app package name
and version, and performance metrics. According to Google, this data is used
to operate and improve ML Kit. More information:
https://developers.google.com/ml-kit/terms and
https://policies.google.com/privacy

On iOS and iPadOS, recognition uses Apple's Vision framework on the device,
without any third party involved.

### Your rights

Since the developer does not process any of your personal data, there is no
data about you that could be disclosed, corrected or deleted. If you have any
questions about privacy, please contact the email address above. You also
have the right to lodge a complaint with a data protection supervisory
authority.

### Changes

This privacy policy may be updated when the app changes. The current version
is always available at
https://github.com/thorsten-l/qr_viewer/blob/main/PRIVACY.md
