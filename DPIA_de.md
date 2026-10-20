# Datenschutz-Folgenabschätzung – QR Viewer

**Deutsch** · [English](DPIA.md)

| | |
|---|---|
| App | QR Viewer 2.3.1 (Build 16), iOS/iPadOS und Android |
| Codestand | `main`, Audit auf Commit `b25767c` („release 2.1.2“); Maßnahmen zu F2 und F6 in 2.2.0; Einstellungen und „Scannen von Foto“ in 2.3.0, Medikationsplan und Amazon-Transparency-Code in 2.3.1 ergänzt |
| Verantwortlicher / Verfasser | Thorsten Ludewig, t.ludewig@gmail.com |
| Datum | 20. Oktober 2026 (erstellt 14. Oktober 2026) |
| Grundlage | Art. 35 DSGVO, § 25 TDDDG |
| Status | Bewertung abgeschlossen; F2 und F6 in 2.2.0 umgesetzt, 2.3.0 und 2.3.1 nachbewertet, übrige Maßnahmen offen (Abschnitt 8) |

Dieses Dokument verbindet ein technisches Sicherheitsaudit der App mit einer
Datenschutz-Folgenabschätzung (DSFA). Es ist keine Rechtsberatung.

---

## 1. Zusammenfassung

QR Viewer ist ein Scanner für QR-Codes und Barcodes. Er zeigt den Inhalt
zuerst an und öffnet Links oder andere Aktionen erst nach Bestätigung. Die
App hat kein Benutzerkonto, keine eigenen Server, keine Werbung und keine
Analyse. Der App-Code selbst baut **keine Netzwerkverbindungen** auf. Alle
Erkennung und Auswertung läuft auf dem Gerät.

**Ist eine DSFA Pflicht?** Eher nicht. Der Entwickler erhält keine
personenbezogenen Daten. Es gibt keine umfangreiche Verarbeitung und kein
Profiling. Keiner der Fälle aus Art. 35 Abs. 3 DSGVO oder der DSK-Liste
trifft zu. Diese Abschätzung ist freiwillig und dokumentiert, warum das
Risiko gering ist.

**Ergebnis:** Das Risiko für die Betroffenen ist **gering**. Zwei Punkte
brauchen Aufmerksamkeit:

1. Unter Android sendet Google ML Kit technische Nutzungsdaten an Google
   (Befund F1). Das steht in der Datenschutzerklärung, nach § 25 TDDDG ist
   aber fraglich, ob das ohne Einwilligung reicht.
2. Bis 2.1.2 lag der Scan-Verlauf unverschlüsselt vor und war Teil der
   Betriebssystem-Sicherungen (Befund F2). Gescannte Codes können
   WLAN-Passwörter, Matter-Einrichtungscodes oder Ticketdaten mit Name und
   Geburtsdatum enthalten. **In 2.2.0 umgesetzt:** Der Verlauf ist mit
   AES-256-CBC + HMAC-SHA256 verschlüsselt, der Schlüssel bleibt auf dem
   Gerät, die Android-Sicherung ist aus.

**Neu in 2.3.0:** Die Aktionen der Ergebnisseite (Öffnen, Anrufen,
Nachschlagen usw.) sind ab Werk ausgeschaltet und lassen sich in den
Einstellungen einschalten. Ohne sie verlässt kein Inhalt die App, außer du
kopierst oder teilst ihn. Mit „Scannen von Foto“ (ab Werk aus) liest die App
Codes aus einem Bild, das du in der Fotoauswahl des Systems wählst. Sie
bekommt nur dieses Bild, braucht keine Leseberechtigung für die Mediathek
und speichert es nicht. Das Risiko bleibt gering.

**Neu in 2.3.1:** Die App erkennt den bundeseinheitlichen Medikationsplan und
zeigt ihn als Karte an. Er enthält Gesundheitsdaten (Art. 9 DSGVO) und wird
nie im Verlauf gespeichert; ältere Einträge entfernt die App beim Start. Sie
schlägt keine Medikamente online nach. Außerdem erkennt sie Echtheitscodes von
Amazon („Transparency“), ohne Daten weiterzugeben.

