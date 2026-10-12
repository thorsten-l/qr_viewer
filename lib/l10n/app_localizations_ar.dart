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

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get scanTitleQr => 'مسح رمز QR';

  @override
  String get scanTitleBarcode => 'مسح الباركود';

  @override
  String get scanTitleDataMatrix => 'مسح Data Matrix';

  @override
  String get scanTitlePdf417 => 'مسح PDF417';

  @override
  String get scanTitleAztec => 'مسح رمز Aztec';

  @override
  String get scanTitleAll => 'مسح جميع الرموز';

  @override
  String get modeQr => 'رمز QR';

  @override
  String get modeBarcode => 'باركود';

  @override
  String get modeAll => 'جميع الرموز';

  @override
  String get hintQr => 'روابط، نصوص، Wi-Fi، جهات اتصال';

  @override
  String get hintDataMatrix => 'ملصقات الطرود، الطوابع، القطع';

  @override
  String get hintPdf417 => 'بطاقات الصعود، بطاقات الهوية';

  @override
  String get hintAztec => 'تذاكر القطار والطيران';

  @override
  String get hintAll => 'جميع الصيغ المدعومة';

  @override
  String get chooseScanType => 'اختر نوع المسح';

  @override
  String get history => 'السجل';

  @override
  String get info => 'معلومات';

  @override
  String get torch => 'المصباح';

  @override
  String get typeUrl => 'رابط';

  @override
  String get typeWifi => 'بيانات Wi-Fi';

  @override
  String get typeContact => 'جهة اتصال';

  @override
  String get typeEmail => 'بريد إلكتروني';

  @override
  String get typePhone => 'رقم الهاتف';

  @override
  String get typeSms => 'رسالة SMS';

  @override
  String get typeGeo => 'الموقع';

  @override
  String get typeCalendar => 'حدث';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'رمز المنتج';

  @override
  String get typeDriverLicense => 'رخصة القيادة';

  @override
  String get typeText => 'نص';

  @override
  String get typeBinary => 'بيانات ثنائية';

  @override
  String byteCount(String count) {
    return '$count بايت';
  }

  @override
  String get vdvTicket => 'تذكرة VDV إلكترونية (موقّعة)';

  @override
  String get ticketData => 'بيانات التذكرة';

  @override
  String get ticketNumber => 'رقم التذكرة';

  @override
  String get ticketProduct => 'المنتج';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket للعمل';

  @override
  String get productStudentTicket => 'Deutschlandticket للتلاميذ والطلاب';

  @override
  String get validFrom => 'صالح من';

  @override
  String get validUntil => 'صالح حتى';

  @override
  String get issuedAt => 'تاريخ الإصدار';

  @override
  String get ticketHolder => 'حامل التذكرة';

  @override
  String get birthDate => 'تاريخ الميلاد';

  @override
  String get nameMasked => 'مخفي';

  @override
  String get organizations => 'أرقام الجهات';

  @override
  String get travelClass => 'الدرجة';

  @override
  String get firstClass => 'الدرجة الأولى';

  @override
  String get secondClass => 'الدرجة الثانية';

  @override
  String get ticketPrice => 'السعر';

  @override
  String get signatureValid => 'التوقيع صالح';

  @override
  String get signatureInvalid => 'التوقيع غير صالح';

  @override
  String unknownIssuer(String car) {
    return 'لا يوجد مفتاح عام لهذه الجهة (CA $car). لا يمكن قراءة بيانات التذكرة.';
  }

  @override
  String get rawData => 'البيانات الخام (hex)';

  @override
  String get lensChoice => 'اختيار العدسة';

  @override
  String get lensAuto => 'تلقائي';

  @override
  String get lensTele => 'مقرّب';

  @override
  String get lensAutoName => 'تلقائي (يختار النظام العدسة)';

  @override
  String get lensUltraWideName => 'فائق الاتساع';

  @override
  String get lensMainName => 'الكاميرا الرئيسية';

  @override
  String get lensTeleName => 'عدسة مقرّبة';

  @override
  String get typePayment => 'تحويل مصرفي';

  @override
  String get rawContent => 'المحتوى الخام';

  @override
  String get valueYes => 'نعم';

  @override
  String get valueOpenNetwork => 'بدون (شبكة مفتوحة)';

  @override
  String copyField(String label) {
    return 'نسخ $label';
  }

  @override
  String get fieldName => 'الاسم';

  @override
  String get fieldNickname => 'اللقب';

  @override
  String get fieldOrganization => 'المؤسسة';

  @override
  String get fieldJobTitle => 'المسمى الوظيفي';

  @override
  String get fieldPhone => 'الهاتف';

  @override
  String get fieldMobile => 'الجوال';

  @override
  String get fieldWorkPhone => 'هاتف العمل';

  @override
  String get fieldHomePhone => 'هاتف المنزل';

  @override
  String get fieldFax => 'الفاكس';

  @override
  String get fieldEmail => 'البريد الإلكتروني';

  @override
  String get fieldWebsite => 'الموقع الإلكتروني';

  @override
  String get fieldAddress => 'العنوان';

  @override
  String get fieldBirthday => 'تاريخ الميلاد';

  @override
  String get fieldNote => 'ملاحظة';

  @override
  String get fieldTo => 'إلى';

  @override
  String get fieldCc => 'نسخة';

  @override
  String get fieldBcc => 'نسخة مخفية';

  @override
  String get fieldSubject => 'الموضوع';

  @override
  String get fieldMessage => 'الرسالة';

  @override
  String get fieldNumber => 'الرقم';

  @override
  String get fieldLatitude => 'خط العرض';

  @override
  String get fieldLongitude => 'خط الطول';

  @override
  String get fieldAltitude => 'الارتفاع';

  @override
  String get fieldQuery => 'المكان';

  @override
  String get fieldTitle => 'العنوان';

  @override
  String get fieldLink => 'الرابط';

  @override
  String get fieldStart => 'البداية';

  @override
  String get fieldEnd => 'النهاية';

  @override
  String get fieldLocation => 'الموقع';

  @override
  String get fieldDescription => 'الوصف';

  @override
  String get fieldNetwork => 'اسم الشبكة (SSID)';

  @override
  String get fieldPassword => 'كلمة المرور';

  @override
  String get fieldSecurity => 'الأمان';

  @override
  String get fieldHidden => 'شبكة مخفية';

  @override
  String get fieldEapMethod => 'طريقة EAP';

  @override
  String get fieldIdentity => 'الهوية';

  @override
  String get fieldRecipient => 'المستفيد';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'المبلغ';

  @override
  String get fieldPurpose => 'رمز الغرض';

  @override
  String get fieldReference => 'المرجع';

  @override
  String get fieldRemittance => 'بيان الدفع';

  @override
  String get fieldInfo => 'ملاحظة للدافع';

  @override
  String get typeOtp => 'كلمة مرور لمرة واحدة (2FA)';

  @override
  String get infoSupport => 'الدعم';

  @override
  String get fieldIssuer => 'الجهة المصدرة';

  @override
  String get fieldAccount => 'الحساب';

  @override
  String get fieldSecret => 'المفتاح السري';

  @override
  String get fieldOtpType => 'الطريقة';

  @override
  String get fieldAlgorithm => 'الخوارزمية';

  @override
  String get fieldDigits => 'الأرقام';

  @override
  String get fieldPeriod => 'الفاصل (ثوانٍ)';

  @override
  String get fieldCounter => 'العداد';

  @override
  String get formatMicroQr => 'رمز Micro QR';

  @override
  String get formatUnknown => 'غير معروف';

  @override
  String formatLine(String format) {
    return 'الصيغة: $format';
  }

  @override
  String hostLine(String host) {
    return 'المضيف: $host';
  }

  @override
  String get copied => 'تم النسخ إلى الحافظة';

  @override
  String get copy => 'نسخ';

  @override
  String get openEllipsis => 'فتح …';

  @override
  String get openLinkTitle => 'فتح الرابط؟';

  @override
  String get open => 'فتح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get historyClear => 'مسح السجل';

  @override
  String get historyClearTitle => 'مسح السجل؟';

  @override
  String get historyClearBody => 'ستتم إزالة جميع المحتويات المحفوظة.';

  @override
  String get delete => 'حذف';

  @override
  String get historyEmpty => 'لا توجد محتويات ممسوحة بعد.';

  @override
  String get infoDeveloper => 'المطوّر';

  @override
  String get infoVersion => 'الإصدار';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (البناء $build)';
  }

  @override
  String get infoBuildDate => 'تاريخ البناء';

  @override
  String get infoInstalled => 'تاريخ التثبيت';

  @override
  String get valueUnknown => 'غير معروف';

  @override
  String get licenses => 'التراخيص';

  @override
  String get close => 'إغلاق';

  @override
  String get actionEmail => 'كتابة بريد…';

  @override
  String get actionCall => 'اتصال…';

  @override
  String get actionSms => 'كتابة رسالة SMS…';

  @override
  String get actionMap => 'عرض على الخريطة…';

  @override
  String get actionOtp => 'فتح في تطبيق المصادقة…';

  @override
  String get actionLookUp => 'البحث على الإنترنت…';

  @override
  String get actionAddContact => 'إضافة إلى جهات الاتصال…';

  @override
  String get actionAddEvent => 'إضافة إلى التقويم…';

  @override
  String get actionTrack => 'تتبع الشحنة…';

  @override
  String get noAppFound => 'لم يتم العثور على تطبيق لفتح هذا.';

  @override
  String get share => 'مشاركة';

  @override
  String get historySearch => 'البحث في السجل';

  @override
  String get historyNoMatches => 'لا توجد نتائج';

  @override
  String get historyExport => 'تصدير';

  @override
  String get exportCsv => 'مشاركة بصيغة CSV';

  @override
  String get exportJson => 'مشاركة بصيغة JSON';

  @override
  String get historyEntryDeleted => 'تم حذف الإدخال';

  @override
  String get undo => 'تراجع';

  @override
  String get otpNotSaved => 'لا يتم حفظ رموز 2FA في السجل.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'طابع بريدي (Deutsche Post)';

  @override
  String get fieldGtin => 'رقم الصنف (GTIN)';

  @override
  String get fieldCheckDigit => 'رقم التحقق';

  @override
  String get fieldGs1Prefix => 'مسجل في (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'رقم التتبع';

  @override
  String get valueValid => 'صالح';

  @override
  String get valueInvalid => 'غير صالح';

  @override
  String get valueInStore => 'رقم داخلي للمتجر';

  @override
  String get valueCoupon => 'قسيمة';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'حول هذه البيانات';

  @override
  String get infoLocal =>
      'قرأ QR Viewer هذه البيانات مباشرة من الرمز. يحدث ذلك على جهازك فقط، ولا يُرسل أي شيء إلى الإنترنت.';

  @override
  String infoOnline(String action, String host) {
    return 'إذا نقرت على «$action»، يفتح متصفحك الموقع $host. سيرى هذا الموقع ما تبحث عنه، ومثل أي موقع، عنوانك على الإنترنت. ما يعرضه يأتي من خارج التطبيق، ولا يستطيع QR Viewer التحقق من صحته.';
  }

  @override
  String infoOtherApp(String action) {
    return 'إذا نقرت على «$action»، تُسلَّم البيانات إلى تطبيق آخر على جهازك، مثل البريد أو الهاتف أو الخرائط أو التقويم. بعد ذلك يقرر هذا التطبيق ما يحدث بها.';
  }

  @override
  String get infoKindText =>
      'نص عادي. يحتوي الرمز على هذه الكلمات أو الأحرف فقط، لا أكثر.';

  @override
  String get infoKindUrl =>
      'عنوان ويب (رابط). يؤدي إلى صفحة على الإنترنت أو يفتح تطبيقًا آخر. قد يؤدي الرابط إلى أي مكان، فلا تفتحه إلا إذا كنت تثق بمصدر الرمز.';

  @override
  String get infoKindEmail =>
      'عنوان بريد إلكتروني، غالبًا مع موضوع ورسالة جاهزين. لا يُرسل شيء حتى ترسل الرسالة بنفسك من تطبيق البريد.';

  @override
  String get infoKindPhone =>
      'رقم هاتف. لا يتصل QR Viewer من تلقاء نفسه أبدًا، بل يفتح تطبيق الهاتف مع إدخال الرقم فقط.';

  @override
  String get infoKindSms =>
      'رقم هاتف مع رسالة SMS جاهزة. لا تُرسل الرسالة إلا إذا أرسلتها بنفسك، وقد تكون رسائل SMS مدفوعة.';

  @override
  String get infoKindGeo =>
      'مكان على الأرض محدد بإحداثيات (خط العرض وخط الطول). يمكن لتطبيق الخرائط أن يريك موقعه.';

  @override
  String get infoKindContact =>
      'بطاقة عمل رقمية تحتوي على بيانات شخص، مثل الاسم ورقم الهاتف والعنوان. يمكنك حفظها في جهات الاتصال.';

  @override
  String get infoKindEvent =>
      'موعد بتاريخ ووقت، وغالبًا بمكان. يمكنك إضافته إلى التقويم.';

  @override
  String get infoKindWifi =>
      'بيانات الدخول إلى شبكة Wi-Fi: اسمها وعادةً كلمة المرور. يمكن لأي شخص يرى هذا الرمز استخدام الشبكة.';

  @override
  String get infoKindPayment =>
      'تحويل مصرفي جاهز (GiroCode): المستفيد ورقم IBAN والمبلغ والغرض. يمكن لتطبيق البنك استخدامها، فتحقق من كل التفاصيل قبل الدفع.';

  @override
  String get infoKindOtp =>
      'مفتاح سري لتسجيل الدخول بخطوتين (2FA). يستخدمه تطبيق المصادقة لإنشاء رموز الدخول القصيرة. احتفظ به سرًا، فـ QR Viewer لا يحفظه في السجل.';

  @override
  String get infoKindProduct =>
      'رقم الصنف من باركود المنتج (GTIN/EAN). يحدد المنتج فقط، فلا يحتوي الرمز على الاسم أو السعر أو المكونات. تدل الأرقام الأولى على البلد الذي منح الرقم، وليس بالضرورة مكان صنع المنتج.';

  @override
  String get infoKindBook =>
      'رقم كتاب (ISBN) أو مجلة (ISSN). يحدد هذه الطبعة بالضبط، ولا يحتوي الرمز على العنوان أو المؤلف.';

  @override
  String get infoKindJson =>
      'بيانات منظمة بصيغة JSON، كالتي تتبادلها برامج الحاسوب. يعرضها QR Viewer فقط بتنسيق مرتب.';

  @override
  String get infoKindPostage =>
      'الرمز الموجود على طابع أو Internetmarke من Deutsche Post. يحتوي على رقم تتبع للرسالة.';

  @override
  String get infoKindVdv =>
      'تذكرة إلكترونية للحافلات والقطارات (VDV eTicket، مثل Deutschlandticket). يحميها توقيع رقمي من التعديل، ويتحقق منه QR Viewer باستخدام المفاتيح العامة لشركات النقل.';
}
