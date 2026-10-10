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
}
