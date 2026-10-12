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
  String get typePayment => 'Bank transfer';

  @override
  String get rawContent => 'Raw content';

  @override
  String get valueYes => 'Yes';

  @override
  String get valueOpenNetwork => 'None (open network)';

  @override
  String copyField(String label) {
    return 'Copy $label';
  }

  @override
  String get fieldName => 'Name';

  @override
  String get fieldNickname => 'Nickname';

  @override
  String get fieldOrganization => 'Organization';

  @override
  String get fieldJobTitle => 'Job title';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldMobile => 'Mobile';

  @override
  String get fieldWorkPhone => 'Work phone';

  @override
  String get fieldHomePhone => 'Home phone';

  @override
  String get fieldFax => 'Fax';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldWebsite => 'Website';

  @override
  String get fieldAddress => 'Address';

  @override
  String get fieldBirthday => 'Birthday';

  @override
  String get fieldNote => 'Note';

  @override
  String get fieldTo => 'To';

  @override
  String get fieldCc => 'Cc';

  @override
  String get fieldBcc => 'Bcc';

  @override
  String get fieldSubject => 'Subject';

  @override
  String get fieldMessage => 'Message';

  @override
  String get fieldNumber => 'Number';

  @override
  String get fieldLatitude => 'Latitude';

  @override
  String get fieldLongitude => 'Longitude';

  @override
  String get fieldAltitude => 'Altitude';

  @override
  String get fieldQuery => 'Place';

  @override
  String get fieldTitle => 'Title';

  @override
  String get fieldLink => 'Link';

  @override
  String get fieldStart => 'Start';

  @override
  String get fieldEnd => 'End';

  @override
  String get fieldLocation => 'Location';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldNetwork => 'Network name (SSID)';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldSecurity => 'Security';

  @override
  String get fieldHidden => 'Hidden network';

  @override
  String get fieldEapMethod => 'EAP method';

  @override
  String get fieldIdentity => 'Identity';

  @override
  String get fieldRecipient => 'Recipient';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Amount';

  @override
  String get fieldPurpose => 'Purpose code';

  @override
  String get fieldReference => 'Reference';

  @override
  String get fieldRemittance => 'Payment reference';

  @override
  String get fieldInfo => 'Note to payer';

  @override
  String get typeOtp => 'One-time password (2FA)';

  @override
  String get infoSupport => 'Support';

  @override
  String get fieldIssuer => 'Issuer';

  @override
  String get fieldAccount => 'Account';

  @override
  String get fieldSecret => 'Secret key';

  @override
  String get fieldOtpType => 'Method';

  @override
  String get fieldAlgorithm => 'Algorithm';

  @override
  String get fieldDigits => 'Digits';

  @override
  String get fieldPeriod => 'Interval (seconds)';

  @override
  String get fieldCounter => 'Counter';

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

  @override
  String get actionEmail => 'Write email…';

  @override
  String get actionCall => 'Call…';

  @override
  String get actionSms => 'Write SMS…';

  @override
  String get actionMap => 'Show on map…';

  @override
  String get actionOtp => 'Open in authenticator…';

  @override
  String get actionLookUp => 'Look up online…';

  @override
  String get actionAddContact => 'Add to contacts…';

  @override
  String get actionAddEvent => 'Add to calendar…';

  @override
  String get actionTrack => 'Track shipment…';

  @override
  String get noAppFound => 'No app found to open this.';

  @override
  String get share => 'Share';

  @override
  String get historySearch => 'Search history';

  @override
  String get historyNoMatches => 'No matches';

  @override
  String get historyExport => 'Export';

  @override
  String get exportCsv => 'Share as CSV';

  @override
  String get exportJson => 'Share as JSON';

  @override
  String get historyEntryDeleted => 'Entry deleted';

  @override
  String get undo => 'Undo';

  @override
  String get otpNotSaved => '2FA codes are not saved in the history.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Postage stamp (Deutsche Post)';

  @override
  String get fieldGtin => 'Item number (GTIN)';

  @override
  String get fieldCheckDigit => 'Check digit';

  @override
  String get fieldGs1Prefix => 'Registered in (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Tracking number';

  @override
  String get valueValid => 'valid';

  @override
  String get valueInvalid => 'invalid';

  @override
  String get valueInStore => 'In-store number';

  @override
  String get valueCoupon => 'Coupon';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'About this data';

  @override
  String get infoLocal =>
      'QR Viewer read these details directly from the code. This happens only on your device – nothing is sent to the internet.';

  @override
  String infoOnline(String action, String host) {
    return 'If you tap “$action”, your browser opens the website $host. That website then sees what you are looking for and, like any website, your internet address. What it shows comes from outside the app – QR Viewer cannot check whether it is correct.';
  }

  @override
  String infoOtherApp(String action) {
    return 'If you tap “$action”, the data is handed to another app on your device, for example mail, phone, maps or calendar. From then on, that app decides what happens with it.';
  }

  @override
  String get infoKindText =>
      'Plain text. The code contains just these words or characters – nothing more.';

  @override
  String get infoKindUrl =>
      'A web address (link). It leads to a page on the internet or opens another app. A link can lead anywhere – only open it if you trust where the code comes from.';

  @override
  String get infoKindEmail =>
      'An email address, often with a prepared subject and message. Nothing is sent until you send the email yourself in your mail app.';

  @override
  String get infoKindPhone =>
      'A phone number. QR Viewer never calls by itself – the phone app only opens with the number filled in.';

  @override
  String get infoKindSms =>
      'A phone number with a prepared text message. The message is only sent if you send it yourself – text messages may cost money.';

  @override
  String get infoKindGeo =>
      'A place on Earth, given as coordinates (latitude and longitude). A map app can show you where it is.';

  @override
  String get infoKindContact =>
      'A digital business card with a person\'s details, such as name, phone number and address. You can save it to your contacts.';

  @override
  String get infoKindEvent =>
      'An appointment with date, time and often a place. You can add it to your calendar.';

  @override
  String get infoKindWifi =>
      'The access details for a Wi-Fi network: its name and usually the password. Anyone who can see this code can use the network.';

  @override
  String get infoKindPayment =>
      'A prepared bank transfer (GiroCode): recipient, IBAN, amount and reference. A banking app can take these over – check every detail before you pay.';

  @override
  String get infoKindOtp =>
      'A secret key for two-step login (2FA). An authenticator app uses it to create the short login codes. Keep it secret – QR Viewer does not save it in the history.';

  @override
  String get infoKindProduct =>
      'The article number from a product\'s barcode (GTIN/EAN). It only identifies the product – the code itself contains no name, price or ingredients. The first digits show which country assigned the number, not necessarily where the product was made.';

  @override
  String get infoKindBook =>
      'The number of a book (ISBN) or magazine (ISSN). It identifies exactly this edition – title and author are not in the code.';

  @override
  String get infoKindJson =>
      'Structured data in JSON format, as exchanged between computer programs. QR Viewer only shows it neatly indented.';

  @override
  String get infoKindPostage =>
      'The code on a Deutsche Post stamp or Internetmarke. It contains a tracking number for the letter.';

  @override
  String get infoKindVdv =>
      'An electronic ticket for buses and trains (VDV eTicket, e.g. Deutschlandticket). A digital signature protects it against changes; QR Viewer checks it with the publicly known keys of the transport companies.';
}
