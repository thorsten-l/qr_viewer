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
  String get ticketData => 'Ticketdaten';

  @override
  String get ticketNumber => 'Ticketnummer';

  @override
  String get ticketProduct => 'Produkt';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket für Schüler und Studierende';

  @override
  String get validFrom => 'Gültig ab';

  @override
  String get validUntil => 'Gültig bis';

  @override
  String get issuedAt => 'Ausgestellt';

  @override
  String get ticketHolder => 'Inhaber';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get nameMasked => 'maskiert';

  @override
  String get organizations => 'Organisationsnummern';

  @override
  String get travelClass => 'Klasse';

  @override
  String get firstClass => '1. Klasse';

  @override
  String get secondClass => '2. Klasse';

  @override
  String get ticketPrice => 'Preis';

  @override
  String get signatureValid => 'Signatur gültig';

  @override
  String get signatureInvalid => 'Signatur ungültig';

  @override
  String unknownIssuer(String car) {
    return 'Kein öffentlicher Schlüssel für diesen Herausgeber (CA $car). Die Ticketdaten können nicht gelesen werden.';
  }

  @override
  String get rawData => 'Rohdaten (Hex)';

  @override
  String get lensChoice => 'Objektiv wählen';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automatisch (System wählt das Objektiv)';

  @override
  String get lensUltraWideName => 'Ultraweitwinkel';

  @override
  String get lensMainName => 'Hauptkamera';

  @override
  String get lensTeleName => 'Teleobjektiv';

  @override
  String get typePayment => 'Überweisung';

  @override
  String get rawContent => 'Rohinhalt';

  @override
  String get valueYes => 'Ja';

  @override
  String get valueOpenNetwork => 'Keine (offenes Netz)';

  @override
  String copyField(String label) {
    return '$label kopieren';
  }

  @override
  String get fieldName => 'Name';

  @override
  String get fieldNickname => 'Spitzname';

  @override
  String get fieldOrganization => 'Firma';

  @override
  String get fieldJobTitle => 'Position';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldMobile => 'Mobil';

  @override
  String get fieldWorkPhone => 'Telefon (geschäftlich)';

  @override
  String get fieldHomePhone => 'Telefon (privat)';

  @override
  String get fieldFax => 'Fax';

  @override
  String get fieldEmail => 'E-Mail';

  @override
  String get fieldWebsite => 'Webseite';

  @override
  String get fieldAddress => 'Adresse';

  @override
  String get fieldBirthday => 'Geburtstag';

  @override
  String get fieldNote => 'Notiz';

  @override
  String get fieldTo => 'An';

  @override
  String get fieldCc => 'Kopie (CC)';

  @override
  String get fieldBcc => 'Blindkopie (BCC)';

  @override
  String get fieldSubject => 'Betreff';

  @override
  String get fieldMessage => 'Nachricht';

  @override
  String get fieldNumber => 'Rufnummer';

  @override
  String get fieldLatitude => 'Breitengrad';

  @override
  String get fieldLongitude => 'Längengrad';

  @override
  String get fieldAltitude => 'Höhe';

  @override
  String get fieldQuery => 'Ort';

  @override
  String get fieldTitle => 'Titel';

  @override
  String get fieldLink => 'Link';

  @override
  String get fieldStart => 'Beginn';

  @override
  String get fieldEnd => 'Ende';

  @override
  String get fieldLocation => 'Ort';

  @override
  String get fieldDescription => 'Beschreibung';

  @override
  String get fieldNetwork => 'Netzwerkname (SSID)';

  @override
  String get fieldPassword => 'Passwort';

  @override
  String get fieldSecurity => 'Verschlüsselung';

  @override
  String get fieldHidden => 'Verstecktes Netz';

  @override
  String get fieldEapMethod => 'EAP-Methode';

  @override
  String get fieldIdentity => 'Identität';

  @override
  String get fieldRecipient => 'Empfänger';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Betrag';

  @override
  String get fieldPurpose => 'Zweck-Code';

  @override
  String get fieldReference => 'Referenz';

  @override
  String get fieldRemittance => 'Verwendungszweck';

  @override
  String get fieldInfo => 'Hinweis';

  @override
  String get typeOtp => 'Einmalpasswort (2FA)';

  @override
  String get infoSupport => 'Support';

  @override
  String get fieldIssuer => 'Anbieter';

  @override
  String get fieldAccount => 'Konto';

  @override
  String get fieldSecret => 'Geheimer Schlüssel';

  @override
  String get fieldOtpType => 'Verfahren';

  @override
  String get fieldAlgorithm => 'Algorithmus';

  @override
  String get fieldDigits => 'Stellen';

  @override
  String get fieldPeriod => 'Intervall (Sekunden)';

  @override
  String get fieldCounter => 'Zähler';

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

  @override
  String get actionEmail => 'E-Mail schreiben…';

  @override
  String get actionCall => 'Anrufen…';

  @override
  String get actionSms => 'SMS schreiben…';

  @override
  String get actionMap => 'In Karten zeigen…';

  @override
  String get actionOtp => 'In Authenticator öffnen…';

  @override
  String get actionLookUp => 'Online nachschlagen…';

  @override
  String get actionAddContact => 'Zu Kontakten…';

  @override
  String get actionAddEvent => 'Zum Kalender…';

  @override
  String get actionTrack => 'Sendung verfolgen…';

  @override
  String get noAppFound => 'Keine passende App gefunden.';

  @override
  String get share => 'Teilen';

  @override
  String get historySearch => 'Verlauf durchsuchen';

  @override
  String get historyNoMatches => 'Keine Treffer';

  @override
  String get historyExport => 'Exportieren';

  @override
  String get exportCsv => 'Als CSV teilen';

  @override
  String get exportJson => 'Als JSON teilen';

  @override
  String get historyEntryDeleted => 'Eintrag gelöscht';

  @override
  String get undo => 'Rückgängig';

  @override
  String get otpNotSaved => '2FA-Codes werden nicht im Verlauf gespeichert.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Briefmarke (Deutsche Post)';

  @override
  String get fieldGtin => 'Artikelnummer (GTIN)';

  @override
  String get fieldCheckDigit => 'Prüfziffer';

  @override
  String get fieldGs1Prefix => 'Vergeben in (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Sendungsnummer';

  @override
  String get valueValid => 'gültig';

  @override
  String get valueInvalid => 'ungültig';

  @override
  String get valueInStore => 'Interne Nummer (Handel)';

  @override
  String get valueCoupon => 'Gutschein';

  @override
  String get valueGs1Global => 'GS1 Global Office';
}
