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
  String get ticketData => 'Dane biletu';

  @override
  String get ticketNumber => 'Numer biletu';

  @override
  String get ticketProduct => 'Produkt';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket dla uczniów i studentów';

  @override
  String get validFrom => 'Ważny od';

  @override
  String get validUntil => 'Ważny do';

  @override
  String get issuedAt => 'Wystawiony';

  @override
  String get ticketHolder => 'Posiadacz';

  @override
  String get birthDate => 'Data urodzenia';

  @override
  String get nameMasked => 'zamaskowane';

  @override
  String get organizations => 'Numery organizacji';

  @override
  String get travelClass => 'Klasa';

  @override
  String get firstClass => '1. klasa';

  @override
  String get secondClass => '2. klasa';

  @override
  String get ticketPrice => 'Cena';

  @override
  String get signatureValid => 'Podpis prawidłowy';

  @override
  String get signatureInvalid => 'Podpis nieprawidłowy';

  @override
  String unknownIssuer(String car) {
    return 'Brak klucza publicznego dla tego wystawcy (CA $car). Nie można odczytać danych biletu.';
  }

  @override
  String get rawData => 'Surowe dane (hex)';

  @override
  String get lensChoice => 'Wybierz obiektyw';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automatycznie (system wybiera obiektyw)';

  @override
  String get lensUltraWideName => 'Ultraszerokokątny';

  @override
  String get lensMainName => 'Aparat główny';

  @override
  String get lensTeleName => 'Teleobiektyw';

  @override
  String get typePayment => 'Przelew';

  @override
  String get rawContent => 'Surowa zawartość';

  @override
  String get valueYes => 'Tak';

  @override
  String get valueOpenNetwork => 'Brak (sieć otwarta)';

  @override
  String copyField(String label) {
    return 'Kopiuj: $label';
  }

  @override
  String get fieldName => 'Imię i nazwisko';

  @override
  String get fieldNickname => 'Pseudonim';

  @override
  String get fieldOrganization => 'Organizacja';

  @override
  String get fieldJobTitle => 'Stanowisko';

  @override
  String get fieldPhone => 'Telefon';

  @override
  String get fieldMobile => 'Komórka';

  @override
  String get fieldWorkPhone => 'Telefon służbowy';

  @override
  String get fieldHomePhone => 'Telefon domowy';

  @override
  String get fieldFax => 'Faks';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldWebsite => 'Strona WWW';

  @override
  String get fieldAddress => 'Adres';

  @override
  String get fieldBirthday => 'Urodziny';

  @override
  String get fieldNote => 'Notatka';

  @override
  String get fieldTo => 'Do';

  @override
  String get fieldCc => 'DW';

  @override
  String get fieldBcc => 'UDW';

  @override
  String get fieldSubject => 'Temat';

  @override
  String get fieldMessage => 'Wiadomość';

  @override
  String get fieldNumber => 'Numer';

  @override
  String get fieldLatitude => 'Szerokość';

  @override
  String get fieldLongitude => 'Długość';

  @override
  String get fieldAltitude => 'Wysokość';

  @override
  String get fieldQuery => 'Miejsce';

  @override
  String get fieldTitle => 'Tytuł';

  @override
  String get fieldLink => 'Link';

  @override
  String get fieldStart => 'Początek';

  @override
  String get fieldEnd => 'Koniec';

  @override
  String get fieldLocation => 'Miejsce';

  @override
  String get fieldDescription => 'Opis';

  @override
  String get fieldNetwork => 'Nazwa sieci (SSID)';

  @override
  String get fieldPassword => 'Hasło';

  @override
  String get fieldSecurity => 'Zabezpieczenia';

  @override
  String get fieldHidden => 'Sieć ukryta';

  @override
  String get fieldEapMethod => 'Metoda EAP';

  @override
  String get fieldIdentity => 'Tożsamość';

  @override
  String get fieldRecipient => 'Odbiorca';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Kwota';

  @override
  String get fieldPurpose => 'Kod celu';

  @override
  String get fieldReference => 'Referencja';

  @override
  String get fieldRemittance => 'Tytuł przelewu';

  @override
  String get fieldInfo => 'Uwaga';

  @override
  String get typeOtp => 'Hasło jednorazowe (2FA)';

  @override
  String get infoSupport => 'Pomoc';

  @override
  String get fieldIssuer => 'Wystawca';

  @override
  String get fieldAccount => 'Konto';

  @override
  String get fieldSecret => 'Klucz tajny';

  @override
  String get fieldOtpType => 'Metoda';

  @override
  String get fieldAlgorithm => 'Algorytm';

  @override
  String get fieldDigits => 'Cyfry';

  @override
  String get fieldPeriod => 'Interwał (sekundy)';

  @override
  String get fieldCounter => 'Licznik';

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

  @override
  String get actionEmail => 'Napisz e-mail…';

  @override
  String get actionCall => 'Zadzwoń…';

  @override
  String get actionSms => 'Napisz SMS…';

  @override
  String get actionMap => 'Pokaż na mapie…';

  @override
  String get actionOtp => 'Otwórz w aplikacji uwierzytelniającej…';

  @override
  String get actionLookUp => 'Wyszukaj online…';

  @override
  String get actionAddContact => 'Dodaj do kontaktów…';

  @override
  String get actionAddEvent => 'Dodaj do kalendarza…';

  @override
  String get actionTrack => 'Śledź przesyłkę…';

  @override
  String get noAppFound => 'Nie znaleziono aplikacji, aby to otworzyć.';

  @override
  String get share => 'Udostępnij';

  @override
  String get historySearch => 'Szukaj w historii';

  @override
  String get historyNoMatches => 'Brak wyników';

  @override
  String get historyExport => 'Eksportuj';

  @override
  String get exportCsv => 'Udostępnij jako CSV';

  @override
  String get exportJson => 'Udostępnij jako JSON';

  @override
  String get historyEntryDeleted => 'Usunięto wpis';

  @override
  String get undo => 'Cofnij';

  @override
  String get otpNotSaved => 'Kody 2FA nie są zapisywane w historii.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Znaczek (Deutsche Post)';

  @override
  String get fieldGtin => 'Numer artykułu (GTIN)';

  @override
  String get fieldCheckDigit => 'Cyfra kontrolna';

  @override
  String get fieldGs1Prefix => 'Nadany w (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Numer przesyłki';

  @override
  String get valueValid => 'poprawna';

  @override
  String get valueInvalid => 'niepoprawna';

  @override
  String get valueInStore => 'Numer wewnętrzny sklepu';

  @override
  String get valueCoupon => 'Kupon';

  @override
  String get valueGs1Global => 'GS1 Global Office';
}