Ein hohes Restrisiko bleibt nicht. Eine vorherige Konsultation der
Aufsichtsbehörde nach Art. 36 DSGVO ist nicht nötig.

---

## 2. Umfang und Vorgehen

**Geprüft:**
- Dart-Quellcode in `lib/` (rund 4.200 Zeilen plus `lib/vdv/`).
- Das zusammengeführte Android-Release-Manifest (`build/app/intermediates/merged_manifests/release`).
- `ios/Runner/Info.plist`.
- Abhängigkeiten in `pubspec.yaml` / `pubspec.lock` (`flutter pub outdated`).
- Die Privacy Manifeste der Plugins.
- Die bestehende Datenschutzerklärung `PRIVACY.md`.

**Nicht geprüft:**
- Penetrationstests auf Geräten.
- Abgleich mit Schwachstellen-Datenbanken (OSV/CVE).
- Das Innenleben von ML Kit und Apple Vision (Closed Source).
- Daten, die Apple und Google als Store-Betreiber erheben.

**Risikoskala:** Eintrittswahrscheinlichkeit × Schwere, jeweils gering /
mittel / hoch, angelehnt an das Standard-Datenschutzmodell (SDM).

---

## 3. Beschreibung der Verarbeitung

### 3.1 Zweck

Die App liest den Inhalt optischer Codes und zeigt ihn verständlich an.
Beispiele sind Links, Kontakte, WLAN-Zugänge, GiroCode-Überweisungen,
2FA-Schlüssel, VDV-Tickets, Codes der Deutschen Post und
Matter-Einrichtungscodes. Weil nichts automatisch geöffnet wird, schützt sie
vor schädlichen Codes („Quishing“).

### 3.2 Betroffene und Datenkategorien

| Betroffene | Daten | Quelle |
|---|---|---|
| Nutzer:in | Kamerabild (nur live, nicht gespeichert) | Kamera |
| Nutzer:in | Scan-Verlauf (letzte 25 Inhalte mit Zeit, Format, Typ) | Scans |
| Nutzer:in | Vom Nutzer gewähltes Foto (nur mit „Scannen von Foto“, nicht gespeichert) | Fotoauswahl des Systems |
| Nutzer:in | Einstellungen: Scan-Art, Zoomstufe, „Aktionen aktivieren“, „Scannen von Foto“ | App |
| Dritte in Codes | Namen, Telefonnummern, E-Mail- und Postadressen (vCard/MECARD), Termine | Code-Inhalt |
| Ticketinhaber:in | Name (Klartext oder maskiert), Geburtsdatum, Ticketnummer, Gültigkeit | VDV-Ticket (Deutschlandticket) |
| Nutzer:in / Dritte | WLAN-Passwörter, 2FA-Geheimnisse, Matter-Einrichtungs-PIN, IBAN/Name (GiroCode) | Code-Inhalt |
| Nutzer:in (Android) | Gerätemodell, OS-Version, Paketname und -version, ML-Kit-Leistungsdaten | ML-Kit-SDK |

**Besondere Kategorien nach Art. 9 DSGVO** werden nicht gezielt
verarbeitet. Ein Code kann solche Daten zufällig enthalten, etwa einen Text
über die Gesundheit. Die App zeigt ihn dann wie jeden anderen Text an.
Eine Ausnahme erkennt sie gezielt: den bundeseinheitlichen Medikationsplan
(BMP, XML mit `<MP …>` als Data Matrix auf dem Papierplan, Spezifikation der
KBV, Anlage 3 zu § 31a SGB V). Er enthält Name, Geburtsdatum, Arzt und
Medikamente. Seit 2.3.1 zeigt die App ihn nur an und speichert ihn nie im
Verlauf; ältere Verlaufseinträge mit einem Plan entfernt sie beim Start.

