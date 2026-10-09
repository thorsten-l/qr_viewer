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

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get scanTitleQr => 'Escanear código QR';

  @override
  String get scanTitleBarcode => 'Escanear código de barras';

  @override
  String get scanTitleDataMatrix => 'Escanear Data Matrix';

  @override
  String get scanTitlePdf417 => 'Escanear PDF417';

  @override
  String get scanTitleAztec => 'Escanear código Aztec';

  @override
  String get scanTitleAll => 'Escanear todos os códigos';

  @override
  String get modeQr => 'Código QR';

  @override
  String get modeBarcode => 'Código de barras';

  @override
  String get modeAll => 'Todos os códigos';

  @override
  String get hintQr => 'Links, texto, Wi-Fi, contatos';

  @override
  String get hintDataMatrix => 'Etiquetas de encomendas, selos, componentes';

  @override
  String get hintPdf417 => 'Cartões de embarque, documentos de identidade';

  @override
  String get hintAztec => 'Passagens de trem e avião';

  @override
  String get hintAll => 'Todos os formatos suportados';

  @override
  String get chooseScanType => 'Escolher tipo de leitura';

  @override
  String get history => 'Histórico';

  @override
  String get info => 'Informações';

  @override
  String get torch => 'Lanterna';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Dados de Wi-Fi';

  @override
  String get typeContact => 'Contato';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typePhone => 'Número de telefone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Localização';

  @override
  String get typeCalendar => 'Evento';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Código do produto';

  @override
  String get typeDriverLicense => 'Carteira de motorista';

  @override
  String get typeText => 'Texto';

  @override
  String get formatMicroQr => 'Código Micro QR';

  @override
  String get formatUnknown => 'Desconhecido';

  @override
  String formatLine(String format) {
    return 'Formato: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'Copiado para a área de transferência';

  @override
  String get copy => 'Copiar';

  @override
  String get openEllipsis => 'Abrir …';

  @override
  String get openLinkTitle => 'Abrir link?';

  @override
  String get open => 'Abrir';

  @override
  String get cancel => 'Cancelar';

  @override
  String get historyClear => 'Limpar histórico';

  @override
  String get historyClearTitle => 'Limpar histórico?';

  @override
  String get historyClearBody => 'Todos os conteúdos salvos serão removidos.';

  @override
  String get delete => 'Excluir';

  @override
  String get historyEmpty => 'Nenhum conteúdo escaneado ainda.';

  @override
  String get infoDeveloper => 'Desenvolvedor';

  @override
  String get infoVersion => 'Versão';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (build $build)';
  }

  @override
  String get infoBuildDate => 'Data da compilação';

  @override
  String get infoInstalled => 'Instalado em';

  @override
  String get valueUnknown => 'desconhecido';

  @override
  String get licenses => 'Licenças';

  @override
  String get close => 'Fechar';
}
