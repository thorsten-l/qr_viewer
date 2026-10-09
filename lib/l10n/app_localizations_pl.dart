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

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get scanTitleQr => 'Skanuj kod QR';

  @override
  String get scanTitleBarcode => 'Skanuj kod kreskowy';

  @override
  String get scanTitleDataMatrix => 'Skanuj Data Matrix';

  @override
  String get scanTitlePdf417 => 'Skanuj PDF417';

  @override
  String get scanTitleAztec => 'Skanuj kod Aztec';

  @override
  String get scanTitleAll => 'Skanuj wszystkie kody';

  @override
  String get modeQr => 'Kod QR';

  @override
  String get modeBarcode => 'Kod kreskowy';

  @override
  String get modeAll => 'Wszystkie kody';

  @override
  String get hintQr => 'Linki, tekst, Wi-Fi, kontakty';

  @override
  String get hintDataMatrix => 'Etykiety paczek, znaczki, części';

  @override
  String get hintPdf417 => 'Karty pokładowe, dowody osobiste';

  @override
  String get hintAztec => 'Bilety kolejowe i lotnicze';

  @override
  String get hintAll => 'Wszystkie obsługiwane formaty';

  @override
  String get chooseScanType => 'Wybierz typ kodu';

  @override
  String get history => 'Historia';

  @override
  String get info => 'Informacje';

  @override
  String get torch => 'Latarka';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Dane Wi-Fi';

  @override
  String get typeContact => 'Kontakt';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typePhone => 'Numer telefonu';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Lokalizacja';

  @override
  String get typeCalendar => 'Wydarzenie';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Kod produktu';

  @override
  String get typeDriverLicense => 'Prawo jazdy';

  @override
  String get typeText => 'Tekst';

  @override
  String get typeBinary => 'Dane binarne';

  @override
  String byteCount(String count) {
    return '$count bajtów';
  }

  @override
  String get vdvTicket => 'eBilet VDV (podpisany)';

  @override
  String get formatMicroQr => 'Kod Micro QR';

  @override
  String get formatUnknown => 'Nieznany';

  @override
  String formatLine(String format) {
    return 'Format: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'Skopiowano do schowka';

  @override
  String get copy => 'Kopiuj';

  @override
  String get openEllipsis => 'Otwórz …';

  @override
  String get openLinkTitle => 'Otworzyć link?';

  @override
  String get open => 'Otwórz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get historyClear => 'Wyczyść historię';

  @override
  String get historyClearTitle => 'Wyczyścić historię?';

  @override
  String get historyClearBody => 'Wszystkie zapisane treści zostaną usunięte.';

  @override
  String get delete => 'Usuń';

  @override
  String get historyEmpty => 'Brak zeskanowanych treści.';

  @override
  String get infoDeveloper => 'Deweloper';

  @override
  String get infoVersion => 'Wersja';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (kompilacja $build)';
  }

  @override
  String get infoBuildDate => 'Data kompilacji';

  @override
  String get infoInstalled => 'Zainstalowano';

  @override
  String get valueUnknown => 'nieznana';

  @override
  String get licenses => 'Licencje';

  @override
  String get close => 'Zamknij';
}
