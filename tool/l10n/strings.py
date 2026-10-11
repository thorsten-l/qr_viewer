# Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Quelle aller App-Texte. Erzeugt lib/l10n/app_<sprache>.arb:
#   python3 tool/l10n/strings.py
import json, os

LANGS = ["en", "de", "es", "fr", "pt", "ru", "zh", "hi", "ar", "ja", "it", "pl", "uk"]

# iOS erwartet für vereinfachtes Chinesisch den Ordner zh-Hans.lproj
IOS_LPROJ = {"zh": "zh-Hans"}

# key: (beschreibung, platzhalter, {sprache: text})
S = {
 "scanTitleQr": ("Titel im Modus QR-Code", [], dict(
   en="Scan QR code", de="QR-Code scannen", es="Escanear código QR", fr="Scanner un QR code",
   pt="Escanear código QR", ru="Сканировать QR-код", zh="扫描二维码", hi="QR कोड स्कैन करें",
   ar="مسح رمز QR", ja="QRコードをスキャン",
   it="Scansiona codice QR", pl="Skanuj kod QR", uk="Сканувати QR-код")),
 "scanTitleBarcode": ("Titel im Modus Barcode", [], dict(
   en="Scan barcode", de="Barcode scannen", es="Escanear código de barras", fr="Scanner un code-barres",
   pt="Escanear código de barras", ru="Сканировать штрихкод", zh="扫描条形码", hi="बारकोड स्कैन करें",
   ar="مسح الباركود", ja="バーコードをスキャン",
   it="Scansiona codice a barre", pl="Skanuj kod kreskowy", uk="Сканувати штрихкод")),
 "scanTitleDataMatrix": ("Titel im Modus Data Matrix", [], dict(
   en="Scan Data Matrix", de="Data Matrix scannen", es="Escanear Data Matrix", fr="Scanner un Data Matrix",
   pt="Escanear Data Matrix", ru="Сканировать Data Matrix", zh="扫描 Data Matrix", hi="Data Matrix स्कैन करें",
   ar="مسح Data Matrix", ja="Data Matrixをスキャン",
   it="Scansiona Data Matrix", pl="Skanuj Data Matrix", uk="Сканувати Data Matrix")),
 "scanTitlePdf417": ("Titel im Modus PDF417", [], dict(
   en="Scan PDF417", de="PDF417 scannen", es="Escanear PDF417", fr="Scanner un PDF417",
   pt="Escanear PDF417", ru="Сканировать PDF417", zh="扫描 PDF417", hi="PDF417 स्कैन करें",
   ar="مسح PDF417", ja="PDF417をスキャン",
   it="Scansiona PDF417", pl="Skanuj PDF417", uk="Сканувати PDF417")),
 "scanTitleAztec": ("Titel im Modus Aztec", [], dict(
   en="Scan Aztec code", de="Aztec scannen", es="Escanear código Aztec", fr="Scanner un code Aztec",
   pt="Escanear código Aztec", ru="Сканировать Aztec", zh="扫描 Aztec 码", hi="Aztec कोड स्कैन करें",
   ar="مسح رمز Aztec", ja="Aztecコードをスキャン",
   it="Scansiona codice Aztec", pl="Skanuj kod Aztec", uk="Сканувати Aztec")),
 "scanTitleAll": ("Titel im Modus alle Codes", [], dict(
   en="Scan all codes", de="Alle Codes scannen", es="Escanear todos los códigos", fr="Scanner tous les codes",
   pt="Escanear todos os códigos", ru="Сканировать все коды", zh="扫描所有码", hi="सभी कोड स्कैन करें",
   ar="مسح جميع الرموز", ja="すべてのコードをスキャン",
   it="Scansiona tutti i codici", pl="Skanuj wszystkie kody", uk="Сканувати всі коди")),
 "modeQr": ("Menüeintrag und Formatname QR-Code", [], dict(
   en="QR code", de="QR-Code", es="Código QR", fr="QR code", pt="Código QR", ru="QR-код",
   zh="二维码", hi="QR कोड", ar="رمز QR", ja="QRコード",
   it="Codice QR", pl="Kod QR", uk="QR-код")),
 "modeBarcode": ("Menüeintrag Barcode", [], dict(
   en="Barcode", de="Barcode", es="Código de barras", fr="Code-barres", pt="Código de barras", ru="Штрихкод",
   zh="条形码", hi="बारकोड", ar="باركود", ja="バーコード",
   it="Codice a barre", pl="Kod kreskowy", uk="Штрихкод")),
 "modeAll": ("Menüeintrag alle Codes", [], dict(
   en="All codes", de="Alle Codes", es="Todos los códigos", fr="Tous les codes", pt="Todos os códigos",
   ru="Все коды", zh="所有码", hi="सभी कोड", ar="جميع الرموز", ja="すべてのコード",
   it="Tutti i codici", pl="Wszystkie kody", uk="Усі коди")),
 "hintQr": ("Beispiele für QR-Codes", [], dict(
   en="Links, text, Wi-Fi, contacts", de="Links, Text, WLAN, Kontakte", es="Enlaces, texto, Wi-Fi, contactos",
   fr="Liens, texte, Wi-Fi, contacts", pt="Links, texto, Wi-Fi, contatos", ru="Ссылки, текст, Wi-Fi, контакты",
   zh="链接、文本、Wi-Fi、联系人", hi="लिंक, टेक्स्ट, Wi-Fi, संपर्क", ar="روابط، نصوص، Wi-Fi، جهات اتصال",
   ja="リンク、テキスト、Wi-Fi、連絡先",
   it="Link, testo, Wi-Fi, contatti", pl="Linki, tekst, Wi-Fi, kontakty", uk="Посилання, текст, Wi-Fi, контакти")),
 "hintDataMatrix": ("Beispiele für Data Matrix", [], dict(
   en="Parcel labels, stamps, components", de="Paketaufkleber, Briefmarken, Bauteile",
   es="Etiquetas de paquetes, sellos, componentes", fr="Étiquettes de colis, timbres, composants",
   pt="Etiquetas de encomendas, selos, componentes", ru="Посылки, марки, детали",
   zh="包裹标签、邮票、零部件", hi="पार्सल लेबल, डाक टिकट, पुर्ज़े", ar="ملصقات الطرود، الطوابع، القطع",
   ja="荷札、切手、部品",
   it="Etichette dei pacchi, francobolli, componenti", pl="Etykiety paczek, znaczki, części", uk="Етикетки посилок, марки, деталі")),
 "hintPdf417": ("Beispiele für PDF417", [], dict(
   en="Boarding passes, ID cards", de="Bordkarten, Ausweise", es="Tarjetas de embarque, documentos de identidad",
   fr="Cartes d'embarquement, pièces d'identité", pt="Cartões de embarque, documentos de identidade",
   ru="Посадочные талоны, удостоверения", zh="登机牌、身份证件", hi="बोर्डिंग पास, पहचान पत्र",
   ar="بطاقات الصعود، بطاقات الهوية", ja="搭乗券、身分証明書",
   it="Carte d'imbarco, documenti d'identità", pl="Karty pokładowe, dowody osobiste", uk="Посадкові талони, посвідчення")),
 "hintAztec": ("Beispiele für Aztec", [], dict(
   en="Train and plane tickets", de="Bahn- und Flugtickets", es="Billetes de tren y avión",
   fr="Billets de train et d'avion", pt="Passagens de trem e avião", ru="Ж/д и авиабилеты",
   zh="火车票和机票", hi="ट्रेन और फ़्लाइट टिकट", ar="تذاكر القطار والطيران", ja="鉄道・航空券",
   it="Biglietti del treno e aerei", pl="Bilety kolejowe i lotnicze", uk="Залізничні та авіаквитки")),
 "hintAll": ("Beschreibung alle Codes", [], dict(
   en="All supported formats", de="Alle unterstützten Formate", es="Todos los formatos compatibles",
   fr="Tous les formats pris en charge", pt="Todos os formatos suportados", ru="Все поддерживаемые форматы",
   zh="所有支持的格式", hi="सभी समर्थित फ़ॉर्मैट", ar="جميع الصيغ المدعومة", ja="対応するすべての形式",
   it="Tutti i formati supportati", pl="Wszystkie obsługiwane formaty", uk="Усі підтримувані формати")),
 "chooseScanType": ("Tooltip des Auswahlmenüs", [], dict(
   en="Choose scan type", de="Scan-Art wählen", es="Elegir tipo de escaneo", fr="Choisir le type de code",
   pt="Escolher tipo de leitura", ru="Выбрать тип кода", zh="选择扫描类型", hi="स्कैन प्रकार चुनें",
   ar="اختر نوع المسح", ja="スキャンの種類を選択",
   it="Scegli il tipo di codice", pl="Wybierz typ kodu", uk="Вибрати тип коду")),
 "history": ("Verlauf: Tooltip und Seitentitel", [], dict(
   en="History", de="Verlauf", es="Historial", fr="Historique", pt="Histórico", ru="История",
   zh="历史记录", hi="इतिहास", ar="السجل", ja="履歴",
   it="Cronologia", pl="Historia", uk="Історія")),
 "info": ("Tooltip Info", [], dict(
   en="Info", de="Info", es="Información", fr="Infos", pt="Informações", ru="Информация",
   zh="关于", hi="जानकारी", ar="معلومات", ja="情報",
   it="Info", pl="Informacje", uk="Інформація")),
 "torch": ("Tooltip Taschenlampe", [], dict(
   en="Flashlight", de="Taschenlampe", es="Linterna", fr="Lampe torche", pt="Lanterna", ru="Фонарик",
   zh="手电筒", hi="टॉर्च", ar="المصباح", ja="ライト",
   it="Torcia", pl="Latarka", uk="Ліхтарик")),
 "typeUrl": ("Inhaltstyp URL", [], dict(
   en="URL", de="URL", es="URL", fr="URL", pt="URL", ru="URL", zh="网址", hi="URL", ar="رابط", ja="URL",
   it="URL", pl="URL", uk="URL")),
 "typeWifi": ("Inhaltstyp WLAN", [], dict(
   en="Wi-Fi credentials", de="WLAN-Zugangsdaten", es="Datos de Wi-Fi", fr="Identifiants Wi-Fi",
   pt="Dados de Wi-Fi", ru="Данные Wi-Fi", zh="Wi-Fi 信息", hi="Wi-Fi विवरण", ar="بيانات Wi-Fi", ja="Wi-Fi 情報",
   it="Dati Wi-Fi", pl="Dane Wi-Fi", uk="Дані Wi-Fi")),
 "typeContact": ("Inhaltstyp Kontakt", [], dict(
   en="Contact", de="Kontakt", es="Contacto", fr="Contact", pt="Contato", ru="Контакт",
   zh="联系人", hi="संपर्क", ar="جهة اتصال", ja="連絡先",
   it="Contatto", pl="Kontakt", uk="Контакт")),
 "typeEmail": ("Inhaltstyp E-Mail", [], dict(
   en="Email", de="E-Mail", es="Correo electrónico", fr="E-mail", pt="E-mail", ru="Эл. почта",
   zh="电子邮件", hi="ईमेल", ar="بريد إلكتروني", ja="メール",
   it="E-mail", pl="E-mail", uk="Ел. пошта")),
 "typePhone": ("Inhaltstyp Telefon", [], dict(
   en="Phone number", de="Telefonnummer", es="Número de teléfono", fr="Numéro de téléphone",
   pt="Número de telefone", ru="Номер телефона", zh="电话号码", hi="फ़ोन नंबर", ar="رقم الهاتف", ja="電話番号",
   it="Numero di telefono", pl="Numer telefonu", uk="Номер телефону")),
 "typeSms": ("Inhaltstyp SMS", [], dict(
   en="SMS", de="SMS", es="SMS", fr="SMS", pt="SMS", ru="SMS", zh="短信", hi="SMS", ar="رسالة SMS", ja="SMS",
   it="SMS", pl="SMS", uk="SMS")),
 "typeGeo": ("Inhaltstyp Ort", [], dict(
   en="Location", de="Geo-Position", es="Ubicación", fr="Position", pt="Localização", ru="Местоположение",
   zh="位置", hi="स्थान", ar="الموقع", ja="位置情報",
   it="Posizione", pl="Lokalizacja", uk="Місцезнаходження")),
 "typeCalendar": ("Inhaltstyp Termin", [], dict(
   en="Event", de="Termin", es="Evento", fr="Événement", pt="Evento", ru="Событие",
   zh="日程", hi="इवेंट", ar="حدث", ja="予定",
   it="Evento", pl="Wydarzenie", uk="Подія")),
 "typeIsbn": ("Inhaltstyp ISBN", [], dict(
   en="ISBN", de="ISBN", es="ISBN", fr="ISBN", pt="ISBN", ru="ISBN", zh="ISBN", hi="ISBN", ar="ISBN", ja="ISBN",
   it="ISBN", pl="ISBN", uk="ISBN")),
 "typeProduct": ("Inhaltstyp Produktcode", [], dict(
   en="Product code", de="Produktcode", es="Código de producto", fr="Code produit", pt="Código do produto",
   ru="Код товара", zh="商品码", hi="उत्पाद कोड", ar="رمز المنتج", ja="商品コード",
   it="Codice prodotto", pl="Kod produktu", uk="Код товару")),
 "typeDriverLicense": ("Inhaltstyp Führerschein", [], dict(
   en="Driver's license", de="Führerschein", es="Permiso de conducir", fr="Permis de conduire",
   pt="Carteira de motorista", ru="Водительское удостоверение", zh="驾驶证", hi="ड्राइविंग लाइसेंस",
   ar="رخصة القيادة", ja="運転免許証",
   it="Patente di guida", pl="Prawo jazdy", uk="Посвідчення водія")),
 "typeText": ("Inhaltstyp Text", [], dict(
   en="Text", de="Text", es="Texto", fr="Texte", pt="Texto", ru="Текст", zh="文本", hi="टेक्स्ट", ar="نص", ja="テキスト",
   it="Testo", pl="Tekst", uk="Текст")),
 "typeBinary": ("Inhaltstyp Binärdaten", [], dict(
   en="Binary data", de="Binärdaten", es="Datos binarios", fr="Données binaires", pt="Dados binários",
   ru="Двоичные данные", zh="二进制数据", hi="बाइनरी डेटा", ar="بيانات ثنائية", ja="バイナリデータ",
   it="Dati binari", pl="Dane binarne", uk="Двійкові дані")),
 "byteCount": ("Größe der Binärdaten", ["count"], dict(
   en="{count} bytes", de="{count} Bytes", es="{count} bytes", fr="{count} octets", pt="{count} bytes",
   ru="{count} байт", zh="{count} 字节", hi="{count} बाइट", ar="{count} بايت", ja="{count} バイト",
   it="{count} byte", pl="{count} bajtów", uk="{count} байт")),
 "vdvTicket": ("Binärcode eines deutschen eTickets (VDV)", [], dict(
   en="VDV eTicket (signed)", de="VDV-eTicket (signiert)", es="eTicket VDV (firmado)",
   fr="eTicket VDV (signé)", pt="eTicket VDV (assinado)", ru="eTicket VDV (подписан)",
   zh="VDV 电子票（已签名）", hi="VDV ई-टिकट (हस्ताक्षरित)", ar="تذكرة VDV إلكترونية (موقّعة)",
   ja="VDV eチケット（署名付き）", it="eTicket VDV (firmato)", pl="eBilet VDV (podpisany)",
   uk="eTicket VDV (підписаний)")),
 "ticketData": ("Überschrift Ticketdaten", [], dict(en="Ticket data", de="Ticketdaten", es="Datos del billete", fr="Données du billet", pt="Dados do bilhete", ru="Данные билета", zh="车票数据", hi="टिकट डेटा", ar="بيانات التذكرة", ja="チケット情報", it="Dati del biglietto", pl="Dane biletu", uk="Дані квитка")),
 "ticketNumber": ("Ticketnummer", [], dict(en="Ticket number", de="Ticketnummer", es="Número de billete", fr="Numéro de billet", pt="Número do bilhete", ru="Номер билета", zh="票号", hi="टिकट संख्या", ar="رقم التذكرة", ja="チケット番号", it="Numero biglietto", pl="Numer biletu", uk="Номер квитка")),
 "ticketProduct": ("Produkt des Tickets", [], dict(en="Product", de="Produkt", es="Producto", fr="Produit", pt="Produto", ru="Продукт", zh="产品", hi="उत्पाद", ar="المنتج", ja="商品", it="Prodotto", pl="Produkt", uk="Продукт")),
 "productDeutschlandticket": ("Produktname", [], dict(en="Deutschlandticket", de="Deutschlandticket", es="Deutschlandticket", fr="Deutschlandticket", pt="Deutschlandticket", ru="Deutschlandticket", zh="Deutschlandticket", hi="Deutschlandticket", ar="Deutschlandticket", ja="Deutschlandticket", it="Deutschlandticket", pl="Deutschlandticket", uk="Deutschlandticket")),
 "productJobticket": ("Produktname", [], dict(en="Deutschlandticket job ticket", de="Deutschlandticket Job", es="Deutschlandticket Job", fr="Deutschlandticket Job", pt="Deutschlandticket Job", ru="Deutschlandticket Job", zh="Deutschlandticket 职工票", hi="Deutschlandticket जॉब टिकट", ar="Deutschlandticket للعمل", ja="Deutschlandticket ジョブチケット", it="Deutschlandticket Job", pl="Deutschlandticket Job", uk="Deutschlandticket Job")),
 "productStudentTicket": ("Produktname", [], dict(en="Deutschlandticket for pupils and students", de="Deutschlandticket für Schüler und Studierende", es="Deutschlandticket para escolares y estudiantes", fr="Deutschlandticket pour élèves et étudiants", pt="Deutschlandticket para alunos e estudantes", ru="Deutschlandticket для школьников и студентов", zh="学生版 Deutschlandticket", hi="छात्रों के लिए Deutschlandticket", ar="Deutschlandticket للتلاميذ والطلاب", ja="生徒・学生向け Deutschlandticket", it="Deutschlandticket per alunni e studenti", pl="Deutschlandticket dla uczniów i studentów", uk="Deutschlandticket для школярів і студентів")),
 "validFrom": ("Gültig ab", [], dict(en="Valid from", de="Gültig ab", es="Válido desde", fr="Valable du", pt="Válido de", ru="Действует с", zh="生效时间", hi="से मान्य", ar="صالح من", ja="有効開始", it="Valido dal", pl="Ważny od", uk="Дійсний з")),
 "validUntil": ("Gültig bis", [], dict(en="Valid until", de="Gültig bis", es="Válido hasta", fr="Valable jusqu'au", pt="Válido até", ru="Действует до", zh="失效时间", hi="तक मान्य", ar="صالح حتى", ja="有効期限", it="Valido fino al", pl="Ważny do", uk="Дійсний до")),
 "issuedAt": ("Ausstellungszeit", [], dict(en="Issued", de="Ausgestellt", es="Emitido", fr="Émis le", pt="Emitido em", ru="Выдан", zh="签发时间", hi="जारी", ar="تاريخ الإصدار", ja="発行日時", it="Emesso il", pl="Wystawiony", uk="Видано")),
 "ticketHolder": ("Inhaber", [], dict(en="Holder", de="Inhaber", es="Titular", fr="Titulaire", pt="Titular", ru="Владелец", zh="持票人", hi="धारक", ar="حامل التذكرة", ja="所有者", it="Titolare", pl="Posiadacz", uk="Власник")),
 "birthDate": ("Geburtsdatum", [], dict(en="Date of birth", de="Geburtsdatum", es="Fecha de nacimiento", fr="Date de naissance", pt="Data de nascimento", ru="Дата рождения", zh="出生日期", hi="जन्म तिथि", ar="تاريخ الميلاد", ja="生年月日", it="Data di nascita", pl="Data urodzenia", uk="Дата народження")),
 "nameMasked": ("Hinweis maskierter Name", [], dict(en="masked", de="maskiert", es="enmascarado", fr="masqué", pt="mascarado", ru="замаскировано", zh="已遮盖", hi="छिपाया गया", ar="مخفي", ja="マスク済み", it="mascherato", pl="zamaskowane", uk="замасковано")),
 "organizations": ("Organisationsnummern KVP/PV", [], dict(en="Organisation IDs", de="Organisationsnummern", es="ID de organizaciones", fr="ID des organismes", pt="IDs das organizações", ru="Номера организаций", zh="机构编号", hi="संगठन आईडी", ar="أرقام الجهات", ja="事業者番号", it="ID organizzazioni", pl="Numery organizacji", uk="Номери організацій")),
 "travelClass": ("Wagenklasse", [], dict(en="Class", de="Klasse", es="Clase", fr="Classe", pt="Classe", ru="Класс", zh="舱位等级", hi="श्रेणी", ar="الدرجة", ja="等級", it="Classe", pl="Klasa", uk="Клас")),
 "firstClass": ("1. Klasse", [], dict(en="1st class", de="1. Klasse", es="1.ª clase", fr="1re classe", pt="1.ª classe", ru="1-й класс", zh="一等", hi="प्रथम श्रेणी", ar="الدرجة الأولى", ja="1等", it="1ª classe", pl="1. klasa", uk="1-й клас")),
 "secondClass": ("2. Klasse", [], dict(en="2nd class", de="2. Klasse", es="2.ª clase", fr="2e classe", pt="2.ª classe", ru="2-й класс", zh="二等", hi="द्वितीय श्रेणी", ar="الدرجة الثانية", ja="2等", it="2ª classe", pl="2. klasa", uk="2-й клас")),
 "ticketPrice": ("Preis", [], dict(en="Price", de="Preis", es="Precio", fr="Prix", pt="Preço", ru="Цена", zh="价格", hi="कीमत", ar="السعر", ja="価格", it="Prezzo", pl="Cena", uk="Ціна")),
 "signatureValid": ("Signatur gültig", [], dict(en="Signature valid", de="Signatur gültig", es="Firma válida", fr="Signature valide", pt="Assinatura válida", ru="Подпись действительна", zh="签名有效", hi="हस्ताक्षर मान्य", ar="التوقيع صالح", ja="署名は有効", it="Firma valida", pl="Podpis prawidłowy", uk="Підпис дійсний")),
 "signatureInvalid": ("Signatur ungültig", [], dict(en="Signature invalid", de="Signatur ungültig", es="Firma no válida", fr="Signature non valide", pt="Assinatura inválida", ru="Подпись недействительна", zh="签名无效", hi="हस्ताक्षर अमान्य", ar="التوقيع غير صالح", ja="署名が無効", it="Firma non valida", pl="Podpis nieprawidłowy", uk="Підпис недійсний")),
 "unknownIssuer": ("Kein Schlüssel für die CA", ['car'], dict(en="No public key for this issuer (CA {car}). The ticket data cannot be read.", de="Kein öffentlicher Schlüssel für diesen Herausgeber (CA {car}). Die Ticketdaten können nicht gelesen werden.", es="No hay clave pública para este emisor (CA {car}). No se pueden leer los datos del billete.", fr="Aucune clé publique pour cet émetteur (CA {car}). Les données du billet ne peuvent pas être lues.", pt="Não há chave pública para este emissor (CA {car}). Os dados do bilhete não podem ser lidos.", ru="Нет открытого ключа для этого эмитента (CA {car}). Данные билета не читаются.", zh="没有该签发方的公钥（CA {car}），无法读取车票数据。", hi="इस जारीकर्ता के लिए कोई सार्वजनिक कुंजी नहीं (CA {car})। टिकट डेटा पढ़ा नहीं जा सकता।", ar="لا يوجد مفتاح عام لهذه الجهة (CA {car}). لا يمكن قراءة بيانات التذكرة.", ja="この発行元の公開鍵がありません（CA {car}）。チケット情報を読み取れません。", it="Nessuna chiave pubblica per questo emittente (CA {car}). I dati del biglietto non sono leggibili.", pl="Brak klucza publicznego dla tego wystawcy (CA {car}). Nie można odczytać danych biletu.", uk="Немає відкритого ключа для цього емітента (CA {car}). Дані квитка не читаються.")),
 "rawData": ("Rohdaten", [], dict(en="Raw data (hex)", de="Rohdaten (Hex)", es="Datos sin procesar (hex)", fr="Données brutes (hex)", pt="Dados brutos (hex)", ru="Исходные данные (hex)", zh="原始数据（十六进制）", hi="कच्चा डेटा (hex)", ar="البيانات الخام (hex)", ja="生データ（16進）", it="Dati grezzi (hex)", pl="Surowe dane (hex)", uk="Сирі дані (hex)")),
 "lensChoice": ("Tooltip der Objektivauswahl", [], dict(en="Choose lens", de="Objektiv wählen", es="Elegir objetivo", fr="Choisir l'objectif", pt="Escolher lente", ru="Выбрать объектив", zh="选择镜头", hi="लेंस चुनें", ar="اختيار العدسة", ja="レンズを選択", it="Scegli obiettivo", pl="Wybierz obiektyw", uk="Вибрати об'єктив")),
 "lensAuto": ("Kurzlabel automatische Objektivwahl", [], dict(en="Auto", de="Auto", es="Auto", fr="Auto", pt="Auto", ru="Авто", zh="自动", hi="ऑटो", ar="تلقائي", ja="自動", it="Auto", pl="Auto", uk="Авто")),
 "lensTele": ("Kurzlabel Teleobjektiv", [], dict(en="Tele", de="Tele", es="Tele", fr="Télé", pt="Tele", ru="Теле", zh="长焦", hi="टेली", ar="مقرّب", ja="望遠", it="Tele", pl="Tele", uk="Теле")),
 "lensAutoName": ("Name automatische Objektivwahl", [], dict(en="Automatic (system chooses the lens)", de="Automatisch (System wählt das Objektiv)", es="Automático (el sistema elige el objetivo)", fr="Automatique (le système choisit l'objectif)", pt="Automático (o sistema escolhe a lente)", ru="Автоматически (объектив выбирает система)", zh="自动（由系统选择镜头）", hi="स्वचालित (सिस्टम लेंस चुनता है)", ar="تلقائي (يختار النظام العدسة)", ja="自動（システムがレンズを選択）", it="Automatico (il sistema sceglie l'obiettivo)", pl="Automatycznie (system wybiera obiektyw)", uk="Автоматично (система вибирає об'єктив)")),
 "lensUltraWideName": ("Name Ultraweitwinkel", [], dict(en="Ultra wide", de="Ultraweitwinkel", es="Ultra gran angular", fr="Ultra grand-angle", pt="Ultra-angular", ru="Сверхширокоугольный", zh="超广角", hi="अल्ट्रा वाइड", ar="فائق الاتساع", ja="超広角", it="Ultra grandangolo", pl="Ultraszerokokątny", uk="Надширококутний")),
 "lensMainName": ("Name Hauptkamera", [], dict(en="Main camera", de="Hauptkamera", es="Cámara principal", fr="Caméra principale", pt="Câmera principal", ru="Основная камера", zh="主摄像头", hi="मुख्य कैमरा", ar="الكاميرا الرئيسية", ja="メインカメラ", it="Fotocamera principale", pl="Aparat główny", uk="Основна камера")),
 "lensTeleName": ("Name Teleobjektiv", [], dict(en="Telephoto", de="Teleobjektiv", es="Teleobjetivo", fr="Téléobjectif", pt="Teleobjetiva", ru="Телеобъектив", zh="长焦镜头", hi="टेलीफ़ोटो", ar="عدسة مقرّبة", ja="望遠レンズ", it="Teleobiettivo", pl="Teleobiektyw", uk="Телеоб'єктив")),
 "typePayment": ('Inhaltsart Überweisung', [], dict(en='Bank transfer', de='Überweisung', es='Transferencia', fr='Virement', pt='Transferência', ru='Банковский перевод', zh='银行转账', hi='बैंक ट्रांसफ़र', ar='تحويل مصرفي', ja='銀行振込', it='Bonifico', pl='Przelew', uk='Банківський переказ')),
 "rawContent": ('Überschrift Rohinhalt', [], dict(en='Raw content', de='Rohinhalt', es='Contenido sin procesar', fr='Contenu brut', pt='Conteúdo bruto', ru='Исходное содержимое', zh='原始内容', hi='कच्ची सामग्री', ar='المحتوى الخام', ja='元の内容', it='Contenuto grezzo', pl='Surowa zawartość', uk='Сирий вміст')),
 "valueYes": ('Ja', [], dict(en='Yes', de='Ja', es='Sí', fr='Oui', pt='Sim', ru='Да', zh='是', hi='हाँ', ar='نعم', ja='はい', it='Sì', pl='Tak', uk='Так')),
 "valueOpenNetwork": ('Offenes WLAN', [], dict(en='None (open network)', de='Keine (offenes Netz)', es='Ninguna (red abierta)', fr='Aucune (réseau ouvert)', pt='Nenhuma (rede aberta)', ru='Нет (открытая сеть)', zh='无（开放网络）', hi='कोई नहीं (खुला नेटवर्क)', ar='بدون (شبكة مفتوحة)', ja='なし（オープンネットワーク）', it='Nessuna (rete aperta)', pl='Brak (sieć otwarta)', uk='Немає (відкрита мережа)')),
 "copyField": ('Tooltip Feld kopieren', ['label'], dict(en='Copy {label}', de='{label} kopieren', es='Copiar {label}', fr='Copier {label}', pt='Copiar {label}', ru='Копировать: {label}', zh='复制{label}', hi='{label} कॉपी करें', ar='نسخ {label}', ja='{label}をコピー', it='Copia {label}', pl='Kopiuj: {label}', uk='Копіювати: {label}')),
 "fieldName": ('Feld Name', [], dict(en='Name', de='Name', es='Nombre', fr='Nom', pt='Nome', ru='Имя', zh='姓名', hi='नाम', ar='الاسم', ja='名前', it='Nome', pl='Imię i nazwisko', uk="Ім'я")),
 "fieldNickname": ('Feld Spitzname', [], dict(en='Nickname', de='Spitzname', es='Apodo', fr='Surnom', pt='Apelido', ru='Псевдоним', zh='昵称', hi='उपनाम', ar='اللقب', ja='ニックネーム', it='Soprannome', pl='Pseudonim', uk='Псевдонім')),
 "fieldOrganization": ('Feld Firma', [], dict(en='Organization', de='Firma', es='Empresa', fr='Organisation', pt='Empresa', ru='Организация', zh='单位', hi='संगठन', ar='المؤسسة', ja='組織', it='Organizzazione', pl='Organizacja', uk='Організація')),
 "fieldJobTitle": ('Feld Position', [], dict(en='Job title', de='Position', es='Cargo', fr='Fonction', pt='Cargo', ru='Должность', zh='职位', hi='पद', ar='المسمى الوظيفي', ja='役職', it='Ruolo', pl='Stanowisko', uk='Посада')),
 "fieldPhone": ('Feld Telefon', [], dict(en='Phone', de='Telefon', es='Teléfono', fr='Téléphone', pt='Telefone', ru='Телефон', zh='电话', hi='फ़ोन', ar='الهاتف', ja='電話', it='Telefono', pl='Telefon', uk='Телефон')),
 "fieldMobile": ('Feld Mobil', [], dict(en='Mobile', de='Mobil', es='Móvil', fr='Mobile', pt='Celular', ru='Мобильный', zh='手机', hi='मोबाइल', ar='الجوال', ja='携帯電話', it='Cellulare', pl='Komórka', uk='Мобільний')),
 "fieldWorkPhone": ('Feld Telefon geschäftlich', [], dict(en='Work phone', de='Telefon (geschäftlich)', es='Teléfono del trabajo', fr='Téléphone (travail)', pt='Telefone comercial', ru='Рабочий телефон', zh='工作电话', hi='कार्यालय फ़ोन', ar='هاتف العمل', ja='勤務先電話', it='Telefono di lavoro', pl='Telefon służbowy', uk='Робочий телефон')),
 "fieldHomePhone": ('Feld Telefon privat', [], dict(en='Home phone', de='Telefon (privat)', es='Teléfono particular', fr='Téléphone (domicile)', pt='Telefone residencial', ru='Домашний телефон', zh='住宅电话', hi='घर का फ़ोन', ar='هاتف المنزل', ja='自宅電話', it='Telefono di casa', pl='Telefon domowy', uk='Домашній телефон')),
 "fieldFax": ('Feld Fax', [], dict(en='Fax', de='Fax', es='Fax', fr='Fax', pt='Fax', ru='Факс', zh='传真', hi='फ़ैक्स', ar='الفاكس', ja='FAX', it='Fax', pl='Faks', uk='Факс')),
 "fieldEmail": ('Feld E-Mail', [], dict(en='Email', de='E-Mail', es='Correo electrónico', fr='E-mail', pt='E-mail', ru='Эл. почта', zh='电子邮件', hi='ईमेल', ar='البريد الإلكتروني', ja='メール', it='Email', pl='E-mail', uk='Ел. пошта')),
 "fieldWebsite": ('Feld Webseite', [], dict(en='Website', de='Webseite', es='Sitio web', fr='Site web', pt='Site', ru='Веб-сайт', zh='网站', hi='वेबसाइट', ar='الموقع الإلكتروني', ja='ウェブサイト', it='Sito web', pl='Strona WWW', uk='Вебсайт')),
 "fieldAddress": ('Feld Adresse', [], dict(en='Address', de='Adresse', es='Dirección', fr='Adresse', pt='Endereço', ru='Адрес', zh='地址', hi='पता', ar='العنوان', ja='住所', it='Indirizzo', pl='Adres', uk='Адреса')),
 "fieldBirthday": ('Feld Geburtstag', [], dict(en='Birthday', de='Geburtstag', es='Cumpleaños', fr='Anniversaire', pt='Aniversário', ru='День рождения', zh='生日', hi='जन्मदिन', ar='تاريخ الميلاد', ja='誕生日', it='Compleanno', pl='Urodziny', uk='День народження')),
 "fieldNote": ('Feld Notiz', [], dict(en='Note', de='Notiz', es='Nota', fr='Note', pt='Observação', ru='Заметка', zh='备注', hi='नोट', ar='ملاحظة', ja='メモ', it='Nota', pl='Notatka', uk='Нотатка')),
 "fieldTo": ('Feld An', [], dict(en='To', de='An', es='Para', fr='À', pt='Para', ru='Кому', zh='收件人', hi='प्रति', ar='إلى', ja='宛先', it='A', pl='Do', uk='Кому')),
 "fieldCc": ('Feld Kopie', [], dict(en='Cc', de='Kopie (CC)', es='CC', fr='Cc', pt='Cc', ru='Копия', zh='抄送', hi='Cc', ar='نسخة', ja='CC', it='Cc', pl='DW', uk='Копія')),
 "fieldBcc": ('Feld Blindkopie', [], dict(en='Bcc', de='Blindkopie (BCC)', es='CCO', fr='Cci', pt='Cco', ru='Скрытая копия', zh='密送', hi='Bcc', ar='نسخة مخفية', ja='BCC', it='Ccn', pl='UDW', uk='Прихована копія')),
 "fieldSubject": ('Feld Betreff', [], dict(en='Subject', de='Betreff', es='Asunto', fr='Objet', pt='Assunto', ru='Тема', zh='主题', hi='विषय', ar='الموضوع', ja='件名', it='Oggetto', pl='Temat', uk='Тема')),
 "fieldMessage": ('Feld Nachricht', [], dict(en='Message', de='Nachricht', es='Mensaje', fr='Message', pt='Mensagem', ru='Сообщение', zh='内容', hi='संदेश', ar='الرسالة', ja='本文', it='Messaggio', pl='Wiadomość', uk='Повідомлення')),
 "fieldNumber": ('Feld Rufnummer', [], dict(en='Number', de='Rufnummer', es='Número', fr='Numéro', pt='Número', ru='Номер', zh='号码', hi='नंबर', ar='الرقم', ja='番号', it='Numero', pl='Numer', uk='Номер')),
 "fieldLatitude": ('Feld Breitengrad', [], dict(en='Latitude', de='Breitengrad', es='Latitud', fr='Latitude', pt='Latitude', ru='Широта', zh='纬度', hi='अक्षांश', ar='خط العرض', ja='緯度', it='Latitudine', pl='Szerokość', uk='Широта')),
 "fieldLongitude": ('Feld Längengrad', [], dict(en='Longitude', de='Längengrad', es='Longitud', fr='Longitude', pt='Longitude', ru='Долгота', zh='经度', hi='देशांतर', ar='خط الطول', ja='経度', it='Longitudine', pl='Długość', uk='Довгота')),
 "fieldAltitude": ('Feld Höhe', [], dict(en='Altitude', de='Höhe', es='Altitud', fr='Altitude', pt='Altitude', ru='Высота', zh='海拔', hi='ऊँचाई', ar='الارتفاع', ja='高度', it='Altitudine', pl='Wysokość', uk='Висота')),
 "fieldQuery": ('Feld Suche/Ort', [], dict(en='Place', de='Ort', es='Lugar', fr='Lieu', pt='Local', ru='Место', zh='地点', hi='स्थान', ar='المكان', ja='場所', it='Luogo', pl='Miejsce', uk='Місце')),
 "fieldTitle": ('Feld Titel', [], dict(en='Title', de='Titel', es='Título', fr='Titre', pt='Título', ru='Название', zh='标题', hi='शीर्षक', ar='العنوان', ja='タイトル', it='Titolo', pl='Tytuł', uk='Назва')),
 "fieldLink": ('Feld Link', [], dict(en='Link', de='Link', es='Enlace', fr='Lien', pt='Link', ru='Ссылка', zh='链接', hi='लिंक', ar='الرابط', ja='リンク', it='Link', pl='Link', uk='Посилання')),
 "fieldStart": ('Feld Beginn', [], dict(en='Start', de='Beginn', es='Inicio', fr='Début', pt='Início', ru='Начало', zh='开始', hi='शुरू', ar='البداية', ja='開始', it='Inizio', pl='Początek', uk='Початок')),
 "fieldEnd": ('Feld Ende', [], dict(en='End', de='Ende', es='Fin', fr='Fin', pt='Fim', ru='Конец', zh='结束', hi='समाप्ति', ar='النهاية', ja='終了', it='Fine', pl='Koniec', uk='Кінець')),
 "fieldLocation": ('Feld Ort Termin', [], dict(en='Location', de='Ort', es='Ubicación', fr='Lieu', pt='Local', ru='Место', zh='地点', hi='स्थान', ar='الموقع', ja='場所', it='Luogo', pl='Miejsce', uk='Місце')),
 "fieldDescription": ('Feld Beschreibung', [], dict(en='Description', de='Beschreibung', es='Descripción', fr='Description', pt='Descrição', ru='Описание', zh='描述', hi='विवरण', ar='الوصف', ja='説明', it='Descrizione', pl='Opis', uk='Опис')),
 "fieldNetwork": ('Feld WLAN-Name', [], dict(en='Network name (SSID)', de='Netzwerkname (SSID)', es='Nombre de red (SSID)', fr='Nom du réseau (SSID)', pt='Nome da rede (SSID)', ru='Имя сети (SSID)', zh='网络名称 (SSID)', hi='नेटवर्क नाम (SSID)', ar='اسم الشبكة (SSID)', ja='ネットワーク名（SSID）', it='Nome rete (SSID)', pl='Nazwa sieci (SSID)', uk='Назва мережі (SSID)')),
 "fieldPassword": ('Feld Passwort', [], dict(en='Password', de='Passwort', es='Contraseña', fr='Mot de passe', pt='Senha', ru='Пароль', zh='密码', hi='पासवर्ड', ar='كلمة المرور', ja='パスワード', it='Password', pl='Hasło', uk='Пароль')),
 "fieldSecurity": ('Feld Verschlüsselung', [], dict(en='Security', de='Verschlüsselung', es='Seguridad', fr='Sécurité', pt='Segurança', ru='Защита', zh='加密方式', hi='सुरक्षा', ar='الأمان', ja='セキュリティ', it='Sicurezza', pl='Zabezpieczenia', uk='Захист')),
 "fieldHidden": ('Feld verstecktes Netz', [], dict(en='Hidden network', de='Verstecktes Netz', es='Red oculta', fr='Réseau masqué', pt='Rede oculta', ru='Скрытая сеть', zh='隐藏网络', hi='छिपा नेटवर्क', ar='شبكة مخفية', ja='非公開ネットワーク', it='Rete nascosta', pl='Sieć ukryta', uk='Прихована мережа')),
 "fieldEapMethod": ('Feld EAP-Methode', [], dict(en='EAP method', de='EAP-Methode', es='Método EAP', fr='Méthode EAP', pt='Método EAP', ru='Метод EAP', zh='EAP 方法', hi='EAP विधि', ar='طريقة EAP', ja='EAP方式', it='Metodo EAP', pl='Metoda EAP', uk='Метод EAP')),
 "fieldIdentity": ('Feld Identität', [], dict(en='Identity', de='Identität', es='Identidad', fr='Identité', pt='Identidade', ru='Идентификатор', zh='身份', hi='पहचान', ar='الهوية', ja='ID', it='Identità', pl='Tożsamość', uk='Ідентифікатор')),
 "fieldRecipient": ('Feld Empfänger', [], dict(en='Recipient', de='Empfänger', es='Beneficiario', fr='Bénéficiaire', pt='Beneficiário', ru='Получатель', zh='收款人', hi='प्राप्तकर्ता', ar='المستفيد', ja='受取人', it='Beneficiario', pl='Odbiorca', uk='Одержувач')),
 "fieldIban": ('Feld IBAN', [], dict(en='IBAN', de='IBAN', es='IBAN', fr='IBAN', pt='IBAN', ru='IBAN', zh='IBAN', hi='IBAN', ar='IBAN', ja='IBAN', it='IBAN', pl='IBAN', uk='IBAN')),
 "fieldBic": ('Feld BIC', [], dict(en='BIC', de='BIC', es='BIC', fr='BIC', pt='BIC', ru='BIC', zh='BIC', hi='BIC', ar='BIC', ja='BIC', it='BIC', pl='BIC', uk='BIC')),
 "fieldAmount": ('Feld Betrag', [], dict(en='Amount', de='Betrag', es='Importe', fr='Montant', pt='Valor', ru='Сумма', zh='金额', hi='राशि', ar='المبلغ', ja='金額', it='Importo', pl='Kwota', uk='Сума')),
 "fieldPurpose": ('Feld Zweck-Code', [], dict(en='Purpose code', de='Zweck-Code', es='Código de propósito', fr='Code motif', pt='Código de finalidade', ru='Код назначения', zh='用途代码', hi='उद्देश्य कोड', ar='رمز الغرض', ja='目的コード', it='Codice causale', pl='Kod celu', uk='Код призначення')),
 "fieldReference": ('Feld Referenz', [], dict(en='Reference', de='Referenz', es='Referencia', fr='Référence', pt='Referência', ru='Референс', zh='参考号', hi='संदर्भ', ar='المرجع', ja='参照番号', it='Riferimento', pl='Referencja', uk='Референс')),
 "fieldRemittance": ('Feld Verwendungszweck', [], dict(en='Payment reference', de='Verwendungszweck', es='Concepto', fr='Libellé', pt='Descrição do pagamento', ru='Назначение платежа', zh='付款附言', hi='भुगतान विवरण', ar='بيان الدفع', ja='振込メモ', it='Causale', pl='Tytuł przelewu', uk='Призначення платежу')),
 "fieldInfo": ('Feld Hinweis', [], dict(en='Note to payer', de='Hinweis', es='Nota para el pagador', fr='Note au payeur', pt='Nota ao pagador', ru='Примечание', zh='付款人备注', hi='भुगतानकर्ता हेतु नोट', ar='ملاحظة للدافع', ja='支払者へのメモ', it='Nota per il pagatore', pl='Uwaga', uk='Примітка')),
 "typeOtp": ('Inhaltsart Einmalpasswort', [], dict(en='One-time password (2FA)', de='Einmalpasswort (2FA)', es='Contraseña de un solo uso (2FA)', fr='Mot de passe à usage unique (2FA)', pt='Senha única (2FA)', ru='Одноразовый пароль (2FA)', zh='一次性密码 (2FA)', hi='वन-टाइम पासवर्ड (2FA)', ar='كلمة مرور لمرة واحدة (2FA)', ja='ワンタイムパスワード（2FA）', it='Password monouso (2FA)', pl='Hasło jednorazowe (2FA)', uk='Одноразовий пароль (2FA)')),
 "infoSupport": ('Info-Dialog Support', [], dict(en='Support', de='Support', es='Soporte', fr='Assistance', pt='Suporte', ru='Поддержка', zh='支持', hi='सहायता', ar='الدعم', ja='サポート', it='Assistenza', pl='Pomoc', uk='Підтримка')),
 "fieldIssuer": ('Feld Anbieter', [], dict(en='Issuer', de='Anbieter', es='Emisor', fr='Émetteur', pt='Emissor', ru='Сервис', zh='发行方', hi='जारीकर्ता', ar='الجهة المصدرة', ja='発行者', it='Emittente', pl='Wystawca', uk='Сервіс')),
 "fieldAccount": ('Feld Konto', [], dict(en='Account', de='Konto', es='Cuenta', fr='Compte', pt='Conta', ru='Аккаунт', zh='账户', hi='खाता', ar='الحساب', ja='アカウント', it='Account', pl='Konto', uk='Обліковий запис')),
 "fieldSecret": ('Feld geheimer Schlüssel', [], dict(en='Secret key', de='Geheimer Schlüssel', es='Clave secreta', fr='Clé secrète', pt='Chave secreta', ru='Секретный ключ', zh='密钥', hi='गुप्त कुंजी', ar='المفتاح السري', ja='秘密鍵', it='Chiave segreta', pl='Klucz tajny', uk='Секретний ключ')),
 "fieldOtpType": ('Feld OTP-Verfahren', [], dict(en='Method', de='Verfahren', es='Método', fr='Méthode', pt='Método', ru='Метод', zh='方式', hi='विधि', ar='الطريقة', ja='方式', it='Metodo', pl='Metoda', uk='Метод')),
 "fieldAlgorithm": ('Feld Algorithmus', [], dict(en='Algorithm', de='Algorithmus', es='Algoritmo', fr='Algorithme', pt='Algoritmo', ru='Алгоритм', zh='算法', hi='एल्गोरिदम', ar='الخوارزمية', ja='アルゴリズム', it='Algoritmo', pl='Algorytm', uk='Алгоритм')),
 "fieldDigits": ('Feld Stellen', [], dict(en='Digits', de='Stellen', es='Dígitos', fr='Chiffres', pt='Dígitos', ru='Цифр', zh='位数', hi='अंक', ar='الأرقام', ja='桁数', it='Cifre', pl='Cyfry', uk='Цифр')),
 "fieldPeriod": ('Feld Intervall', [], dict(en='Interval (seconds)', de='Intervall (Sekunden)', es='Intervalo (segundos)', fr='Intervalle (secondes)', pt='Intervalo (segundos)', ru='Интервал (секунды)', zh='间隔（秒）', hi='अंतराल (सेकंड)', ar='الفاصل (ثوانٍ)', ja='間隔（秒）', it='Intervallo (secondi)', pl='Interwał (sekundy)', uk='Інтервал (секунди)')),
 "fieldCounter": ('Feld Zähler', [], dict(en='Counter', de='Zähler', es='Contador', fr='Compteur', pt='Contador', ru='Счётчик', zh='计数器', hi='काउंटर', ar='العداد', ja='カウンター', it='Contatore', pl='Licznik', uk='Лічильник')),
 "formatMicroQr": ("Formatname Micro-QR", [], dict(
   en="Micro QR code", de="Micro-QR-Code", es="Código Micro QR", fr="Micro QR code", pt="Código Micro QR",
   ru="Micro QR-код", zh="Micro QR 码", hi="Micro QR कोड", ar="رمز Micro QR", ja="マイクロQRコード",
   it="Codice Micro QR", pl="Kod Micro QR", uk="Micro QR-код")),
 "formatUnknown": ("Unbekanntes Format", [], dict(
   en="Unknown", de="Unbekannt", es="Desconocido", fr="Inconnu", pt="Desconhecido", ru="Неизвестно",
   zh="未知", hi="अज्ञात", ar="غير معروف", ja="不明",
   it="Sconosciuto", pl="Nieznany", uk="Невідомо")),
 "formatLine": ("Formatzeile im Ergebnis", ["format"], dict(
   en="Format: {format}", de="Format: {format}", es="Formato: {format}", fr="Format : {format}",
   pt="Formato: {format}", ru="Формат: {format}", zh="格式：{format}", hi="फ़ॉर्मैट: {format}",
   ar="الصيغة: {format}", ja="形式：{format}",
   it="Formato: {format}", pl="Format: {format}", uk="Формат: {format}")),
 "hostLine": ("Hostzeile bei Links", ["host"], dict(
   en="Host: {host}", de="Host: {host}", es="Host: {host}", fr="Hôte : {host}", pt="Host: {host}",
   ru="Хост: {host}", zh="主机：{host}", hi="होस्ट: {host}", ar="المضيف: {host}", ja="ホスト：{host}",
   it="Host: {host}", pl="Host: {host}", uk="Хост: {host}")),
 "copied": ("Meldung nach dem Kopieren", [], dict(
   en="Copied to clipboard", de="In die Zwischenablage kopiert", es="Copiado al portapapeles",
   fr="Copié dans le presse-papiers", pt="Copiado para a área de transferência", ru="Скопировано в буфер обмена",
   zh="已复制到剪贴板", hi="क्लिपबोर्ड पर कॉपी किया गया", ar="تم النسخ إلى الحافظة", ja="クリップボードにコピーしました",
   it="Copiato negli appunti", pl="Skopiowano do schowka", uk="Скопійовано в буфер обміну")),
 "copy": ("Knopf Kopieren", [], dict(
   en="Copy", de="Kopieren", es="Copiar", fr="Copier", pt="Copiar", ru="Копировать",
   zh="复制", hi="कॉपी करें", ar="نسخ", ja="コピー",
   it="Copia", pl="Kopiuj", uk="Копіювати")),
 "openEllipsis": ("Knopf Link öffnen (mit Rückfrage)", [], dict(
   en="Open …", de="Öffnen …", es="Abrir …", fr="Ouvrir …", pt="Abrir …", ru="Открыть …",
   zh="打开…", hi="खोलें …", ar="فتح …", ja="開く…",
   it="Apri …", pl="Otwórz …", uk="Відкрити …")),
 "openLinkTitle": ("Titel der Rückfrage vor dem Öffnen", [], dict(
   en="Open link?", de="Link öffnen?", es="¿Abrir enlace?", fr="Ouvrir le lien ?", pt="Abrir link?",
   ru="Открыть ссылку?", zh="打开链接？", hi="लिंक खोलें?", ar="فتح الرابط؟", ja="リンクを開きますか？",
   it="Aprire il link?", pl="Otworzyć link?", uk="Відкрити посилання?")),
 "open": ("Knopf Öffnen in der Rückfrage", [], dict(
   en="Open", de="Öffnen", es="Abrir", fr="Ouvrir", pt="Abrir", ru="Открыть",
   zh="打开", hi="खोलें", ar="فتح", ja="開く",
   it="Apri", pl="Otwórz", uk="Відкрити")),
 "cancel": ("Knopf Abbrechen", [], dict(
   en="Cancel", de="Abbrechen", es="Cancelar", fr="Annuler", pt="Cancelar", ru="Отмена",
   zh="取消", hi="रद्द करें", ar="إلغاء", ja="キャンセル",
   it="Annulla", pl="Anuluj", uk="Скасувати")),
 "historyClear": ("Tooltip Verlauf löschen", [], dict(
   en="Clear history", de="Verlauf löschen", es="Borrar historial", fr="Effacer l'historique",
   pt="Limpar histórico", ru="Очистить историю", zh="清除历史记录", hi="इतिहास साफ़ करें",
   ar="مسح السجل", ja="履歴を消去",
   it="Cancella cronologia", pl="Wyczyść historię", uk="Очистити історію")),
 "historyClearTitle": ("Titel der Rückfrage Verlauf löschen", [], dict(
   en="Clear history?", de="Verlauf löschen?", es="¿Borrar historial?", fr="Effacer l'historique ?",
   pt="Limpar histórico?", ru="Очистить историю?", zh="清除历史记录？", hi="इतिहास साफ़ करें?",
   ar="مسح السجل؟", ja="履歴を消去しますか？",
   it="Cancellare la cronologia?", pl="Wyczyścić historię?", uk="Очистити історію?")),
 "historyClearBody": ("Text der Rückfrage Verlauf löschen", [], dict(
   en="All saved contents will be removed.", de="Alle gespeicherten Inhalte werden entfernt.",
   es="Se eliminarán todos los contenidos guardados.", fr="Tous les contenus enregistrés seront supprimés.",
   pt="Todos os conteúdos salvos serão removidos.", ru="Все сохранённые данные будут удалены.",
   zh="所有已保存的内容都将被删除。", hi="सभी सहेजी गई सामग्री हटा दी जाएगी।",
   ar="ستتم إزالة جميع المحتويات المحفوظة.", ja="保存されたすべての内容が削除されます。",
   it="Tutti i contenuti salvati verranno rimossi.", pl="Wszystkie zapisane treści zostaną usunięte.", uk="Усі збережені дані буде видалено.")),
 "delete": ("Knopf Löschen", [], dict(
   en="Delete", de="Löschen", es="Eliminar", fr="Supprimer", pt="Excluir", ru="Удалить",
   zh="删除", hi="हटाएँ", ar="حذف", ja="削除",
   it="Elimina", pl="Usuń", uk="Видалити")),
 "historyEmpty": ("Leerer Verlauf", [], dict(
   en="No scanned contents yet.", de="Noch keine gescannten Inhalte.", es="Aún no hay contenidos escaneados.",
   fr="Aucun contenu scanné pour l'instant.", pt="Nenhum conteúdo escaneado ainda.",
   ru="Пока нет отсканированных данных.", zh="暂无扫描内容。", hi="अभी तक कोई स्कैन की गई सामग्री नहीं।",
   ar="لا توجد محتويات ممسوحة بعد.", ja="スキャンした内容はまだありません。",
   it="Nessun contenuto scansionato.", pl="Brak zeskanowanych treści.", uk="Ще немає відсканованих даних.")),
 "infoDeveloper": ("Info: Entwickler", [], dict(
   en="Developer", de="Entwickler", es="Desarrollador", fr="Développeur", pt="Desenvolvedor", ru="Разработчик",
   zh="开发者", hi="डेवलपर", ar="المطوّر", ja="開発者",
   it="Sviluppatore", pl="Deweloper", uk="Розробник")),
 "infoVersion": ("Info: Version", [], dict(
   en="Version", de="Version", es="Versión", fr="Version", pt="Versão", ru="Версия",
   zh="版本", hi="संस्करण", ar="الإصدار", ja="バージョン",
   it="Versione", pl="Wersja", uk="Версія")),
 "infoVersionValue": ("Info: Versionsangabe", ["version", "build"], dict(
   en="{version} (Build {build})", de="{version} (Build {build})", es="{version} (compilación {build})",
   fr="{version} (build {build})", pt="{version} (build {build})", ru="{version} (сборка {build})",
   zh="{version}（构建 {build}）", hi="{version} (बिल्ड {build})", ar="{version} (البناء {build})",
   ja="{version}（ビルド {build}）",
   it="{version} (build {build})", pl="{version} (kompilacja {build})", uk="{version} (збірка {build})")),
 "infoBuildDate": ("Info: Build-Datum", [], dict(
   en="Build date", de="Build-Datum", es="Fecha de compilación", fr="Date de compilation",
   pt="Data da compilação", ru="Дата сборки", zh="构建日期", hi="बिल्ड तिथि", ar="تاريخ البناء", ja="ビルド日",
   it="Data di compilazione", pl="Data kompilacji", uk="Дата збірки")),
 "infoInstalled": ("Info: Installationszeitpunkt", [], dict(
   en="Installed on", de="Installiert am", es="Instalado el", fr="Installé le", pt="Instalado em",
   ru="Установлено", zh="安装时间", hi="इंस्टॉल किया गया", ar="تاريخ التثبيت", ja="インストール日",
   it="Installato il", pl="Zainstalowano", uk="Встановлено")),
 "valueUnknown": ("Unbekannter Wert", [], dict(
   en="unknown", de="unbekannt", es="desconocido", fr="inconnu", pt="desconhecido", ru="неизвестно",
   zh="未知", hi="अज्ञात", ar="غير معروف", ja="不明",
   it="sconosciuto", pl="nieznana", uk="невідомо")),
 "licenses": ("Knopf Lizenzen", [], dict(
   en="Licenses", de="Lizenzen", es="Licencias", fr="Licences", pt="Licenças", ru="Лицензии",
   zh="许可", hi="लाइसेंस", ar="التراخيص", ja="ライセンス",
   it="Licenze", pl="Licencje", uk="Ліцензії")),
 "close": ("Knopf Schließen", [], dict(
   en="Close", de="Schließen", es="Cerrar", fr="Fermer", pt="Fechar", ru="Закрыть",
   zh="关闭", hi="बंद करें", ar="إغلاق", ja="閉じる",
   it="Chiudi", pl="Zamknij", uk="Закрити")),
 "actionEmail": ('Knopf E-Mail schreiben (mit Rückfrage)', [], dict(en='Write email…', de='E-Mail schreiben…', es='Escribir correo…', fr='Écrire un e-mail…', pt='Escrever e-mail…', ru='Написать письмо…', zh='写邮件…', hi='ईमेल लिखें…', ar='كتابة بريد…', ja='メールを作成…', it='Scrivi e-mail…', pl='Napisz e-mail…', uk='Написати лист…')),
 "actionCall": ('Knopf Anrufen (öffnet nur den Wähler)', [], dict(en='Call…', de='Anrufen…', es='Llamar…', fr='Appeler…', pt='Ligar…', ru='Позвонить…', zh='拨打…', hi='कॉल करें…', ar='اتصال…', ja='電話をかける…', it='Chiama…', pl='Zadzwoń…', uk='Зателефонувати…')),
 "actionSms": ('Knopf SMS schreiben', [], dict(en='Write SMS…', de='SMS schreiben…', es='Escribir SMS…', fr='Écrire un SMS…', pt='Escrever SMS…', ru='Написать SMS…', zh='写短信…', hi='SMS लिखें…', ar='كتابة رسالة SMS…', ja='SMSを作成…', it='Scrivi SMS…', pl='Napisz SMS…', uk='Написати SMS…')),
 "actionMap": ('Knopf Ort in Karten zeigen', [], dict(en='Show on map…', de='In Karten zeigen…', es='Ver en el mapa…', fr='Voir sur la carte…', pt='Ver no mapa…', ru='Показать на карте…', zh='在地图中显示…', hi='मानचित्र पर दिखाएँ…', ar='عرض على الخريطة…', ja='地図で表示…', it='Mostra sulla mappa…', pl='Pokaż na mapie…', uk='Показати на мапі…')),
 "actionOtp": ('Knopf Einmalpasswort an Authenticator-App geben', [], dict(en='Open in authenticator…', de='In Authenticator öffnen…', es='Abrir en el autenticador…', fr="Ouvrir dans l'authentificateur…", pt='Abrir no autenticador…', ru='Открыть в аутентификаторе…', zh='在验证器中打开…', hi='ऑथेंटिकेटर में खोलें…', ar='فتح في تطبيق المصادقة…', ja='認証アプリで開く…', it="Apri nell'autenticatore…", pl='Otwórz w aplikacji uwierzytelniającej…', uk='Відкрити в автентифікаторі…')),
 "actionLookUp": ('Knopf Produkt oder Buch online nachschlagen', [], dict(en='Look up online…', de='Online nachschlagen…', es='Buscar en línea…', fr='Rechercher en ligne…', pt='Pesquisar online…', ru='Найти в интернете…', zh='在线查找…', hi='ऑनलाइन खोजें…', ar='البحث على الإنترنت…', ja='オンラインで調べる…', it='Cerca online…', pl='Wyszukaj online…', uk='Знайти в інтернеті…')),
 "actionAddContact": ('Knopf Kontakt übernehmen (Teilen-Menü)', [], dict(en='Add to contacts…', de='Zu Kontakten…', es='Añadir a contactos…', fr='Ajouter aux contacts…', pt='Adicionar aos contatos…', ru='В контакты…', zh='添加到联系人…', hi='संपर्कों में जोड़ें…', ar='إضافة إلى جهات الاتصال…', ja='連絡先に追加…', it='Aggiungi ai contatti…', pl='Dodaj do kontaktów…', uk='До контактів…')),
 "actionAddEvent": ('Knopf Termin übernehmen (Teilen-Menü)', [], dict(en='Add to calendar…', de='Zum Kalender…', es='Añadir al calendario…', fr='Ajouter au calendrier…', pt='Adicionar ao calendário…', ru='В календарь…', zh='添加到日历…', hi='कैलेंडर में जोड़ें…', ar='إضافة إلى التقويم…', ja='カレンダーに追加…', it='Aggiungi al calendario…', pl='Dodaj do kalendarza…', uk='До календаря…')),
 "actionTrack": ('Knopf Sendung verfolgen', [], dict(en='Track shipment…', de='Sendung verfolgen…', es='Seguir envío…', fr="Suivre l'envoi…", pt='Rastrear envio…', ru='Отследить отправление…', zh='跟踪邮件…', hi='शिपमेंट ट्रैक करें…', ar='تتبع الشحنة…', ja='追跡する…', it='Traccia spedizione…', pl='Śledź przesyłkę…', uk='Відстежити відправлення…')),
 "noAppFound": ('Meldung: keine App für die Aktion', [], dict(en='No app found to open this.', de='Keine passende App gefunden.', es='No se encontró ninguna app para abrirlo.', fr="Aucune app trouvée pour l'ouvrir.", pt='Nenhum app encontrado para abrir isto.', ru='Не найдено приложение для открытия.', zh='未找到可打开的应用。', hi='इसे खोलने के लिए कोई ऐप नहीं मिला।', ar='لم يتم العثور على تطبيق لفتح هذا.', ja='開けるアプリが見つかりません。', it='Nessuna app trovata per aprirlo.', pl='Nie znaleziono aplikacji, aby to otworzyć.', uk='Не знайдено застосунок для відкриття.')),
 "share": ('Tooltip Teilen', [], dict(en='Share', de='Teilen', es='Compartir', fr='Partager', pt='Compartilhar', ru='Поделиться', zh='分享', hi='साझा करें', ar='مشاركة', ja='共有', it='Condividi', pl='Udostępnij', uk='Поділитися')),
 "historySearch": ('Tooltip und Hinweis der Verlaufssuche', [], dict(en='Search history', de='Verlauf durchsuchen', es='Buscar en el historial', fr="Rechercher dans l'historique", pt='Pesquisar no histórico', ru='Поиск в истории', zh='搜索历史记录', hi='इतिहास खोजें', ar='البحث في السجل', ja='履歴を検索', it='Cerca nella cronologia', pl='Szukaj w historii', uk='Пошук в історії')),
 "historyNoMatches": ('Verlaufssuche ohne Treffer', [], dict(en='No matches', de='Keine Treffer', es='Sin resultados', fr='Aucun résultat', pt='Nenhum resultado', ru='Ничего не найдено', zh='无匹配项', hi='कोई परिणाम नहीं', ar='لا توجد نتائج', ja='一致する項目はありません', it='Nessun risultato', pl='Brak wyników', uk='Нічого не знайдено')),
 "historyExport": ('Tooltip Verlauf exportieren', [], dict(en='Export', de='Exportieren', es='Exportar', fr='Exporter', pt='Exportar', ru='Экспорт', zh='导出', hi='निर्यात करें', ar='تصدير', ja='エクスポート', it='Esporta', pl='Eksportuj', uk='Експорт')),
 "exportCsv": ('Menü Verlauf als CSV teilen', [], dict(en='Share as CSV', de='Als CSV teilen', es='Compartir como CSV', fr='Partager en CSV', pt='Compartilhar como CSV', ru='Поделиться как CSV', zh='以 CSV 分享', hi='CSV के रूप में साझा करें', ar='مشاركة بصيغة CSV', ja='CSVで共有', it='Condividi come CSV', pl='Udostępnij jako CSV', uk='Поділитися як CSV')),
 "exportJson": ('Menü Verlauf als JSON teilen', [], dict(en='Share as JSON', de='Als JSON teilen', es='Compartir como JSON', fr='Partager en JSON', pt='Compartilhar como JSON', ru='Поделиться как JSON', zh='以 JSON 分享', hi='JSON के रूप में साझा करें', ar='مشاركة بصيغة JSON', ja='JSONで共有', it='Condividi come JSON', pl='Udostępnij jako JSON', uk='Поділитися як JSON')),
 "historyEntryDeleted": ('Meldung nach Löschen eines Eintrags', [], dict(en='Entry deleted', de='Eintrag gelöscht', es='Entrada eliminada', fr='Entrée supprimée', pt='Entrada excluída', ru='Запись удалена', zh='已删除条目', hi='प्रविष्टि हटाई गई', ar='تم حذف الإدخال', ja='項目を削除しました', it='Voce eliminata', pl='Usunięto wpis', uk='Запис видалено')),
 "undo": ('Knopf Rückgängig', [], dict(en='Undo', de='Rückgängig', es='Deshacer', fr='Annuler', pt='Desfazer', ru='Отменить', zh='撤销', hi='पूर्ववत करें', ar='تراجع', ja='元に戻す', it='Annulla', pl='Cofnij', uk='Скасувати')),
 "otpNotSaved": ('Hinweis: 2FA-Codes nicht im Verlauf', [], dict(en='2FA codes are not saved in the history.', de='2FA-Codes werden nicht im Verlauf gespeichert.', es='Los códigos 2FA no se guardan en el historial.', fr="Les codes 2FA ne sont pas enregistrés dans l'historique.", pt='Códigos 2FA não são salvos no histórico.', ru='Коды 2FA не сохраняются в истории.', zh='2FA 码不会保存在历史记录中。', hi='2FA कोड इतिहास में सहेजे नहीं जाते।', ar='لا يتم حفظ رموز 2FA في السجل.', ja='2FAコードは履歴に保存されません。', it='I codici 2FA non vengono salvati nella cronologia.', pl='Kody 2FA nie są zapisywane w historii.', uk='Коди 2FA не зберігаються в історії.')),
 "typeJson": ('Inhaltsart JSON', [], dict(en='JSON', de='JSON', es='JSON', fr='JSON', pt='JSON', ru='JSON', zh='JSON', hi='JSON', ar='JSON', ja='JSON', it='JSON', pl='JSON', uk='JSON')),
 "typePostage": ('Inhaltsart Briefmarke der Deutschen Post', [], dict(en='Postage stamp (Deutsche Post)', de='Briefmarke (Deutsche Post)', es='Franqueo (Deutsche Post)', fr='Affranchissement (Deutsche Post)', pt='Selo postal (Deutsche Post)', ru='Почтовая марка (Deutsche Post)', zh='邮票（Deutsche Post）', hi='डाक टिकट (Deutsche Post)', ar='طابع بريدي (Deutsche Post)', ja='切手（Deutsche Post）', it='Francobollo (Deutsche Post)', pl='Znaczek (Deutsche Post)', uk='Поштова марка (Deutsche Post)')),
 "fieldGtin": ('Feld Artikelnummer', [], dict(en='Item number (GTIN)', de='Artikelnummer (GTIN)', es='Número de artículo (GTIN)', fr="Numéro d'article (GTIN)", pt='Número do item (GTIN)', ru='Номер товара (GTIN)', zh='商品编号 (GTIN)', hi='आइटम नंबर (GTIN)', ar='رقم الصنف (GTIN)', ja='商品番号 (GTIN)', it='Codice articolo (GTIN)', pl='Numer artykułu (GTIN)', uk='Номер товару (GTIN)')),
 "fieldCheckDigit": ('Feld Prüfziffer', [], dict(en='Check digit', de='Prüfziffer', es='Dígito de control', fr='Chiffre de contrôle', pt='Dígito verificador', ru='Контрольная цифра', zh='校验位', hi='चेक अंक', ar='رقم التحقق', ja='チェックディジット', it='Cifra di controllo', pl='Cyfra kontrolna', uk='Контрольна цифра')),
 "fieldGs1Prefix": ('Feld Land der Nummernvergabe (GS1)', [], dict(en='Registered in (GS1)', de='Vergeben in (GS1)', es='Registrado en (GS1)', fr='Attribué en (GS1)', pt='Registrado em (GS1)', ru='Выдан в (GS1)', zh='注册地 (GS1)', hi='पंजीकृत देश (GS1)', ar='مسجل في (GS1)', ja='登録国 (GS1)', it='Registrato in (GS1)', pl='Nadany w (GS1)', uk='Видано в (GS1)')),
 "fieldIsbn": ('Feld ISBN', [], dict(en='ISBN', de='ISBN', es='ISBN', fr='ISBN', pt='ISBN', ru='ISBN', zh='ISBN', hi='ISBN', ar='ISBN', ja='ISBN', it='ISBN', pl='ISBN', uk='ISBN')),
 "fieldIsbn10": ('Feld ISBN-10', [], dict(en='ISBN-10', de='ISBN-10', es='ISBN-10', fr='ISBN-10', pt='ISBN-10', ru='ISBN-10', zh='ISBN-10', hi='ISBN-10', ar='ISBN-10', ja='ISBN-10', it='ISBN-10', pl='ISBN-10', uk='ISBN-10')),
 "fieldIssn": ('Feld ISSN', [], dict(en='ISSN', de='ISSN', es='ISSN', fr='ISSN', pt='ISSN', ru='ISSN', zh='ISSN', hi='ISSN', ar='ISSN', ja='ISSN', it='ISSN', pl='ISSN', uk='ISSN')),
 "fieldTrackingNumber": ('Feld Sendungsnummer', [], dict(en='Tracking number', de='Sendungsnummer', es='Número de seguimiento', fr='Numéro de suivi', pt='Código de rastreio', ru='Трек-номер', zh='跟踪号', hi='ट्रैकिंग नंबर', ar='رقم التتبع', ja='追跡番号', it='Numero di tracciamento', pl='Numer przesyłki', uk='Трек-номер')),
 "valueValid": ('Wert gültig', [], dict(en='valid', de='gültig', es='válido', fr='valide', pt='válido', ru='верна', zh='有效', hi='मान्य', ar='صالح', ja='有効', it='valida', pl='poprawna', uk='правильна')),
 "valueInvalid": ('Wert ungültig', [], dict(en='invalid', de='ungültig', es='no válido', fr='invalide', pt='inválido', ru='неверна', zh='无效', hi='अमान्य', ar='غير صالح', ja='無効', it='non valida', pl='niepoprawna', uk='неправильна')),
 "valueInStore": ('Wert interne Nummer des Handels', [], dict(en='In-store number', de='Interne Nummer (Handel)', es='Número interno de tienda', fr='Numéro interne (magasin)', pt='Número interno da loja', ru='Внутренний номер магазина', zh='店内编码', hi='स्टोर का आंतरिक नंबर', ar='رقم داخلي للمتجر', ja='店内コード', it='Numero interno del negozio', pl='Numer wewnętrzny sklepu', uk='Внутрішній номер магазину')),
 "valueCoupon": ('Wert Gutschein', [], dict(en='Coupon', de='Gutschein', es='Cupón', fr='Bon de réduction', pt='Cupom', ru='Купон', zh='优惠券', hi='कूपन', ar='قسيمة', ja='クーポン', it='Buono', pl='Kupon', uk='Купон')),
 "valueGs1Global": ('Wert GS1 Global Office', [], dict(en='GS1 Global Office', de='GS1 Global Office', es='GS1 Global Office', fr='GS1 Global Office', pt='GS1 Global Office', ru='GS1 Global Office', zh='GS1 Global Office', hi='GS1 Global Office', ar='GS1 Global Office', ja='GS1 Global Office', it='GS1 Global Office', pl='GS1 Global Office', uk='GS1 Global Office')),
}

