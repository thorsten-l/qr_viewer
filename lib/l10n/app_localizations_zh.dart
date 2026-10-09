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
  String get close => '关闭';
}
