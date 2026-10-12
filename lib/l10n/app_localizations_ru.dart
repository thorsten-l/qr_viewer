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

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get scanTitleQr => 'Сканировать QR-код';

  @override
  String get scanTitleBarcode => 'Сканировать штрихкод';

  @override
  String get scanTitleDataMatrix => 'Сканировать Data Matrix';

  @override
  String get scanTitlePdf417 => 'Сканировать PDF417';

  @override
  String get scanTitleAztec => 'Сканировать Aztec';

  @override
  String get scanTitleAll => 'Сканировать все коды';

  @override
  String get modeQr => 'QR-код';

  @override
  String get modeBarcode => 'Штрихкод';

  @override
  String get modeAll => 'Все коды';

  @override
  String get hintQr => 'Ссылки, текст, Wi-Fi, контакты';

  @override
  String get hintDataMatrix => 'Посылки, марки, детали';

  @override
  String get hintPdf417 => 'Посадочные талоны, удостоверения';

  @override
  String get hintAztec => 'Ж/д и авиабилеты';

  @override
  String get hintAll => 'Все поддерживаемые форматы';

  @override
  String get chooseScanType => 'Выбрать тип кода';

  @override
  String get history => 'История';

  @override
  String get info => 'Информация';

  @override
  String get torch => 'Фонарик';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Данные Wi-Fi';

  @override
  String get typeContact => 'Контакт';

  @override
  String get typeEmail => 'Эл. почта';

  @override
  String get typePhone => 'Номер телефона';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Местоположение';

  @override
  String get typeCalendar => 'Событие';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Код товара';

  @override
  String get typeDriverLicense => 'Водительское удостоверение';

  @override
  String get typeText => 'Текст';

  @override
  String get typeBinary => 'Двоичные данные';

  @override
  String byteCount(String count) {
    return '$count байт';
  }

  @override
  String get vdvTicket => 'eTicket VDV (подписан)';

  @override
  String get ticketData => 'Данные билета';

  @override
  String get ticketNumber => 'Номер билета';

  @override
  String get ticketProduct => 'Продукт';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket для школьников и студентов';

  @override
  String get validFrom => 'Действует с';

  @override
  String get validUntil => 'Действует до';

  @override
  String get issuedAt => 'Выдан';

  @override
  String get ticketHolder => 'Владелец';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get nameMasked => 'замаскировано';

  @override
  String get organizations => 'Номера организаций';

  @override
  String get travelClass => 'Класс';

  @override
  String get firstClass => '1-й класс';

  @override
  String get secondClass => '2-й класс';

  @override
  String get ticketPrice => 'Цена';

  @override
  String get signatureValid => 'Подпись действительна';

  @override
  String get signatureInvalid => 'Подпись недействительна';

  @override
  String unknownIssuer(String car) {
    return 'Нет открытого ключа для этого эмитента (CA $car). Данные билета не читаются.';
  }

  @override
  String get rawData => 'Исходные данные (hex)';

  @override
  String get lensChoice => 'Выбрать объектив';

  @override
  String get lensAuto => 'Авто';

  @override
  String get lensTele => 'Теле';

  @override
  String get lensAutoName => 'Автоматически (объектив выбирает система)';

  @override
  String get lensUltraWideName => 'Сверхширокоугольный';

  @override
  String get lensMainName => 'Основная камера';

  @override
  String get lensTeleName => 'Телеобъектив';

  @override
  String get typePayment => 'Банковский перевод';

  @override
  String get rawContent => 'Исходное содержимое';

  @override
  String get valueYes => 'Да';

  @override
  String get valueOpenNetwork => 'Нет (открытая сеть)';

  @override
  String copyField(String label) {
    return 'Копировать: $label';
  }

  @override
  String get fieldName => 'Имя';

  @override
  String get fieldNickname => 'Псевдоним';

  @override
  String get fieldOrganization => 'Организация';

  @override
  String get fieldJobTitle => 'Должность';

  @override
  String get fieldPhone => 'Телефон';

  @override
  String get fieldMobile => 'Мобильный';

  @override
  String get fieldWorkPhone => 'Рабочий телефон';

  @override
  String get fieldHomePhone => 'Домашний телефон';

  @override
  String get fieldFax => 'Факс';

  @override
  String get fieldEmail => 'Эл. почта';

  @override
  String get fieldWebsite => 'Веб-сайт';

  @override
  String get fieldAddress => 'Адрес';

  @override
  String get fieldBirthday => 'День рождения';

  @override
  String get fieldNote => 'Заметка';

  @override
  String get fieldTo => 'Кому';

  @override
  String get fieldCc => 'Копия';

  @override
  String get fieldBcc => 'Скрытая копия';

  @override
  String get fieldSubject => 'Тема';

  @override
  String get fieldMessage => 'Сообщение';

  @override
  String get fieldNumber => 'Номер';

  @override
  String get fieldLatitude => 'Широта';

  @override
  String get fieldLongitude => 'Долгота';

  @override
  String get fieldAltitude => 'Высота';

  @override
  String get fieldQuery => 'Место';

  @override
  String get fieldTitle => 'Название';

  @override
  String get fieldLink => 'Ссылка';

  @override
  String get fieldStart => 'Начало';

  @override
  String get fieldEnd => 'Конец';

  @override
  String get fieldLocation => 'Место';

  @override
  String get fieldDescription => 'Описание';

  @override
  String get fieldNetwork => 'Имя сети (SSID)';

  @override
  String get fieldPassword => 'Пароль';

  @override
  String get fieldSecurity => 'Защита';

  @override
  String get fieldHidden => 'Скрытая сеть';

  @override
  String get fieldEapMethod => 'Метод EAP';

  @override
  String get fieldIdentity => 'Идентификатор';

  @override
  String get fieldRecipient => 'Получатель';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Сумма';

  @override
  String get fieldPurpose => 'Код назначения';

  @override
  String get fieldReference => 'Референс';

  @override
  String get fieldRemittance => 'Назначение платежа';

  @override
  String get fieldInfo => 'Примечание';

  @override
  String get typeOtp => 'Одноразовый пароль (2FA)';

  @override
  String get infoSupport => 'Поддержка';

  @override
  String get fieldIssuer => 'Сервис';

  @override
  String get fieldAccount => 'Аккаунт';

  @override
  String get fieldSecret => 'Секретный ключ';

  @override
  String get fieldOtpType => 'Метод';

  @override
  String get fieldAlgorithm => 'Алгоритм';

  @override
  String get fieldDigits => 'Цифр';

  @override
  String get fieldPeriod => 'Интервал (секунды)';

  @override
  String get fieldCounter => 'Счётчик';

  @override
  String get formatMicroQr => 'Micro QR-код';

  @override
  String get formatUnknown => 'Неизвестно';

  @override
  String formatLine(String format) {
    return 'Формат: $format';
  }

  @override
  String hostLine(String host) {
    return 'Хост: $host';
  }

  @override
  String get copied => 'Скопировано в буфер обмена';

  @override
  String get copy => 'Копировать';

  @override
  String get openEllipsis => 'Открыть …';

  @override
  String get openLinkTitle => 'Открыть ссылку?';

  @override
  String get open => 'Открыть';

  @override
  String get cancel => 'Отмена';

  @override
  String get historyClear => 'Очистить историю';

  @override
  String get historyClearTitle => 'Очистить историю?';

  @override
  String get historyClearBody => 'Все сохранённые данные будут удалены.';

  @override
  String get delete => 'Удалить';

  @override
  String get historyEmpty => 'Пока нет отсканированных данных.';

  @override
  String get infoDeveloper => 'Разработчик';

  @override
  String get infoVersion => 'Версия';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (сборка $build)';
  }

  @override
  String get infoBuildDate => 'Дата сборки';

  @override
  String get infoInstalled => 'Установлено';

  @override
  String get valueUnknown => 'неизвестно';

  @override
  String get licenses => 'Лицензии';

  @override
  String get close => 'Закрыть';

  @override
  String get actionEmail => 'Написать письмо…';

  @override
  String get actionCall => 'Позвонить…';

  @override
  String get actionSms => 'Написать SMS…';

  @override
  String get actionMap => 'Показать на карте…';

  @override
  String get actionOtp => 'Открыть в аутентификаторе…';

  @override
  String get actionLookUp => 'Найти в интернете…';

  @override
  String get actionAddContact => 'В контакты…';

  @override
  String get actionAddEvent => 'В календарь…';

  @override
  String get actionTrack => 'Отследить отправление…';

  @override
  String get noAppFound => 'Не найдено приложение для открытия.';

  @override
  String get share => 'Поделиться';

  @override
  String get historySearch => 'Поиск в истории';

  @override
  String get historyNoMatches => 'Ничего не найдено';

  @override
  String get historyExport => 'Экспорт';

  @override
  String get exportCsv => 'Поделиться как CSV';

  @override
  String get exportJson => 'Поделиться как JSON';

  @override
  String get historyEntryDeleted => 'Запись удалена';

  @override
  String get undo => 'Отменить';

  @override
  String get otpNotSaved => 'Коды 2FA не сохраняются в истории.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Почтовая марка (Deutsche Post)';

  @override
  String get fieldGtin => 'Номер товара (GTIN)';

  @override
  String get fieldCheckDigit => 'Контрольная цифра';

  @override
  String get fieldGs1Prefix => 'Выдан в (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Трек-номер';

  @override
  String get valueValid => 'верна';

  @override
  String get valueInvalid => 'неверна';

  @override
  String get valueInStore => 'Внутренний номер магазина';

  @override
  String get valueCoupon => 'Купон';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'Об этих данных';

  @override
  String get infoLocal =>
      'QR Viewer прочитал эти данные прямо из кода. Это происходит только на вашем устройстве — ничего не отправляется в интернет.';

  @override
  String infoOnline(String action, String host) {
    return 'Если нажать «$action», браузер откроет сайт $host. Этот сайт увидит, что вы ищете, и, как любой сайт, ваш интернет-адрес. То, что он покажет, приходит извне приложения — QR Viewer не может проверить, верно ли это.';
  }

  @override
  String infoOtherApp(String action) {
    return 'Если нажать «$action», данные передаются другому приложению на устройстве, например почте, телефону, картам или календарю. Дальше ими распоряжается это приложение.';
  }

  @override
  String get infoKindText =>
      'Обычный текст. Код содержит только эти слова или символы — ничего больше.';

  @override
  String get infoKindUrl =>
      'Веб-адрес (ссылка). Он ведёт на страницу в интернете или открывает другое приложение. Ссылка может вести куда угодно — открывайте её, только если доверяете источнику кода.';

  @override
  String get infoKindEmail =>
      'Адрес электронной почты, часто с готовой темой и текстом. Ничего не отправится, пока вы сами не отправите письмо в почтовом приложении.';

  @override
  String get infoKindPhone =>
      'Номер телефона. QR Viewer никогда не звонит сам — приложение «Телефон» лишь открывается с введённым номером.';

  @override
  String get infoKindSms =>
      'Номер телефона с готовым SMS. Сообщение уйдёт, только если вы отправите его сами, — SMS могут быть платными.';

  @override
  String get infoKindGeo =>
      'Место на Земле, заданное координатами (широта и долгота). Приложение карт покажет, где оно находится.';

  @override
  String get infoKindContact =>
      'Цифровая визитка с данными человека: имя, телефон, адрес. Её можно сохранить в контакты.';

  @override
  String get infoKindEvent =>
      'Встреча с датой, временем и часто местом. Её можно добавить в календарь.';

  @override
  String get infoKindWifi =>
      'Данные для подключения к Wi-Fi: имя сети и обычно пароль. Любой, кто видит этот код, может пользоваться сетью.';

  @override
  String get infoKindPayment =>
      'Подготовленный банковский перевод (GiroCode): получатель, IBAN, сумма и назначение платежа. Банковское приложение может их подставить — перед оплатой проверьте каждую деталь.';

  @override
  String get infoKindOtp =>
      'Секретный ключ для двухэтапного входа (2FA). Приложение-аутентификатор создаёт с его помощью короткие коды входа. Храните его в тайне — QR Viewer не сохраняет его в истории.';

  @override
  String get infoKindProduct =>
      'Номер товара из штрихкода (GTIN/EAN). Он лишь обозначает товар — названия, цены или состава в коде нет. Первые цифры показывают, в какой стране выдан номер, а не обязательно где произведён товар.';

  @override
  String get infoKindBook =>
      'Номер книги (ISBN) или журнала (ISSN). Он обозначает именно это издание — названия и автора в коде нет.';

  @override
  String get infoKindJson =>
      'Структурированные данные в формате JSON, которыми обмениваются компьютерные программы. QR Viewer лишь показывает их с удобными отступами.';

  @override
  String get infoKindPostage =>
      'Код на марке или Internetmarke Deutsche Post. В нём есть номер отслеживания письма.';

  @override
  String get infoKindVdv =>
      'Электронный билет на автобус и поезд (VDV eTicket, например Deutschlandticket). Цифровая подпись защищает его от изменений; QR Viewer проверяет её открытыми ключами транспортных компаний.';
}
