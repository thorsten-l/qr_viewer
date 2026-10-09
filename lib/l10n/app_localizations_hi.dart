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

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get scanTitleQr => 'QR कोड स्कैन करें';

  @override
  String get scanTitleBarcode => 'बारकोड स्कैन करें';

  @override
  String get scanTitleDataMatrix => 'Data Matrix स्कैन करें';

  @override
  String get scanTitlePdf417 => 'PDF417 स्कैन करें';

  @override
  String get scanTitleAztec => 'Aztec कोड स्कैन करें';

  @override
  String get scanTitleAll => 'सभी कोड स्कैन करें';

  @override
  String get modeQr => 'QR कोड';

  @override
  String get modeBarcode => 'बारकोड';

  @override
  String get modeAll => 'सभी कोड';

  @override
  String get hintQr => 'लिंक, टेक्स्ट, Wi-Fi, संपर्क';

  @override
  String get hintDataMatrix => 'पार्सल लेबल, डाक टिकट, पुर्ज़े';

  @override
  String get hintPdf417 => 'बोर्डिंग पास, पहचान पत्र';

  @override
  String get hintAztec => 'ट्रेन और फ़्लाइट टिकट';

  @override
  String get hintAll => 'सभी समर्थित फ़ॉर्मैट';

  @override
  String get chooseScanType => 'स्कैन प्रकार चुनें';

  @override
  String get history => 'इतिहास';

  @override
  String get info => 'जानकारी';

  @override
  String get torch => 'टॉर्च';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi विवरण';

  @override
  String get typeContact => 'संपर्क';

  @override
  String get typeEmail => 'ईमेल';

  @override
  String get typePhone => 'फ़ोन नंबर';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'स्थान';

  @override
  String get typeCalendar => 'इवेंट';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'उत्पाद कोड';

  @override
  String get typeDriverLicense => 'ड्राइविंग लाइसेंस';

  @override
  String get typeText => 'टेक्स्ट';

  @override
  String get formatMicroQr => 'Micro QR कोड';

  @override
  String get formatUnknown => 'अज्ञात';

  @override
  String formatLine(String format) {
    return 'फ़ॉर्मैट: $format';
  }

  @override
  String hostLine(String host) {
    return 'होस्ट: $host';
  }

  @override
  String get copied => 'क्लिपबोर्ड पर कॉपी किया गया';

  @override
  String get copy => 'कॉपी करें';

  @override
  String get openEllipsis => 'खोलें …';

  @override
  String get openLinkTitle => 'लिंक खोलें?';

  @override
  String get open => 'खोलें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get historyClear => 'इतिहास साफ़ करें';

  @override
  String get historyClearTitle => 'इतिहास साफ़ करें?';

  @override
  String get historyClearBody => 'सभी सहेजी गई सामग्री हटा दी जाएगी।';

  @override
  String get delete => 'हटाएँ';

  @override
  String get historyEmpty => 'अभी तक कोई स्कैन की गई सामग्री नहीं।';

  @override
  String get infoDeveloper => 'डेवलपर';

  @override
  String get infoVersion => 'संस्करण';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (बिल्ड $build)';
  }

  @override
  String get infoBuildDate => 'बिल्ड तिथि';

  @override
  String get infoInstalled => 'इंस्टॉल किया गया';

  @override
  String get valueUnknown => 'अज्ञात';

  @override
  String get licenses => 'लाइसेंस';

  @override
  String get close => 'बंद करें';
}
