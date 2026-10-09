// Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get scanTitleQr => 'QR-Code scannen';

  @override
  String get scanTitleBarcode => 'Barcode scannen';

  @override
  String get scanTitleDataMatrix => 'Data Matrix scannen';

  @override
  String get scanTitlePdf417 => 'PDF417 scannen';

  @override
  String get scanTitleAztec => 'Aztec scannen';

  @override
  String get scanTitleAll => 'Alle Codes scannen';

  @override
  String get modeQr => 'QR-Code';

  @override
  String get modeBarcode => 'Barcode';

  @override
  String get modeAll => 'Alle Codes';

  @override
  String get hintQr => 'Links, Text, WLAN, Kontakte';

  @override
  String get hintDataMatrix => 'Paketaufkleber, Briefmarken, Bauteile';

  @override
  String get hintPdf417 => 'Bordkarten, Ausweise';

  @override
  String get hintAztec => 'Bahn- und Flugtickets';

  @override
  String get hintAll => 'Alle unterstützten Formate';

  @override
  String get chooseScanType => 'Scan-Art wählen';

  @override
  String get history => 'Verlauf';

  @override
  String get info => 'Info';

  @override
  String get torch => 'Taschenlampe';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'WLAN-Zugangsdaten';

  @override
  String get typeContact => 'Kontakt';

  @override
  String get typeEmail => 'E-Mail';

  @override
  String get typePhone => 'Telefonnummer';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Geo-Position';

  @override
  String get typeCalendar => 'Termin';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Produktcode';

  @override
  String get typeDriverLicense => 'Führerschein';

  @override
  String get typeText => 'Text';

  @override
  String get typeBinary => 'Binärdaten';

  @override
  String byteCount(String count) {
    return '$count Bytes';
  }

  @override
  String get vdvTicket => 'VDV-eTicket (signiert)';

  @override
  String get formatMicroQr => 'Micro-QR-Code';

  @override
  String get formatUnknown => 'Unbekannt';

  @override
  String formatLine(String format) {
    return 'Format: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'In die Zwischenablage kopiert';

  @override
  String get copy => 'Kopieren';

  @override
  String get openEllipsis => 'Öffnen …';

  @override
  String get openLinkTitle => 'Link öffnen?';

  @override
  String get open => 'Öffnen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get historyClear => 'Verlauf löschen';

  @override
  String get historyClearTitle => 'Verlauf löschen?';

  @override
  String get historyClearBody => 'Alle gespeicherten Inhalte werden entfernt.';

  @override
  String get delete => 'Löschen';

  @override
  String get historyEmpty => 'Noch keine gescannten Inhalte.';

  @override
  String get infoDeveloper => 'Entwickler';

  @override
  String get infoVersion => 'Version';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String get infoBuildDate => 'Build-Datum';

  @override
  String get infoInstalled => 'Installiert am';

  @override
  String get valueUnknown => 'unbekannt';

  @override
  String get licenses => 'Lizenzen';

  @override
  String get close => 'Schließen';
}
