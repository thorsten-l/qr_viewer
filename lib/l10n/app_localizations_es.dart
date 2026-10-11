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

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

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
  String get scanTitleAll => 'Escanear todos los códigos';

  @override
  String get modeQr => 'Código QR';

  @override
  String get modeBarcode => 'Código de barras';

  @override
  String get modeAll => 'Todos los códigos';

  @override
  String get hintQr => 'Enlaces, texto, Wi-Fi, contactos';

  @override
  String get hintDataMatrix => 'Etiquetas de paquetes, sellos, componentes';

  @override
  String get hintPdf417 => 'Tarjetas de embarque, documentos de identidad';

  @override
  String get hintAztec => 'Billetes de tren y avión';

  @override
  String get hintAll => 'Todos los formatos compatibles';

  @override
  String get chooseScanType => 'Elegir tipo de escaneo';

  @override
  String get history => 'Historial';

  @override
  String get info => 'Información';

  @override
  String get torch => 'Linterna';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Datos de Wi-Fi';

  @override
  String get typeContact => 'Contacto';

  @override
  String get typeEmail => 'Correo electrónico';

  @override
  String get typePhone => 'Número de teléfono';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => 'Ubicación';

  @override
  String get typeCalendar => 'Evento';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => 'Código de producto';

  @override
  String get typeDriverLicense => 'Permiso de conducir';

  @override
  String get typeText => 'Texto';

  @override
  String get typeBinary => 'Datos binarios';

  @override
  String byteCount(String count) {
    return '$count bytes';
  }

  @override
  String get vdvTicket => 'eTicket VDV (firmado)';

  @override
  String get ticketData => 'Datos del billete';

  @override
  String get ticketNumber => 'Número de billete';

  @override
  String get ticketProduct => 'Producto';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket Job';

  @override
  String get productStudentTicket =>
      'Deutschlandticket para escolares y estudiantes';

  @override
  String get validFrom => 'Válido desde';

  @override
  String get validUntil => 'Válido hasta';

  @override
  String get issuedAt => 'Emitido';

  @override
  String get ticketHolder => 'Titular';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get nameMasked => 'enmascarado';

  @override
  String get organizations => 'ID de organizaciones';

  @override
  String get travelClass => 'Clase';

  @override
  String get firstClass => '1.ª clase';

  @override
  String get secondClass => '2.ª clase';

  @override
  String get ticketPrice => 'Precio';

  @override
  String get signatureValid => 'Firma válida';

  @override
  String get signatureInvalid => 'Firma no válida';

  @override
  String unknownIssuer(String car) {
    return 'No hay clave pública para este emisor (CA $car). No se pueden leer los datos del billete.';
  }

  @override
  String get rawData => 'Datos sin procesar (hex)';

  @override
  String get lensChoice => 'Elegir objetivo';

  @override
  String get lensAuto => 'Auto';

  @override
  String get lensTele => 'Tele';

  @override
  String get lensAutoName => 'Automático (el sistema elige el objetivo)';

  @override
  String get lensUltraWideName => 'Ultra gran angular';

  @override
  String get lensMainName => 'Cámara principal';

  @override
  String get lensTeleName => 'Teleobjetivo';

  @override
  String get typePayment => 'Transferencia';

  @override
  String get rawContent => 'Contenido sin procesar';

  @override
  String get valueYes => 'Sí';

  @override
  String get valueOpenNetwork => 'Ninguna (red abierta)';

  @override
  String copyField(String label) {
    return 'Copiar $label';
  }

  @override
  String get fieldName => 'Nombre';

  @override
  String get fieldNickname => 'Apodo';

  @override
  String get fieldOrganization => 'Empresa';

  @override
  String get fieldJobTitle => 'Cargo';

  @override
  String get fieldPhone => 'Teléfono';

  @override
  String get fieldMobile => 'Móvil';

  @override
  String get fieldWorkPhone => 'Teléfono del trabajo';

  @override
  String get fieldHomePhone => 'Teléfono particular';

  @override
  String get fieldFax => 'Fax';

  @override
  String get fieldEmail => 'Correo electrónico';

  @override
  String get fieldWebsite => 'Sitio web';

  @override
  String get fieldAddress => 'Dirección';

  @override
  String get fieldBirthday => 'Cumpleaños';

  @override
  String get fieldNote => 'Nota';

  @override
  String get fieldTo => 'Para';

  @override
  String get fieldCc => 'CC';

  @override
  String get fieldBcc => 'CCO';

  @override
  String get fieldSubject => 'Asunto';

  @override
  String get fieldMessage => 'Mensaje';

  @override
  String get fieldNumber => 'Número';

  @override
  String get fieldLatitude => 'Latitud';

  @override
  String get fieldLongitude => 'Longitud';

  @override
  String get fieldAltitude => 'Altitud';

  @override
  String get fieldQuery => 'Lugar';

  @override
  String get fieldTitle => 'Título';

  @override
  String get fieldLink => 'Enlace';

  @override
  String get fieldStart => 'Inicio';

  @override
  String get fieldEnd => 'Fin';

  @override
  String get fieldLocation => 'Ubicación';

  @override
  String get fieldDescription => 'Descripción';

  @override
  String get fieldNetwork => 'Nombre de red (SSID)';

  @override
  String get fieldPassword => 'Contraseña';

  @override
  String get fieldSecurity => 'Seguridad';

  @override
  String get fieldHidden => 'Red oculta';

  @override
  String get fieldEapMethod => 'Método EAP';

  @override
  String get fieldIdentity => 'Identidad';

  @override
  String get fieldRecipient => 'Beneficiario';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => 'Importe';

  @override
  String get fieldPurpose => 'Código de propósito';

  @override
  String get fieldReference => 'Referencia';

  @override
  String get fieldRemittance => 'Concepto';

  @override
  String get fieldInfo => 'Nota para el pagador';

  @override
  String get typeOtp => 'Contraseña de un solo uso (2FA)';

  @override
  String get infoSupport => 'Soporte';

  @override
  String get fieldIssuer => 'Emisor';

  @override
  String get fieldAccount => 'Cuenta';

  @override
  String get fieldSecret => 'Clave secreta';

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
  String get formatUnknown => 'Desconocido';

  @override
  String formatLine(String format) {
    return 'Formato: $format';
  }

  @override
  String hostLine(String host) {
    return 'Host: $host';
  }

  @override
  String get copied => 'Copiado al portapapeles';

  @override
  String get copy => 'Copiar';

  @override
  String get openEllipsis => 'Abrir …';

  @override
  String get openLinkTitle => '¿Abrir enlace?';

  @override
  String get open => 'Abrir';

  @override
  String get cancel => 'Cancelar';

  @override
  String get historyClear => 'Borrar historial';

  @override
  String get historyClearTitle => '¿Borrar historial?';

  @override
  String get historyClearBody =>
      'Se eliminarán todos los contenidos guardados.';

  @override
  String get delete => 'Eliminar';

  @override
  String get historyEmpty => 'Aún no hay contenidos escaneados.';

  @override
  String get infoDeveloper => 'Desarrollador';

  @override
  String get infoVersion => 'Versión';

  @override
  String infoVersionValue(String version, String build) {
    return '$version (compilación $build)';
  }

  @override
  String get infoBuildDate => 'Fecha de compilación';

  @override
  String get infoInstalled => 'Instalado el';

  @override
  String get valueUnknown => 'desconocido';

  @override
  String get licenses => 'Licencias';

  @override
  String get close => 'Cerrar';

  @override
  String get actionEmail => 'Escribir correo…';

  @override
  String get actionCall => 'Llamar…';

  @override
  String get actionSms => 'Escribir SMS…';

  @override
  String get actionMap => 'Ver en el mapa…';

  @override
  String get actionOtp => 'Abrir en el autenticador…';

  @override
  String get actionLookUp => 'Buscar en línea…';

  @override
  String get actionAddContact => 'Añadir a contactos…';

  @override
  String get actionAddEvent => 'Añadir al calendario…';

  @override
  String get actionTrack => 'Seguir envío…';

  @override
  String get noAppFound => 'No se encontró ninguna app para abrirlo.';

  @override
  String get share => 'Compartir';

  @override
  String get historySearch => 'Buscar en el historial';

  @override
  String get historyNoMatches => 'Sin resultados';

  @override
  String get historyExport => 'Exportar';

  @override
  String get exportCsv => 'Compartir como CSV';

  @override
  String get exportJson => 'Compartir como JSON';

  @override
  String get historyEntryDeleted => 'Entrada eliminada';

  @override
  String get undo => 'Deshacer';

  @override
  String get otpNotSaved => 'Los códigos 2FA no se guardan en el historial.';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => 'Franqueo (Deutsche Post)';

  @override
  String get fieldGtin => 'Número de artículo (GTIN)';

  @override
  String get fieldCheckDigit => 'Dígito de control';

  @override
  String get fieldGs1Prefix => 'Registrado en (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => 'Número de seguimiento';

  @override
  String get valueValid => 'válido';

  @override
  String get valueInvalid => 'no válido';

  @override
  String get valueInStore => 'Número interno de tienda';

  @override
  String get valueCoupon => 'Cupón';

  @override
  String get valueGs1Global => 'GS1 Global Office';
}
