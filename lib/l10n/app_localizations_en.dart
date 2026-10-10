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

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get scanTitleQr => 'Scan QR code';

  @override
  String get scanTitleBarcode => 'Scan barcode';

  @override
  String get scanTitleDataMatrix => 'Scan Data Matrix';

  @override
  String get scanTitlePdf417 => 'Scan PDF417';

  @override
  String get scanTitleAztec => 'Scan Aztec code';

  @override
  String get scanTitleAll => 'Scan all codes';

  @override
  String get modeQr => 'QR code';

  @override
  String get modeBarcode => 'Barcode';

  @override
  String get modeAll => 'All codes';

  @override
  String get hintQr => 'Links, text, Wi-Fi, contacts';

  @override
  String get hintDataMatrix => 'Parcel labels, stamps, components';

  @override
  String get hintPdf417 => 'Boarding passes, ID cards';

  @override
  String get hintAztec => 'Train and plane tickets';

  @override
  String get hintAll => 'All supported formats';

  @override
  String get chooseScanType => 'Choose scan type';

  @override
  String get history => 'History';

  @override
  String get info => 'Info';

  @override
  String get torch => 'Flashlight';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi credentials';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeEmail => 'Email';

  @override
  String get typePhone => 'Phone number';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Location';

  @override
  String get typeCalendar => 'Event';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Product code';

  @override
  String get typeDriverLicense => 'Driver\'s license';

  @override
  String get typeText => 'Text';

  @override
  String get typeBinary => 'Binary data';

  @override
  String byteCount(String count) {
    return '$count bytes';
  }

  @override
  String get vdvTicket => 'VDV eTicket (signed)';

  @override
  String get ticketData => 'Ticket data';

  @override
  String get ticketNumber => 'Ticket number';

  @override
  String get ticketProduct => 'Product';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket job ticket';

  @override
  String get productStudentTicket =>
      'Deutschlandticket for pupils and students';

  @override
  String get validFrom => 'Valid from';

  @override
  String get validUntil => 'Valid until';

  @override
  String get issuedAt => 'Issued';

  @override
  String get ticketHolder => 'Holder';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get nameMasked => 'masked';

  @override
  String get organizations => 'Organisation IDs';

  @override
  String get travelClass => 'Class';

  @override
  String get firstClass => '1st class';

  @override
  String get secondClass => '2nd class';

  @override
  String get ticketPrice => 'Price';

  @override
  String get signatureValid => 'Signature valid';

  @override
  String get signatureInvalid => 'Signature invalid';

  @override
  String unknownIssuer(String car) {
    return 'No public key for this issuer (CA $car). The ticket data cannot be read.';
  }

  @override
  String get rawData => 'Raw data (hex)';

  @override
  String get lensChoice => 'Choose lens';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automatic (system chooses the lens)';

  @override
  String get lensUltraWideName => 'Ultra wide';

  @override
  String get lensMainName => 'Main camera';

  @override
  String get lensTeleName => 'Telephoto';

  @override
  String get formatMicroQr => 'Micro QR code';

  @override
  String get formatUnknown => 'Unknown';

  @override
  String formatLine(String format) {
    return 'Format: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'Copied to clipboard';

  @override
  String get copy => 'Copy';

  @override
  String get openEllipsis => 'Open …';

  @override
  String get openLinkTitle => 'Open link?';

  @override
  String get open => 'Open';

  @override
  String get cancel => 'Cancel';

  @override
  String get historyClear => 'Clear history';

  @override
  String get historyClearTitle => 'Clear history?';

  @override
  String get historyClearBody => 'All saved contents will be removed.';

  @override
  String get delete => 'Delete';

  @override
  String get historyEmpty => 'No scanned contents yet.';

  @override
  String get infoDeveloper => 'Developer';

  @override
  String get infoVersion => 'Version';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (Build $build)';
  }

  @override
  String get infoBuildDate => 'Build date';

  @override
  String get infoInstalled => 'Installed on';

  @override
  String get valueUnknown => 'unknown';

  @override
  String get licenses => 'Licenses';

  @override
  String get close => 'Close';
}
