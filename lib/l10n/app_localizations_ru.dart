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
}
