# Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Texte der deutschen Anleitung. **fett**, `Code`; Listen als Python-Listen."""

UI = dict(
    file="QR-Viewer-Anleitung.odt",
    language="de", country="DE",
    footer="QR Viewer – Anleitung · Seite ",
    contents="Inhalt",
    platforms="Für iPhone, iPad und Android",
    appendix="Anhang: Alle Codes im Überblick",
    columns=("Nr.", "Code", "Scan-Art", "Geräte"),
    meta="Scan-Art: {mode} · Geräte: {devices}",
    try_code="Beispielcode zum Ausprobieren",
    shown="So zeigt QR Viewer ihn an",
    what="Was ist das?",
    where="Wo begegnet er dir?",
    example="Was steckt im Beispiel?",
    app="So verarbeitet QR Viewer den Code",
    do="Was du damit tun kannst",
    care="Darauf solltest du achten:",
)

TITLE = "QR Viewer"
SUBTITLE = "Codes sicher scannen – einfach erklärt"
VERSION_LINE = "Anleitung für Version 2.3.1 · Stand: Oktober 2026"

# Hauptteil: (Überschrift, [Blöcke]). Ein Block ist ein Absatz (str),
# eine Liste (list), ein Bild ("img", Datei, Breite in cm, Bildunterschrift)
# oder ein Hinweis ("note", Text).
CHAPTERS = [
    ("1 Was ist QR Viewer?", [
        "QR-Codes und Strichcodes begegnen dir überall: auf Plakaten, "
        "Speisekarten, Paketen, Fahrkarten, Lebensmitteln oder Briefen. "
        "Hinter so einem Code kann sich vieles verstecken – ein Link zu einer "
        "Internetseite, eine Telefonnummer, WLAN-Zugangsdaten oder eine "
        "vorbereitete Überweisung. Mit bloßem Auge siehst du nicht, was "
        "drinsteht.",
        "Viele Scanner-Apps öffnen einen Link sofort, sobald die Kamera den "
        "Code erkennt. Das ist bequem, aber riskant: Betrüger kleben zum "
        "Beispiel gefälschte Codes auf Parkautomaten oder Ladesäulen, um dich "
        "auf eine falsche Bezahlseite zu locken. Man nennt das „Quishing“ "
        "(aus „QR“ und „Phishing“).",
        "**QR Viewer macht es anders: erst ansehen, dann öffnen.** Die App "
        "zeigt dir zuerst nur, was im Code steht. Erst wenn du es "
        "ausdrücklich bestätigst, passiert etwas – etwa dass ein Link im "
        "Browser geöffnet wird. So kannst du in Ruhe prüfen, wohin ein Code "
        "wirklich führt.",
        "Außerdem gilt:",
        [
            "kein Benutzerkonto, keine Anmeldung",
            "keine Werbung und kein Tracking",
            "kostenlos für iPhone, iPad und Android-Geräte",
            "in 13 Sprachen – die App richtet sich nach der Sprache deines "
            "Geräts",
        ],
    ]),
    ("2 Erste Schritte", [
        "**Installieren:** Du findest QR Viewer im App Store (iPhone, iPad) "
        "und bei Google Play (Android). Suche nach „QR Viewer“.",
        "**Kamera erlauben:** Beim ersten Start fragt dein Gerät, ob QR Viewer "
        "die Kamera benutzen darf. Tippe auf „Erlauben“ bzw. „Bei Nutzung der "
        "App“. Ohne Kamera kann die App keine Codes lesen. Das Kamerabild wird "
        "nur auf deinem Gerät ausgewertet – es werden keine Fotos gespeichert "
        "oder verschickt.",
        ("note", "Hast du den Kamerazugriff versehentlich abgelehnt? Dann "
         "öffne die Einstellungen deines Geräts, suche dort „QR Viewer“ und "
         "schalte die Kamera ein."),
    ]),
    ("3 Einen Code scannen", [
        "Nach dem Start siehst du das Kamerabild. Halte dein Gerät so, dass "
        "der Code gut sichtbar im Bild ist. Sobald QR Viewer ihn erkennt, "
        "vibriert das Gerät kurz und die Ergebnisseite öffnet sich.",
        ("imgpair", "scanner.png", "scanner_menu.png", 5.2,
         "Links: der Scan-Bildschirm mit Zoomstufen unten. Rechts: das Menü "
         "im Titel, in dem du die Art von Code wählst. (Das Kamerabild ist "
         "nachgestellt.)"),
        "**Scan-Art wählen:** Oben links steht zum Beispiel „QR-Code "
        "scannen“. Tippst du darauf, öffnet sich ein Menü:",
        [
            "**QR-Code** – Links, Texte, WLAN-Zugänge, Kontakte und vieles "
            "mehr",
            "**Barcode** – die Strichcodes auf Produkten, Büchern und "
            "Etiketten",
            "**Data Matrix** – kleine quadratische Codes, z. B. auf "
            "Briefmarken und Bauteilen",
            "**PDF417** – breite, gestapelte Codes, z. B. auf Bordkarten",
            "**Aztec** – Codes mit einem „Zielscheiben“-Muster in der Mitte, "
            "z. B. auf Bahntickets",
            "**Alle Codes** – erkennt alles, was dein Gerät lesen kann",
        ],
        "QR Viewer merkt sich deine Wahl. Wenn du nicht weißt, was für ein "
        "Code vor dir liegt, nimm einfach „Alle Codes“. Die gezielte Auswahl "
        "hat einen Vorteil: Liegen mehrere Codes nebeneinander, liest die App "
        "nur den gewünschten.",
        "**Zoom:** Unten im Kamerabild findest du runde Knöpfe wie „0,6×“, "
        "„1×“ oder „2×“ – wie in der Kamera-App deines Geräts. Mit „2×“ "
        "oder mehr kannst du kleine oder weit entfernte Codes heranholen. "
        "Welche Stufen es gibt, hängt von den Kameras deines Geräts ab.",
        "**Taschenlampe:** Das Lampensymbol oben rechts schaltet das Licht "
        "ein und aus – praktisch in dunkler Umgebung.",
        "**Menü:** Das Symbol mit den drei Strichen (☰) ganz rechts öffnet "
        "das Menü mit **Verlauf**, **Einstellungen** und **Info**.",
        ("img", "scanner_app_menu_crop.png", 8.0,
         "Das Menü oben rechts auf dem Scan-Bildschirm."),
        ("note", "Tipps, wenn ein Code nicht erkannt wird: Halte das Gerät "
         "ruhig und etwas weiter weg, damit die Kamera scharf stellen kann. "
         "Vermeide Spiegelungen auf glänzendem Papier oder Displays. Prüfe, "
         "ob die richtige Scan-Art gewählt ist, oder nimm „Alle Codes“."),
        ("h3", "Code aus einem Foto lesen"),
        "Hast du einen Code fotografiert oder als Bildschirmfoto gespeichert, "
        "kann QR Viewer ihn auch aus dem Bild lesen. Schalte dazu unter "
        "☰ → Einstellungen „Scannen von Foto“ ein. Dann erscheint links neben "
        "der Taschenlampe ein Foto-Symbol. Tippe darauf und wähle ein Bild "
        "aus deinen Fotos.",
        ("img", "photo_scan.png", 5.0,
         "Während der Auswertung zeigt QR Viewer das gewählte Foto."),
        "Sobald du ein Foto antippst, erscheint ein Fenster mit einem "
        "Ladekreis – neue Fotos braucht dein Gerät oft ein paar Sekunden, bis "
        "es sie bereitstellt. Danach siehst du das Foto mit "
        "Fortschrittsbalken, während QR Viewer es auswertet. Findet die App einen Code, öffnet sich die "
        "Ergebnisseite wie nach einem Kamera-Scan. Sie sucht dabei nach "
        "allen Codearten, egal welche Scan-Art gewählt ist. Findet sie "
        "keinen Code, sagt sie dir das.",
        ("note", "Schwierige Codes – etwa eingravierte Codes auf Geräten "
         "oder Codes mit einem Logo in der Mitte – sind auf einem Foto "
         "manchmal schwer zu lesen. QR Viewer probiert deshalb das Foto in "
         "mehreren Größen aus. Klappt es trotzdem nicht, mach ein neues Foto "
         "etwas näher am Code und ohne Spiegelung."),
    ]),
    ("4 Das Ergebnis verstehen", [
        "Nach dem Scannen öffnet sich die Ergebnisseite. Ganz oben steht, "
        "was die App erkannt hat, zum Beispiel „Kontakt“, „WLAN-Zugangsdaten“ "
        "oder „Produktcode“. Darunter siehst du:",
        [
            "**Format:** welche Art von Code gescannt wurde, z. B. „QR-Code“ "
            "oder „EAN-13“",
            "**Host:** bei Links die Adresse der Internetseite, zu der der "
            "Link führt – so erkennst du auf einen Blick, wohin es geht",
            "**die Datenkarte:** die Angaben aus dem Code, übersichtlich mit "
            "Beschriftung, z. B. „Name“, „Telefon“ oder „IBAN“. Mit dem "
            "Kopier-Symbol neben jedem Feld kopierst du genau diese Angabe.",
            "**Rohinhalt:** darunter steht der Inhalt des Codes genau so, wie "
            "er gespeichert ist – Zeichen für Zeichen",
        ],
        ("imgpair", "qr_contact.png", "qr_contact_info.png", 5.6,
         "Links: Ergebnis für eine digitale Visitenkarte. Rechts: Der "
         "Info-Knopf erklärt, was das für Daten sind."),
        "**Der Info-Knopf:** Oben rechts in jeder Datenkarte sitzt ein "
        "kleines „i“. Tippst du darauf, erklärt dir QR Viewer in einfachen "
        "Worten, welche Art von Daten der Code enthält, dass sie nur auf "
        "deinem Gerät gelesen wurden und was passiert, wenn du auf den "
        "Aktionsknopf tippst.",
        "Manche Codes enthalten keine Schrift, sondern „Binärdaten“ – zum "
        "Beispiel elektronische Fahrkarten. QR Viewer zeigt sie als "
        "Zahlenkolonnen (Hex-Ansicht) an. Fahrkarten nach dem VDV-Standard, "
        "etwa das Deutschlandticket, kann die App sogar entschlüsseln und "
        "lesbar anzeigen (siehe Anhang A.32).",
    ]),
    ("5 Aktionen – immer mit Rückfrage", [
        "**Aktionen sind ab Werk ausgeschaltet.** Dann zeigt QR Viewer "
        "Inhalte nur an – kopieren, teilen und den Code anzeigen kannst du "
        "trotzdem. Möchtest du Links direkt aus der App öffnen oder eine "
        "Nummer anrufen, schalte unter ☰ → Einstellungen „Aktionen "
        "aktivieren“ ein (siehe Kapitel 8).",
        "Sind die Aktionen eingeschaltet, findest du unten auf der "
        "Ergebnisseite je nach Inhalt einen Aktionsknopf, zum Beispiel:",
        [
            "**Öffnen …** – öffnet einen Link im Browser",
            "**E-Mail schreiben …**, **Anrufen …**, **SMS schreiben …**",
            "**In Karten zeigen …** – zeigt einen Ort in deiner Karten-App",
            "**Zu Kontakten …**, **Zum Kalender …** – übernimmt eine "
            "Visitenkarte oder einen Termin",
            "**In Authenticator öffnen …** – übergibt einen 2FA-Schlüssel an "
            "deine Authenticator-App",
            "**Online nachschlagen …** – sucht eine Artikel- oder Buchnummer "
            "im Internet",
            "**Sendung verfolgen …** – öffnet die Sendungsverfolgung der "
            "Deutschen Post",
        ],
        "Die drei Punkte „…“ bedeuten: Es kommt noch eine Rückfrage. Bevor "
        "irgendetwas geöffnet wird, zeigt dir QR Viewer genau, was passieren "
        "soll. Erst wenn du „Öffnen“ antippst, geht es weiter. Mit "
        "„Abbrechen“ passiert gar nichts.",
        ("img", "qr_url_confirm.png", 5.0,
         "Die Rückfrage vor dem Öffnen eines Links. Die Werbe-Anhängsel "
         "(utm_…) wurden bereits entfernt."),
        "**Werbe-Anhängsel werden entfernt:** Viele Links enthalten "
        "Zusätze wie `utm_source=…` oder `fbclid=…`. Damit können Firmen "
        "nachverfolgen, woher du kommst. QR Viewer entfernt bekannte "
        "Anhängsel dieser Art, bevor der Link geöffnet wird. In der "
        "Rückfrage siehst du bereits den bereinigten Link.",
        "**Wichtig:** QR Viewer ruft nie selbst jemanden an und verschickt "
        "keine E-Mails oder SMS. Die App öffnet nur die zuständige App "
        "(Telefon, Mail, Nachrichten) mit den vorbereiteten Angaben. "
        "Abschicken musst du immer selbst.",
    ]),
    ("6 Code anzeigen, kopieren und teilen", [
        "**Code anzeigen:** Der kleine Knopf mit dem QR-Code-Symbol ganz "
        "links in der unteren Zeile zeigt den gescannten Code als Grafik in "
        "einem Fenster. So kannst du ihn zum Beispiel mit einem anderen "
        "Gerät scannen. QR Viewer zeichnet den Code wenn möglich im "
        "Originalformat, etwa als EAN-13-Strichcode, Data Matrix oder Aztec. "
        "Formate, die die App nicht zeichnen kann (Micro QR, MaxiCode, GS1 "
        "DataBar), zeigt sie als QR-Code mit gleichem Inhalt und sagt dir das "
        "unter der Grafik.",
        ("img", "qr_url_code.png", 5.0,
         "Der gescannte Link als QR-Code zum Weitergeben."),
        ("note", "Ein angezeigter Code lässt sich von jedem scannen, der "
         "dein Display sieht. Zeige Codes mit WLAN-Passwörtern oder "
         "2FA-Schlüsseln nur, wenn du das wirklich willst."),
        "**Kopieren:** Der Knopf „Kopieren“ legt den ganzen Inhalt in die "
        "Zwischenablage. Von dort kannst du ihn in jede andere App einfügen. "
        "Einzelne Angaben kopierst du mit dem Kopier-Symbol neben dem Feld in "
        "der Datenkarte.",
        "**Teilen:** Das Teilen-Symbol oben rechts öffnet das Teilen-Menü "
        "deines Geräts. Damit kannst du den Inhalt zum Beispiel per "
        "Nachricht verschicken oder in einer Notiz speichern. Was du wohin "
        "teilst, entscheidest du – QR Viewer schickt nichts von sich aus "
        "weg.",
    ]),
    ("7 Der Verlauf", [
        "QR Viewer merkt sich die letzten 25 gescannten Codes. Den Verlauf "
        "öffnest du auf dem Scan-Bildschirm über ☰ → Verlauf.",
        ("img", "history.png", 5.6,
         "Der Verlauf mit Suche, Export und Löschen oben rechts."),
        [
            "**Erneut ansehen:** Tippe auf einen Eintrag, um die "
            "Ergebnisseite wieder zu öffnen.",
            "**Kopieren:** Das Kopier-Symbol rechts kopiert den Inhalt direkt.",
            "**Suchen:** Die Lupe durchsucht Inhalt, Format und Art.",
            "**Einzeln löschen:** Wische einen Eintrag zur Seite. Hast du "
            "dich vertan, tippe auf „Rückgängig“.",
            "**Alles löschen:** Der Papierkorb leert den ganzen Verlauf.",
            "**Exportieren:** Das Teilen-Symbol gibt den Verlauf als Tabelle "
            "(CSV) oder als Datei für Programme (JSON) weiter.",
        ],
        ("note", "Der Verlauf bleibt auf deinem Gerät und wird dort "
         "verschlüsselt gespeichert. Bedenke aber: Er kann "
         "vertrauliche Angaben enthalten, etwa WLAN-Passwörter. Lösche solche "
         "Einträge, wenn du sie nicht mehr brauchst. Geheime Schlüssel für "
         "die Anmeldung in zwei Schritten (2FA) und Medikationspläne "
         "speichert QR Viewer grundsätzlich nicht."),
    ]),
    ("8 Einstellungen", [
        "Die Einstellungen öffnest du auf dem Scan-Bildschirm über "
        "☰ → Einstellungen. Beide Punkte sind ab Werk ausgeschaltet. QR "
        "Viewer merkt sich, was du einstellst.",
        ("img", "settings_crop.png", 8.0, "Die Einstellungen."),
        [
            "**Aktionen aktivieren** – zeigt auf der Ergebnisseite Knöpfe "
            "wie „Öffnen …“, „Anrufen …“ oder „Online nachschlagen …“ (siehe "
            "Kapitel 5). Auch eingeschaltet fragt QR Viewer vor jeder Aktion "
            "nach.",
            "**Scannen von Foto** – zeigt neben der Taschenlampe ein "
            "Foto-Symbol, mit dem du einen Code aus einem Bild liest (siehe "
            "Kapitel 3). QR Viewer bekommt dabei nur das eine Bild, das du "
            "auswählst, und braucht keinen Zugriff auf deine übrigen Fotos. "
            "Deshalb fragt dein Gerät auch nicht nach einer Erlaubnis.",
        ],
    ]),
    ("9 Info und Hilfe", [
        "Über ☰ → Info auf dem Scan-Bildschirm öffnest du den Info-Dialog. Dort "
        "siehst du die Version der App und das Datum, an dem sie erstellt "
        "wurde.",
        ("img", "about_crop.png", 6.0, "Der Info-Dialog."),
        [
            "**Support** öffnet die Seite für Fragen und Fehlermeldungen im "
            "Browser (github.com/thorsten-l/qr_viewer/issues).",
            "**Lizenzen** zeigt die Lizenzen der verwendeten Bausteine.",
            "**Anleitungen** öffnet im Browser die Seite, auf der diese "
            "Anleitung auf Deutsch und Englisch zum Herunterladen liegt "
            "(github.com/thorsten-l/qr_viewer/tree/main/docs).",
        ],
    ]),
    ("10 Datenschutz – so schützt QR Viewer deine Daten", [
        "Datenschutz ist der Kern von QR Viewer. Hier steht verständlich "
        "zusammengefasst, was mit deinen Daten passiert – und was nicht. Die "
        "vollständige Datenschutzerklärung findest du unter "
        "github.com/thorsten-l/qr_viewer/blob/main/PRIVACY.md.",
        ("h3", "Das Wichtigste in Kürze"),
        [
            "QR Viewer sammelt **keine** persönlichen Daten.",
            "Es gibt **kein Benutzerkonto**, **keine Werbung**, **keine "
            "Auswertung deines Verhaltens** (Tracking) und **keine eigenen "
            "Server**.",
            "Codes werden **nur auf deinem Gerät** gelesen und ausgewertet.",
            "Ins Internet geht es nur, wenn du es **ausdrücklich bestätigst**.",
        ],
        ("h3", "Kamera"),
        "Die App braucht die Kamera, um Codes zu lesen. Das Kamerabild wird "
        "nur auf deinem Gerät ausgewertet. Es werden keine Fotos oder Videos "
        "gespeichert oder übertragen. Du kannst den Kamerazugriff jederzeit "
        "in den Einstellungen deines Geräts wieder entziehen.",
        "**Scannen von Foto:** Wählst du ein Foto aus, bekommt QR Viewer nur "
        "dieses eine Bild – nicht deine übrigen Fotos. Es wird nur auf "
        "deinem Gerät ausgewertet und nicht gespeichert. Im Verlauf landet "
        "wie beim Kamera-Scan nur der Inhalt des Codes.",
        ("h3", "Was auf deinem Gerät gespeichert wird"),
        "Gespeichert werden nur die Inhalte der letzten 25 Scans (der "
        "Verlauf) sowie die zuletzt gewählte Scan-Art und Zoomstufe. Diese "
        "Daten bleiben auf deinem Gerät. Du kannst einzelne Einträge oder "
        "den ganzen Verlauf jederzeit löschen. Löschst du die App, sind auch "
        "alle ihre Daten weg.",
        "**Der Verlauf ist verschlüsselt** (AES-256). Den Schlüssel erzeugt "
        "die App bei der Installation zufällig. Er liegt nur im "
        "Schlüsselbund deines iPhones bzw. im Android Keystore, wird nicht "
        "mit iCloud abgeglichen und kommt in keine Sicherung.",
        "**Sicherungen:** Unter Android ist QR Viewer von der "
        "Google-Sicherung ausgenommen. Eine iCloud- oder Gerätesicherung "
        "unter iOS kann den Verlauf enthalten, aber nur verschlüsselt – "
        "ohne den Schlüssel ist er nicht lesbar. Stellst du eine Sicherung "
        "auf einem neuen Gerät wieder her, beginnt der Verlauf deshalb leer.",
        ("h3", "Besonders schützenswerte Inhalte"),
        [
            "**Schlüssel für die Anmeldung in zwei Schritten (2FA)** werden "
            "nie im Verlauf gespeichert. Die Ergebnisseite weist dich darauf "
            "hin.",
            "**Medikationspläne** (der Code auf dem bundeseinheitlichen "
            "Medikationsplan vom Arzt oder der Apotheke) enthalten "
            "Gesundheitsdaten. QR Viewer zeigt sie nur an und speichert sie "
            "nie im Verlauf. Die Ergebnisseite weist dich darauf hin.",
            "**WLAN-Passwörter** stehen wie jeder andere Inhalt im Verlauf, "
            "bis du ihn löschst.",
            "**Einrichtungscodes von Smart-Home-Geräten** (Matter) zeigt die "
            "App nur an. Sie richtet kein Gerät ein und schickt nichts an "
            "Hersteller oder Home-Apps. Auch diese Codes stehen im Verlauf, "
            "bis du sie löschst.",
            "**Fahrkarten** (z. B. Deutschlandticket) werden nur auf deinem "
            "Gerät entschlüsselt. Den Namen zeigt die App so an, wie er im "
            "Ticket steht – je nach Ticket ausgeschrieben oder verkürzt "
            "(z. B. „G…e M…n“). Zum Prüfen der Echtheit "
            "nutzt sie öffentlich bekannte Schlüssel, die in der App "
            "mitgeliefert werden – dafür ist keine Internetverbindung nötig.",
            "**Überweisungsdaten** (GiroCode) werden nur angezeigt. QR Viewer "
            "überweist kein Geld und gibt die Daten nicht an Banken weiter.",
        ],
        ("h3", "Wann Daten dein Gerät verlassen"),
        "Nur wenn du die Aktionen eingeschaltet hast, selbst eine Aktion "
        "auslöst und die Rückfrage bestätigst:",
        [
            "**Link öffnen:** Dein Browser ruft die Internetseite auf. Diese "
            "Seite sieht – wie jede Internetseite – deine Internetadresse. "
            "Bekannte Werbe-Anhängsel entfernt QR Viewer vorher.",
            "**Online nachschlagen:** Eine Artikelnummer wird an die "
            "Suchmaschine DuckDuckGo geschickt, eine Buchnummer (ISBN) an "
            "Open Library.",
            "**Sendung verfolgen:** Die Sendungsnummer geht an die Deutsche "
            "Post.",
            "**E-Mail, Anrufen, SMS, Karte, Kontakte, Kalender, "
            "Authenticator:** Die Angaben gehen an die jeweilige App auf "
            "deinem Gerät. Was dort damit passiert, bestimmt diese App.",
            "**Kopieren, Teilen, Exportieren:** Nur wenn du es antippst, und "
            "nur an die App, die du auswählst.",
        ],
        "Für jede aufgerufene Internetseite oder App gelten deren eigene "
        "Datenschutzregeln. Der Info-Knopf in jeder Datenkarte erklärt dir "
        "vorher, wohin die Daten gehen würden.",
        ("h3", "Besonderheit bei Android"),
        "Auf Android-Geräten nutzt QR Viewer zum Erkennen der Codes eine "
        "Programmbibliothek von Google („ML Kit“). Auch sie arbeitet auf "
        "deinem Gerät, Kamerabilder werden nicht an Google geschickt. ML Kit "
        "kann aber technische Angaben an Google übermitteln, etwa "
        "Gerätemodell, Android-Version, App-Version und Messwerte zur "
        "Geschwindigkeit. Auf iPhone und iPad erkennt Apples eingebaute "
        "Technik die Codes, ohne dass ein anderer Anbieter beteiligt ist.",
        ("h3", "Deine Rechte"),
        "Da der Entwickler keine persönlichen Daten von dir erhält, gibt es "
        "bei ihm auch nichts, worüber er Auskunft geben, was er berichtigen "
        "oder löschen könnte. Bei Fragen zum Datenschutz kannst du dich an "
        "t.ludewig@gmail.com wenden. Außerdem darfst du dich bei einer "
        "Datenschutz-Aufsichtsbehörde beschweren.",
        ("h3", "Tipps für sicheres Scannen"),
        [
            "Achte auf den **Host**: Passt die Internetadresse zu dem, was du "
            "erwartest? Ein Parkautomat der Stadt sollte nicht auf eine "
            "unbekannte Adresse verweisen.",
            "Sieh genau hin, ob ein Code **überklebt** wurde – etwa auf "
            "Parkautomaten, Ladesäulen oder Plakaten.",
            "Gib nach dem Scannen **keine Passwörter oder Kontodaten** auf "
            "einer Seite ein, der du nicht sicher vertraust.",
            "Prüfe bei einer **Überweisung** jede Angabe, bevor du sie in "
            "deiner Banking-App bestätigst.",
            "Gib Codes mit **WLAN-Passwörtern** oder **2FA-Schlüsseln** nicht "
            "weiter und lösche sie aus dem Verlauf, wenn du sie nicht mehr "
            "brauchst.",
        ],
    ]),
    ("11 Häufige Fragen", [
        "**Die App erkennt einen Code nicht.** Wähle „Alle Codes“, halte "
        "das Gerät ruhig und etwas weiter weg und sorge für gutes Licht "
        "(Taschenlampe). Bei sehr kleinen Codes hilft eine höhere "
        "Zoomstufe. Manche seltenen Codearten kann nicht jedes Gerät lesen "
        "(siehe Anhang). Alternativ kannst du den Code fotografieren und mit "
        "„Scannen von Foto“ aus dem Bild lesen (siehe Kapitel 3).",
        "**Ich sehe keinen Knopf wie „Öffnen …“.** Die Aktionen sind ab Werk "
        "ausgeschaltet. Schalte sie unter ☰ → Einstellungen „Aktionen "
        "aktivieren“ ein.",
        "**Ich sehe nur ein schwarzes Bild.** Wahrscheinlich fehlt der "
        "Kamerazugriff. Erlaube ihn in den Einstellungen deines Geräts unter "
        "„QR Viewer“.",
        "**Beim Tippen auf eine Aktion passiert nichts.** Dann ist auf "
        "deinem Gerät keine passende App installiert, etwa keine "
        "Authenticator-App. QR Viewer zeigt dann „Keine passende App "
        "gefunden“.",
        "**Wie ändere ich die Sprache?** QR Viewer folgt der Sprache deines "
        "Geräts. Auf Android ab Version 13 und auf dem iPhone kannst du in "
        "den Einstellungen auch nur für QR Viewer eine andere Sprache "
        "wählen.",
        "**Kostet die App etwas?** Nein. Es gibt auch keine Käufe in der "
        "App und keine Werbung.",
    ]),
]

