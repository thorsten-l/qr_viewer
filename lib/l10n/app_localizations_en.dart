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
