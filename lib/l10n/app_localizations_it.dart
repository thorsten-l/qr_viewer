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
  String get showCode => 'Mostra codice';

  @override
  String shownAsQr(String format) {
    return 'Impossibile disegnare $format qui; mostrato come codice QR.';
  }

  @override
  String get codeTooLarge =>
      'Il contenuto è troppo grande per essere disegnato come codice.';

  @override
  String get close => 'Chiudi';

  @override
  String get actionEmail => 'Scrivi e-mail…';

  @override
  String get actionCall => 'Chiama…';

  @override
  String get actionSms => 'Scrivi SMS…';

  @override
  String get actionMap => 'Mostra sulla mappa…';

  @override
  String get actionOtp => 'Apri nell\'autenticatore…';

  @override
  String get actionLookUp => 'Cerca online…';

  @override
  String get actionAddContact => 'Aggiungi ai contatti…';

  @override
  String get actionAddEvent => 'Aggiungi al calendario…';

  @override
  String get actionTrack => 'Traccia spedizione…';

  @override
  String get noAppFound => 'Nessuna app trovata per aprirlo.';

  @override
  String get share => 'Condividi';

  @override
  String get historySearch => 'Cerca nella cronologia';

  @override
  String get historyNoMatches => 'Nessun risultato';

  @override
  String get historyExport => 'Esporta';

  @override
  String get exportCsv => 'Condividi come CSV';

  @override
  String get exportJson => 'Condividi come JSON';

  @override
  String get historyEntryDeleted => 'Voce eliminata';

  @override
  String get undo => 'Annulla';

  @override
  String get otpNotSaved =>
      'I codici 2FA non vengono salvati nella cronologia.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Francobollo (Deutsche Post)';

  @override
  String get fieldGtin => 'Codice articolo (GTIN)';

  @override
  String get fieldCheckDigit => 'Cifra di controllo';

  @override
  String get fieldGs1Prefix => 'Registrato in (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Numero di tracciamento';

  @override
  String get valueValid => 'valida';

  @override
  String get valueInvalid => 'non valida';

  @override
  String get valueInStore => 'Numero interno del negozio';

  @override
  String get valueCoupon => 'Buono';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'Informazioni su questi dati';

  @override
  String get infoLocal =>
      'QR Viewer ha letto questi dati direttamente dal codice. Avviene solo sul tuo dispositivo: nulla viene inviato a internet.';

  @override
  String infoOnline(String action, String host) {
    return 'Se tocchi «$action», il browser apre il sito $host. Quel sito vede cosa stai cercando e, come ogni sito web, il tuo indirizzo internet. Ciò che mostra proviene dall\'esterno dell\'app: QR Viewer non può verificare che sia corretto.';
  }

  @override
  String infoOtherApp(String action) {
    return 'Se tocchi «$action», i dati passano a un\'altra app del dispositivo, ad esempio Mail, Telefono, Mappe o Calendario. Da quel momento è quell\'app a decidere cosa farne.';
  }

  @override
  String get infoKindText =>
      'Testo semplice. Il codice contiene solo queste parole o caratteri, nient\'altro.';

  @override
  String get infoKindUrl =>
      'Un indirizzo web (link). Porta a una pagina su internet o apre un\'altra app. Un link può portare ovunque: aprilo solo se ti fidi della provenienza del codice.';

  @override
  String get infoKindEmail =>
      'Un indirizzo email, spesso con oggetto e messaggio già pronti. Non viene inviato nulla finché non invii tu stesso l\'email dalla tua app di posta.';

  @override
  String get infoKindPhone =>
      'Un numero di telefono. QR Viewer non chiama mai da solo: l\'app Telefono si apre solo con il numero già inserito.';

  @override
  String get infoKindSms =>
      'Un numero di telefono con un SMS già pronto. Il messaggio parte solo se lo invii tu: gli SMS possono costare.';

  @override
  String get infoKindGeo =>
      'Un luogo sulla Terra, indicato da coordinate (latitudine e longitudine). Un\'app di mappe può mostrarti dove si trova.';

  @override
  String get infoKindContact =>
      'Un biglietto da visita digitale con i dati di una persona, come nome, telefono e indirizzo. Puoi salvarlo nei contatti.';

  @override
  String get infoKindEvent =>
      'Un appuntamento con data, ora e spesso un luogo. Puoi aggiungerlo al calendario.';

  @override
  String get infoKindWifi =>
      'I dati di accesso a una rete Wi-Fi: il nome e di solito la password. Chiunque veda questo codice può usare la rete.';

  @override
  String get infoKindPayment =>
      'Un bonifico già pronto (GiroCode): beneficiario, IBAN, importo e causale. Un\'app bancaria può riprenderli: controlla ogni dato prima di pagare.';

  @override
  String get infoKindOtp =>
      'Una chiave segreta per l\'accesso in due passaggi (2FA). Un\'app di autenticazione la usa per creare i brevi codici di accesso. Tienila segreta: QR Viewer non la salva nella cronologia.';

  @override
  String get infoKindProduct =>
      'Il numero di articolo dal codice a barre di un prodotto (GTIN/EAN). Identifica solo il prodotto: il codice non contiene nome, prezzo o ingredienti. Le prime cifre indicano il paese che ha assegnato il numero, non per forza dove è stato prodotto.';

  @override
  String get infoKindBook =>
      'Il numero di un libro (ISBN) o di una rivista (ISSN). Identifica esattamente questa edizione: titolo e autore non sono nel codice.';

  @override
  String get infoKindJson =>
      'Dati strutturati in formato JSON, come quelli scambiati tra programmi. QR Viewer si limita a mostrarli ben indentati.';

  @override
  String get infoKindPostage =>
      'Il codice su un francobollo o Internetmarke di Deutsche Post. Contiene un numero di tracciamento per la lettera.';

  @override
  String get infoKindVdv =>
      'Un biglietto elettronico per autobus e treni (VDV eTicket, ad es. Deutschlandticket). Una firma digitale lo protegge da modifiche; QR Viewer la verifica con le chiavi pubbliche delle aziende di trasporto.';

  @override
  String get typeMatter => 'Dispositivo Matter';

  @override
  String get fieldVendorId => 'ID produttore';

  @override
  String get fieldProductId => 'ID prodotto';

  @override
  String get fieldDiscriminator => 'Discriminatore';

  @override
  String get fieldSetupCode => 'Codice di configurazione (PIN)';

  @override
  String get fieldManualCode => 'Codice di associazione manuale';

  @override
  String get fieldDiscovery => 'Configurazione tramite';

  @override
  String get fieldFlow => 'Procedura di configurazione';

  @override
  String get valueFlowStandard => 'Standard';

  @override
  String get valueFlowUserAction =>
      'Attiva prima il dispositivo (ad es. premi un pulsante)';

  @override
  String get valueFlowCustom => 'Serve l\'app del produttore';

  @override
  String get valueDiscoverySoftAp => 'Punto di accesso Wi-Fi (SoftAP)';

  @override
  String get valueDiscoveryOnNetwork => 'Rete esistente';

  @override
  String get infoKindMatter =>
      'I dati di configurazione di un dispositivo smart home con lo standard Matter. La tua app smart home (ad es. Apple Casa, Google Home) li usa per aggiungere il dispositivo: scansiona il codice lì o inserisci il codice di associazione manuale. Chiunque abbia questo codice può associare il dispositivo finché è in modalità di configurazione.';

  @override
  String get infoManuals => 'Manuali';

  @override
  String get typeBookmark => 'Segnalibro';

  @override
  String get infoKindBookmark =>
      'Un segnalibro: un link a un sito web insieme a un nome (formato MEBKM). Come ogni link può portare ovunque: aprilo solo se ti fidi della provenienza del codice.';
}