### 3.3 Speicherorte

| Daten | Ort | Schutz | Löschung |
|---|---|---|---|
| Verlauf (`scan_history_v2`) | SharedPreferences (Android-XML in der App-Sandbox) / NSUserDefaults (iOS) | Sandbox des Betriebssystems, Geräteverschlüsselung; **AES-256-CBC + HMAC-SHA256** seit 2.2.0 | Einzeln, „Verlauf löschen“, Deinstallation; max. 25 Einträge |
| Verlaufsschlüssel (32 Byte, zufällig) | iOS-Schlüsselbund (`AfterFirstUnlockThisDeviceOnly`, nicht synchronisiert) / Android Keystore | Wo vorhanden hardwaregestützt; nie in Sicherungen | Deinstallation |
| 2FA-Schlüssel, Medikationspläne | **werden nicht gespeichert** | – | – |
| Scan-Art, Zoom, Einstellungen | SharedPreferences / NSUserDefaults | Sandbox | Deinstallation |
| Kamerabild | Nur im Arbeitsspeicher | – | Sofort |
| Gewähltes Foto | Kopie von `image_picker` im temporären App-Ordner; verkleinerte Fassungen in einem eigenen temporären Ordner | Sandbox | Die App löscht beides direkt nach der Auswertung |
| Exportdateien (CSV/JSON), vCard/iCalendar | Temporäre Datei von `share_plus` im App-Cache, danach die Ziel-App | Sandbox; in der Ziel-App gelten deren Regeln | Das Betriebssystem leert den Cache |

### 3.4 Datenflüsse und Empfänger

| # | Fluss | Auslöser | Empfänger |
|---|---|---|---|
| D1 | Kamerabild → Codeerkennung | Scannen | Auf dem Gerät: Apple Vision (iOS) bzw. ML Kit (Android) |
| D1a | Gewähltes Foto → Codeerkennung | Nutzer:in wählt ein Foto („Scannen von Foto“) | Auf dem Gerät: Apple Vision (iOS) bzw. ML Kit (Android) |
| D2 | ML-Kit-Telemetrie | Automatisch, nur Android | Google (Firelog/CCT über `com.google.android.datatransport`) |
| D3 | Link öffnen | Nur mit „Aktionen aktivieren“; Nutzer:in bestätigt den Dialog | Browser bzw. die App für das Schema, danach die Website |
| D4 | E-Mail, Anruf, SMS, Karte, Authenticator | Nur mit „Aktionen aktivieren“; Nutzer:in bestätigt | Die passende System-App |
| D5 | „Online nachschlagen“ | Nur mit „Aktionen aktivieren“; Nutzer:in bestätigt | DuckDuckGo (GTIN) / Open Library (ISBN) |
| D6 | „Sendung verfolgen“ | Nur mit „Aktionen aktivieren“; Nutzer:in bestätigt | Deutsche Post (`deutschepost.de`, Sendungsnummer in der URL) |
| D7 | Kopieren, Teilen, Kontakt, Termin, Verlaufsexport | Nutzer:in tippt | Zwischenablage / im Teilen-Menü gewählte App |
| D8 | Support, Anleitungen | Nutzer:in tippt | GitHub |
| D9 | Sicherung | Betriebssystem | iOS: iCloud-/Gerätesicherung, Verlauf nur als Geheimtext. Android: keine seit 2.2.0 (`allowBackup="false"`) |

### 3.5 Berechtigungen

| Plattform | Berechtigung | Herkunft | Zweck |
|---|---|---|---|
| iOS | Kamera (`NSCameraUsageDescription`) | App | Scannen |
| iOS | Fotomediathek (`NSPhotoLibraryUsageDescription`) | `image_picker` | Pflichttext für die Fotoauswahl; die Abfrage erscheint nie, weil PHPicker ohne Bibliothekszugriff auskommt (`requestFullMetadata: false`) |
| Android | `CAMERA` | mobile_scanner | Scannen |
| Android | `INTERNET`, `ACCESS_NETWORK_STATE` | ML Kit / datatransport (nicht vom App-Code genutzt) | Telemetrie D2 |
| Android | `DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` | AndroidX | Intern |
| Android | – (keine) | `image_picker` | Android Photo Picker, auf älteren Geräten über Google Play-Dienste; keine Speicher- oder Medienberechtigung |

