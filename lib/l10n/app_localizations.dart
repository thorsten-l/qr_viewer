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

  /// Inhaltstyp Binärdaten
  ///
  /// In en, this message translates to:
  /// **'Binary data'**
  String get typeBinary;

  /// Größe der Binärdaten
  ///
  /// In en, this message translates to:
  /// **'{count} bytes'**
  String byteCount(String count);

  /// Binärcode eines deutschen eTickets (VDV)
  ///
  /// In en, this message translates to:
  /// **'VDV eTicket (signed)'**
  String get vdvTicket;

  /// Überschrift Ticketdaten
  ///
  /// In en, this message translates to:
  /// **'Ticket data'**
  String get ticketData;

  /// Ticketnummer
  ///
  /// In en, this message translates to:
  /// **'Ticket number'**
  String get ticketNumber;

  /// Produkt des Tickets
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get ticketProduct;

  /// Produktname
  ///
  /// In en, this message translates to:
  /// **'Deutschlandticket'**
  String get productDeutschlandticket;

  /// Produktname
  ///
  /// In en, this message translates to:
  /// **'Deutschlandticket job ticket'**
  String get productJobticket;

  /// Produktname
  ///
  /// In en, this message translates to:
  /// **'Deutschlandticket for pupils and students'**
  String get productStudentTicket;

  /// Gültig ab
  ///
  /// In en, this message translates to:
  /// **'Valid from'**
  String get validFrom;

  /// Gültig bis
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get validUntil;

  /// Ausstellungszeit
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get issuedAt;

  /// Inhaber
  ///
  /// In en, this message translates to:
  /// **'Holder'**
  String get ticketHolder;

  /// Geburtsdatum
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birthDate;

  /// Hinweis maskierter Name
  ///
  /// In en, this message translates to:
  /// **'masked'**
  String get nameMasked;

  /// Organisationsnummern KVP/PV
  ///
  /// In en, this message translates to:
  /// **'Organisation IDs'**
  String get organizations;

  /// Wagenklasse
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get travelClass;

  /// 1. Klasse
  ///
  /// In en, this message translates to:
  /// **'1st class'**
  String get firstClass;

  /// 2. Klasse
  ///
  /// In en, this message translates to:
  /// **'2nd class'**
  String get secondClass;

  /// Preis
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get ticketPrice;

  /// Signatur gültig
  ///
  /// In en, this message translates to:
  /// **'Signature valid'**
  String get signatureValid;

  /// Signatur ungültig
  ///
  /// In en, this message translates to:
  /// **'Signature invalid'**
  String get signatureInvalid;

  /// Kein Schlüssel für die CA
  ///
  /// In en, this message translates to:
  /// **'No public key for this issuer (CA {car}). The ticket data cannot be read.'**
  String unknownIssuer(String car);

  /// Rohdaten
  ///
  /// In en, this message translates to:
  /// **'Raw data (hex)'**
  String get rawData;

  /// Tooltip der Objektivauswahl
  ///
  /// In en, this message translates to:
  /// **'Choose lens'**
  String get lensChoice;

  /// Kurzlabel automatische Objektivwahl
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get lensAuto;

  /// Kurzlabel Teleobjektiv
  ///
  /// In en, this message translates to:
  /// **'Tele'**
  String get lensTele;

  /// Name automatische Objektivwahl
  ///
  /// In en, this message translates to:
  /// **'Automatic (system chooses the lens)'**
  String get lensAutoName;

  /// Name Ultraweitwinkel
  ///
  /// In en, this message translates to:
  /// **'Ultra wide'**
  String get lensUltraWideName;

  /// Name Hauptkamera
  ///
  /// In en, this message translates to:
  /// **'Main camera'**
  String get lensMainName;

  /// Name Teleobjektiv
  ///
  /// In en, this message translates to:
  /// **'Telephoto'**
  String get lensTeleName;

  /// Inhaltsart Überweisung
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get typePayment;

  /// Überschrift Rohinhalt
  ///
  /// In en, this message translates to:
  /// **'Raw content'**
  String get rawContent;

  /// Ja
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get valueYes;

  /// Offenes WLAN
  ///
  /// In en, this message translates to:
  /// **'None (open network)'**
  String get valueOpenNetwork;

  /// Tooltip Feld kopieren
  ///
  /// In en, this message translates to:
  /// **'Copy {label}'**
  String copyField(String label);

  /// Feld Name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// Feld Spitzname
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get fieldNickname;

  /// Feld Firma
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get fieldOrganization;

  /// Feld Position
  ///
  /// In en, this message translates to:
  /// **'Job title'**
  String get fieldJobTitle;

  /// Feld Telefon
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// Feld Mobil
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get fieldMobile;

  /// Feld Telefon geschäftlich
  ///
  /// In en, this message translates to:
  /// **'Work phone'**
  String get fieldWorkPhone;

  /// Feld Telefon privat
  ///
  /// In en, this message translates to:
  /// **'Home phone'**
  String get fieldHomePhone;

  /// Feld Fax
  ///
  /// In en, this message translates to:
  /// **'Fax'**
  String get fieldFax;

  /// Feld E-Mail
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// Feld Webseite
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get fieldWebsite;

  /// Feld Adresse
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get fieldAddress;

  /// Feld Geburtstag
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get fieldBirthday;

  /// Feld Notiz
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get fieldNote;

  /// Feld An
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get fieldTo;

  /// Feld Kopie
  ///
  /// In en, this message translates to:
  /// **'Cc'**
  String get fieldCc;

  /// Feld Blindkopie
  ///
  /// In en, this message translates to:
  /// **'Bcc'**
  String get fieldBcc;

  /// Feld Betreff
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get fieldSubject;

  /// Feld Nachricht
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get fieldMessage;

  /// Feld Rufnummer
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get fieldNumber;

  /// Feld Breitengrad
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get fieldLatitude;

  /// Feld Längengrad
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get fieldLongitude;

  /// Feld Höhe
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get fieldAltitude;

  /// Feld Suche/Ort
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get fieldQuery;

  /// Feld Titel
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitle;

  /// Feld Link
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get fieldLink;

  /// Feld Beginn
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get fieldStart;

  /// Feld Ende
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get fieldEnd;

  /// Feld Ort Termin
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get fieldLocation;

  /// Feld Beschreibung
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get fieldDescription;

  /// Feld WLAN-Name
  ///
  /// In en, this message translates to:
  /// **'Network name (SSID)'**
  String get fieldNetwork;

  /// Feld Passwort
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// Feld Verschlüsselung
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get fieldSecurity;

  /// Feld verstecktes Netz
  ///
  /// In en, this message translates to:
  /// **'Hidden network'**
  String get fieldHidden;

  /// Feld EAP-Methode
  ///
  /// In en, this message translates to:
  /// **'EAP method'**
  String get fieldEapMethod;

  /// Feld Identität
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get fieldIdentity;

  /// Feld Empfänger
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get fieldRecipient;

  /// Feld IBAN
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get fieldIban;

  /// Feld BIC
  ///
  /// In en, this message translates to:
  /// **'BIC'**
  String get fieldBic;

  /// Feld Betrag
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// Feld Zweck-Code
  ///
  /// In en, this message translates to:
  /// **'Purpose code'**
  String get fieldPurpose;

  /// Feld Referenz
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get fieldReference;

  /// Feld Verwendungszweck
  ///
  /// In en, this message translates to:
  /// **'Payment reference'**
  String get fieldRemittance;

  /// Feld Hinweis
  ///
  /// In en, this message translates to:
  /// **'Note to payer'**
  String get fieldInfo;

  /// Inhaltsart Einmalpasswort
  ///
  /// In en, this message translates to:
  /// **'One-time password (2FA)'**
  String get typeOtp;

  /// Info-Dialog Support
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get infoSupport;

  /// Feld Anbieter
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get fieldIssuer;

  /// Feld Konto
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get fieldAccount;

  /// Feld geheimer Schlüssel
  ///
  /// In en, this message translates to:
  /// **'Secret key'**
  String get fieldSecret;

  /// Feld OTP-Verfahren
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get fieldOtpType;

  /// Feld Algorithmus
  ///
  /// In en, this message translates to:
  /// **'Algorithm'**
  String get fieldAlgorithm;

  /// Feld Stellen
  ///
  /// In en, this message translates to:
  /// **'Digits'**
  String get fieldDigits;

  /// Feld Intervall
  ///
  /// In en, this message translates to:
  /// **'Interval (seconds)'**
  String get fieldPeriod;

  /// Feld Zähler
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get fieldCounter;

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

  /// Knopf E-Mail schreiben (mit Rückfrage)
  ///
  /// In en, this message translates to:
  /// **'Write email…'**
  String get actionEmail;

  /// Knopf Anrufen (öffnet nur den Wähler)
  ///
  /// In en, this message translates to:
  /// **'Call…'**
  String get actionCall;

  /// Knopf SMS schreiben
  ///
  /// In en, this message translates to:
  /// **'Write SMS…'**
  String get actionSms;

  /// Knopf Ort in Karten zeigen
  ///
  /// In en, this message translates to:
  /// **'Show on map…'**
  String get actionMap;

  /// Knopf Einmalpasswort an Authenticator-App geben
  ///
  /// In en, this message translates to:
  /// **'Open in authenticator…'**
  String get actionOtp;

  /// Knopf Produkt oder Buch online nachschlagen
  ///
  /// In en, this message translates to:
  /// **'Look up online…'**
  String get actionLookUp;

  /// Knopf Kontakt übernehmen (Teilen-Menü)
  ///
  /// In en, this message translates to:
  /// **'Add to contacts…'**
  String get actionAddContact;

  /// Knopf Termin übernehmen (Teilen-Menü)
  ///
  /// In en, this message translates to:
  /// **'Add to calendar…'**
  String get actionAddEvent;

  /// Knopf Sendung verfolgen
  ///
  /// In en, this message translates to:
  /// **'Track shipment…'**
  String get actionTrack;

  /// Meldung: keine App für die Aktion
  ///
  /// In en, this message translates to:
  /// **'No app found to open this.'**
  String get noAppFound;

  /// Tooltip Teilen
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Tooltip und Hinweis der Verlaufssuche
  ///
  /// In en, this message translates to:
  /// **'Search history'**
  String get historySearch;

  /// Verlaufssuche ohne Treffer
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get historyNoMatches;

  /// Tooltip Verlauf exportieren
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get historyExport;

  /// Menü Verlauf als CSV teilen
  ///
  /// In en, this message translates to:
  /// **'Share as CSV'**
  String get exportCsv;

  /// Menü Verlauf als JSON teilen
  ///
  /// In en, this message translates to:
  /// **'Share as JSON'**
  String get exportJson;

  /// Meldung nach Löschen eines Eintrags
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get historyEntryDeleted;

  /// Knopf Rückgängig
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Hinweis: 2FA-Codes nicht im Verlauf
  ///
  /// In en, this message translates to:
  /// **'2FA codes are not saved in the history.'**
  String get otpNotSaved;

  /// Inhaltsart JSON
  ///
  /// In en, this message translates to:
  /// **'JSON'**
  String get typeJson;

  /// Inhaltsart Briefmarke der Deutschen Post
  ///
  /// In en, this message translates to:
  /// **'Postage stamp (Deutsche Post)'**
  String get typePostage;

  /// Feld Artikelnummer
  ///
  /// In en, this message translates to:
  /// **'Item number (GTIN)'**
  String get fieldGtin;

  /// Feld Prüfziffer
  ///
  /// In en, this message translates to:
  /// **'Check digit'**
  String get fieldCheckDigit;

  /// Feld Land der Nummernvergabe (GS1)
  ///
  /// In en, this message translates to:
  /// **'Registered in (GS1)'**
  String get fieldGs1Prefix;

  /// Feld ISBN
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get fieldIsbn;

  /// Feld ISBN-10
  ///
  /// In en, this message translates to:
  /// **'ISBN-10'**
  String get fieldIsbn10;

  /// Feld ISSN
  ///
  /// In en, this message translates to:
  /// **'ISSN'**
  String get fieldIssn;

  /// Feld Sendungsnummer
  ///
  /// In en, this message translates to:
  /// **'Tracking number'**
  String get fieldTrackingNumber;

  /// Wert gültig
  ///
  /// In en, this message translates to:
  /// **'valid'**
  String get valueValid;

  /// Wert ungültig
  ///
  /// In en, this message translates to:
  /// **'invalid'**
  String get valueInvalid;

  /// Wert interne Nummer des Handels
  ///
  /// In en, this message translates to:
  /// **'In-store number'**
  String get valueInStore;

  /// Wert Gutschein
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get valueCoupon;

  /// Wert GS1 Global Office
  ///
  /// In en, this message translates to:
  /// **'GS1 Global Office'**
  String get valueGs1Global;

  /// Tooltip Info-Knopf der Datenkarte
  ///
  /// In en, this message translates to:
  /// **'About this data'**
  String get dataInfo;

  /// Info-Dialog: Daten wurden nur lokal gelesen
  ///
  /// In en, this message translates to:
  /// **'QR Viewer read these details directly from the code. This happens only on your device – nothing is sent to the internet.'**
  String get infoLocal;

  /// Info-Dialog: Aktion öffnet eine Website; action = Knopftext, host = Website
  ///
  /// In en, this message translates to:
  /// **'If you tap “{action}”, your browser opens the website {host}. That website then sees what you are looking for and, like any website, your internet address. What it shows comes from outside the app – QR Viewer cannot check whether it is correct.'**
  String infoOnline(String action, String host);

  /// Info-Dialog: Aktion gibt Daten an eine andere App; action = Knopftext
  ///
  /// In en, this message translates to:
  /// **'If you tap “{action}”, the data is handed to another app on your device, for example mail, phone, maps or calendar. From then on, that app decides what happens with it.'**
  String infoOtherApp(String action);

  /// Info-Dialog: Erklärung Text
  ///
  /// In en, this message translates to:
  /// **'Plain text. The code contains just these words or characters – nothing more.'**
  String get infoKindText;

  /// Info-Dialog: Erklärung Link
  ///
  /// In en, this message translates to:
  /// **'A web address (link). It leads to a page on the internet or opens another app. A link can lead anywhere – only open it if you trust where the code comes from.'**
  String get infoKindUrl;

  /// Info-Dialog: Erklärung E-Mail
  ///
  /// In en, this message translates to:
  /// **'An email address, often with a prepared subject and message. Nothing is sent until you send the email yourself in your mail app.'**
  String get infoKindEmail;

  /// Info-Dialog: Erklärung Telefon
  ///
  /// In en, this message translates to:
  /// **'A phone number. QR Viewer never calls by itself – the phone app only opens with the number filled in.'**
  String get infoKindPhone;

  /// Info-Dialog: Erklärung SMS
  ///
  /// In en, this message translates to:
  /// **'A phone number with a prepared text message. The message is only sent if you send it yourself – text messages may cost money.'**
  String get infoKindSms;

  /// Info-Dialog: Erklärung Ort
  ///
  /// In en, this message translates to:
  /// **'A place on Earth, given as coordinates (latitude and longitude). A map app can show you where it is.'**
  String get infoKindGeo;

  /// Info-Dialog: Erklärung Kontakt
  ///
  /// In en, this message translates to:
  /// **'A digital business card with a person\'s details, such as name, phone number and address. You can save it to your contacts.'**
  String get infoKindContact;

  /// Info-Dialog: Erklärung Termin
  ///
  /// In en, this message translates to:
  /// **'An appointment with date, time and often a place. You can add it to your calendar.'**
  String get infoKindEvent;

  /// Info-Dialog: Erklärung WLAN
  ///
  /// In en, this message translates to:
  /// **'The access details for a Wi-Fi network: its name and usually the password. Anyone who can see this code can use the network.'**
  String get infoKindWifi;

  /// Info-Dialog: Erklärung Überweisung
  ///
  /// In en, this message translates to:
  /// **'A prepared bank transfer (GiroCode): recipient, IBAN, amount and reference. A banking app can take these over – check every detail before you pay.'**
  String get infoKindPayment;

  /// Info-Dialog: Erklärung Einmalpasswort
  ///
  /// In en, this message translates to:
  /// **'A secret key for two-step login (2FA). An authenticator app uses it to create the short login codes. Keep it secret – QR Viewer does not save it in the history.'**
  String get infoKindOtp;

  /// Info-Dialog: Erklärung Artikelnummer
  ///
  /// In en, this message translates to:
  /// **'The article number from a product\'s barcode (GTIN/EAN). It only identifies the product – the code itself contains no name, price or ingredients. The first digits show which country assigned the number, not necessarily where the product was made.'**
  String get infoKindProduct;

  /// Info-Dialog: Erklärung ISBN/ISSN
  ///
  /// In en, this message translates to:
  /// **'The number of a book (ISBN) or magazine (ISSN). It identifies exactly this edition – title and author are not in the code.'**
  String get infoKindBook;

  /// Info-Dialog: Erklärung JSON
  ///
  /// In en, this message translates to:
  /// **'Structured data in JSON format, as exchanged between computer programs. QR Viewer only shows it neatly indented.'**
  String get infoKindJson;

  /// Info-Dialog: Erklärung Briefmarke
  ///
  /// In en, this message translates to:
  /// **'The code on a Deutsche Post stamp or Internetmarke. It contains a tracking number for the letter.'**
  String get infoKindPostage;

  /// Info-Dialog: Erklärung VDV-eTicket
  ///
  /// In en, this message translates to:
  /// **'An electronic ticket for buses and trains (VDV eTicket, e.g. Deutschlandticket). A digital signature protects it against changes; QR Viewer checks it with the publicly known keys of the transport companies.'**
  String get infoKindVdv;

  /// Inhaltsart Matter-Gerät
  ///
  /// In en, this message translates to:
  /// **'Matter device'**
  String get typeMatter;

  /// Matter: Hersteller-ID
  ///
  /// In en, this message translates to:
  /// **'Vendor ID'**
  String get fieldVendorId;

  /// Matter: Produkt-ID
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get fieldProductId;

  /// Matter: Diskriminator
  ///
  /// In en, this message translates to:
  /// **'Discriminator'**
  String get fieldDiscriminator;

  /// Matter: Einrichtungscode (Passcode)
  ///
  /// In en, this message translates to:
  /// **'Setup code (PIN)'**
  String get fieldSetupCode;

  /// Matter: manueller Kopplungscode
  ///
  /// In en, this message translates to:
  /// **'Manual pairing code'**
  String get fieldManualCode;

  /// Matter: Verbindungsarten beim Einrichten
  ///
  /// In en, this message translates to:
  /// **'Setup via'**
  String get fieldDiscovery;

  /// Matter: Einrichtungsablauf
  ///
  /// In en, this message translates to:
  /// **'Setup flow'**
  String get fieldFlow;

  /// Matter-Ablauf: Standard
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get valueFlowStandard;

  /// Matter-Ablauf: Gerät erst aktivieren
  ///
  /// In en, this message translates to:
  /// **'Activate the device first (e.g. press a button)'**
  String get valueFlowUserAction;

  /// Matter-Ablauf: Hersteller-App nötig
  ///
  /// In en, this message translates to:
  /// **'Manufacturer\'s app required'**
  String get valueFlowCustom;

  /// Matter-Verbindung: WLAN-Zugangspunkt des Geräts
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi access point (SoftAP)'**
  String get valueDiscoverySoftAp;

  /// Matter-Verbindung: Gerät ist schon im Netzwerk
  ///
  /// In en, this message translates to:
  /// **'Existing network'**
  String get valueDiscoveryOnNetwork;

  /// Info-Dialog: Erklärung Matter-Gerät
  ///
  /// In en, this message translates to:
  /// **'The setup data of a smart home device using the Matter standard. Your smart home app (e.g. Apple Home, Google Home) uses it to add the device – scan the code there or type in the manual pairing code. Anyone with this code can pair the device while it is in setup mode.'**
  String get infoKindMatter;

  /// Info-Dialog: Knopf zu den Anleitungen
  ///
  /// In en, this message translates to:
  /// **'Manuals'**
  String get infoManuals;

  /// Inhaltsart Lesezeichen (MEBKM)
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get typeBookmark;

  /// Info-Dialog: Erklärung Lesezeichen
  ///
  /// In en, this message translates to:
  /// **'A bookmark: a link to a website together with a name for it (MEBKM format). Like any link, it can lead anywhere – only open it if you trust where the code comes from.'**
  String get infoKindBookmark;
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
