# Changelog

[English](CHANGELOG.md) · **Deutsch**

Alle wichtigen Änderungen an QR Viewer. Versionen nach
[Semantic Versioning](https://semver.org/lang/de/), Build-Nummer hinter `+`.

## [2.3.1+16] – 2026-10-20

### Neu

- **Medikationsplan** (bundeseinheitlich, BMP): Karte mit Patient*in,
  Ersteller und allen Medikamenten samt Dosierung, Hinweis und Grund; PZN per
  Kopier-Symbol. Wird **nie im Verlauf gespeichert**.
- **Amazon-Transparency-Code** (`AZ:…`): Karte mit Seriennummer.
- Anleitung: Anhangseiten zu beiden Codes.

### Sicherheit

- VDV-Schlüssel kommen direkt aus dem Verzeichnis der VDV-PKI, jede Signatur
  wird geprüft; der falsche Schlüssel `4445564456110416` ist ersetzt.
- Beim Start entfernt die App Verlaufseinträge, die nicht gespeichert werden
  dürfen (z. B. ältere Medikationspläne).

### Geändert

- Scannen von Foto: Der Ladedialog erscheint sofort nach der Auswahl.
- Datenschutzerklärung, DSFA und Anleitungen aktualisiert.

## [2.3.0+15] – 2026-10-19

### Neu

- **Menü** (☰) mit Verlauf, Einstellungen und Info.
- **Einstellungen:** „Aktionen aktivieren“ und „Scannen von Foto“, beide ab
  Werk aus.
- **Scannen von Foto** über die Fotoauswahl des Systems, ohne
  Fotoberechtigung; schwierige Codes werden in mehreren Bildgrößen gesucht.
- Abhängigkeit `image_picker`.

### Geändert

- Aktionen (Öffnen, Anrufen …) sind ab Werk aus.
- Die Kopie des gewählten Fotos wird nach der Auswertung gelöscht.
- Datenschutzerklärung, DSFA und Anleitungen aktualisiert.

## [2.2.0+14] – 2026-10-14

### Sicherheit

- **Verlauf verschlüsselt** (AES-256-CBC + HMAC-SHA256); Schlüssel nur im
  Schlüsselbund bzw. Android Keystore, nie in Sicherungen. Alter Verlauf wird
  übernommen.
- Android: keine Google-Sicherung mehr (`allowBackup="false"`).

### Neu

- **Code anzeigen** als Grafik, im Originalformat oder als QR-Code.
- Datenschutz-Folgenabschätzung (`DPIA.md`, `DPIA_de.md`).

### Geändert

- Datenschutzerklärung aktualisiert.
- Abhängigkeiten `flutter_secure_storage`, `pointycastle`, `barcode_widget`.

## [2.1.2+13] – 2026-10-13

### Neu

- **Matter-Codes** (`MT:`) mit Kopplungscode, PIN, Hersteller und
  Verbindungsarten.
- **Lesezeichen** (MEBKM) als eigene Karte.
- **Anleitung** (DE/EN, ODT/PDF) mit Beispielcode je Codeart; Knopf
  „Anleitungen“ im Info-Dialog.

### Geändert

- Info-Dialog: vier gleich breite Knöpfe.

## [2.1.1+12] – 2026-10-12

### Neu

- **Info-Knopf** in jeder Datenkarte erklärt Daten und Aktion.

## [2.1.0+11] – 2026-10-11

Ideen aus [BinaryEye](https://github.com/markusfisch/BinaryEye).

### Neu

- **Aktionen** mit Rückfrage: E-Mail, Anruf, SMS, Karte, Authenticator,
  Nachschlagen, Sendungsverfolgung; Kontakt und Termin als `.vcf`/`.ics`.
- **Teilen**; Verlauf mit Wischen zum Löschen, Suche und Export (CSV/JSON).
- Artikelnummern mit Prüfziffer und Land, ISBN/ISSN, Matrixcode der Deutschen
  Post, JSON, Links ohne Schema.
- Hex-Dump mit Textspalte, Vibration, Taschenlampen-Status.

### Geändert

- 2FA-Schlüssel werden nicht mehr gespeichert.
- Tracking-Parameter werden aus Links entfernt.

## [2.0.1+10] – 2026-10-10

### Neu

- **Einmalpasswort** (`otpauth://`) als Karte.
- Info-Dialog mit „Support“ und „Lizenzen“.

## [2.0.0+9] – 2026-10-10

### Neu

- **Inhalte erkannt:** Kontakt, Termin, WLAN, E-Mail, Telefon, SMS, Ort,
  Link, GiroCode – als Karte mit einzeln kopierbaren Feldern.

### Geändert

- Verlauf: 25 statt 10 Scans.

## [1.4.0+8] – 2026-10-10

### Neu

- **Zoomstufen** der Rückkamera wie in der Kamera-App.

## [1.3.0+7] – 2026-10-09

### Neu

- **VDV-eTickets** (z. B. Deutschlandticket) lesbar, mit Signaturprüfung.
- Öffentliche VDV-CA-Schlüssel und Update-Skript; Abhängigkeit `crypto`.

## [1.2.0+6] – 2026-10-09

### Neu

- **Binärcodes** als Hex-Dump.

## [1.1.0+5] – 2026-10-09

### Neu

- **Scan-Arten:** QR, Barcode, Data Matrix, PDF417, Aztec, alle.
- **13 Sprachen**; Datenschutzerklärung und Apache-2.0-Lizenz.

## [1.0.1+4/5] – 2026-10-09

### Neu

- **Verlauf** der letzten 10 Scans; Inhalt in Source Code Pro.

## [1.0.0+1–3] – 2026-10-08

### Neu

- Erste Version: QR-Codes scannen und anzeigen, Links nach Rückfrage öffnen,
  Kopieren, Taschenlampe, Info-Dialog, App-Icon.