Die App fragt **nicht** nach Standort, Kontakten, Kalender, Speicher, Fotos,
Mikrofon oder Bluetooth. Kontakte und Termine gehen als `.vcf` bzw. `.ics`
über das Teilen-Menü weiter. Dafür braucht es keine Kontakt- oder
Kalenderberechtigung.

---

## 4. Rechtliche Einordnung

- **Verarbeitung durch dich als Nutzer:in:** Scannen, Verlauf und
  Weitergabe an andere Apps passieren auf deinem eigenen Gerät für
  persönliche Zwecke. Das fällt unter die Haushaltsausnahme in Art. 2
  Abs. 2 lit. c DSGVO.
- **Entwickler:** Er erhält keine personenbezogenen Daten. Er entscheidet
  aber, welche SDKs in die App kommen. Für die ML-Kit-Telemetrie (D2) ist er
  deshalb wahrscheinlich gemeinsam mit Google verantwortlich (vgl. EuGH
  C-40/17 „Fashion ID“).
- **Rechtsgrundlage für D2:**
  - Art. 6 Abs. 1 lit. f DSGVO (berechtigtes Interesse an einer
    funktionierenden, gepflegten Bibliothek).
  - Das Auslesen von Geräteinformationen fällt zusätzlich unter **§ 25
    Abs. 1 TDDDG**. Dafür braucht es eine Einwilligung, es sei denn, es ist
    für den Dienst *unbedingt erforderlich* (Abs. 2 Nr. 2).
  - Das Scannen würde auch ohne die Telemetrie funktionieren. Ob sie
    „unbedingt erforderlich“ ist, ist deshalb zweifelhaft. → Befund F1.
- **D3–D8:** Daten gehen nur nach einer ausdrücklichen Handlung an Dritte.
  Ab dann sind die Empfänger selbst verantwortlich.
- **Informationspflichten (Art. 13 DSGVO):** Erfüllt durch `PRIVACY.md`,
  verlinkt in den Stores und in der README. Ein Detail stimmt nicht (F6).

---

## 5. Notwendigkeit und Verhältnismäßigkeit

| Grundsatz | Bewertung |
|---|---|
| Zweckbindung | Daten dienen nur der Anzeige und Aktionen, die du selbst auslöst. |
| Datenminimierung | Das Kamerabild und gewählte Fotos werden nicht gespeichert. Der Verlauf ist auf 25 Einträge begrenzt. 2FA-Schlüssel und Medikationspläne werden nicht gespeichert. Tracking-Parameter werden aus Links entfernt. Es gibt keine unnötigen Berechtigungen. **Aber:** WLAN-Passwörter und Matter-PINs landen im Verlauf. |
| Speicherbegrenzung | Höchstens 25 Einträge; einzeln oder alle löschbar. |
| Transparenz | Datenschutzerklärung auf Deutsch/Englisch; Info-Knopf in jeder Datenkarte; der Bestätigungsdialog zeigt das vollständige Ziel. |
| Integrität / Vertraulichkeit | Sandbox des Betriebssystems; kein Netzwerkcode in der App; kein WebView; die Parser prüfen Längen. Siehe F2–F5. |
| Betroffenenrechte | Beim Entwickler liegen keine Daten. Du verwaltest alles lokal selbst. |

---

## 6. Sicherheitsaudit – Befunde

Schweregrad: **Hoch / Mittel / Gering / Info**.

