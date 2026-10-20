# Changelog

[English](CHANGELOG.md) · **Deutsch**

Alle wichtigen Änderungen an QR Viewer. Die Versionen folgen
[Semantic Versioning](https://semver.org/lang/de/), die Build-Nummer steht
hinter dem `+`.

## [2.3.1+16] – 2026-10-20

### Neu

- **Amazon-Transparency-Code:** Codes, die mit `AZ:` und einer
  alphanumerischen Seriennummer beginnen (meist als Data Matrix auf
  Amazon-Verpackungen), erscheinen als Karte „Amazon-Transparency-Code“ mit
  der Seriennummer. Der Info-Knopf erklärt: Es ist ein Echtheitscode, der Code
  enthält nur die zufällige Seriennummer, und geprüft wird er in der
  Amazon-Shopping- oder Transparency-App (dabei geht der Code an Amazon). Die
  Karte bietet keine Aktion an.

- **Medikationsplan:** Der Code auf dem bundeseinheitlichen Medikationsplan
  (BMP, XML `<MP …>` als Data Matrix, Spezifikation der KBV) wird erkannt. Die
  Ergebnisseite heißt „Medikationsplan“ und weist darauf hin, dass er
  Gesundheitsdaten enthält und **nicht im Verlauf gespeichert** wird. Das gilt
  auch, wenn der Scanner ihn als Binärdaten liefert.
- **Karte „Medikationsplan“:** zeigt den Plan lesbar an: Patient*in
  (Name, Geburtsdatum, Allergien, Gewicht, Größe, Kreatinin, Schwangerschaft,
  Stillzeit), Ersteller mit Adresse und Ausdruckdatum, Seite x von y, dann
  jeden Block mit Zwischenüberschrift und je Medikament Wirkstoff/Stärke bzw.
  Handelsname, Darreichungsform, Dosierung (Viererschema oder Freitext, mit
  Wochentag), Hinweis, Grund, Zusatzzeile und PZN; außerdem Freitextzeilen und
  Rezepturen. Überschriften, Darreichungsformen und Dosiereinheiten kommen aus
  den KBV-Schlüsseltabellen (S_BMP_ZWISCHENUEBERSCHRIFT, S_BMP_DOSIEREINHEIT,
  S_BMP_DARREICHUNGSFORM) und stehen wie auf dem Papierplan auf Deutsch.
  Medikamente, die nur als PZN im Plan stehen, kann die App offline nicht
  benennen; das Kopier-Symbol rechts an jedem Medikament kopiert dessen PZN,
  nachschlagen kann man sie dann selbst. Neue Datei
  `lib/medication_plan.dart`.
- Anleitung: neue Anhangseite „Data Matrix – Medikationsplan“ mit
  erfundenem Beispielplan.

### Sicherheit

- Beim Start entfernt die App Verlaufseinträge, die nach den aktuellen Regeln
  nicht gespeichert werden dürfen, z. B. einen Medikationsplan, der mit einer
  älteren Version gescannt wurde.

### Geändert

- Datenschutzerklärung, DSFA und Anleitungen nennen Medikationspläne neben
  2FA-Schlüsseln als Inhalte, die nie gespeichert werden.
- **Scannen von Foto:** Der Dialog „Foto wird ausgewertet …“ erscheint jetzt
  sofort nach dem Antippen eines Fotos, zuerst mit Ladekreis. Bisher öffnete
  er sich erst, wenn die Fotoauswahl das Bild geliefert hatte; bei neuen
  Fotos dauerte das einige Sekunden.

## [2.3.0+15] – 2026-10-19

### Neu

- **Menü auf der Scanner-Seite:** Der Info-Knopf ist einem Menü-Knopf (☰)
  ganz rechts in der Kopfzeile gewichen. Das Menü enthält „Verlauf“,
  „Einstellungen“ und „Info“; der Verlauf-Knopf ist ebenfalls ins Menü
  gewandert.
- **Einstellungen** mit dem Schalter „Aktionen aktivieren“. Er blendet auf
  der Ergebnisseite die Aktionsknöpfe ein (Öffnen, Anrufen, E-Mail, SMS,
  Karten, Nachschlagen, Sendungsverfolgung, Kontakt oder Termin hinzufügen,
  Einmalpasswort). **Standard: aus** – die App zeigt Inhalte dann nur an;
  Kopieren, Teilen und „Code anzeigen“ bleiben immer verfügbar.
- **Scannen von Foto** (Einstellung, **Standard: aus**): Links neben der
  Taschenlampe erscheint ein Foto-Knopf. Damit wählst du ein Bild aus deinen
  Fotos; die App liest den ersten Code darin (alle Formate, unabhängig von
  der Scan-Art) und zeigt das Ergebnis wie bei einem Kamera-Scan. Während
  der Auswertung zeigt ein Dialog das gewählte Foto mit Fortschrittsbalken.
  Findet die App im Original keinen Code, prüft sie verkleinerte Fassungen
  (1600, 1024, 2000, 800 px lange Seite). Schwierige Codes, etwa graviert
  oder mit Logo, erkennt Vision bzw. ML Kit oft nur bei bestimmten Größen. Findet sie
  keinen Code, meldet sie „Im Foto wurde kein Code gefunden.“ Die Auswahl
  läuft über die Fotoauswahl des Systems (PHPicker bzw. Android Photo
  Picker): Die App bekommt nur das gewählte Bild und braucht kein Leserecht
  auf die Mediathek, es erscheint also keine Berechtigungsabfrage. Für Apple
  steht der Pflichttext `NSPhotoLibraryUsageDescription` in der Info.plist.
- Neue Abhängigkeit `image_picker` (BSD-3-Clause) für die Fotoauswahl.

### Geändert

- Datenschutzerklärung: Abschnitte zu „Scannen von Foto“ und zu den
  standardmäßig ausgeschalteten Aktionen; gilt ab 2.3.0.
- Die temporäre Kopie des gewählten Fotos löscht die App direkt nach der
  Auswertung.
- DSFA (DPIA) für 2.3.0 nachbewertet: neue Datenflüsse, Berechtigungen und
  Schutzmaßnahmen; Risiko weiterhin gering.
- Anleitungen (DE/EN) für 2.3.0: Menü, neues Kapitel „Einstellungen“, Code aus
  einem Foto lesen, Aktionen ab Werk aus; neue Bilder für Menü,
  Einstellungen und Foto-Scan.

## [2.2.0+14] – 2026-10-14

### Sicherheit

- **Verschlüsselter Verlauf:** Der Verlauf wird mit AES-256-CBC und
  HMAC-SHA256 gespeichert (Encrypt-then-MAC, bei jedem Speichern ein neuer
  zufälliger IV). Der 32-Byte-Schlüssel wird je Installation zufällig erzeugt.
  Er liegt nur im iOS-Schlüsselbund (`AfterFirstUnlockThisDeviceOnly`, nicht
  mit iCloud synchronisiert) bzw. im Android Keystore und ist nie Teil einer
  Sicherung. Ohne den Schlüssel ist eine Kopie des Verlaufs wertlos.
- Der Klartext-Verlauf früherer Versionen wird beim ersten Start übernommen
  und verschlüsselt, danach wird die Klartext-Kopie gelöscht. Fehlt der
  Schlüssel, z. B. nach Wiederherstellung auf einem anderen Gerät, beginnt der
  Verlauf leer.
- Android: App-Daten sind nicht mehr Teil der Google-Sicherung
  (`allowBackup="false"`).

### Neu

- **Code anzeigen:** Ein kleiner QR-Code-Knopf ganz links in der Aktionszeile
  zeigt den gescannten Code als Grafik in einem Dialog, wenn möglich im
  Originalformat, sonst als QR-Code.
- Datenschutz-Folgenabschätzung mit Sicherheitsaudit (`DPIA.md`,
  `DPIA_de.md`).

### Geändert

- Datenschutzerklärung: verschlüsselter Verlauf; bei VDV-Tickets wird der
  Name je nach Ticket im Klartext oder maskiert angezeigt.
- Neue Abhängigkeiten: `flutter_secure_storage`, `pointycastle`,
  `barcode_widget`.

## [2.1.2+13] – 2026-10-13

### Neu

- **Matter-Codes** (Smart Home, beginnen mit `MT:`) werden erkannt und als
  Karte „Matter-Gerät“ angezeigt: manueller Kopplungscode (11 bzw. 21 Ziffern
  mit Verhoeff-Prüfziffer, zum Eintippen in Apple Home, Google Home usw.),
  Einrichtungscode (PIN), Hersteller- und Produkt-ID, Diskriminator,
  Verbindungsarten (Bluetooth LE, WLAN-Zugangspunkt, vorhandenes Netzwerk,
  Wi-Fi PAF) und Einrichtungsablauf. Ungültige Codes bleiben Text. Der
  Info-Knopf weist darauf hin, dass jeder mit dem Code das Gerät koppeln kann,
  solange es im Einrichtungsmodus ist.
- **Info-Dialog:** Knopf „Anleitungen“ links neben „Schließen“; er öffnet
  github.com/thorsten-l/qr_viewer/tree/main/docs im Browser.
- **Lesezeichen (MEBKM)** haben eine eigene Karte „Lesezeichen“ mit Titel und
  Link statt „URL“. Das Escape-Zeichen `¥` aus der Docomo-Spezifikation wird
  verstanden, Titel oder Link dürfen fehlen; ohne Link gibt es keinen
  Öffnen-Knopf.
- **Anleitung** für Alltagsnutzer als ODT und PDF auf Deutsch und Englisch
  (`docs/`), mit einer Seite und einem scanbaren Beispielcode je Codeart,
  Kapitel zum Datenschutz und dem Generator in `tool/manual/`.
- 17 neue Texte in allen 13 Sprachen.

### Geändert

- **Info-Dialog:** Support, Lizenzen, Anleitungen und Schließen sind vier
  gleich breite Knöpfe in zwei Reihen; Schließen hat ein Symbol. Lange
  Beschriftungen werden etwas kleiner statt umzubrechen.
- Datenschutzerklärung: Einrichtungscodes von Matter-Geräten werden nur auf
  dem Gerät ausgewertet und stehen wie jeder Inhalt im Verlauf; der Knopf
  „Anleitungen“ öffnet eine Seite auf GitHub.

## [2.1.1+12] – 2026-10-12

### Neu

- **Info-Knopf** oben rechts in jeder Datenkarte (auch bei VDV-Tickets). Der
  Dialog erklärt in einfachen Worten, was für Daten der Code enthält, dass sie
  nur auf dem Gerät gelesen wurden und was beim Tippen auf die Aktion
  passiert: Eine Website wie DuckDuckGo, Open Library oder die Deutsche Post
  sieht dann die Anfrage und die Internetadresse, und ihre Angaben kommen von
  außerhalb der App; andere Aktionen geben die Daten an eine andere App.
- 20 neue Texte in allen 13 Sprachen.

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
- **Hex-Dump mit Textspalte** wie bei `xxd`. Die Textspalte steht immer rechts
  neben den Hex-Werten: 16 oder 8 Bytes pro Zeile, notfalls in kleinerer
  Schrift; ist es dann noch zu schmal, lässt sich der Dump waagerecht
  scrollen.
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
