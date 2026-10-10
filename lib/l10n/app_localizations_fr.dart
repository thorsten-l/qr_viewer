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

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get scanTitleQr => 'Scanner un QR code';

  @override
  String get scanTitleBarcode => 'Scanner un code-barres';

  @override
  String get scanTitleDataMatrix => 'Scanner un Data Matrix';

  @override
  String get scanTitlePdf417 => 'Scanner un PDF417';

  @override
  String get scanTitleAztec => 'Scanner un code Aztec';

  @override
  String get scanTitleAll => 'Scanner tous les codes';

  @override
  String get modeQr => 'QR code';

  @override
  String get modeBarcode => 'Code-barres';

  @override
  String get modeAll => 'Tous les codes';

  @override
  String get hintQr => 'Liens, texte, Wi-Fi, contacts';

  @override
  String get hintDataMatrix => 'Étiquettes de colis, timbres, composants';

  @override
  String get hintPdf417 => 'Cartes d\'embarquement, pièces d\'identité';

  @override
  String get hintAztec => 'Billets de train et d\'avion';

  @override
  String get hintAll => 'Tous les formats pris en charge';

  @override
  String get chooseScanType => 'Choisir le type de code';

  @override
  String get history => 'Historique';

  @override
  String get info => 'Infos';

  @override
  String get torch => 'Lampe torche';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Identifiants Wi-Fi';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typePhone => 'Numéro de téléphone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Position';

  @override
  String get typeCalendar => 'Événement';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Code produit';

  @override
  String get typeDriverLicense => 'Permis de conduire';

  @override
  String get typeText => 'Texte';

  @override
  String get typeBinary => 'Données binaires';

  @override
  String byteCount(String count) {
    return '$count octets';
  }

  @override
  String get vdvTicket => 'eTicket VDV (signé)';

  @override
  String get ticketData => 'Données du billet';

  @override
  String get ticketNumber => 'Numéro de billet';

  @override
  String get ticketProduct => 'Produit';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket pour élèves et étudiants';

  @override
  String get validFrom => 'Valable du';

  @override
  String get validUntil => 'Valable jusqu\'au';

  @override
  String get issuedAt => 'Émis le';

  @override
  String get ticketHolder => 'Titulaire';

  @override
  String get birthDate => 'Date de naissance';

  @override
  String get nameMasked => 'masqué';

  @override
  String get organizations => 'ID des organismes';

  @override
  String get travelClass => 'Classe';

  @override
  String get firstClass => '1re classe';

  @override
  String get secondClass => '2e classe';

  @override
  String get ticketPrice => 'Prix';

  @override
  String get signatureValid => 'Signature valide';

  @override
  String get signatureInvalid => 'Signature non valide';

  @override
  String unknownIssuer(String car) {
    return 'Aucune clé publique pour cet émetteur (CA $car). Les données du billet ne peuvent pas être lues.';
  }

  @override
  String get rawData => 'Données brutes (hex)';

  @override
  String get lensChoice => 'Choisir l\'objectif';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Télé';

  @override
  String get lensAutoName => 'Automatique (le système choisit l\'objectif)';

  @override
  String get lensUltraWideName => 'Ultra grand-angle';

  @override
  String get lensMainName => 'Caméra principale';

  @override
  String get lensTeleName => 'Téléobjectif';

  @override
  String get formatMicroQr => 'Micro QR code';

  @override
  String get formatUnknown => 'Inconnu';

  @override
  String formatLine(String format) {
    return 'Format : $format';
  }

  @override
  String hostLine(String host) {
    return 'Hôte : $host';
  }

  @override
  String get copied => 'Copié dans le presse-papiers';

  @override
  String get copy => 'Copier';

  @override
  String get openEllipsis => 'Ouvrir …';

  @override
  String get openLinkTitle => 'Ouvrir le lien ?';

  @override
  String get open => 'Ouvrir';

  @override
  String get cancel => 'Annuler';

  @override
  String get historyClear => 'Effacer l\'historique';

  @override
  String get historyClearTitle => 'Effacer l\'historique ?';

  @override
  String get historyClearBody =>
      'Tous les contenus enregistrés seront supprimés.';

  @override
  String get delete => 'Supprimer';

  @override
  String get historyEmpty => 'Aucun contenu scanné pour l\'instant.';

  @override
  String get infoDeveloper => 'Développeur';

  @override
  String get infoVersion => 'Version';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (build $build)';
  }

  @override
  String get infoBuildDate => 'Date de compilation';

  @override
  String get infoInstalled => 'Installé le';

  @override
  String get valueUnknown => 'inconnu';

  @override
  String get licenses => 'Licences';

  @override
  String get close => 'Fermer';
}