| ID | Schwere | Befund | Empfehlung |
|---|---|---|---|
| F1 | Mittel | **ML-Kit-Telemetrie unter Android.** `mobile_scanner` bindet `com.google.mlkit:barcode-scanning` ein. Das Release-Manifest enthält deshalb `INTERNET` sowie `TransportBackendDiscovery` mit `CctBackendFactory`. Google erhält Geräte- und Nutzungsdaten, ohne dass du etwas tust. Das steht in `PRIVACY.md`, es gibt aber keine Einwilligung (§ 25 TDDDG). | (a) Rechtlich prüfen lassen. (b) Eine Erkennungsbibliothek ohne Telemetrie suchen (z. B. ZXing-basiert) für einen Android-Build „ohne Netzwerk“. (c) Mindestens: Prüfen, dass die Angaben in „Datensicherheit“ der Play Console dazu passen. |
| F2 | Mittel → **in 2.2.0 umgesetzt** | **Verlauf unverschlüsselt und in Sicherungen.** `scan_history_v1` ist Klartext-JSON in SharedPreferences/NSUserDefaults. Android Auto Backup ist aktiv, weil `android:allowBackup` nicht gesetzt ist (Standard `true`). iOS nimmt UserDefaults in iCloud- und Gerätesicherungen auf. Der Verlauf kann WLAN-Passwörter, Matter-PINs, GiroCode-Daten (IBAN, Name) und VDV-Tickets (Name, Geburtsdatum) enthalten. | (a) Den Verlauf von Sicherungen ausnehmen: Android `allowBackup="false"` oder `dataExtractionRules`/`fullBackupContent` ohne `sharedpref`; unter iOS den Verlauf in einer Datei mit `isExcludedFromBackup` speichern. (b) WLAN-Passwörter und Matter-Codes wie 2FA-Schlüssel nicht oder nur maskiert speichern. (c) Optional: Einstellung „Verlauf speichern“ an/aus. |
| F3 | Gering | **Zwischenablage ohne Markierung „sensibel“.** „Kopieren“ legt Passwörter und Geheimnisse im Klartext in die Zwischenablage. Android 13+ zeigt sie in der Vorschau und in den Zwischenablage-Verläufen von Tastaturen. iOS kann sie per Universal Clipboard synchronisieren. | Unter Android für Passwort- und Geheimnis-Felder `ClipDescription.EXTRA_IS_SENSITIVE` setzen (Platform Channel). Unter iOS `UIPasteboard` mit `localOnly` und `expirationDate` nutzen. |
| F4 | Gering | **App-Umschalter / Bildschirmfotos.** Ergebnisse mit Geheimnissen sind in der Taskvorschau sichtbar. Weder `FLAG_SECURE` noch eine iOS-Abdeckung wird genutzt. Seit 2.2.0 zeigt „Code anzeigen“ den Inhalt als scanbare Grafik; wer in der Nähe ist, kann ihn mit einer Kamera abgreifen (z. B. WLAN-Passwort, 2FA-Schlüssel). Die Anzeige startest du bewusst. | Optional: Die Vorschau verbergen, solange die Ergebnisseite ein Passwort oder Geheimnis zeigt. |
| F5 | Gering | **Verlaufsexport im Klartext.** CSV und JSON enthalten alle Einträge ohne Schutz. Wo sie danach liegen, hängt von der Ziel-App ab (Cloud, E-Mail). Den Export startest du bewusst. | Im Exportdialog darauf hinweisen, dass sensible Inhalte enthalten sein können (z. B. WLAN-Passwörter). |
| F6 | Info → **in 2.2.0 behoben** | **Datenschutzerklärung bei VDV-Tickets ungenau.** `PRIVACY.md` spricht von einem „maskierten Namen“. Der Parser (`decodeTravelerName`) zeigt auch Klartextnamen (`Vorname#Nachname`), wenn das Ticket sie enthält. | Formulierung anpassen: „Name (je nach Ticket im Klartext oder maskiert)“. |
| F7 | Info | **Kein App-eigenes Privacy Manifest unter iOS.** `ios/Runner/PrivacyInfo.xcprivacy` fehlt. Die Plugins (`shared_preferences_foundation`, `mobile_scanner`, `url_launcher_ios`, `package_info_plus`, `share_plus`, `flutter_secure_storage`) bringen eigene mit. Die Vorgaben des App Store sind damit erfüllt. | Optional: Ein App-Manifest mit `NSPrivacyTracking = false` und ohne erhobene Datentypen ergänzen, der Vollständigkeit halber. |
| F8 | Info | **Sperrliste statt Positivliste für URL-Schemata.** `linkUri` sperrt `file`, `content`, `data`, `javascript`, `vbscript`, `intent`, `about`, `blob` und `chrome`. Andere Schemata mit `//` sowie `fido`, `magnet`, `bitcoin`, `lightning` und `ethereum` sind erlaubt, jeweils nach einer Bestätigung mit vollständigem Ziel. | Vertretbar. Bei Bedarf auf eine Positivliste umstellen (http, https, market, itms-apps, …). |
| F9 | Info | **Auswertung fremder Eingaben.** Der BER-Parser prüft jede Länge und begrenzt das Längenfeld auf 3 Byte. Die VDV-Dekodierung steckt in `try/catch`, ebenso der Binär- und der Deutsche-Post-Parser. RSA (`modPow`) arbeitet nur auf Daten in QR-Größe (wenige KB); ein nennenswertes Risiko für Denial-of-Service gibt es deshalb nicht. Es gibt kein WebView, keinen dynamischen Code und keine Deep Links. Exportiert sind nur die Launcher-Activity und der `ProfileInstallReceiver`, der durch die Berechtigung `DUMP` geschützt ist. | Kein Handlungsbedarf. Die Tests mit Grenzfällen beibehalten. |
| F10 | Info | **Abhängigkeiten.** Alle direkten Abhängigkeiten sind aktuell, außer `cupertino_icons` (1.0.9 → 2.0.0, nur Symbole). Einige transitive Pakete liegen ein Patch-Release zurück. Neu in 2.2.0: `flutter_secure_storage` (Schlüsselbund/Keystore), `pointycastle` und `barcode_widget` (reines Dart, ohne Netzwerk und ohne Berechtigungen). Neu in 2.3.0: `image_picker` (BSD-3-Clause, Flutter-Team) für „Scannen von Foto“ über die Fotoauswahl des Systems, ohne Leserecht auf die Mediathek. Ein Abgleich mit Schwachstellen-Datenbanken wurde nicht gemacht. | Regelmäßig `flutter pub upgrade` ausführen. `osv-scanner` in die Release-Checkliste aufnehmen. |

