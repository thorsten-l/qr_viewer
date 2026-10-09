# qr_viewer

Minimaler QR-Code-Scanner für Android und iOS.

- Scannt ausschließlich QR-Codes (`mobile_scanner`).
- Zeigt den Inhalt nur an, öffnet nichts automatisch.
- Nur `http`/`https`-Links lassen sich öffnen, und erst nach einer Rückfrage mit sichtbarer URL.
- Inhalt kann in die Zwischenablage kopiert werden.
- Taschenlampe über die AppBar.

## Datenschutz

Die App erhebt keine personenbezogenen Daten. Details stehen in der
[Datenschutzerklärung](PRIVACY.md). Fragen und Fehlerberichte gerne über die
[Issues](https://github.com/thorsten-l/qr_viewer/issues).

## Entwicklung

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build-Datum im Info-Dialog

Das Build-Datum wird beim Bauen übergeben:

```sh
flutter run --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)
flutter build ios --release --dart-define=BUILD_DATE=$(date +%Y-%m-%dT%H:%M)
```

Ohne diese Angabe zeigt der Info-Dialog stattdessen den Installationszeitpunkt.

## Plattform-Hinweise

- **iOS:** `NSCameraUsageDescription` ist in `ios/Runner/Info.plist` gesetzt.
- **Android:** Die Kamera-Berechtigung kommt aus dem Plugin-Manifest von `mobile_scanner`.
  Die `<queries>` für `http`/`https` in `AndroidManifest.xml` sind für `url_launcher` nötig.

## Sprachen

Die App gibt es auf Englisch, Deutsch, Spanisch, Französisch, Portugiesisch,
Russisch, Chinesisch (vereinfacht), Hindi, Arabisch, Japanisch, Italienisch,
Polnisch und Ukrainisch. Sie folgt
der Gerätesprache; andere Sprachen fallen auf Englisch zurück.

Alle Texte stehen in `tool/l10n/strings.py`. Nach einer Änderung:

```sh
python3 tool/l10n/strings.py   # erzeugt lib/l10n/*.arb und ios/Runner/*.lproj
flutter gen-l10n               # erzeugt lib/l10n/app_localizations*.dart
```

## Lizenz

Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)

Lizenziert unter der [Apache License 2.0](LICENSE). Jede Quelldatei trägt den
Lizenzkopf; neue Dateien ergänzt bzw. prüft:

```sh
python3 tool/license/add_headers.py          # fehlende Köpfe einfügen
python3 tool/license/add_headers.py --check  # nur prüfen
```

Die Schrift Source Code Pro steht unter der SIL Open Font License 1.1
(`assets/fonts/SourceCodePro-OFL.txt`).