# iOS-Kamera-Rückfrage (InfoPlist.strings)
CAMERA = dict(
  en="The camera is used to scan QR codes and barcodes.",
  de="Die Kamera wird zum Scannen von QR-Codes und Barcodes benötigt.",
  es="La cámara se usa para escanear códigos QR y de barras.",
  fr="L'appareil photo est utilisé pour scanner les QR codes et les codes-barres.",
  pt="A câmera é usada para escanear códigos QR e códigos de barras.",
  ru="Камера используется для сканирования QR-кодов и штрихкодов.",
  zh="需要使用相机扫描二维码和条形码。",
  hi="QR कोड और बारकोड स्कैन करने के लिए कैमरे का उपयोग किया जाता है।",
  ar="تُستخدم الكاميرا لمسح رموز QR والباركود.",
  ja="QRコードやバーコードをスキャンするためにカメラを使用します。",
  it="La fotocamera viene usata per scansionare codici QR e codici a barre.",
  pl="Aparat służy do skanowania kodów QR i kodów kreskowych.",
  uk="Камера використовується для сканування QR-кодів і штрихкодів.",
)

if __name__ == "__main__":
    root = os.path.join(os.path.dirname(__file__), "..", "..")
    missing = [(k, l) for k, (_, _, t) in S.items() for l in LANGS if l not in t]
    assert not missing, f"Fehlende Übersetzungen: {missing}"
    assert set(CAMERA) == set(LANGS)
    for lang in LANGS:
        arb = {"@@locale": lang}
        for key, (desc, ph, t) in S.items():
            arb[key] = t[lang]
            if lang == "en":
                meta = {"description": desc}
                if ph:
                    meta["placeholders"] = {p: {"type": "String"} for p in ph}
                arb["@" + key] = meta
        path = os.path.join(root, "lib", "l10n", f"app_{lang}.arb")
        with open(path, "w", encoding="utf-8") as f:
            json.dump(arb, f, ensure_ascii=False, indent=2)
            f.write("\n")
        # InfoPlist.strings für iOS
        d = os.path.join(root, "ios", "Runner", f"{IOS_LPROJ.get(lang, lang)}.lproj")
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "InfoPlist.strings"), "w", encoding="utf-8") as f:
            f.write(f'"NSCameraUsageDescription" = "{CAMERA[lang]}";\n')
    print(f"{len(S)} Texte x {len(LANGS)} Sprachen geschrieben")
