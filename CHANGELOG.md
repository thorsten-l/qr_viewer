# Changelog

Alle wichtigen Änderungen an QR Viewer. Die Versionen folgen
[Semantic Versioning](https://semver.org/lang/de/), die Build-Nummer steht
hinter dem `+`.

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
