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
