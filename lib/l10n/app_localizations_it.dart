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

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get scanTitleQr => 'Scansiona codice QR';

  @override
  String get scanTitleBarcode => 'Scansiona codice a barre';

  @override
  String get scanTitleDataMatrix => 'Scansiona Data Matrix';

  @override
  String get scanTitlePdf417 => 'Scansiona PDF417';

  @override
  String get scanTitleAztec => 'Scansiona codice Aztec';

  @override
  String get scanTitleAll => 'Scansiona tutti i codici';

  @override
  String get modeQr => 'Codice QR';

  @override
  String get modeBarcode => 'Codice a barre';

  @override
  String get modeAll => 'Tutti i codici';

  @override
  String get hintQr => 'Link, testo, Wi-Fi, contatti';

  @override
  String get hintDataMatrix => 'Etichette dei pacchi, francobolli, componenti';

  @override
  String get hintPdf417 => 'Carte d\'imbarco, documenti d\'identità';

  @override
  String get hintAztec => 'Biglietti del treno e aerei';

  @override
  String get hintAll => 'Tutti i formati supportati';

  @override
  String get chooseScanType => 'Scegli il tipo di codice';

  @override
  String get history => 'Cronologia';

  @override
  String get info => 'Info';

  @override
  String get torch => 'Torcia';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Dati Wi-Fi';

  @override
  String get typeContact => 'Contatto';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typePhone => 'Numero di telefono';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Posizione';

  @override
  String get typeCalendar => 'Evento';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Codice prodotto';

  @override
  String get typeDriverLicense => 'Patente di guida';

  @override
  String get typeText => 'Testo';

  @override
  String get typeBinary => 'Dati binari';

  @override
  String byteCount(String count) {
    return '$count byte';
  }

  @override
  String get vdvTicket => 'eTicket VDV (firmato)';

  @override
  String get ticketData => 'Dati del biglietto';

  @override
  String get ticketNumber => 'Numero biglietto';

  @override
  String get ticketProduct => 'Prodotto';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket => 'Deutschlandticket per alunni e studenti';

  @override
  String get validFrom => 'Valido dal';

  @override
  String get validUntil => 'Valido fino al';

  @override
  String get issuedAt => 'Emesso il';

  @override
  String get ticketHolder => 'Titolare';

  @override
  String get birthDate => 'Data di nascita';

  @override
  String get nameMasked => 'mascherato';

  @override
  String get organizations => 'ID organizzazioni';

  @override
  String get travelClass => 'Classe';

  @override
  String get firstClass => '1ª classe';

  @override
  String get secondClass => '2ª classe';

  @override
  String get ticketPrice => 'Prezzo';

  @override
  String get signatureValid => 'Firma valida';

  @override
  String get signatureInvalid => 'Firma non valida';

  @override
  String unknownIssuer(String car) {
    return 'Nessuna chiave pubblica per questo emittente (CA $car). I dati del biglietto non sono leggibili.';
  }

  @override
  String get rawData => 'Dati grezzi (hex)';

  @override
  String get lensChoice => 'Scegli obiettivo';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automatico (il sistema sceglie l\'obiettivo)';

  @override
  String get lensUltraWideName => 'Ultra grandangolo';

  @override
  String get lensMainName => 'Fotocamera principale';

  @override
  String get lensTeleName => 'Teleobiettivo';

  @override
  String get typePayment => 'Bonifico';

  @override
  String get rawContent => 'Contenuto grezzo';

  @override
  String get valueYes => 'Sì';

  @override
  String get valueOpenNetwork => 'Nessuna (rete aperta)';

  @override
  String copyField(String label) {
    return 'Copia $label';
  }

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldNickname => 'Soprannome';

  @override
  String get fieldOrganization => 'Organizzazione';

  @override
  String get fieldJobTitle => 'Ruolo';

  @override
  String get fieldPhone => 'Telefono';

  @override
  String get fieldMobile => 'Cellulare';

  @override
  String get fieldWorkPhone => 'Telefono di lavoro';

  @override
  String get fieldHomePhone => 'Telefono di casa';

  @override
  String get fieldFax => 'Fax';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldWebsite => 'Sito web';

  @override
  String get fieldAddress => 'Indirizzo';

  @override
  String get fieldBirthday => 'Compleanno';

  @override
  String get fieldNote => 'Nota';

  @override
  String get fieldTo => 'A';

  @override
  String get fieldCc => 'Cc';

  @override
  String get fieldBcc => 'Ccn';

  @override
  String get fieldSubject => 'Oggetto';

  @override
  String get fieldMessage => 'Messaggio';

  @override
  String get fieldNumber => 'Numero';

  @override
  String get fieldLatitude => 'Latitudine';

  @override
  String get fieldLongitude => 'Longitudine';

  @override
  String get fieldAltitude => 'Altitudine';

  @override
  String get fieldQuery => 'Luogo';

  @override
  String get fieldTitle => 'Titolo';

  @override
  String get fieldLink => 'Link';

  @override
  String get fieldStart => 'Inizio';

  @override
  String get fieldEnd => 'Fine';

  @override
  String get fieldLocation => 'Luogo';

  @override
  String get fieldDescription => 'Descrizione';

  @override
  String get fieldNetwork => 'Nome rete (SSID)';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldSecurity => 'Sicurezza';

  @override
  String get fieldHidden => 'Rete nascosta';

  @override
  String get fieldEapMethod => 'Metodo EAP';

  @override
  String get fieldIdentity => 'Identità';

  @override
  String get fieldRecipient => 'Beneficiario';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Importo';

  @override
  String get fieldPurpose => 'Codice causale';

  @override
  String get fieldReference => 'Riferimento';

  @override
  String get fieldRemittance => 'Causale';

  @override
  String get fieldInfo => 'Nota per il pagatore';

  @override
  String get typeOtp => 'Password monouso (2FA)';

  @override
  String get infoSupport => 'Assistenza';

  @override
  String get fieldIssuer => 'Emittente';

  @override
  String get fieldAccount => 'Account';

  @override
  String get fieldSecret => 'Chiave segreta';

  @override
  String get fieldOtpType => 'Metodo';

  @override
  String get fieldAlgorithm => 'Algoritmo';

  @override
  String get fieldDigits => 'Cifre';

  @override
  String get fieldPeriod => 'Intervallo (secondi)';

  @override
  String get fieldCounter => 'Contatore';

  @override
  String get formatMicroQr => 'Codice Micro QR';

  @override
  String get formatUnknown => 'Sconosciuto';

  @override
  String formatLine(String format) {
    return 'Formato: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'Copiato negli appunti';

  @override
  String get copy => 'Copia';

  @override
  String get openEllipsis => 'Apri …';

  @override
  String get openLinkTitle => 'Aprire il link?';

  @override
  String get open => 'Apri';

  @override
  String get cancel => 'Annulla';

  @override
  String get historyClear => 'Cancella cronologia';

  @override
  String get historyClearTitle => 'Cancellare la cronologia?';

  @override
  String get historyClearBody => 'Tutti i contenuti salvati verranno rimossi.';

  @override
  String get delete => 'Elimina';

  @override
  String get historyEmpty => 'Nessun contenuto scansionato.';

  @override
  String get infoDeveloper => 'Sviluppatore';

  @override
  String get infoVersion => 'Versione';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (build $build)';
  }

  @override
  String get infoBuildDate => 'Data di compilazione';

  @override
  String get infoInstalled => 'Installato il';

  @override
  String get valueUnknown => 'sconosciuto';

  @override
  String get licenses => 'Licenze';

  @override
  String get close => 'Chiudi';
}
