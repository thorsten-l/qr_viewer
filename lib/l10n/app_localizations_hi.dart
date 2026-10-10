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
  String get typeBinary => 'बाइनरी डेटा';

  @override
  String byteCount(String count) {
    return '$count बाइट';
  }

  @override
  String get vdvTicket => 'VDV ई-टिकट (हस्ताक्षरित)';

  @override
  String get ticketData => 'टिकट डेटा';

  @override
  String get ticketNumber => 'टिकट संख्या';

  @override
  String get ticketProduct => 'उत्पाद';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket जॉब टिकट';

  @override
  String get productStudentTicket => 'छात्रों के लिए Deutschlandticket';

  @override
  String get validFrom => 'से मान्य';

  @override
  String get validUntil => 'तक मान्य';

  @override
  String get issuedAt => 'जारी';

  @override
  String get ticketHolder => 'धारक';

  @override
  String get birthDate => 'जन्म तिथि';

  @override
  String get nameMasked => 'छिपाया गया';

  @override
  String get organizations => 'संगठन आईडी';

  @override
  String get travelClass => 'श्रेणी';

  @override
  String get firstClass => 'प्रथम श्रेणी';

  @override
  String get secondClass => 'द्वितीय श्रेणी';

  @override
  String get ticketPrice => 'कीमत';

  @override
  String get signatureValid => 'हस्ताक्षर मान्य';

  @override
  String get signatureInvalid => 'हस्ताक्षर अमान्य';

  @override
  String unknownIssuer(String car) {
    return 'इस जारीकर्ता के लिए कोई सार्वजनिक कुंजी नहीं (CA $car)। टिकट डेटा पढ़ा नहीं जा सकता।';
  }

  @override
  String get rawData => 'कच्चा डेटा (hex)';

  @override
  String get lensChoice => 'लेंस चुनें';

  @override
  String get lensAuto => 'ऑटो';

  @override
  String get lensTele => 'टेली';

  @override
  String get lensAutoName => 'स्वचालित (सिस्टम लेंस चुनता है)';

  @override
  String get lensUltraWideName => 'अल्ट्रा वाइड';

  @override
  String get lensMainName => 'मुख्य कैमरा';

  @override
  String get lensTeleName => 'टेलीफ़ोटो';

  @override
  String get typePayment => 'बैंक ट्रांसफ़र';

  @override
  String get rawContent => 'कच्ची सामग्री';

  @override
  String get valueYes => 'हाँ';

  @override
  String get valueOpenNetwork => 'कोई नहीं (खुला नेटवर्क)';

  @override
  String copyField(String label) {
    return '$label कॉपी करें';
  }

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldNickname => 'उपनाम';

  @override
  String get fieldOrganization => 'संगठन';

  @override
  String get fieldJobTitle => 'पद';

  @override
  String get fieldPhone => 'फ़ोन';

  @override
  String get fieldMobile => 'मोबाइल';

  @override
  String get fieldWorkPhone => 'कार्यालय फ़ोन';

  @override
  String get fieldHomePhone => 'घर का फ़ोन';

  @override
  String get fieldFax => 'फ़ैक्स';

  @override
  String get fieldEmail => 'ईमेल';

  @override
  String get fieldWebsite => 'वेबसाइट';

  @override
  String get fieldAddress => 'पता';

  @override
  String get fieldBirthday => 'जन्मदिन';

  @override
  String get fieldNote => 'नोट';

  @override
  String get fieldTo => 'प्रति';

  @override
  String get fieldCc => 'Cc';

  @override
  String get fieldBcc => 'Bcc';

  @override
  String get fieldSubject => 'विषय';

  @override
  String get fieldMessage => 'संदेश';

  @override
  String get fieldNumber => 'नंबर';

  @override
  String get fieldLatitude => 'अक्षांश';

  @override
  String get fieldLongitude => 'देशांतर';

  @override
  String get fieldAltitude => 'ऊँचाई';

  @override
  String get fieldQuery => 'स्थान';

  @override
  String get fieldTitle => 'शीर्षक';

  @override
  String get fieldLink => 'लिंक';

  @override
  String get fieldStart => 'शुरू';

  @override
  String get fieldEnd => 'समाप्ति';

  @override
  String get fieldLocation => 'स्थान';

  @override
  String get fieldDescription => 'विवरण';

  @override
  String get fieldNetwork => 'नेटवर्क नाम (SSID)';

  @override
  String get fieldPassword => 'पासवर्ड';

  @override
  String get fieldSecurity => 'सुरक्षा';

  @override
  String get fieldHidden => 'छिपा नेटवर्क';

  @override
  String get fieldEapMethod => 'EAP विधि';

  @override
  String get fieldIdentity => 'पहचान';

  @override
  String get fieldRecipient => 'प्राप्तकर्ता';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'राशि';

  @override
  String get fieldPurpose => 'उद्देश्य कोड';

  @override
  String get fieldReference => 'संदर्भ';

  @override
  String get fieldRemittance => 'भुगतान विवरण';

  @override
  String get fieldInfo => 'भुगतानकर्ता हेतु नोट';

  @override
  String get typeOtp => 'वन-टाइम पासवर्ड (2FA)';

  @override
  String get infoSupport => 'सहायता';

  @override
  String get fieldIssuer => 'जारीकर्ता';

  @override
  String get fieldAccount => 'खाता';

  @override
  String get fieldSecret => 'गुप्त कुंजी';

  @override
  String get fieldOtpType => 'विधि';

  @override
  String get fieldAlgorithm => 'एल्गोरिदम';

  @override
  String get fieldDigits => 'अंक';

  @override
  String get fieldPeriod => 'अंतराल (सेकंड)';

  @override
  String get fieldCounter => 'काउंटर';

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
