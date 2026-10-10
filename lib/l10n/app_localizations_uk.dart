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

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get scanTitleQr => 'Сканувати QR-код';

  @override
  String get scanTitleBarcode => 'Сканувати штрихкод';

  @override
  String get scanTitleDataMatrix => 'Сканувати Data Matrix';

  @override
  String get scanTitlePdf417 => 'Сканувати PDF417';

  @override
  String get scanTitleAztec => 'Сканувати Aztec';

  @override
  String get scanTitleAll => 'Сканувати всі коди';

  @override
  String get modeQr => 'QR-код';

  @override
  String get modeBarcode => 'Штрихкод';

  @override
  String get modeAll => 'Усі коди';

  @override
  String get hintQr => 'Посилання, текст, Wi-Fi, контакти';

  @override
  String get hintDataMatrix => 'Етикетки посилок, марки, деталі';

  @override
  String get hintPdf417 => 'Посадкові талони, посвідчення';

  @override
  String get hintAztec => 'Залізничні та авіаквитки';

  @override
  String get hintAll => 'Усі підтримувані формати';

  @override
  String get chooseScanType => 'Вибрати тип коду';

  @override
  String get history => 'Історія';

  @override
  String get info => 'Інформація';

  @override
  String get torch => 'Ліхтарик';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Дані Wi-Fi';

  @override
  String get typeContact => 'Контакт';

  @override
  String get typeEmail => 'Ел. пошта';

  @override
  String get typePhone => 'Номер телефону';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Місцезнаходження';

  @override
  String get typeCalendar => 'Подія';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Код товару';

  @override
  String get typeDriverLicense => 'Посвідчення водія';

  @override
  String get typeText => 'Текст';

  @override
  String get typeBinary => 'Двійкові дані';

  @override
  String byteCount(String count) {
    return '$count байт';
  }

  @override
  String get vdvTicket => 'eTicket VDV (підписаний)';

  @override
  String get ticketData => 'Дані квитка';

  @override
  String get ticketNumber => 'Номер квитка';

  @override
  String get ticketProduct => 'Продукт';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket для школярів і студентів';

  @override
  String get validFrom => 'Дійсний з';

  @override
  String get validUntil => 'Дійсний до';

  @override
  String get issuedAt => 'Видано';

  @override
  String get ticketHolder => 'Власник';

  @override
  String get birthDate => 'Дата народження';

  @override
  String get nameMasked => 'замасковано';

  @override
  String get organizations => 'Номери організацій';

  @override
  String get travelClass => 'Клас';

  @override
  String get firstClass => '1-й клас';

  @override
  String get secondClass => '2-й клас';

  @override
  String get ticketPrice => 'Ціна';

  @override
  String get signatureValid => 'Підпис дійсний';

  @override
  String get signatureInvalid => 'Підпис недійсний';

  @override
  String unknownIssuer(String car) {
    return 'Немає відкритого ключа для цього емітента (CA $car). Дані квитка не читаються.';
  }

  @override
  String get rawData => 'Сирі дані (hex)';

  @override
  String get lensChoice => 'Вибрати об\'єктив';

  @override
  String get lensAuto => 'Авто';

  @override
  String get lensTele => 'Теле';

  @override
  String get lensAutoName => 'Автоматично (система вибирає об\'єктив)';

  @override
  String get lensUltraWideName => 'Надширококутний';

  @override
  String get lensMainName => 'Основна камера';

  @override
  String get lensTeleName => 'Телеоб\'єктив';

  @override
  String get typePayment => 'Банківський переказ';

  @override
  String get rawContent => 'Сирий вміст';

  @override
  String get valueYes => 'Так';

  @override
  String get valueOpenNetwork => 'Немає (відкрита мережа)';

  @override
  String copyField(String label) {
    return 'Копіювати: $label';
  }

  @override
  String get fieldName => 'Ім\'я';

  @override
  String get fieldNickname => 'Псевдонім';

  @override
  String get fieldOrganization => 'Організація';

  @override
  String get fieldJobTitle => 'Посада';

  @override
  String get fieldPhone => 'Телефон';

  @override
  String get fieldMobile => 'Мобільний';

  @override
  String get fieldWorkPhone => 'Робочий телефон';

  @override
  String get fieldHomePhone => 'Домашній телефон';

  @override
  String get fieldFax => 'Факс';

  @override
  String get fieldEmail => 'Ел. пошта';

  @override
  String get fieldWebsite => 'Вебсайт';

  @override
  String get fieldAddress => 'Адреса';

  @override
  String get fieldBirthday => 'День народження';

  @override
  String get fieldNote => 'Нотатка';

  @override
  String get fieldTo => 'Кому';

  @override
  String get fieldCc => 'Копія';

  @override
  String get fieldBcc => 'Прихована копія';

  @override
  String get fieldSubject => 'Тема';

  @override
  String get fieldMessage => 'Повідомлення';

  @override
  String get fieldNumber => 'Номер';

  @override
  String get fieldLatitude => 'Широта';

  @override
  String get fieldLongitude => 'Довгота';

  @override
  String get fieldAltitude => 'Висота';

  @override
  String get fieldQuery => 'Місце';

  @override
  String get fieldTitle => 'Назва';

  @override
  String get fieldLink => 'Посилання';

  @override
  String get fieldStart => 'Початок';

  @override
  String get fieldEnd => 'Кінець';

  @override
  String get fieldLocation => 'Місце';

  @override
  String get fieldDescription => 'Опис';

  @override
  String get fieldNetwork => 'Назва мережі (SSID)';

  @override
  String get fieldPassword => 'Пароль';

  @override
  String get fieldSecurity => 'Захист';

  @override
  String get fieldHidden => 'Прихована мережа';

  @override
  String get fieldEapMethod => 'Метод EAP';

  @override
  String get fieldIdentity => 'Ідентифікатор';

  @override
  String get fieldRecipient => 'Одержувач';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Сума';

  @override
  String get fieldPurpose => 'Код призначення';

  @override
  String get fieldReference => 'Референс';

  @override
  String get fieldRemittance => 'Призначення платежу';

  @override
  String get fieldInfo => 'Примітка';

  @override
  String get typeOtp => 'Одноразовий пароль (2FA)';

  @override
  String get infoSupport => 'Підтримка';

  @override
  String get fieldIssuer => 'Сервіс';

  @override
  String get fieldAccount => 'Обліковий запис';

  @override
  String get fieldSecret => 'Секретний ключ';

  @override
  String get fieldOtpType => 'Метод';

  @override
  String get fieldAlgorithm => 'Алгоритм';

  @override
  String get fieldDigits => 'Цифр';

  @override
  String get fieldPeriod => 'Інтервал (секунди)';

  @override
  String get fieldCounter => 'Лічильник';

  @override
  String get formatMicroQr => 'Micro QR-код';

  @override
  String get formatUnknown => 'Невідомо';

  @override
  String formatLine(String format) {
    return 'Формат: $format';
  }

  @override
  String hostLine(String host) {
    return 'Хост: $host';
  }

  @override
  String get copied => 'Скопійовано в буфер обміну';

  @override
  String get copy => 'Копіювати';

  @override
  String get openEllipsis => 'Відкрити …';

  @override
  String get openLinkTitle => 'Відкрити посилання?';

  @override
  String get open => 'Відкрити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get historyClear => 'Очистити історію';

  @override
  String get historyClearTitle => 'Очистити історію?';

  @override
  String get historyClearBody => 'Усі збережені дані буде видалено.';

  @override
  String get delete => 'Видалити';

  @override
  String get historyEmpty => 'Ще немає відсканованих даних.';

  @override
  String get infoDeveloper => 'Розробник';

  @override
  String get infoVersion => 'Версія';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (збірка $build)';
  }

  @override
  String get infoBuildDate => 'Дата збірки';

  @override
  String get infoInstalled => 'Встановлено';

  @override
  String get valueUnknown => 'невідомо';

  @override
  String get licenses => 'Ліцензії';

  @override
  String get close => 'Закрити';
}
