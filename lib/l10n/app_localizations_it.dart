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
