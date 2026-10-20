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
  String get menu => 'Menu';

  @override
  String get settings => 'Configurações';

  @override
  String get enableActions => 'Ativar ações';

  @override
  String get enableActionsHint =>
      'Mostra botões como Abrir, Ligar ou Pesquisar na página de resultado. Desativado, o app apenas mostra e copia.';

  @override
  String get scanFromPhoto => 'Escanear de foto';

  @override
  String get scanFromPhotoHint =>
      'Mostra um botão de foto ao lado da lanterna. Com ele você escolhe uma imagem das suas fotos e o app lê o código. O app só recebe a imagem escolhida.';

  @override
  String get pickPhoto => 'Escanear foto';

  @override
  String get analyzingPhoto => 'Analisando a foto …';

  @override
  String get noCodeInPhoto => 'Nenhum código foi encontrado na foto.';

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
  String get typeBinary => 'Dados binários';

  @override
  String byteCount(String count) {
    return '$count bytes';
  }

  @override
  String get vdvTicket => 'eTicket VDV (assinado)';

  @override
  String get ticketData => 'Dados do bilhete';

  @override
  String get ticketNumber => 'Número do bilhete';

  @override
  String get ticketProduct => 'Produto';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket para alunos e estudantes';

  @override
  String get validFrom => 'Válido de';

  @override
  String get validUntil => 'Válido até';

  @override
  String get issuedAt => 'Emitido em';

  @override
  String get ticketHolder => 'Titular';

  @override
  String get birthDate => 'Data de nascimento';

  @override
  String get nameMasked => 'mascarado';

  @override
  String get organizations => 'IDs das organizações';

  @override
  String get travelClass => 'Classe';

  @override
  String get firstClass => '1.ª classe';

  @override
  String get secondClass => '2.ª classe';

  @override
  String get ticketPrice => 'Preço';

  @override
  String get signatureValid => 'Assinatura válida';

  @override
  String get signatureInvalid => 'Assinatura inválida';

  @override
  String unknownIssuer(String car) {
    return 'Não há chave pública para este emissor (CA $car). Os dados do bilhete não podem ser lidos.';
  }

  @override
  String get rawData => 'Dados brutos (hex)';

  @override
  String get lensChoice => 'Escolher lente';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automático (o sistema escolhe a lente)';

  @override
  String get lensUltraWideName => 'Ultra-angular';

  @override
  String get lensMainName => 'Câmera principal';

  @override
  String get lensTeleName => 'Teleobjetiva';

  @override
  String get typePayment => 'Transferência';

  @override
  String get rawContent => 'Conteúdo bruto';

  @override
  String get valueYes => 'Sim';

  @override
  String get valueOpenNetwork => 'Nenhuma (rede aberta)';

  @override
  String copyField(String label) {
    return 'Copiar $label';
  }

  @override
  String get fieldName => 'Nome';

  @override
  String get fieldNickname => 'Apelido';

  @override
  String get fieldOrganization => 'Empresa';

  @override
  String get fieldJobTitle => 'Cargo';

  @override
  String get fieldPhone => 'Telefone';

  @override
  String get fieldMobile => 'Celular';

  @override
  String get fieldWorkPhone => 'Telefone comercial';

  @override
  String get fieldHomePhone => 'Telefone residencial';

  @override
  String get fieldFax => 'Fax';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldWebsite => 'Site';

  @override
  String get fieldAddress => 'Endereço';

  @override
  String get fieldBirthday => 'Aniversário';

  @override
  String get fieldNote => 'Observação';

  @override
  String get fieldTo => 'Para';

  @override
  String get fieldCc => 'Cc';

  @override
  String get fieldBcc => 'Cco';

  @override
  String get fieldSubject => 'Assunto';

  @override
  String get fieldMessage => 'Mensagem';

  @override
  String get fieldNumber => 'Número';

  @override
  String get fieldLatitude => 'Latitude';

  @override
  String get fieldLongitude => 'Longitude';

  @override
  String get fieldAltitude => 'Altitude';

  @override
  String get fieldQuery => 'Local';

  @override
  String get fieldTitle => 'Título';

  @override
  String get fieldLink => 'Link';

  @override
  String get fieldStart => 'Início';

  @override
  String get fieldEnd => 'Fim';

  @override
  String get fieldLocation => 'Local';

  @override
  String get fieldDescription => 'Descrição';

  @override
  String get fieldNetwork => 'Nome da rede (SSID)';

  @override
  String get fieldPassword => 'Senha';

  @override
  String get fieldSecurity => 'Segurança';

  @override
  String get fieldHidden => 'Rede oculta';

  @override
  String get fieldEapMethod => 'Método EAP';

  @override
  String get fieldIdentity => 'Identidade';

  @override
  String get fieldRecipient => 'Beneficiário';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Valor';

  @override
  String get fieldPurpose => 'Código de finalidade';

  @override
  String get fieldReference => 'Referência';

  @override
  String get fieldRemittance => 'Descrição do pagamento';

  @override
  String get fieldInfo => 'Nota ao pagador';

  @override
  String get typeOtp => 'Senha única (2FA)';

  @override
  String get infoSupport => 'Suporte';

  @override
  String get fieldIssuer => 'Emissor';

  @override
  String get fieldAccount => 'Conta';

  @override
  String get fieldSecret => 'Chave secreta';

  @override
  String get fieldOtpType => 'Método';

  @override
  String get fieldAlgorithm => 'Algoritmo';

  @override
  String get fieldDigits => 'Dígitos';

  @override
  String get fieldPeriod => 'Intervalo (segundos)';

  @override
  String get fieldCounter => 'Contador';

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
  String get showCode => 'Mostrar código';

  @override
  String shownAsQr(String format) {
    return 'Não é possível desenhar $format aqui; mostrado como código QR.';
  }

  @override
  String get codeTooLarge =>
      'O conteúdo é grande demais para ser desenhado como código.';

  @override
  String get close => 'Fechar';

  @override
  String get actionEmail => 'Escrever e-mail…';

  @override
  String get actionCall => 'Ligar…';

  @override
  String get actionSms => 'Escrever SMS…';

  @override
  String get actionMap => 'Ver no mapa…';

  @override
  String get actionOtp => 'Abrir no autenticador…';

  @override
  String get actionLookUp => 'Pesquisar online…';

  @override
  String get actionAddContact => 'Adicionar aos contatos…';

  @override
  String get actionAddEvent => 'Adicionar ao calendário…';

  @override
  String get actionTrack => 'Rastrear envio…';

  @override
  String get noAppFound => 'Nenhum app encontrado para abrir isto.';

  @override
  String get share => 'Compartilhar';

  @override
  String get historySearch => 'Pesquisar no histórico';

  @override
  String get historyNoMatches => 'Nenhum resultado';

  @override
  String get historyExport => 'Exportar';

  @override
  String get exportCsv => 'Compartilhar como CSV';

  @override
  String get exportJson => 'Compartilhar como JSON';

  @override
  String get historyEntryDeleted => 'Entrada excluída';

  @override
  String get undo => 'Desfazer';

  @override
  String get otpNotSaved => 'Códigos 2FA não são salvos no histórico.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Selo postal (Deutsche Post)';

  @override
  String get fieldGtin => 'Número do item (GTIN)';

  @override
  String get fieldCheckDigit => 'Dígito verificador';

  @override
  String get fieldGs1Prefix => 'Registrado em (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Código de rastreio';

  @override
  String get valueValid => 'válido';

  @override
  String get valueInvalid => 'inválido';

  @override
  String get valueInStore => 'Número interno da loja';

  @override
  String get valueCoupon => 'Cupom';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'Sobre estes dados';

  @override
  String get infoLocal =>
      'O QR Viewer leu estes dados diretamente do código. Isso acontece apenas no seu dispositivo – nada é enviado para a internet.';

  @override
  String infoOnline(String action, String host) {
    return 'Se você tocar em “$action”, o navegador abre o site $host. Esse site vê o que você procura e, como qualquer site, o seu endereço de internet. O que ele mostra vem de fora do app – o QR Viewer não pode verificar se está correto.';
  }

  @override
  String infoOtherApp(String action) {
    return 'Se você tocar em “$action”, os dados vão para outro app do seu dispositivo, por exemplo e-mail, telefone, mapas ou calendário. A partir daí, esse app decide o que acontece com eles.';
  }

  @override
  String get infoKindText =>
      'Texto simples. O código contém apenas estas palavras ou caracteres, nada mais.';

  @override
  String get infoKindUrl =>
      'Um endereço da web (link). Leva a uma página na internet ou abre outro app. Um link pode levar a qualquer lugar – abra-o só se confiar na origem do código.';

  @override
  String get infoKindEmail =>
      'Um endereço de e-mail, muitas vezes com assunto e mensagem prontos. Nada é enviado até você mesmo enviar o e-mail no seu app de e-mail.';

  @override
  String get infoKindPhone =>
      'Um número de telefone. O QR Viewer nunca liga sozinho – o app de telefone só abre com o número preenchido.';

  @override
  String get infoKindSms =>
      'Um número de telefone com um SMS pronto. A mensagem só é enviada se você mesmo enviar – SMS podem ter custo.';

  @override
  String get infoKindGeo =>
      'Um lugar na Terra, indicado por coordenadas (latitude e longitude). Um app de mapas pode mostrar onde fica.';

  @override
  String get infoKindContact =>
      'Um cartão de visita digital com dados de uma pessoa, como nome, telefone e endereço. Você pode salvá-lo nos seus contatos.';

  @override
  String get infoKindEvent =>
      'Um compromisso com data, hora e muitas vezes um local. Você pode adicioná-lo ao seu calendário.';

  @override
  String get infoKindWifi =>
      'Os dados de acesso a uma rede Wi-Fi: o nome e normalmente a senha. Quem vir este código pode usar a rede.';

  @override
  String get infoKindPayment =>
      'Uma transferência bancária pronta (GiroCode): destinatário, IBAN, valor e referência. Um app de banco pode usar esses dados – confira tudo antes de pagar.';

  @override
  String get infoKindOtp =>
      'Uma chave secreta para o login em duas etapas (2FA). Um app autenticador a usa para gerar os códigos curtos de acesso. Mantenha-a em segredo – o QR Viewer não a salva no histórico.';

  @override
  String get infoKindProduct =>
      'O número do artigo no código de barras de um produto (GTIN/EAN). Ele apenas identifica o produto – o código não contém nome, preço nem ingredientes. Os primeiros dígitos mostram o país que atribuiu o número, não necessariamente onde o produto foi feito.';

  @override
  String get infoKindBook =>
      'O número de um livro (ISBN) ou revista (ISSN). Identifica exatamente esta edição – título e autor não estão no código.';

  @override
  String get infoKindJson =>
      'Dados estruturados no formato JSON, como os trocados entre programas de computador. O QR Viewer apenas os mostra bem indentados.';

  @override
  String get infoKindPostage =>
      'O código de um selo ou Internetmarke da Deutsche Post. Contém um número de rastreio da carta.';

  @override
  String get infoKindVdv =>
      'Um bilhete eletrônico de ônibus e trem (VDV eTicket, p. ex. Deutschlandticket). Uma assinatura digital o protege contra alterações; o QR Viewer a verifica com as chaves públicas das empresas de transporte.';

  @override
  String get typeMatter => 'Dispositivo Matter';

  @override
  String get fieldVendorId => 'ID do fabricante';

  @override
  String get fieldProductId => 'ID do produto';

  @override
  String get fieldDiscriminator => 'Discriminador';

  @override
  String get fieldSetupCode => 'Código de configuração (PIN)';

  @override
  String get fieldManualCode => 'Código de emparelhamento manual';

  @override
  String get fieldDiscovery => 'Configuração via';

  @override
  String get fieldFlow => 'Processo de configuração';

  @override
  String get valueFlowStandard => 'Padrão';

  @override
  String get valueFlowUserAction =>
      'Ative o dispositivo primeiro (p. ex., pressione um botão)';

  @override
  String get valueFlowCustom => 'É necessário o app do fabricante';

  @override
  String get valueDiscoverySoftAp => 'Ponto de acesso Wi-Fi (SoftAP)';

  @override
  String get valueDiscoveryOnNetwork => 'Rede existente';

  @override
  String get infoKindMatter =>
      'Os dados de configuração de um dispositivo de casa inteligente no padrão Matter. Seu app de casa inteligente (p. ex. Apple Casa, Google Home) os usa para adicionar o dispositivo – escaneie o código nele ou digite o código de emparelhamento manual. Quem tiver este código pode emparelhar o dispositivo enquanto ele estiver no modo de configuração.';

  @override
  String get typeTransparency => 'Código Amazon Transparency';

  @override
  String get fieldSerialNumber => 'Número de série';

  @override
  String get infoKindTransparency =>
      'Um código antifalsificação da Amazon (programa Transparency). Cada embalagem recebe seu próprio número de série aleatório. Só a Amazon sabe a qual produto ele pertence – o código não contém mais nada. Você pode verificar se é autêntico no app Amazon Shopping ou Transparency; o código é então enviado à Amazon.';

  @override
  String get typeMedicationPlan => 'Plano de medicação';

  @override
  String get medicationPlanNotSaved =>
      'Planos de medicação contêm dados de saúde e não são salvos no histórico.';

  @override
  String get planPatient => 'Paciente';

  @override
  String get planIssuedBy => 'Impresso por';

  @override
  String get planPrinted => 'Impresso em';

  @override
  String planPage(String page, String pages) {
    return 'Página $page de $pages';
  }

  @override
  String get planAllergies => 'Alergias/intolerâncias';

  @override
  String get planPregnant => 'Grávida';

  @override
  String get planBreastfeeding => 'Amamentando';

  @override
  String get planWeight => 'Peso';

  @override
  String get planHeight => 'Altura';

  @override
  String get planCreatinine => 'Creatinina';

  @override
  String get planMoreInfo => 'Mais informações';

  @override
  String get planDosage => 'Dosagem';

  @override
  String get planHint => 'Observação';

  @override
  String get planReason => 'Motivo';

  @override
  String get infoKindMedicationPlan =>
      'O código do plano de medicação federal alemão (BMP) do seu médico, hospital ou farmácia. Contém seu nome, data de nascimento e todos os medicamentos com a dosagem. São dados de saúde: o QR Viewer só os mostra no seu dispositivo e nunca os salva no histórico. Medicamentos indicados apenas pelo PZN não podem ser nomeados offline.';

  @override
  String get infoManuals => 'Manuais';

  @override
  String get typeBookmark => 'Favorito';

  @override
  String get infoKindBookmark =>
      'Um favorito: um link para um site junto com um nome (formato MEBKM). Como qualquer link, ele pode levar a qualquer lugar – abra-o somente se você confiar na origem do código.';
}
