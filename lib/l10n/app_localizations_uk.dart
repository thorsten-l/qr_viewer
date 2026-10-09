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