APPENDIX_INTRO = [
    "Auf den folgenden Seiten findest du jede Art von Code, die QR Viewer "
    "lesen kann – jeweils auf einer eigenen Seite. Alle Beispielcodes sind "
    "echt und lassen sich scannen: Halte einfach die Kamera auf den Code "
    "auf dem Bildschirm oder auf dem Ausdruck und probiere es aus.",
    "Auf jeder Seite steht, was für ein Code es ist, wo er dir im Alltag "
    "begegnet, was im Beispiel steckt, wie QR Viewer ihn anzeigt und was du "
    "damit tun kannst. Das Bild rechts ist die Ergebnisseite der App.",
    "Alle Namen, Nummern und Adressen in den Beispielen sind erfunden – mit "
    "zwei Ausnahmen: Der Ort ist das echte Rathaus in Wolfenbüttel, und die "
    "erste Fahrkarte (A.32) ist ein offizielles Muster-Ticket auf den Namen "
    "Geraldine Mustermann. Die zweite Fahrkarte (A.33) ist ein selbst "
    "gebautes Test-Ticket.",
    ("note", "Die Ergebnisseiten im Anhang sind mit eingeschalteten "
     "Aktionen aufgenommen (☰ → Einstellungen → „Aktionen aktivieren“). "
     "Sind sie aus, fehlt nur der Aktionsknopf unten rechts."),
    ("note", "Zwei Codearten (Micro-QR-Code und GS1 DataBar) kann nur die "
     "Version für iPhone und iPad lesen, weil die Erkennungstechnik von "
     "Android sie nicht unterstützt. Das steht auf der jeweiligen Seite."),
]

