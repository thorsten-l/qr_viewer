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
  String get menu => 'Меню';

  @override
  String get settings => 'Налаштування';

  @override
  String get enableActions => 'Увімкнути дії';

  @override
  String get enableActionsHint =>
      'Показує на сторінці результату кнопки «Відкрити», «Подзвонити» чи «Знайти». Якщо вимкнено, застосунок лише показує й копіює.';

  @override
  String get scanFromPhoto => 'Сканувати з фото';

  @override
  String get scanFromPhotoHint =>
      'Показує кнопку фото поруч із ліхтариком. Нею ви вибираєте знімок із фото, і застосунок читає код на ньому. Застосунок отримує лише вибраний знімок.';

  @override
  String get pickPhoto => 'Сканувати фото';

  @override
  String get analyzingPhoto => 'Аналіз фото …';

  @override
  String get noCodeInPhoto => 'На фото код не знайдено.';

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
  String get showCode => 'Показати код';

  @override
  String shownAsQr(String format) {
    return '$format не можна намалювати тут; показано як QR-код.';
  }

  @override
  String get codeTooLarge => 'Вміст завеликий, щоб намалювати його як код.';

  @override
  String get close => 'Закрити';

  @override
  String get actionEmail => 'Написати лист…';

  @override
  String get actionCall => 'Зателефонувати…';

  @override
  String get actionSms => 'Написати SMS…';

  @override
  String get actionMap => 'Показати на мапі…';

  @override
  String get actionOtp => 'Відкрити в автентифікаторі…';

  @override
  String get actionLookUp => 'Знайти в інтернеті…';

  @override
  String get actionAddContact => 'До контактів…';

  @override
  String get actionAddEvent => 'До календаря…';

  @override
  String get actionTrack => 'Відстежити відправлення…';

  @override
  String get noAppFound => 'Не знайдено застосунок для відкриття.';

  @override
  String get share => 'Поділитися';

  @override
  String get historySearch => 'Пошук в історії';

  @override
  String get historyNoMatches => 'Нічого не знайдено';

  @override
  String get historyExport => 'Експорт';

  @override
  String get exportCsv => 'Поділитися як CSV';

  @override
  String get exportJson => 'Поділитися як JSON';

  @override
  String get historyEntryDeleted => 'Запис видалено';

  @override
  String get undo => 'Скасувати';

  @override
  String get otpNotSaved => 'Коди 2FA не зберігаються в історії.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Поштова марка (Deutsche Post)';

  @override
  String get fieldGtin => 'Номер товару (GTIN)';

  @override
  String get fieldCheckDigit => 'Контрольна цифра';

  @override
  String get fieldGs1Prefix => 'Видано в (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Трек-номер';

  @override
  String get valueValid => 'правильна';

  @override
  String get valueInvalid => 'неправильна';

  @override
  String get valueInStore => 'Внутрішній номер магазину';

  @override
  String get valueCoupon => 'Купон';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'Про ці дані';

  @override
  String get infoLocal =>
      'QR Viewer прочитав ці дані безпосередньо з коду. Це відбувається лише на вашому пристрої — нічого не надсилається в інтернет.';

  @override
  String infoOnline(String action, String host) {
    return 'Якщо натиснути «$action», браузер відкриє сайт $host. Цей сайт побачить, що ви шукаєте, і, як будь-який сайт, вашу інтернет-адресу. Те, що він покаже, надходить ззовні застосунку — QR Viewer не може перевірити, чи це правильно.';
  }

  @override
  String infoOtherApp(String action) {
    return 'Якщо натиснути «$action», дані передаються іншому застосунку на пристрої, наприклад пошті, телефону, картам чи календарю. Далі саме він вирішує, що з ними буде.';
  }

  @override
  String get infoKindText =>
      'Звичайний текст. Код містить лише ці слова чи символи — нічого більше.';

  @override
  String get infoKindUrl =>
      'Веб-адреса (посилання). Вона веде на сторінку в інтернеті або відкриває інший застосунок. Посилання може вести куди завгодно — відкривайте його, лише якщо довіряєте джерелу коду.';

  @override
  String get infoKindEmail =>
      'Адреса електронної пошти, часто з готовою темою та текстом. Нічого не надсилається, доки ви самі не надішлете лист у поштовому застосунку.';

  @override
  String get infoKindPhone =>
      'Номер телефону. QR Viewer ніколи не телефонує сам — застосунок «Телефон» лише відкривається з уведеним номером.';

  @override
  String get infoKindSms =>
      'Номер телефону з готовим SMS. Повідомлення надійде, лише якщо ви самі його надішлете, — SMS можуть бути платними.';

  @override
  String get infoKindGeo =>
      'Місце на Землі, задане координатами (широта й довгота). Застосунок карт покаже, де воно розташоване.';

  @override
  String get infoKindContact =>
      'Цифрова візитка з даними людини: ім\'я, телефон, адреса. Її можна зберегти в контакти.';

  @override
  String get infoKindEvent =>
      'Подія з датою, часом і часто місцем. Її можна додати до календаря.';

  @override
  String get infoKindWifi =>
      'Дані для доступу до Wi-Fi: назва мережі та зазвичай пароль. Будь-хто, хто бачить цей код, може користуватися мережею.';

  @override
  String get infoKindPayment =>
      'Підготовлений банківський переказ (GiroCode): отримувач, IBAN, сума та призначення платежу. Банківський застосунок може їх підставити — перед оплатою перевірте кожну деталь.';

  @override
  String get infoKindOtp =>
      'Секретний ключ для двоетапного входу (2FA). Застосунок-автентифікатор створює з нього короткі коди входу. Тримайте його в таємниці — QR Viewer не зберігає його в історії.';

  @override
  String get infoKindProduct =>
      'Номер товару зі штрихкоду (GTIN/EAN). Він лише позначає товар — назви, ціни чи складу в коді немає. Перші цифри показують, яка країна видала номер, а не обов\'язково де виготовлено товар.';

  @override
  String get infoKindBook =>
      'Номер книги (ISBN) або журналу (ISSN). Він позначає саме це видання — назви й автора в коді немає.';

  @override
  String get infoKindJson =>
      'Структуровані дані у форматі JSON, якими обмінюються комп\'ютерні програми. QR Viewer лише показує їх з охайними відступами.';

  @override
  String get infoKindPostage =>
      'Код на марці або Internetmarke Deutsche Post. Він містить номер відстеження листа.';

  @override
  String get infoKindVdv =>
      'Електронний квиток на автобус і поїзд (VDV eTicket, напр. Deutschlandticket). Цифровий підпис захищає його від змін; QR Viewer перевіряє його відкритими ключами транспортних компаній.';

  @override
  String get typeMatter => 'Пристрій Matter';

  @override
  String get fieldVendorId => 'ID виробника';

  @override
  String get fieldProductId => 'ID продукту';

  @override
  String get fieldDiscriminator => 'Дискримінатор';

  @override
  String get fieldSetupCode => 'Код налаштування (PIN)';

  @override
  String get fieldManualCode => 'Код ручного сполучення';

  @override
  String get fieldDiscovery => 'Налаштування через';

  @override
  String get fieldFlow => 'Порядок налаштування';

  @override
  String get valueFlowStandard => 'Стандартний';

  @override
  String get valueFlowUserAction =>
      'Спочатку активуйте пристрій (напр., натисніть кнопку)';

  @override
  String get valueFlowCustom => 'Потрібен застосунок виробника';

  @override
  String get valueDiscoverySoftAp => 'Точка доступу Wi-Fi (SoftAP)';

  @override
  String get valueDiscoveryOnNetwork => 'Наявна мережа';

  @override
  String get infoKindMatter =>
      'Дані для налаштування пристрою розумного дому за стандартом Matter. Застосунок розумного дому (наприклад, Apple Дім, Google Home) додає з їх допомогою пристрій — відскануйте код там або введіть код ручного сполучення. Будь-хто з цим кодом може під\'єднати пристрій, поки він у режимі налаштування.';

  @override
  String get infoManuals => 'Посібники';

  @override
  String get typeBookmark => 'Закладка';

  @override
  String get infoKindBookmark =>
      'Закладка: посилання на вебсайт разом із назвою (формат MEBKM). Як і будь-яке посилання, воно може вести будь-куди — відкривайте його, лише якщо довіряєте джерелу коду.';
}