### Vorhandene Schutzmaßnahmen (positiv)

- Nichts wird automatisch geöffnet. Aktionen sind ab Werk ausgeschaltet
  (seit 2.3.0); eingeschaltet zeigt jede Aktion das Ziel und fragt nach.
- „Scannen von Foto“ ist ab Werk aus und nutzt die Fotoauswahl des Systems:
  Die App bekommt nur das gewählte Bild, nie die Mediathek, und löscht ihre
  Kopie nach der Auswertung.
- Bekannte Tracking-Parameter (`utm_*`, `fbclid`, `gclid`, …) werden vor dem
  Öffnen eines Links entfernt.
- 2FA-Schlüssel (`otpauth://`) und Medikationspläne werden nie im Verlauf gespeichert.
- Der Verlauf ist auf 25 Einträge begrenzt und löschbar.
- Kein Konto, kein eigenes Backend, keine Analyse, keine Werbung, keine
  Absturzberichte im App-Code.
- Unter iOS läuft die Erkennung komplett auf dem Gerät (Apple Vision), ohne Drittanbieter.
- Minimale Berechtigungen. Kontakte und Termine gehen ohne
  Zugriffsrechte über das Teilen-Menü weiter.
- VDV-Signaturen werden offline mit mitgelieferten öffentlichen Schlüsseln
  geprüft.