ALL = "iPhone, iPad und Android"
APPLE = "nur iPhone und iPad"

# Eine Seite pro Beispiel. Schlüssel = id aus examples.json.
PAGES = {
    "qr_text": dict(
        title="QR-Code mit Text", mode="QR-Code oder Alle Codes", devices=ALL,
        what="Der **QR-Code** ist das bekannte Quadrat mit drei großen "
        "Ecken-Markierungen. Er wurde 1994 in Japan erfunden, um Autoteile "
        "zu kennzeichnen, und kann bis zu einigen tausend Zeichen speichern. "
        "Selbst wenn ein Teil verschmutzt oder beschädigt ist, lässt er sich "
        "meist noch lesen. Der einfachste Inhalt ist ganz normaler Text.",
        where="Auf Schildern in Museen, an Sehenswürdigkeiten, auf "
        "Verpackungen oder als kleine Botschaft auf Karten.",
        example="Willkommen im Rathaus Wolfenbüttel! Die Bürgerberatung "
        "findest du im Erdgeschoss.",
        app="QR Viewer zeigt den Text groß und gut lesbar an. Weil Text "
        "nichts auslösen kann, gibt es keine Datenkarte und keinen "
        "Aktionsknopf.",
        do="Text kopieren oder teilen.",
        care="Text ist harmlos. Steht darin aber eine Internetadresse "
        "oder Telefonnummer, prüfe sie, bevor du sie abtippst."),
    "qr_url": dict(
        title="QR-Code mit Link", mode="QR-Code oder Alle Codes", devices=ALL,
        what="Ein **Link** (auch URL oder Internetadresse) führt zu einer "
        "Seite im Internet. Das ist der häufigste Inhalt von QR-Codes.",
        where="Auf Plakaten, Speisekarten, Flyern, Parkautomaten, "
        "Ladesäulen, Rechnungen und in Zeitschriften.",
        example="https://www.wolfenbuettel.de/?utm_source=plakat&"
        "utm_campaign=herbst – ein Link zur Internetseite der Stadt "
        "Wolfenbüttel mit zwei Werbe-Anhängseln (utm_…).",
        app="Unter „Host“ steht die Adresse der Internetseite "
        "(www.wolfenbuettel.de). Darunter siehst du den vollständigen Link. "
        "Geöffnet wird er erst über „Öffnen …“ und nach einer Rückfrage. "
        "Dabei entfernt QR Viewer die Werbe-Anhängsel.",
        do="Link nach Rückfrage im Browser öffnen, kopieren, teilen.",
        care="Prüfe den Host! Betrüger nutzen Adressen, die echten ähneln "
        "(z. B. „wolfenbuettel-parken.info“). Im Zweifel öffne den Link "
        "nicht."),
    "qr_bookmark": dict(
        title="QR-Code mit Lesezeichen (MEBKM)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="Ein **Lesezeichen** ist ein Link mit einem Namen dafür. Das "
        "Format MEBKM stammt vom japanischen Mobilfunkanbieter NTT Docomo; "
        "dort konnten Handys den Link direkt als Lesezeichen speichern. "
        "Viele Scanner-Apps erzeugen es bis heute.",
        where="Auf Plakaten, Flyern und Visitenkarten, vor allem bei Codes "
        "aus älteren oder japanischen QR-Code-Generatoren.",
        example="Das Lesezeichen „Stadt Wolfenbüttel“ mit dem Link "
        "https://www.wolfenbuettel.de/.",
        app="Die Datenkarte „Lesezeichen“ zeigt den Namen und den Link, "
        "darüber steht der Host. Ein Lesezeichen ohne Link zeigt nur den "
        "Namen; dann gibt es keinen Öffnen-Knopf.",
        do="„Öffnen …“ öffnet den Link nach Rückfrage im Browser, wie bei "
        "einem normalen Link. Speichern kannst du ihn dort selbst als "
        "Lesezeichen.",
        care="Der Name kann alles behaupten – entscheidend ist der Host. "
        "Prüfe ihn, bevor du den Link öffnest."),
    "qr_email": dict(
        title="QR-Code mit E-Mail", mode="QR-Code oder Alle Codes",
        devices=ALL,
        what="Der Code enthält eine **E-Mail-Adresse**, oft schon mit Betreff "
        "und Text. So musst du nichts abtippen.",
        where="Auf Visitenkarten, Aushängen („Schreib uns!“) oder "
        "Kontaktformularen auf Papier.",
        example="E-Mail an info@example.com mit dem Betreff „Anfrage“ und "
        "dem Text „Hallo, ich habe eine Frage.“",
        app="Die Datenkarte zeigt Empfänger, Betreff und Nachricht "
        "getrennt an. Jede Angabe lässt sich einzeln kopieren.",
        do="Über „E-Mail schreiben …“ öffnet sich deine Mail-App mit allen "
        "Angaben. Abgeschickt wird erst, wenn du selbst auf „Senden“ "
        "tippst.",
        care="Prüfe die Empfängeradresse, bevor du persönliche Angaben "
        "verschickst."),
    "qr_phone": dict(
        title="QR-Code mit Telefonnummer", mode="QR-Code oder Alle Codes",
        devices=ALL,
        what="Der Code enthält eine **Telefonnummer**.",
        where="Auf Werbeschildern, Firmenfahrzeugen, Notfall-Aushängen oder "
        "Visitenkarten.",
        example="+49 30 23125456 (eine für Beispiele reservierte Nummer).",
        app="Die Datenkarte zeigt die Rufnummer an.",
        do="„Anrufen …“ öffnet nach Rückfrage die Telefon-App mit der "
        "Nummer. QR Viewer ruft nie selbst an – den Anruf startest du in der "
        "Telefon-App.",
        care="Achte auf teure Sondernummern (z. B. 0900 oder 0137) und "
        "unbekannte Auslandsvorwahlen."),
    "qr_sms": dict(
        title="QR-Code mit SMS", mode="QR-Code oder Alle Codes", devices=ALL,
        what="Der Code enthält eine **Telefonnummer und eine vorbereitete "
        "SMS**.",
        where="Bei Gewinnspielen, Spendenaktionen oder Rückruf-Bitten.",
        example="SMS an +49 30 23125456 mit dem Text „Bitte ruf mich "
        "zurück.“",
        app="Die Datenkarte zeigt Rufnummer und Nachricht.",
        do="„SMS schreiben …“ öffnet nach Rückfrage deine Nachrichten-App. "
        "Die SMS geht erst raus, wenn du sie selbst abschickst.",
        care="SMS an Kurzwahlnummern können Geld kosten oder ein Abo "
        "auslösen. Lies den Text, bevor du sendest."),
    "qr_geo": dict(
        title="QR-Code mit Ort (Geo-Position)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="Der Code enthält einen **Ort auf der Erde**, angegeben als "
        "Breiten- und Längengrad – so wie bei einem Navigationsgerät.",
        where="Auf Einladungen, Wanderkarten, Infotafeln oder "
        "Veranstaltungsplakaten („So findest du uns“).",
        example="Das Rathaus in Wolfenbüttel am Stadtmarkt: Breitengrad "
        "52,16271, Längengrad 10,53441.",
        app="Die Datenkarte zeigt Breitengrad, Längengrad und den Namen des "
        "Ortes.",
        do="„In Karten zeigen …“ öffnet nach Rückfrage deine Karten-App "
        "(z. B. Apple Karten oder Google Maps) an genau diesem Punkt. Von "
        "dort kannst du dich hinführen lassen.",
        care="Die Karten-App erfährt, welchen Ort du dir ansiehst."),
    "qr_contact": dict(
        title="QR-Code mit Kontakt (Visitenkarte)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="Eine **digitale Visitenkarte** (Fachbegriff „vCard“). Sie kann "
        "Name, Firma, Telefonnummern, E-Mail, Adresse und Webseite "
        "enthalten. QR Viewer versteht auch die kürzeren Formen MECARD und "
        "BIZCARD.",
        where="Auf Visitenkarten, Namensschildern, Messeständen und in "
        "E-Mail-Signaturen.",
        example="Geraldine Mustermann, Projektleiterin bei der Beispiel GmbH, "
        "mit Telefon, E-Mail, Webseite und der Adresse Stadtmarkt 3–6, "
        "38300 Wolfenbüttel.",
        app="Jede Angabe steht beschriftet in der Datenkarte und lässt sich "
        "einzeln kopieren.",
        do="„Zu Kontakten …“ übergibt die Visitenkarte über das "
        "Teilen-Menü an deine Kontakte-App. Dort kannst du alles prüfen, "
        "bevor du speicherst.",
        care="Speichere nur Kontakte, die du wirklich haben möchtest."),
    "qr_event": dict(
        title="QR-Code mit Termin", mode="QR-Code oder Alle Codes",
        devices=ALL,
        what="Ein **Termin** mit Titel, Beginn, Ende, Ort und Beschreibung "
        "(Fachbegriff „iCalendar“).",
        where="Auf Einladungen, Veranstaltungsplakaten, Arzt- oder "
        "Behördenterminen.",
        example="„Stadtführung Wolfenbüttel“ am 7. November 2026 von "
        "14:00 bis 16:00 Uhr, Treffpunkt vor dem Haupteingang des Rathauses.",
        app="Die Datenkarte zeigt Titel, Beginn, Ende, Ort und "
        "Beschreibung – Datum und Uhrzeit im gewohnten deutschen Format.",
        do="„Zum Kalender …“ übergibt den Termin über das Teilen-Menü an "
        "deine Kalender-App.",
        care="Prüfe Datum und Uhrzeit, bevor du den Termin speicherst."),
    "qr_wifi": dict(
        title="QR-Code mit WLAN-Zugang", mode="QR-Code oder Alle Codes",
        devices=ALL,
        what="Die **Zugangsdaten für ein WLAN**: Name des Netzes, "
        "Verschlüsselung und Passwort.",
        where="In Cafés, Hotels, Ferienwohnungen, Arztpraxen oder auf der "
        "Rückseite deines Internet-Routers.",
        example="Netzwerk „Gaeste-WLAN“, Verschlüsselung WPA, Passwort "
        "„Sommer-2026!“.",
        app="Die Datenkarte zeigt Netzwerkname, Passwort und "
        "Verschlüsselung. Das Passwort kannst du einzeln kopieren und in den "
        "WLAN-Einstellungen einfügen.",
        do="Passwort kopieren, dann in den Einstellungen deines Geräts das "
        "Netz auswählen und das Passwort einfügen.",
        care="Wer diesen Code sieht, kann das Netz benutzen. Der Code steht "
        "im Verlauf, bis du ihn löschst – lösche ihn, wenn du ihn nicht mehr "
        "brauchst."),
    "qr_payment": dict(
        title="QR-Code mit Überweisung (GiroCode)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="Ein **GiroCode** (auch EPC-QR-Code) enthält alles für eine "
        "Überweisung: Empfänger, IBAN, BIC, Betrag und Verwendungszweck.",
        where="Auf Rechnungen, Spendenaufrufen, Mahnungen oder "
        "Vereinsbeiträgen.",
        example="12,50 € an den „Muster-Verein e.V.“, IBAN DE02 1203 0000 "
        "0000 2020 51, Verwendungszweck „Mitgliedsbeitrag 2026“.",
        app="Die Datenkarte zeigt Empfänger, IBAN, BIC, Betrag (mit "
        "Euro-Zeichen) und Verwendungszweck. Jede Angabe lässt sich einzeln "
        "kopieren.",
        do="QR Viewer überweist kein Geld. Du kannst die Angaben kopieren "
        "oder den Code direkt mit der Scan-Funktion deiner Banking-App "
        "einlesen.",
        care="Prüfe vor dem Bezahlen jede Angabe, vor allem Empfänger und "
        "IBAN. Betrüger verschicken gefälschte Rechnungen mit eigenem "
        "GiroCode."),
    "qr_otp": dict(
        title="QR-Code mit Einmalpasswort (2FA)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="Ein **geheimer Schlüssel für die Anmeldung in zwei Schritten** "
        "(2FA). Eine Authenticator-App erzeugt damit alle 30 Sekunden einen "
        "neuen sechsstelligen Anmeldecode.",
        where="Beim Einrichten der Zwei-Faktor-Anmeldung bei Online-Diensten, "
        "Banken, E-Mail-Anbietern oder Firmenkonten.",
        example="Ein Schlüssel für das „Beispielkonto“ von "
        "geraldine.mustermann@example.com.",
        app="Die Datenkarte zeigt Anbieter, Konto, Schlüssel und die "
        "technischen Einstellungen. Oben steht der Hinweis „2FA-Codes "
        "werden nicht im Verlauf gespeichert“.",
        do="„In Authenticator öffnen …“ übergibt den Schlüssel nach "
        "Rückfrage an deine Authenticator-App.",
        care="Dieser Schlüssel ist so geheim wie ein Passwort. Zeige ihn "
        "niemandem und mache keine Bildschirmfotos davon. QR Viewer "
        "speichert ihn deshalb nie im Verlauf."),
    "qr_json": dict(
        title="QR-Code mit JSON-Daten", mode="QR-Code oder Alle Codes",
        devices=ALL,
        what="**JSON** ist ein Format, in dem Computerprogramme Daten "
        "austauschen: Namen und Werte in geschweiften und eckigen Klammern.",
        where="Auf Geräte-Etiketten, in Lagerhaltung, bei Eintrittskarten "
        "oder technischen Anleitungen.",
        example="Angaben zur Stadtbücherei Wolfenbüttel mit Öffnungstagen "
        "(Di, Do, Sa).",
        app="QR Viewer rückt die Daten übersichtlich ein, damit du sie "
        "lesen kannst. Mit den Daten passiert nichts weiter.",
        do="Kopieren oder teilen.",
        care="Nichts Besonderes – JSON kann nichts auslösen."),
    "qr_matter": dict(
        title="QR-Code eines Smart-Home-Geräts (Matter)",
        mode="QR-Code oder Alle Codes", devices=ALL,
        what="**Matter** ist ein gemeinsamer Standard für Smart-Home-Geräte "
        "wie Lampen, Steckdosen, Thermostate oder Sensoren – unterstützt von "
        "Apple, Google, Amazon, Samsung und vielen Herstellern. Der QR-Code "
        "beginnt immer mit „MT:“ und enthält alles, was eine Smart-Home-App "
        "zum Einrichten des Geräts braucht.",
        where="Auf dem Gerät selbst, auf der Verpackung oder auf einem "
        "Kärtchen in der Anleitung von Matter-fähigen Smart-Home-Geräten.",
        example="Der Beispielcode aus der Matter-Spezifikation: ein "
        "Testgerät (Hersteller-ID 0xFFF1, für Tests reserviert) mit dem "
        "Einrichtungscode 20202021, erreichbar über Bluetooth LE.",
        app="Die Datenkarte zeigt den **manuellen Kopplungscode** "
        "(3497-011-2332), den Einrichtungscode (PIN), Hersteller- und "
        "Produkt-ID, den Diskriminator, über welche Verbindung sich das "
        "Gerät einrichten lässt und ob vorher z. B. eine Taste gedrückt "
        "werden muss.",
        do="QR Viewer richtet das Gerät nicht selbst ein. Scanne den Code in "
        "deiner Smart-Home-App (z. B. Apple Home, Google Home) – oder tippe "
        "dort den manuellen Kopplungscode ein, wenn das Scannen nicht klappt. "
        "Mit dem Kopier-Symbol neben dem Feld kannst du ihn übernehmen.",
        care="Wer diesen Code hat, kann das Gerät koppeln, solange es im "
        "Einrichtungsmodus ist. Zeige ihn nicht herum, und klebe den "
        "Aufkleber nicht sichtbar nach außen."),
    "microqr": dict(
        title="Micro-QR-Code", mode="Alle Codes", devices=APPLE,
        what="Der **Micro-QR-Code** ist die kleine Schwester des QR-Codes: "
        "nur eine Ecken-Markierung statt drei. Er passt auf sehr kleine "
        "Flächen, speichert aber nur wenige Zeichen.",
        where="Auf elektronischen Bauteilen, Platinen, kleinen Ersatzteilen "
        "oder medizinischen Produkten.",
        example="WF-2026",
        app="Der Inhalt wird als Text angezeigt. Bei Links, Telefonnummern "
        "usw. gilt dasselbe wie beim normalen QR-Code. Als Format steht dort "
        "allerdings „Unbekannt“: Das iPhone erkennt den Code zwar, die App "
        "erfährt aber nicht, dass es ein Micro-QR-Code ist. Am Inhalt ändert "
        "das nichts.",
        do="Kopieren oder teilen.",
        care="Stelle die Scan-Art „Alle Codes“ ein – bei „QR-Code“ wird ein "
        "Micro-QR-Code nicht erkannt. Android kann diesen Code gar nicht "
        "lesen, weil die Erkennung von Google ihn nicht unterstützt."),
    "ean13": dict(
        title="EAN-13 – Produktnummer", mode="Barcode oder Alle Codes",
        devices=ALL,
        what="Der **EAN-13** ist der Strichcode, den du von fast jedem "
        "Produkt im Supermarkt kennst. Er enthält eine 13-stellige "
        "Artikelnummer (Fachbegriff GTIN). Die letzte Ziffer ist eine "
        "Prüfziffer, mit der sich Lesefehler erkennen lassen.",
        where="Auf Lebensmitteln, Drogerieartikeln, Elektronik – an der "
        "Kasse wird er gescannt.",
        example="4006381333931 – eine Artikelnummer aus Deutschland.",
        app="Die Datenkarte zeigt die Artikelnummer, ob die Prüfziffer "
        "stimmt („gültig“) und in welchem Land die Nummer vergeben wurde "
        "(hier: Deutschland). Die Nummer verrät nicht den Produktnamen, den "
        "Preis oder die Zutaten – das steht nicht im Code.",
        do="„Online nachschlagen …“ sucht die Nummer nach Rückfrage mit "
        "der Suchmaschine DuckDuckGo. Kopieren und Teilen geht natürlich "
        "auch.",
        care="Das Land zeigt nur, wo die Nummer vergeben wurde, nicht "
        "unbedingt, wo das Produkt hergestellt wurde. Beim Nachschlagen "
        "erfährt DuckDuckGo, wonach du suchst."),
    "ean13_isbn": dict(
        title="EAN-13 – Buchnummer (ISBN)", mode="Barcode oder Alle Codes",
        devices=ALL,
        what="Bücher tragen einen EAN-13, der mit 978 oder 979 beginnt: "
        "Das ist die **ISBN**, die internationale Buchnummer. Zeitschriften "
        "haben einen Code mit 977 am Anfang, die **ISSN**.",
        where="Auf der Rückseite von Büchern, Zeitschriften und Noten.",
        example="978-3-16-148410-0 – eine bekannte Beispiel-ISBN.",
        app="Die Datenkarte zeigt die ISBN, die ältere zehnstellige Form "
        "(ISBN-10) und ob die Prüfziffer stimmt. Titel und Autor stehen "
        "nicht im Code.",
        do="„Online nachschlagen …“ sucht das Buch nach Rückfrage bei Open "
        "Library, einem freien Bücherverzeichnis im Internet.",
        care="Open Library erfährt, nach welchem Buch du suchst."),
    "ean8": dict(
        title="EAN-8 – kurze Produktnummer", mode="Barcode oder Alle Codes",
        devices=ALL,
        what="Der **EAN-8** ist die kurze Form des EAN-13 mit nur 8 Ziffern – "
        "für Produkte, auf denen wenig Platz ist.",
        where="Auf kleinen Verpackungen wie Kaugummi, Lippenpflege oder "
        "Gewürzen.",
        example="40170725",
        app="Wie beim EAN-13: Artikelnummer, Prüfziffer und Land der "
        "Vergabe.",
        do="Online nachschlagen (DuckDuckGo), kopieren, teilen.",
        care="Wie beim EAN-13."),
    "upca": dict(
        title="UPC-A – amerikanische Produktnummer",
        mode="Barcode oder Alle Codes", devices=ALL,
        what="Der **UPC-A** ist das amerikanische Gegenstück zum EAN-13 mit "
        "12 Ziffern. Er ist vor allem in den USA und Kanada verbreitet.",
        where="Auf Produkten aus Nordamerika, z. B. importierten "
        "Lebensmitteln, Spielen oder Elektronik.",
        example="036000291452",
        app="Die Datenkarte zeigt die Artikelnummer, ob die Prüfziffer "
        "stimmt, und das Land der Vergabe (USA und Kanada). Auf iPhone und "
        "iPad meldet das Gerät diesen Code als EAN-13 mit einer führenden "
        "0 – der Inhalt ist derselbe.",
        do="Online nachschlagen (DuckDuckGo), kopieren, teilen.",
        care="Wie beim EAN-13."),
    "upce": dict(
        title="UPC-E – kurze amerikanische Produktnummer",
        mode="Barcode oder Alle Codes", devices=ALL,
        what="Der **UPC-E** ist eine verkürzte Form des UPC-A für kleine "
        "Verpackungen. Ausgelassene Nullen werden beim Lesen wieder "
        "ergänzt.",
        where="Auf kleinen Produkten aus Nordamerika, z. B. Getränkedosen.",
        example="01234565 – ausgeschrieben 012345000065.",
        app="Die Datenkarte zeigt die Nummer und ob die Prüfziffer stimmt. "
        "Dafür ergänzt QR Viewer intern die ausgelassenen Nullen.",
        do="Online nachschlagen (DuckDuckGo), kopieren, teilen.",
        care="Wie beim EAN-13."),
    "itf14": dict(
        title="ITF-14 – Versandkarton", mode="Barcode oder Alle Codes",
        devices=ALL,
        what="Der **ITF-14** kennzeichnet nicht ein einzelnes Produkt, "
        "sondern einen Karton oder eine Palette mit mehreren Stück. Er hat "
        "14 Ziffern und oft einen dicken Rahmen.",
        where="Auf Umkartons und Transportverpackungen im Lager oder im "
        "Getränkemarkt.",
        example="14006381333938 – ein Karton mit dem Produkt aus dem "
        "EAN-13-Beispiel.",
        app="Die Datenkarte zeigt die 14-stellige Artikelnummer, die "
        "Prüfziffer und das Land der Vergabe.",
        do="Online nachschlagen (DuckDuckGo), kopieren, teilen.",
        care="Nichts Besonderes."),
    "code128": dict(
        title="Code 128", mode="Barcode oder Alle Codes", devices=ALL,
        what="Der **Code 128** ist ein sehr verbreiteter Strichcode, der "
        "Buchstaben, Ziffern und Zeichen speichern kann – kompakt und "
        "zuverlässig.",
        where="Auf Paketaufklebern, Lieferscheinen, Lagerregalen, "
        "Bibliotheksbüchern und Rezepten.",
        example="QRV-2026-0001 – zum Beispiel eine Lieferscheinnummer.",
        app="Der Inhalt wird als Text angezeigt.",
        do="Kopieren oder teilen, z. B. um eine Sendungs- oder "
        "Auftragsnummer weiterzugeben.",
        care="Nichts Besonderes."),
    "code39": dict(
        title="Code 39", mode="Barcode oder Alle Codes", devices=ALL,
        what="Der **Code 39** ist einer der ältesten Strichcodes. Er kann "
        "Großbuchstaben, Ziffern und einige Zeichen speichern, braucht dafür "
        "aber viel Platz.",
        where="Auf Werksausweisen, Inventaraufklebern, in Industrie, Behörden "
        "und im Gesundheitswesen.",
        example="WF-RATHAUS – zum Beispiel ein Inventaraufkleber.",
        app="Der Inhalt wird als Text angezeigt.",
        do="Kopieren oder teilen.",
        care="Nichts Besonderes."),
    "code93": dict(
        title="Code 93", mode="Barcode oder Alle Codes", devices=ALL,
        what="Der **Code 93** ist eine kompaktere Weiterentwicklung des "
        "Code 39 mit eingebauter Fehlerprüfung.",
        where="In Logistik, Lagerverwaltung und auf Etiketten der "
        "kanadischen Post.",
        example="INVENTAR 4711",
        app="Der Inhalt wird als Text angezeigt.",
        do="Kopieren oder teilen.",
        care="Nichts Besonderes."),
    "codabar": dict(
        title="Codabar", mode="Barcode oder Alle Codes", devices=ALL,
        what="**Codabar** ist ein einfacher, alter Strichcode für Ziffern. "
        "Am Anfang und Ende steht je ein Buchstabe (A bis D) als "
        "Start- und Stoppzeichen.",
        where="Auf Bibliotheksausweisen, Blutkonserven, Laborproben und "
        "Frachtbriefen.",
        example="A123456789B – zum Beispiel eine Ausweisnummer.",
        app="Der Inhalt wird als Text angezeigt, einschließlich Start- und "
        "Stoppzeichen.",
        do="Kopieren oder teilen.",
        care="Nichts Besonderes."),
    "itf": dict(
        title="ITF (Interleaved 2 of 5)", mode="Alle Codes", devices=ALL,
        what="**ITF** speichert Ziffern paarweise ineinander verschränkt und "
        "ist dadurch sehr kompakt. Der ITF-14 auf Versandkartons ist eine "
        "feste Form davon; der allgemeine ITF kann beliebig viele "
        "Ziffernpaare enthalten.",
        where="In Lagern, auf Paletten, Kartons und in der Industrie.",
        example="12345678",
        app="Der Inhalt wird als Text angezeigt. Diese allgemeine Form "
        "liest QR Viewer nur in der Scan-Art „Alle Codes“.",
        do="Kopieren oder teilen.",
        care="Nichts Besonderes."),
    "databar": dict(
        title="GS1 DataBar", mode="Alle Codes", devices=APPLE,
        what="**GS1 DataBar** ist ein schmaler Strichcode für Artikelnummern, "
        "der auch Zusatzangaben wie Gewicht oder Mindesthaltbarkeit "
        "aufnehmen kann.",
        where="Auf Obst und Gemüse (Aufkleber), Frischfleisch, Käse und "
        "Gutscheinen.",
        example="(01)04006381333931 – die „(01)“ bedeutet: Jetzt folgt eine "
        "Artikelnummer.",
        app="Der Inhalt wird als Text angezeigt.",
        do="Kopieren oder teilen.",
        care="Android kann diesen Code nicht lesen, weil die Erkennung von "
        "Google ihn nicht unterstützt."),
    "datamatrix_post": dict(
        title="Data Matrix – Briefmarke der Deutschen Post",
        mode="Data Matrix oder Alle Codes", devices=ALL,
        what="**Data Matrix** ist ein kleiner quadratischer oder "
        "rechteckiger Code aus Punkten mit einem durchgehenden Rand auf zwei "
        "Seiten. Er speichert viel auf wenig Fläche. Die Deutsche Post druckt "
        "ihn auf Briefmarken und Internetmarken („Matrixcode“).",
        where="Auf Briefmarken und Internetmarken, Paketaufklebern, "
        "Medikamentenpackungen und elektronischen Bauteilen.",
        example="Ein nachgebauter Briefmarken-Code mit der erfundenen "
        "Sendungsnummer A001234567300123456C.",
        app="QR Viewer erkennt den Code der Deutschen Post und berechnet "
        "daraus die Sendungsnummer. Darunter stehen die Rohdaten als "
        "Zahlenkolonnen. Andere Data-Matrix-Codes mit Text werden wie "
        "QR-Codes ausgewertet.",
        do="„Sendung verfolgen …“ öffnet nach Rückfrage die "
        "Sendungsverfolgung der Deutschen Post. (Die Beispielnummer findet "
        "sie natürlich nicht.)",
        care="Bei der Sendungsverfolgung erfährt die Deutsche Post die "
        "Sendungsnummer."),
    "datamatrix_amazon": dict(
        title="Data Matrix – Amazon-Transparency-Code",
        mode="Data Matrix oder Alle Codes", devices=ALL,
        what="Ein **Echtheitscode** von Amazon aus dem Programm "
        "„Transparency“. Markenhersteller drucken ihn auf jede einzelne "
        "Packung, um Fälschungen zu erschweren. Er beginnt mit „AZ:“; danach "
        "folgt eine zufällige Seriennummer, die es nur einmal gibt.",
        where="Auf Verpackungen von Markenprodukten, die über Amazon verkauft "
        "werden, meist als kleiner Data-Matrix-Code neben einem „T“-Logo.",
        example="Ein Code mit der erfundenen Seriennummer "
        "QX7K2M9PL4T8VN3RB6WD1HC5JE.",
        app="QR Viewer zeigt die Karte „Amazon-Transparency-Code“ mit der "
        "Seriennummer. Mehr steht nicht im Code: Zu welchem Produkt die "
        "Nummer gehört, weiß nur Amazon. Deshalb gibt es auch keinen "
        "Aktionsknopf.",
        do="Seriennummer kopieren. Ob der Code echt ist, prüfst du in der "
        "Amazon-Shopping- oder der Transparency-App.",
        care="Beim Prüfen in der Amazon-App geht der Code an Amazon. QR Viewer "
        "selbst schickt nichts weg."),
    "datamatrix_bmp": dict(
        title="Data Matrix – Medikationsplan",
        mode="Data Matrix oder Alle Codes", devices=ALL,
        what="Der **bundeseinheitliche Medikationsplan** ist ein Blatt, das "
        "dir Arztpraxis, Krankenhaus oder Apotheke ausdrucken. Oben rechts "
        "trägt er einen großen Data-Matrix-Code. Darin steht alles, was auf "
        "dem Blatt gedruckt ist: dein Name, dein Geburtsdatum, wer den Plan "
        "erstellt hat und jedes Medikament mit Dosierung, Hinweis und Grund. "
        "So können andere Praxen und Apotheken den Plan einlesen, statt ihn "
        "abzutippen.",
        where="Auf dem Medikationsplan, den du ab drei dauerhaft "
        "eingenommenen Medikamenten bekommst.",
        example="Ein erfundener Plan für Max Mustermann mit Ramipril, "
        "Metformin und Ibuprofen bei Bedarf.",
        app="QR Viewer zeigt den Plan übersichtlich: Patient, Ersteller, "
        "Allergien und Gewicht, dann jeden Block mit seinen Medikamenten – "
        "Wirkstoff und Stärke, Darreichungsform, Dosierung wie „1-0-1-0 "
        "Stück“, Hinweis und Grund. Medikamente, die nur mit ihrer "
        "Pharmazentralnummer (PZN) im Plan stehen, zeigt die App mit dieser "
        "Nummer an; den Namen kann sie offline nicht nachschlagen.",
        do="Den Plan lesen und einzelne Angaben markieren und kopieren. Das "
        "Kopier-Symbol rechts neben jedem Medikament kopiert dessen PZN – "
        "damit kannst du das Medikament selbst nachschlagen, wo du möchtest. "
        "Einen Aktionsknopf gibt es nicht.",
        care="Ein Medikationsplan enthält Gesundheitsdaten. QR Viewer "
        "speichert ihn deshalb nie im Verlauf. Teile oder kopiere ihn nur, "
        "wenn du das wirklich willst."),
    "pdf417": dict(
        title="PDF417", mode="PDF417 oder Alle Codes", devices=ALL,
        what="**PDF417** ist ein breiter, gestapelter Code aus vielen kleinen "
        "Strichreihen. Er speichert viel Text und hält auch Beschädigungen "
        "aus.",
        where="Auf Bordkarten von Fluggesellschaften, Personalausweisen und "
        "Führerscheinen (USA), Versandetiketten und Frachtpapieren.",
        example="Eine erfundene Bordkarte für Geraldine Mustermann, Flug von "
        "Hannover (HAJ) nach München (MUC).",
        app="Der Inhalt wird als Text angezeigt. Die Abkürzungen auf "
        "Bordkarten sind standardisiert; QR Viewer zeigt sie so, wie sie "
        "im Code stehen.",
        do="Kopieren oder teilen.",
        care="Bordkarten enthalten persönliche Daten wie Namen und "
        "Buchungscode. Veröffentliche keine Fotos davon."),
    "aztec_vdv": dict(
        title="Aztec – Deutschlandticket (VDV-eTicket)",
        mode="Aztec oder Alle Codes", devices=ALL,
        what="Den **Aztec-Code** erkennst du an der „Zielscheibe“ in der "
        "Mitte. Er braucht keinen weißen Rand und wird deshalb gern für "
        "Fahrkarten auf dem Handy verwendet. Fahrkarten von Bus und Bahn in "
        "Deutschland folgen dem **VDV-Standard** und sind digital signiert, "
        "damit niemand sie fälschen kann.",
        where="Auf dem Deutschlandticket und anderen Bus- und Bahntickets "
        "(VDV), Bahntickets anderer Länder und Flugtickets.",
        example="Das offizielle Muster-Ticket „Deutschlandsemesterticket“ "
        "von Geraldine Mustermann, gültig vom 1.9.2026 bis 28.2.2027.",
        app="QR Viewer entschlüsselt die Fahrkarte auf deinem Gerät und "
        "zeigt Ticketnummer, Produkt (als Nummer, wenn die App den Tarif "
        "nicht beim Namen kennt), Gültigkeit, Ausstellungszeit, Inhaber "
        "(verkürzt, so wie er im Ticket steht), Geburtsdatum, Klasse und ob "
        "die **Signatur gültig** ist. Die Rohdaten kannst du aufklappen.",
        do="Nachsehen, was in deiner Fahrkarte gespeichert ist. Kopieren "
        "gibt die Rohdaten als Zahlenfolge weiter.",
        care="QR Viewer ist kein Kontrollgerät: Die App zeigt nur an, was in "
        "der Fahrkarte steht, und ersetzt keine Fahrkartenkontrolle. Gib "
        "Bildschirmfotos deiner Fahrkarte nicht weiter – sie enthalten "
        "deinen Namen und dein Geburtsdatum."),
    "aztec_vdv_test": dict(
        title="Aztec – Test-Ticket eines unbekannten Herausgebers",
        mode="Aztec oder Alle Codes", devices=ALL,
        what="Ein Fahrschein nach dem **VDV-Standard**, genau wie das "
        "Deutschlandticket auf der vorigen Seite. Diesmal steht der Name "
        "aber **unverkürzt** im Ticket. Der Haken: Die Ticketdaten sind in "
        "der digitalen Signatur „eingeschlossen“. Nur wer den öffentlichen "
        "Schlüssel des Herausgebers hat, kann sie wieder herausholen und "
        "zugleich prüfen, dass niemand etwas verändert hat.",
        where="So sieht es aus, wenn QR Viewer einen Herausgeber nicht "
        "kennt – zum Beispiel ein Ticket aus dem Ausland, von einem neuen "
        "Verkehrsverbund oder ein gefälschtes Ticket.",
        example="Ein Test-Ticket für **Max Mustermann** (geboren am "
        "1.1.1990), Deutschlandticket, Ticketnummer 123456789. Es ist mit "
        "einem selbst erzeugten Test-Schlüssel der erfundenen "
        "Zertifizierungsstelle „XXTEST26“ signiert, nicht von einem echten "
        "Verkehrsunternehmen.",
        app="QR Viewer erkennt den Code als „VDV-eTicket (signiert)“, findet "
        "aber keinen öffentlichen Schlüssel für diesen Herausgeber. Die App "
        "nennt die Kennung der Zertifizierungsstelle (CA 5858544553543236 = "
        "„XXTEST26“) und meldet, dass die Ticketdaten nicht gelesen werden "
        "können. Den Namen zeigt sie deshalb gar nicht an – auch nicht "
        "teilweise. Die Rohdaten kannst du aufklappen.",
        do="Rohdaten ansehen und kopieren. Mehr ist ohne den passenden "
        "Schlüssel nicht möglich.",
        care="QR Viewer liest nur Tickets, deren Herausgeber-Schlüssel "
        "öffentlich bekannt und in der App enthalten sind. Ein unbekannter "
        "Herausgeber heißt nicht automatisch, dass ein Ticket gefälscht "
        "ist – die App kann es nur nicht prüfen."),
}

# Reihenfolge der Anhangsseiten.
ORDER = [
    "qr_text", "qr_url", "qr_bookmark", "qr_email", "qr_phone", "qr_sms", "qr_geo",
    "qr_contact", "qr_event", "qr_wifi", "qr_payment", "qr_otp", "qr_json",
    "qr_matter", "microqr", "ean13", "ean13_isbn", "ean8", "upca", "upce", "itf14",
    "code128", "code39", "code93", "codabar", "itf", "databar",
    "datamatrix_post", "datamatrix_amazon", "datamatrix_bmp", "pdf417",
    "aztec_vdv",
    "aztec_vdv_test",
]
