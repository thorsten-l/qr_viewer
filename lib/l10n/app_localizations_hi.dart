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
  String get showCode => 'कोड दिखाएँ';

  @override
  String shownAsQr(String format) {
    return '$format यहाँ नहीं बनाया जा सकता; QR कोड के रूप में दिखाया गया।';
  }

  @override
  String get codeTooLarge =>
      'सामग्री कोड के रूप में बनाने के लिए बहुत बड़ी है।';

  @override
  String get close => 'बंद करें';

  @override
  String get actionEmail => 'ईमेल लिखें…';

  @override
  String get actionCall => 'कॉल करें…';

  @override
  String get actionSms => 'SMS लिखें…';

  @override
  String get actionMap => 'मानचित्र पर दिखाएँ…';

  @override
  String get actionOtp => 'ऑथेंटिकेटर में खोलें…';

  @override
  String get actionLookUp => 'ऑनलाइन खोजें…';

  @override
  String get actionAddContact => 'संपर्कों में जोड़ें…';

  @override
  String get actionAddEvent => 'कैलेंडर में जोड़ें…';

  @override
  String get actionTrack => 'शिपमेंट ट्रैक करें…';

  @override
  String get noAppFound => 'इसे खोलने के लिए कोई ऐप नहीं मिला।';

  @override
  String get share => 'साझा करें';

  @override
  String get historySearch => 'इतिहास खोजें';

  @override
  String get historyNoMatches => 'कोई परिणाम नहीं';

  @override
  String get historyExport => 'निर्यात करें';

  @override
  String get exportCsv => 'CSV के रूप में साझा करें';

  @override
  String get exportJson => 'JSON के रूप में साझा करें';

  @override
  String get historyEntryDeleted => 'प्रविष्टि हटाई गई';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get otpNotSaved => '2FA कोड इतिहास में सहेजे नहीं जाते।';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'डाक टिकट (Deutsche Post)';

  @override
  String get fieldGtin => 'आइटम नंबर (GTIN)';

  @override
  String get fieldCheckDigit => 'चेक अंक';

  @override
  String get fieldGs1Prefix => 'पंजीकृत देश (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'ट्रैकिंग नंबर';

  @override
  String get valueValid => 'मान्य';

  @override
  String get valueInvalid => 'अमान्य';

  @override
  String get valueInStore => 'स्टोर का आंतरिक नंबर';

  @override
  String get valueCoupon => 'कूपन';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'इस डेटा के बारे में';

  @override
  String get infoLocal =>
      'QR Viewer ने यह जानकारी सीधे कोड से पढ़ी है। यह केवल आपके डिवाइस पर होता है – इंटरनेट पर कुछ भी नहीं भेजा जाता।';

  @override
  String infoOnline(String action, String host) {
    return '“$action” पर टैप करने पर आपका ब्राउज़र वेबसाइट $host खोलता है। वह वेबसाइट देखती है कि आप क्या खोज रहे हैं और, हर वेबसाइट की तरह, आपका इंटरनेट पता भी। वहाँ दिखाई गई जानकारी ऐप के बाहर से आती है – QR Viewer उसकी सत्यता की जाँच नहीं कर सकता।';
  }

  @override
  String infoOtherApp(String action) {
    return '“$action” पर टैप करने पर डेटा आपके डिवाइस के किसी दूसरे ऐप को दिया जाता है, जैसे मेल, फ़ोन, मैप्स या कैलेंडर। इसके बाद उसके साथ क्या होगा, यह वही ऐप तय करता है।';
  }

  @override
  String get infoKindText =>
      'सादा टेक्स्ट। कोड में केवल ये शब्द या अक्षर हैं – इससे ज़्यादा कुछ नहीं।';

  @override
  String get infoKindUrl =>
      'एक वेब पता (लिंक)। यह इंटरनेट पर किसी पेज तक ले जाता है या कोई दूसरा ऐप खोलता है। लिंक कहीं भी ले जा सकता है – इसे तभी खोलें जब आपको कोड के स्रोत पर भरोसा हो।';

  @override
  String get infoKindEmail =>
      'एक ईमेल पता, अक्सर पहले से तैयार विषय और संदेश के साथ। जब तक आप खुद मेल ऐप से ईमेल नहीं भेजते, कुछ नहीं भेजा जाता।';

  @override
  String get infoKindPhone =>
      'एक फ़ोन नंबर। QR Viewer कभी खुद कॉल नहीं करता – फ़ोन ऐप केवल नंबर भरकर खुलता है।';

  @override
  String get infoKindSms =>
      'पहले से तैयार SMS के साथ एक फ़ोन नंबर। संदेश तभी जाता है जब आप खुद भेजते हैं – SMS पर पैसे लग सकते हैं।';

  @override
  String get infoKindGeo =>
      'पृथ्वी पर एक जगह, जो निर्देशांकों (अक्षांश और देशांतर) में दी गई है। मैप ऐप आपको दिखा सकता है कि यह कहाँ है।';

  @override
  String get infoKindContact =>
      'एक डिजिटल विज़िटिंग कार्ड, जिसमें किसी व्यक्ति का नाम, फ़ोन नंबर और पता जैसी जानकारी है। आप इसे अपने संपर्कों में सहेज सकते हैं।';

  @override
  String get infoKindEvent =>
      'तारीख, समय और अक्सर जगह के साथ एक अपॉइंटमेंट। आप इसे अपने कैलेंडर में जोड़ सकते हैं।';

  @override
  String get infoKindWifi =>
      'किसी Wi-Fi नेटवर्क की एक्सेस जानकारी: उसका नाम और आमतौर पर पासवर्ड। जो भी यह कोड देख सकता है, वह नेटवर्क इस्तेमाल कर सकता है।';

  @override
  String get infoKindPayment =>
      'पहले से तैयार बैंक ट्रांसफ़र (GiroCode): प्राप्तकर्ता, IBAN, राशि और संदर्भ। कोई बैंकिंग ऐप इन्हें ले सकता है – भुगतान से पहले हर जानकारी जाँच लें।';

  @override
  String get infoKindOtp =>
      'दो-चरणीय लॉगिन (2FA) के लिए एक गुप्त कुंजी। ऑथेंटिकेटर ऐप इससे छोटे लॉगिन कोड बनाता है। इसे गुप्त रखें – QR Viewer इसे इतिहास में सहेजता नहीं है।';

  @override
  String get infoKindProduct =>
      'किसी उत्पाद के बारकोड का आर्टिकल नंबर (GTIN/EAN)। यह केवल उत्पाद की पहचान करता है – कोड में नाम, कीमत या सामग्री नहीं होती। पहले अंक बताते हैं कि नंबर किस देश ने दिया, ज़रूरी नहीं कि उत्पाद वहीं बना हो।';

  @override
  String get infoKindBook =>
      'किसी किताब (ISBN) या पत्रिका (ISSN) का नंबर। यह ठीक इसी संस्करण की पहचान करता है – शीर्षक और लेखक कोड में नहीं होते।';

  @override
  String get infoKindJson =>
      'JSON फ़ॉर्मेट में संरचित डेटा, जैसा कंप्यूटर प्रोग्राम आपस में भेजते हैं। QR Viewer इसे केवल सुव्यवस्थित ढंग से दिखाता है।';

  @override
  String get infoKindPostage =>
      'Deutsche Post के डाक टिकट या Internetmarke पर लगा कोड। इसमें पत्र का ट्रैकिंग नंबर होता है।';

  @override
  String get infoKindVdv =>
      'बस और ट्रेन का इलेक्ट्रॉनिक टिकट (VDV eTicket, जैसे Deutschlandticket)। डिजिटल हस्ताक्षर इसे बदलाव से बचाता है; QR Viewer परिवहन कंपनियों की सार्वजनिक कुंजियों से इसकी जाँच करता है।';

  @override
  String get typeMatter => 'Matter डिवाइस';

  @override
  String get fieldVendorId => 'निर्माता ID';

  @override
  String get fieldProductId => 'उत्पाद ID';

  @override
  String get fieldDiscriminator => 'डिस्क्रिमिनेटर';

  @override
  String get fieldSetupCode => 'सेटअप कोड (PIN)';

  @override
  String get fieldManualCode => 'मैनुअल पेयरिंग कोड';

  @override
  String get fieldDiscovery => 'सेटअप माध्यम';

  @override
  String get fieldFlow => 'सेटअप प्रक्रिया';

  @override
  String get valueFlowStandard => 'मानक';

  @override
  String get valueFlowUserAction => 'पहले डिवाइस सक्रिय करें (जैसे बटन दबाएँ)';

  @override
  String get valueFlowCustom => 'निर्माता का ऐप ज़रूरी है';

  @override
  String get valueDiscoverySoftAp => 'Wi-Fi एक्सेस पॉइंट (SoftAP)';

  @override
  String get valueDiscoveryOnNetwork => 'मौजूदा नेटवर्क';

  @override
  String get infoKindMatter =>
      'Matter मानक वाले स्मार्ट होम डिवाइस का सेटअप डेटा। आपका स्मार्ट होम ऐप (जैसे Apple Home, Google Home) इससे डिवाइस जोड़ता है – कोड वहीं स्कैन करें या मैनुअल पेयरिंग कोड टाइप करें। जब तक डिवाइस सेटअप मोड में है, यह कोड रखने वाला कोई भी उसे जोड़ सकता है।';

  @override
  String get infoManuals => 'मैनुअल';

  @override
  String get typeBookmark => 'बुकमार्क';

  @override
  String get infoKindBookmark =>
      'बुकमार्क: किसी वेबसाइट का लिंक और उसका नाम (MEBKM फ़ॉर्मैट)। किसी भी लिंक की तरह यह कहीं भी ले जा सकता है – इसे तभी खोलें जब आपको कोड के स्रोत पर भरोसा हो।';
}
