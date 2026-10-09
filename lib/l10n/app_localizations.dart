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

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('uk'),
    Locale('zh'),
  ];

  /// Titel im Modus QR-Code
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanTitleQr;

  /// Titel im Modus Barcode
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
  String get scanTitleBarcode;

  /// Titel im Modus Data Matrix
  ///
  /// In en, this message translates to:
  /// **'Scan Data Matrix'**
  String get scanTitleDataMatrix;

  /// Titel im Modus PDF417
  ///
  /// In en, this message translates to:
  /// **'Scan PDF417'**
  String get scanTitlePdf417;

  /// Titel im Modus Aztec
  ///
  /// In en, this message translates to:
  /// **'Scan Aztec code'**
  String get scanTitleAztec;

  /// Titel im Modus alle Codes
  ///
  /// In en, this message translates to:
  /// **'Scan all codes'**
  String get scanTitleAll;

  /// Menüeintrag und Formatname QR-Code
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get modeQr;

  /// Menüeintrag Barcode
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get modeBarcode;

  /// Menüeintrag alle Codes
  ///
  /// In en, this message translates to:
  /// **'All codes'**
  String get modeAll;

  /// Beispiele für QR-Codes
  ///
  /// In en, this message translates to:
  /// **'Links, text, Wi-Fi, contacts'**
  String get hintQr;

  /// Beispiele für Data Matrix
  ///
  /// In en, this message translates to:
  /// **'Parcel labels, stamps, components'**
  String get hintDataMatrix;

  /// Beispiele für PDF417
  ///
  /// In en, this message translates to:
  /// **'Boarding passes, ID cards'**
  String get hintPdf417;

  /// Beispiele für Aztec
  ///
  /// In en, this message translates to:
  /// **'Train and plane tickets'**
  String get hintAztec;

  /// Beschreibung alle Codes
  ///
  /// In en, this message translates to:
  /// **'All supported formats'**
  String get hintAll;

  /// Tooltip des Auswahlmenüs
  ///
  /// In en, this message translates to:
  /// **'Choose scan type'**
  String get chooseScanType;

  /// Verlauf: Tooltip und Seitentitel
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Tooltip Info
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// Tooltip Taschenlampe
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get torch;

  /// Inhaltstyp URL
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get typeUrl;

  /// Inhaltstyp WLAN
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi credentials'**
  String get typeWifi;

  /// Inhaltstyp Kontakt
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get typeContact;

  /// Inhaltstyp E-Mail
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get typeEmail;

  /// Inhaltstyp Telefon
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get typePhone;

  /// Inhaltstyp SMS
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get typeSms;

  /// Inhaltstyp Ort
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get typeGeo;

  /// Inhaltstyp Termin
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get typeCalendar;

  /// Inhaltstyp ISBN
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get typeIsbn;

  /// Inhaltstyp Produktcode
  ///
  /// In en, this message translates to:
  /// **'Product code'**
  String get typeProduct;

  /// Inhaltstyp Führerschein
  ///
  /// In en, this message translates to:
  /// **'Driver\'s license'**
  String get typeDriverLicense;

  /// Inhaltstyp Text
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get typeText;

  /// Formatname Micro-QR
  ///
  /// In en, this message translates to:
  /// **'Micro QR code'**
  String get formatMicroQr;

  /// Unbekanntes Format
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get formatUnknown;

  /// Formatzeile im Ergebnis
  ///
  /// In en, this message translates to:
  /// **'Format: {format}'**
  String formatLine(String format);

  /// Hostzeile bei Links
  ///
  /// In en, this message translates to:
  /// **'Host: {host}'**
  String hostLine(String host);

  /// Meldung nach dem Kopieren
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copied;

  /// Knopf Kopieren
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Knopf Link öffnen (mit Rückfrage)
  ///
  /// In en, this message translates to:
  /// **'Open …'**
  String get openEllipsis;

  /// Titel der Rückfrage vor dem Öffnen
  ///
  /// In en, this message translates to:
  /// **'Open link?'**
  String get openLinkTitle;

  /// Knopf Öffnen in der Rückfrage
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Knopf Abbrechen
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Tooltip Verlauf löschen
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get historyClear;

  /// Titel der Rückfrage Verlauf löschen
  ///
  /// In en, this message translates to:
  /// **'Clear history?'**
  String get historyClearTitle;

  /// Text der Rückfrage Verlauf löschen
  ///
  /// In en, this message translates to:
  /// **'All saved contents will be removed.'**
  String get historyClearBody;

  /// Knopf Löschen
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Leerer Verlauf
  ///
  /// In en, this message translates to:
  /// **'No scanned contents yet.'**
  String get historyEmpty;

  /// Info: Entwickler
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get infoDeveloper;

  /// Info: Version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get infoVersion;

  /// Info: Versionsangabe
  ///
  /// In en, this message translates to:
  /// **'{version} (Build {build})'**
  String infoVersionValue(String version, String build);

  /// Info: Build-Datum
  ///
  /// In en, this message translates to:
  /// **'Build date'**
  String get infoBuildDate;

  /// Info: Installationszeitpunkt
  ///
  /// In en, this message translates to:
  /// **'Installed on'**
  String get infoInstalled;

  /// Unbekannter Wert
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get valueUnknown;

  /// Knopf Lizenzen
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// Knopf Schließen
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pl',
    'pt',
    'ru',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
