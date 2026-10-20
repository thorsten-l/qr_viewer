# Öffentliche VDV-Schlüssel

`assets/vdv_certs/*.vdv-cert` enthält die öffentlichen CA-Schlüssel der
VDV-Kernapplikation (VDV-KA). Die App braucht sie, um die Ticketdaten statischer
VDV-Barcodes (z. B. Deutschlandticket) zu lesen: Die Daten stecken per
ISO/IEC 9796-2 mit Nachrichtenrückgewinnung in der RSA-Signatur.

- **Herkunft und Bezug:** direkt aus dem Verzeichnis der VDV-PKI, LDAP
  `ldap://ldap-vdv-ion.telesec.de:389`,
  `ou=VDV KA, o=VDV Kernapplikations GmbH, c=de`, Attribut `cACertificate`.
- **Format:** nur der öffentliche Schlüssel als `7F21 { 5F4E { … } }`, ohne
  Signatur – wie bei KDE KItinerary (`src/lib/vdv/certs/`), deren Dateien
  CC0-1.0 gekennzeichnet sind.
- Dateiname = CA-Referenz (CAR) als Hex, z. B. `4445564456110221.vdv-cert`.

Aktualisieren (braucht `ldapsearch` und `python3`, unter macOS vorhanden):

```sh
tool/vdv/fetch_vdv_certs.sh --dry-run   # nur anzeigen, was sich ändern würde
tool/vdv/fetch_vdv_certs.sh
```

Das Skript folgt dem Downloader von KItinerary
(`src/lib/vdv/certs/cert-downloader.cpp`), braucht aber keine KDE-Werkzeuge:

1. alle Einträge mit `cACertificate` per `ldapsearch` holen,
2. **jede Signatur** mit dem Schlüssel der ausstellenden CA prüfen – offene
   Schlüssel (`5F4E`) per PKCS #1 v1.5, signierte per ISO/IEC 9796-2, jeweils
   SHA-1; die Wurzel-CA `4555564456100106` signiert sich selbst,
3. Unter-CAs, die vor 2019 abgelaufen sind, verwerfen (wie KItinerary),
4. die Schlüssel schreiben und `assets/vdv_certs/` abgleichen (neu, geändert,
   entfallen).

Abweichend vom Original erkennt es **Kopien im Verzeichnis**: Nennt die CHR
im Schlüssel einen anderen Eintrag, ist der Eintrag nur dessen Kopie. Dann
bleibt die vorhandene Datei erhalten, sofern sie den Schlüssel zu ihrem
Namen enthält, und das Skript warnt. Eine CHR, die nur vom Namen abweicht
(`4C55…0921` und `4C55…1021` tragen CHR `4445…`), ist dagegen in Ordnung.

Stand 20.10.2026: 39 Einträge, davon 8 abgelaufen (`…06`), 31 Schlüssel.

- `4C55564456111016` ist im Verzeichnis eine Kopie von `4C55564456110916`;
  die vorhandene, stimmige Datei bleibt.
- `4445564456110416` war bei KItinerary eine Kopie von `4445564456110516`;
  jetzt steht der geprüfte Schlüssel aus dem Verzeichnis darin.

`test/vdv_test.dart` prüft, dass alle Dateien lesbar sind und keine die Kopie
einer anderen ist.

Der Dart-Code unter `lib/vdv/` ist eine eigene Umsetzung des Formats
(Apache License 2.0) und enthält keinen Code aus KItinerary.
