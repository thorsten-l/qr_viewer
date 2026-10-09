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
