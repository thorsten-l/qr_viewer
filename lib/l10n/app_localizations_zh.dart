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

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get scanTitleQr => '扫描二维码';

  @override
  String get scanTitleBarcode => '扫描条形码';

  @override
  String get scanTitleDataMatrix => '扫描 Data Matrix';

  @override
  String get scanTitlePdf417 => '扫描 PDF417';

  @override
  String get scanTitleAztec => '扫描 Aztec 码';

  @override
  String get scanTitleAll => '扫描所有码';

  @override
  String get modeQr => '二维码';

  @override
  String get modeBarcode => '条形码';

  @override
  String get modeAll => '所有码';

  @override
  String get hintQr => '链接、文本、Wi-Fi、联系人';

  @override
  String get hintDataMatrix => '包裹标签、邮票、零部件';

  @override
  String get hintPdf417 => '登机牌、身份证件';

  @override
  String get hintAztec => '火车票和机票';

  @override
  String get hintAll => '所有支持的格式';

  @override
  String get chooseScanType => '选择扫描类型';

  @override
  String get history => '历史记录';

  @override
  String get info => '关于';

  @override
  String get torch => '手电筒';

  @override
  String get typeUrl => '网址';

  @override
  String get typeWifi => 'Wi-Fi 信息';

  @override
  String get typeContact => '联系人';

  @override
  String get typeEmail => '电子邮件';

  @override
  String get typePhone => '电话号码';

  @override
  String get typeSms => '短信';

  @override
  String get typeGeo => '位置';

  @override
  String get typeCalendar => '日程';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => '商品码';

  @override
  String get typeDriverLicense => '驾驶证';

  @override
  String get typeText => '文本';

  @override
  String get typeBinary => '二进制数据';

  @override
  String byteCount(String count) {
    return '$count 字节';
  }

  @override
  String get vdvTicket => 'VDV 电子票（已签名）';

  @override
  String get ticketData => '车票数据';

  @override
  String get ticketNumber => '票号';

  @override
  String get ticketProduct => '产品';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket 职工票';

  @override
  String get productStudentTicket => '学生版 Deutschlandticket';

  @override
  String get validFrom => '生效时间';

  @override
  String get validUntil => '失效时间';

  @override
  String get issuedAt => '签发时间';

  @override
  String get ticketHolder => '持票人';

  @override
  String get birthDate => '出生日期';

  @override
  String get nameMasked => '已遮盖';

  @override
  String get organizations => '机构编号';

  @override
  String get travelClass => '舱位等级';

  @override
  String get firstClass => '一等';

  @override
  String get secondClass => '二等';

  @override
  String get ticketPrice => '价格';

  @override
  String get signatureValid => '签名有效';

  @override
  String get signatureInvalid => '签名无效';

  @override
  String unknownIssuer(String car) {
    return '没有该签发方的公钥（CA $car），无法读取车票数据。';
  }

  @override
  String get rawData => '原始数据（十六进制）';

  @override
  String get lensChoice => '选择镜头';

  @override
  String get lensAuto => '自动';

  @override
  String get lensTele => '长焦';

  @override
  String get lensAutoName => '自动（由系统选择镜头）';

  @override
  String get lensUltraWideName => '超广角';

  @override
  String get lensMainName => '主摄像头';

  @override
  String get lensTeleName => '长焦镜头';

  @override
  String get typePayment => '银行转账';

  @override
  String get rawContent => '原始内容';

  @override
  String get valueYes => '是';

  @override
  String get valueOpenNetwork => '无（开放网络）';

  @override
  String copyField(String label) {
    return '复制$label';
  }

  @override
  String get fieldName => '姓名';

  @override
  String get fieldNickname => '昵称';

  @override
  String get fieldOrganization => '单位';

  @override
  String get fieldJobTitle => '职位';

  @override
  String get fieldPhone => '电话';

  @override
  String get fieldMobile => '手机';

  @override
  String get fieldWorkPhone => '工作电话';

  @override
  String get fieldHomePhone => '住宅电话';

  @override
  String get fieldFax => '传真';

  @override
  String get fieldEmail => '电子邮件';

  @override
  String get fieldWebsite => '网站';

  @override
  String get fieldAddress => '地址';

  @override
  String get fieldBirthday => '生日';

  @override
  String get fieldNote => '备注';

  @override
  String get fieldTo => '收件人';

  @override
  String get fieldCc => '抄送';

  @override
  String get fieldBcc => '密送';

  @override
  String get fieldSubject => '主题';

  @override
  String get fieldMessage => '内容';

  @override
  String get fieldNumber => '号码';

  @override
  String get fieldLatitude => '纬度';

  @override
  String get fieldLongitude => '经度';

  @override
  String get fieldAltitude => '海拔';

  @override
  String get fieldQuery => '地点';

  @override
  String get fieldTitle => '标题';

  @override
  String get fieldLink => '链接';

  @override
  String get fieldStart => '开始';

  @override
  String get fieldEnd => '结束';

  @override
  String get fieldLocation => '地点';

  @override
  String get fieldDescription => '描述';

  @override
  String get fieldNetwork => '网络名称 (SSID)';

  @override
  String get fieldPassword => '密码';

  @override
  String get fieldSecurity => '加密方式';

  @override
  String get fieldHidden => '隐藏网络';

  @override
  String get fieldEapMethod => 'EAP 方法';

  @override
  String get fieldIdentity => '身份';

  @override
  String get fieldRecipient => '收款人';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => '金额';

  @override
  String get fieldPurpose => '用途代码';

  @override
  String get fieldReference => '参考号';

  @override
  String get fieldRemittance => '付款附言';

  @override
  String get fieldInfo => '付款人备注';

  @override
  String get typeOtp => '一次性密码 (2FA)';

  @override
  String get infoSupport => '支持';

  @override
  String get fieldIssuer => '发行方';

  @override
  String get fieldAccount => '账户';

  @override
  String get fieldSecret => '密钥';

  @override
  String get fieldOtpType => '方式';

  @override
  String get fieldAlgorithm => '算法';

  @override
  String get fieldDigits => '位数';

  @override
  String get fieldPeriod => '间隔（秒）';

  @override
  String get fieldCounter => '计数器';

  @override
  String get formatMicroQr => 'Micro QR 码';

  @override
  String get formatUnknown => '未知';

  @override
  String formatLine(String format) {
    return '格式：$format';
  }

  @override
  String hostLine(String host) {
    return '主机：$host';
  }

  @override
  String get copied => '已复制到剪贴板';

  @override
  String get copy => '复制';

  @override
  String get openEllipsis => '打开…';

  @override
  String get openLinkTitle => '打开链接？';

  @override
  String get open => '打开';

  @override
  String get cancel => '取消';

  @override
  String get historyClear => '清除历史记录';

  @override
  String get historyClearTitle => '清除历史记录？';

  @override
  String get historyClearBody => '所有已保存的内容都将被删除。';

  @override
  String get delete => '删除';

  @override
  String get historyEmpty => '暂无扫描内容。';

  @override
  String get infoDeveloper => '开发者';

  @override
  String get infoVersion => '版本';

  @override
  String infoVersionValue(String version, String build) {
    return '$version（构建 $build）';
  }

  @override
  String get infoBuildDate => '构建日期';

  @override
  String get infoInstalled => '安装时间';

  @override
  String get valueUnknown => '未知';

  @override
  String get licenses => '许可';

  @override
  String get showCode => '显示码';

  @override
  String shownAsQr(String format) {
    return '无法在此绘制 $format，以二维码显示。';
  }

  @override
  String get codeTooLarge => '内容过大，无法绘制为码。';

  @override
  String get close => '关闭';

  @override
  String get actionEmail => '写邮件…';

  @override
  String get actionCall => '拨打…';

  @override
  String get actionSms => '写短信…';

  @override
  String get actionMap => '在地图中显示…';

  @override
  String get actionOtp => '在验证器中打开…';

  @override
  String get actionLookUp => '在线查找…';

  @override
  String get actionAddContact => '添加到联系人…';

  @override
  String get actionAddEvent => '添加到日历…';

  @override
  String get actionTrack => '跟踪邮件…';

  @override
  String get noAppFound => '未找到可打开的应用。';

  @override
  String get share => '分享';

  @override
  String get historySearch => '搜索历史记录';

  @override
  String get historyNoMatches => '无匹配项';

  @override
  String get historyExport => '导出';

  @override
  String get exportCsv => '以 CSV 分享';

  @override
  String get exportJson => '以 JSON 分享';

  @override
  String get historyEntryDeleted => '已删除条目';

  @override
  String get undo => '撤销';

  @override
  String get otpNotSaved => '2FA 码不会保存在历史记录中。';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => '邮票（Deutsche Post）';

  @override
  String get fieldGtin => '商品编号 (GTIN)';

  @override
  String get fieldCheckDigit => '校验位';

  @override
  String get fieldGs1Prefix => '注册地 (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => '跟踪号';

  @override
  String get valueValid => '有效';

  @override
  String get valueInvalid => '无效';

  @override
  String get valueInStore => '店内编码';

  @override
  String get valueCoupon => '优惠券';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => '关于这些数据';

  @override
  String get infoLocal => 'QR Viewer 直接从码中读取了这些信息。这一切只在您的设备上进行，不会向互联网发送任何内容。';

  @override
  String infoOnline(String action, String host) {
    return '点击“$action”后，浏览器会打开网站 $host。该网站会看到您在查找什么，并像任何网站一样看到您的网络地址。它显示的内容来自应用之外，QR Viewer 无法核实其是否正确。';
  }

  @override
  String infoOtherApp(String action) {
    return '点击“$action”后，数据会交给设备上的另一个应用，例如邮件、电话、地图或日历。之后如何处理这些数据由该应用决定。';
  }

  @override
  String get infoKindText => '纯文本。此码只包含这些文字或字符，没有其他内容。';

  @override
  String get infoKindUrl =>
      '网址（链接）。它指向互联网上的某个页面或打开另一个应用。链接可能指向任何地方，只有在您信任此码的来源时才打开。';

  @override
  String get infoKindEmail => '电子邮件地址，通常附带预先写好的主题和正文。只有您在邮件应用中亲自发送后，邮件才会发出。';

  @override
  String get infoKindPhone => '电话号码。QR Viewer 绝不会自行拨打，只会打开电话应用并填好号码。';

  @override
  String get infoKindSms => '电话号码以及预先写好的短信。只有您亲自发送，短信才会发出——短信可能会产生费用。';

  @override
  String get infoKindGeo => '地球上的一个地点，以坐标（纬度和经度）表示。地图应用可以为您显示它的位置。';

  @override
  String get infoKindContact => '数字名片，包含某人的信息，例如姓名、电话和地址。您可以将其保存到通讯录。';

  @override
  String get infoKindEvent => '带有日期、时间（通常还有地点）的日程。您可以将其添加到日历。';

  @override
  String get infoKindWifi => 'Wi-Fi 网络的连接信息：网络名称，通常还有密码。任何看到此码的人都可以使用该网络。';

  @override
  String get infoKindPayment =>
      '预先填好的银行转账（GiroCode）：收款人、IBAN、金额和用途。银行应用可以直接使用这些信息——付款前请逐项核对。';

  @override
  String get infoKindOtp =>
      '用于两步登录（2FA）的密钥。身份验证器应用用它生成简短的登录码。请妥善保密——QR Viewer 不会将其保存在历史记录中。';

  @override
  String get infoKindProduct =>
      '商品条形码中的商品编号（GTIN/EAN）。它只用于标识商品——码中不含名称、价格或配料。前几位数字表示分配该编号的国家，而不一定是商品的产地。';

  @override
  String get infoKindBook => '图书（ISBN）或期刊（ISSN）的编号。它准确标识这一版本——码中没有书名和作者。';

  @override
  String get infoKindJson =>
      'JSON 格式的结构化数据，常用于计算机程序之间交换信息。QR Viewer 只是将其整齐缩进显示。';

  @override
  String get infoKindPostage => '德国邮政邮票或 Internetmarke 上的码，其中包含信件的跟踪号。';

  @override
  String get infoKindVdv =>
      '公交和火车的电子车票（VDV eTicket，例如 Deutschlandticket）。数字签名可防止车票被篡改；QR Viewer 使用交通公司公开的密钥进行验证。';

  @override
  String get typeMatter => 'Matter 设备';

  @override
  String get fieldVendorId => '厂商 ID';

  @override
  String get fieldProductId => '产品 ID';

  @override
  String get fieldDiscriminator => '鉴别码';

  @override
  String get fieldSetupCode => '设置码（PIN）';

  @override
  String get fieldManualCode => '手动配对码';

  @override
  String get fieldDiscovery => '设置方式';

  @override
  String get fieldFlow => '设置流程';

  @override
  String get valueFlowStandard => '标准';

  @override
  String get valueFlowUserAction => '请先激活设备（例如按下按钮）';

  @override
  String get valueFlowCustom => '需要厂商的应用';

  @override
  String get valueDiscoverySoftAp => 'Wi-Fi 热点（SoftAP）';

  @override
  String get valueDiscoveryOnNetwork => '现有网络';

  @override
  String get infoKindMatter =>
      '符合 Matter 标准的智能家居设备的设置数据。智能家居应用（如 Apple 家庭、Google Home）用它来添加设备——请在该应用中扫描此码，或输入手动配对码。设备处于设置模式时，任何拿到此码的人都可以配对该设备。';

  @override
  String get infoManuals => '使用手册';

  @override
  String get typeBookmark => '书签';

  @override
  String get infoKindBookmark =>
      '书签：带有名称的网页链接（MEBKM 格式）。和任何链接一样，它可能指向任何地方——只有在信任二维码来源时才打开。';
}
