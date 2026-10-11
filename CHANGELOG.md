# Changelog

Alle wichtigen Änderungen an QR Viewer. Die Versionen folgen
[Semantic Versioning](https://semver.org/lang/de/), die Build-Nummer steht
hinter dem `+`.

## [2.1.0+11] – 2026-10-11

Ideen aus [BinaryEye](https://github.com/markusfisch/BinaryEye) übernommen.

### Neu

- **Aktionen je Inhalt**, jeweils erst nach Rückfrage mit sichtbarem Ziel:
  E-Mail schreiben, Anrufen (öffnet nur den Wähler), SMS schreiben, in Karten
  zeigen (Apple Karten bzw. `geo:`), 2FA-Schlüssel an die
  Authenticator-App geben, Produkt bzw. Buch online nachschlagen
  (DuckDuckGo bzw. Open Library), Sendung verfolgen.
- **Kontakt und Termin übernehmen** über das Teilen-Menü als `.vcf` bzw.
  `.ics`. MECARD und BIZCARD werden dafür in vCard 3.0 umgewandelt, ein
  einzelnes VEVENT in VCALENDAR verpackt.
- **Teilen** des Inhalts auf der Ergebnisseite.
- **Verlauf:** Einträge per Wischen einzeln löschen (mit „Rückgängig“), Suche
  nach Inhalt, Format und Typ sowie Export als CSV oder JSON über das
  Teilen-Menü.
- **Artikelnummern** (EAN-13, EAN-8, UPC-A, UPC-E, ITF-14): Prüfziffer,
  Land der Nummernvergabe (GS1-Präfix), interne Nummern und Gutscheine.
  ISBN mit ISBN-10, ISSN bei Zeitschriften.
- **Matrixcode der Deutschen Post** (Briefmarke, Internetmarke): Sendungsnummer
  mit Prüfziffer und Link zur Sendungsverfolgung.
- **JSON** wird eingerückt in Source Code Pro angezeigt.
- **Links ohne Schema** wie `beispiel.de/pfad`, das Präfix `URL:` sowie andere
  App-Links (`market://`, `itms-apps://`, `fido:/`, …) werden als Link
  erkannt. Lokale und Skript-Schemata (`file:`, `javascript:`, `intent:`, …)
  bleiben ausgeschlossen.
- **Hex-Dump mit Textspalte** wie bei `xxd`; auf schmalen Bildschirmen wird die
  Schrift kleiner, bevor weniger Bytes pro Zeile erscheinen.
- Kurze Vibration beim Erkennen eines Codes.
- Die Taschenlampe zeigt an, ob sie an ist.
- 33 neue Texte in allen 13 Sprachen.

### Geändert

- **2FA-Schlüssel (`otpauth://`) werden nicht mehr im Verlauf gespeichert**;
  die Ergebnisseite weist darauf hin.
- Beim Öffnen von Web-Links fallen bekannte Tracking-Parameter weg (`utm_*`,
  `fbclid`, `gclid`, …); die Rückfrage zeigt den bereinigten Link.
- Datenschutzerklärung: Aktionen, Teilen, Export und 2FA-Ausschluss ergänzt.
- NOTICE-Datei und Lizenzeintrag für BinaryEye (MIT).

## [2.0.1+10] – 2026-10-10

### Neu

- **Einmalpasswort (2FA):** `otpauth://totp/…` und `otpauth://hotp/…`
  (Key Uri Format) erscheinen als Karte mit Anbieter, Konto, geheimem
  Schlüssel, Verfahren, Algorithmus, Stellen und Intervall bzw. Zähler.
  Fehlende Werte zeigen die Standardwerte (SHA1, 6 Stellen, 30 Sekunden).
- **Info-Dialog:** Knöpfe „Support“ (mit Link-Symbol, öffnet
  github.com/thorsten-l/qr_viewer/issues) und „Lizenzen“ nebeneinander unter
  den Angaben; unten bleibt nur „Schließen“.
- 10 neue Texte in allen 13 Sprachen.

### Geändert

- Datenschutzerklärung: Abschnitt zur Inhaltserkennung (auch WLAN-Passwörter
  und 2FA-Schlüssel bleiben auf dem Gerät), Support-Link, gespeicherte
  Zoomstufe.

## [2.0.0+9] – 2026-10-10

### Neu

- **QR-Inhalte werden erkannt und aufbereitet.** Eigener Parser für die
  üblichen Formate (siehe ZXing „Barcode Contents“):
  - Kontakt: vCard 2.1/3.0/4.0 (inkl. Quoted-Printable), MECARD, BIZCARD
  - Termin: iCalendar VEVENT (Zeitzonen, UTC, ganztägig)
  - WLAN: `WIFI:` (WPA/WEP/offen, verstecktes Netz, EAP)
  - E-Mail: `mailto:`, MATMSG, `SMTP:`, bloße Adresse
  - Telefon `tel:`, SMS `sms:`/`SMSTO:`/`mms:`, Ort `geo:`
  - Link: `http(s)://`, `www.`, MEBKM (Lesezeichen mit Titel)
  - Überweisung: EPC-QR/GiroCode (Empfänger, IBAN, BIC, Betrag,
    Verwendungszweck)
  - alles andere bleibt einfacher Text
- Die erkannten Felder stehen in einer Karte mit verständlichen Bezeichnungen;
  jedes Feld lässt sich einzeln kopieren. Datum und Betrag werden passend zur
  Sprache formatiert. Darunter steht weiterhin der Rohinhalt.
- Titel der Ergebnisseite und Symbol im Verlauf richten sich nach dem
  erkannten Format, auch auf iOS (Apple Vision liefert keinen Inhaltstyp).
- 49 neue Texte in allen 13 Sprachen.

### Geändert

- Der Verlauf merkt sich jetzt die letzten 25 statt 10 Scans.

## [1.4.0+8] – 2026-10-10

### Neu

- **Zoomstufen der Rückkamera** wie in der Kamera-App, als runde Umschalter
  über dem Kamerabild. Die App ermittelt die Stufen des Geräts:
  - iOS: Faktoren aus den Umschaltpunkten der Mehrfachkamera und die
    Sensor-Ausschnitte des 48-MP-Hauptsensors, z. B. „Auto · 0,5× · 1× · 2× ·
    5×“ beim iPhone 16 Pro Max. „Auto“ überlässt die Wahl dem System
    (inklusive Makro-Umschaltung).
  - Android: Faktoren aus den Kleinbild-Brennweiten; bei logischen
    Mehrfachkameras (z. B. Pixel) Ultraweitwinkel und Tele über das
    Zoomverhältnis, dazu ein digitales 2×, z. B. „0,6× · 1× · 2×“ beim
    Pixel 9a.
  - Die Auswahl bleibt gespeichert; Geräte mit nur einer Stufe zeigen keinen
    Umschalter.
- 7 neue Texte in allen 13 Sprachen.

## [1.3.0+7] – 2026-10-09

### Neu

- **VDV-eTickets lesbar** (z. B. Deutschlandticket, Semesterticket): Die
  Ticketdaten werden aus der Signatur zurückgewonnen (ISO 9796-2) und als
  Tabelle angezeigt: Ticketnummer, Produkt, Gültig ab/bis, Ausstellungszeit,
  Inhaber (maskiert, wie im Ticket gespeichert), Geburtsdatum,
  Organisationsnummern, Klasse und, falls vorhanden, Preis.
- **Signaturprüfung** von Ticket und Herausgeberzertifikat mit Anzeige
  „Signatur gültig“ bzw. „Signatur ungültig“.
- 31 öffentliche VDV-CA-Schlüssel (CC0) in `assets/vdv_certs/`, mit
  Update-Skript `tool/vdv/fetch_vdv_certs.sh`. Bei unbekanntem Herausgeber
  nennt die App die CA-Referenz und zeigt nur die Rohdaten.
- 21 neue Texte in allen 13 Sprachen.

### Geändert

- Die Rohdaten eines Tickets stehen in einem aufklappbaren Bereich
  „Rohdaten (Hex)“ unter den Ticketdaten.
- Datenschutzerklärung: Abschnitt zu elektronischen Tickets. Die Daten
  werden nur lokal auf dem Gerät dekodiert.
- Neue Abhängigkeit `crypto` (SHA-1 für die Signaturprüfung).

## [1.2.0+6] – 2026-10-09

### Neu

- **Binärcodes** werden als Hex-Dump mit Offset angezeigt; Kopieren liefert
  Hex-Text. VDV-eTickets werden als „VDV-eTicket (signiert)“ erkannt.
- Auf iOS werden die Bytes aus dem Windows-1252-Text von Apple Vision
  rekonstruiert.
- Der Verlauf merkt sich, ob ein Eintrag binär ist.

## [1.1.0+5] – 2026-10-09

### Neu

- **Scan-Arten** über ein Menü im Titel: QR-Code, Barcode, Data Matrix,
  PDF417, Aztec oder alle Codes. Die Auswahl bleibt gespeichert.
- **13 Sprachen**: Englisch, Deutsch, Spanisch, Französisch, Portugiesisch,
  Russisch, Chinesisch (vereinfacht), Hindi, Arabisch, Japanisch,
  Italienisch, Polnisch und Ukrainisch.
- Datenschutzerklärung, Apache-2.0-Lizenz und Lizenzköpfe in allen
  Quelldateien.

## [1.0.1+4/5] – 2026-10-09

### Neu

- **Verlauf** der letzten 10 Scans zum erneuten Aufrufen und Kopieren
  (Build 5).

### Geändert

- Inhalte in Source Code Pro, 20 pt (Build 4).

## [1.0.0+1–3] – 2026-10-08

### Neu

- Erste Version: QR-Codes scannen und nur anzeigen, Links erst nach
  Rückfrage öffnen, Kopieren, Taschenlampe, heller und dunkler Modus.
- Info-Dialog mit Entwickler, Version und Build-Datum.
- App-Icon (QR-Code mit Auge), ab Build 3 auch als Startbildschirm.
