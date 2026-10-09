# Öffentliche VDV-Schlüssel

`assets/vdv_certs/*.vdv-cert` enthält die öffentlichen CA-Schlüssel der
VDV-Kernapplikation (VDV-KA). Die App braucht sie, um die Ticketdaten statischer
VDV-Barcodes (z. B. Deutschlandticket) zu lesen: Die Daten stecken per
ISO/IEC 9796-2 mit Nachrichtenrückgewinnung in der RSA-Signatur.

- **Herkunft:** VDV-PKI, LDAP `ldap://ldap-vdv-ion.telesec.de:389`,
  `ou=VDV KA, o=VDV Kernapplikations GmbH, c=de`.
- **Bezug:** aus dem KDE-Projekt KItinerary (`src/lib/vdv/certs/`), dort mit
  entfernten Signaturen abgelegt.
- **Lizenz:** CC0-1.0 (laut `NOTES` und `REUSE.toml` von KItinerary).
- Dateiname = CA-Referenz (CAR) als Hex, z. B. `4445564456110221.vdv-cert`.

Aktualisieren:

```sh
tool/vdv/fetch_vdv_certs.sh
```

Der Dart-Code unter `lib/vdv/` ist eine eigene Umsetzung des Formats
(Apache License 2.0) und enthält keinen Code aus KItinerary.