- Info-Knöpfe erklären in einfachen Worten, welche Daten ein Code enthält
  und wohin sie bei einer Aktion gehen.

---

## 7. Risiken für die Betroffenen

Wahrscheinlichkeit (W) und Schwere (S): gering / mittel / hoch.

| Risiko | Ursache | W | S | Vor Maßnahmen | Nach Maßnahmen (Abschnitt 8) |
|---|---|---|---|---|---|
| R1 Google erfährt von der App-Nutzung | ML-Kit-Telemetrie (F1) | hoch (Android) | gering (keine Inhalte, keine Bilder) | **mittel** | gering (mit anderer Bibliothek) / unverändert (nur Offenlegung) |
| R2 Jemand liest Geheimnisse aus dem Verlauf | Entsperrtes oder verlorenes Gerät, Backup-Konto kompromittiert (F2) | gering | mittel | **gering–mittel** | gering (seit 2.2.0 verschlüsselt; auf einem entsperrten Gerät zeigt die App den Verlauf weiterhin an) |
| R3 Geheimnisse gelangen über die Zwischenablage nach außen | Zwischenablage-Verlauf, Tastatur-Apps, Universal Clipboard (F3) | gering | mittel | gering | gering |
| R4 Phishing / Schadsoftware über Codes | Schädlicher Link im QR-Code | mittel | hoch | **gering** (Bestätigung, vollständiges Ziel sichtbar, gesperrte Schemata) | gering (seit 2.3.0 Aktionen ab Werk aus) |
| R5 Nachschlagedienste erfahren Artikel- oder Sendungsnummern | Du tippst „Online nachschlagen“ / „Sendung verfolgen“ | mittel | gering | gering | gering |
| R6 Mitlesen / Bildschirmfotos | Taskvorschau (F4) | gering | gering | gering | gering |
| R7 Der Export landet an einem unsicheren Ort | Export im Klartext (F5) | gering | mittel | gering | gering |

---

## 8. Maßnahmenplan

| Priorität | Maßnahme | Befund | Status |
|---|---|---|---|
| 1 | Verlauf verschlüsseln (AES-256-CBC + HMAC, Schlüssel in Schlüsselbund/Keystore) und Android-Sicherung abschalten | F2 | **erledigt (2.2.0)** |
| 2 | WLAN-Passwörter und Matter-Einrichtungscodes nicht im Verlauf speichern (wie 2FA) oder maskieren | F2 | offen |
| 3 | „Datensicherheit“ in der Play Console mit der ML-Kit-Telemetrie abgleichen und bei Bedarf anpassen; § 25 TDDDG rechtlich prüfen | F1 | offen |
| 4 | Eine Android-Erkennungsbibliothek ohne Telemetrie prüfen | F1 | offen |
| 5 | `PRIVACY.md` bei VDV-Namen korrigieren | F6 | **erledigt (2.2.0)** |
| 6 | Sensible Inhalte in der Zwischenablage markieren | F3 | offen |
| 7 | Hinweis auf sensible Inhalte beim Verlaufsexport | F5 | offen |
| 8 | Optional: Taskvorschau verbergen, iOS-App-Privacy-Manifest ergänzen, Positivliste für Schemata | F4, F7, F8 | offen |
| 9 | `osv-scanner` / `flutter pub outdated` in die Release-Checkliste | F10 | offen |

---

## 9. Ergebnis und Überprüfung

- **Gesamtrisiko:** gering. Mit den Maßnahmen 1–3 ist es ohne Einschränkung
  gering.
- **Vorherige Konsultation (Art. 36 DSGVO):** nicht erforderlich.
- **Nächste Überprüfung:** bei jedem Release mit neuen Datenarten,
  Berechtigungen oder SDKs, spätestens im Oktober 2027.

| Rolle | Name | Datum |
|---|---|---|
| Verantwortlicher | Thorsten Ludewig | |
