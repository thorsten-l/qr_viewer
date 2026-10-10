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

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get scanTitleQr => 'QRコードをスキャン';

  @override
  String get scanTitleBarcode => 'バーコードをスキャン';

  @override
  String get scanTitleDataMatrix => 'Data Matrixをスキャン';

  @override
  String get scanTitlePdf417 => 'PDF417をスキャン';

  @override
  String get scanTitleAztec => 'Aztecコードをスキャン';

  @override
  String get scanTitleAll => 'すべてのコードをスキャン';

  @override
  String get modeQr => 'QRコード';

  @override
  String get modeBarcode => 'バーコード';

  @override
  String get modeAll => 'すべてのコード';

  @override
  String get hintQr => 'リンク、テキスト、Wi-Fi、連絡先';

  @override
  String get hintDataMatrix => '荷札、切手、部品';

  @override
  String get hintPdf417 => '搭乗券、身分証明書';

  @override
  String get hintAztec => '鉄道・航空券';

  @override
  String get hintAll => '対応するすべての形式';

  @override
  String get chooseScanType => 'スキャンの種類を選択';

  @override
  String get history => '履歴';

  @override
  String get info => '情報';

  @override
  String get torch => 'ライト';

  @override
  String get typeUrl => 'URL';

  @override
  String get typeWifi => 'Wi-Fi 情報';

  @override
  String get typeContact => '連絡先';

  @override
  String get typeEmail => 'メール';

  @override
  String get typePhone => '電話番号';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeGeo => '位置情報';

  @override
  String get typeCalendar => '予定';

  @override
  String get typeIsbn => 'ISBN';

  @override
  String get typeProduct => '商品コード';

  @override
  String get typeDriverLicense => '運転免許証';

  @override
  String get typeText => 'テキスト';

  @override
  String get typeBinary => 'バイナリデータ';

  @override
  String byteCount(String count) {
    return '$count バイト';
  }

  @override
  String get vdvTicket => 'VDV eチケット（署名付き）';

  @override
  String get ticketData => 'チケット情報';

  @override
  String get ticketNumber => 'チケット番号';

  @override
  String get ticketProduct => '商品';

  @override
  String get productDeutschlandticket => 'Deutschlandticket';

  @override
  String get productJobticket => 'Deutschlandticket ジョブチケット';

  @override
  String get productStudentTicket => '生徒・学生向け Deutschlandticket';

  @override
  String get validFrom => '有効開始';

  @override
  String get validUntil => '有効期限';

  @override
  String get issuedAt => '発行日時';

  @override
  String get ticketHolder => '所有者';

  @override
  String get birthDate => '生年月日';

  @override
  String get nameMasked => 'マスク済み';

  @override
  String get organizations => '事業者番号';

  @override
  String get travelClass => '等級';

  @override
  String get firstClass => '1等';

  @override
  String get secondClass => '2等';

  @override
  String get ticketPrice => '価格';

  @override
  String get signatureValid => '署名は有効';

  @override
  String get signatureInvalid => '署名が無効';

  @override
  String unknownIssuer(String car) {
    return 'この発行元の公開鍵がありません（CA $car）。チケット情報を読み取れません。';
  }

  @override
  String get rawData => '生データ（16進）';

  @override
  String get lensChoice => 'レンズを選択';

  @override
  String get lensAuto => '自動';

  @override
  String get lensTele => '望遠';

  @override
  String get lensAutoName => '自動（システムがレンズを選択）';

  @override
  String get lensUltraWideName => '超広角';

  @override
  String get lensMainName => 'メインカメラ';

  @override
  String get lensTeleName => '望遠レンズ';

  @override
  String get typePayment => '銀行振込';

  @override
  String get rawContent => '元の内容';

  @override
  String get valueYes => 'はい';

  @override
  String get valueOpenNetwork => 'なし（オープンネットワーク）';

  @override
  String copyField(String label) {
    return '$labelをコピー';
  }

  @override
  String get fieldName => '名前';

  @override
  String get fieldNickname => 'ニックネーム';

  @override
  String get fieldOrganization => '組織';

  @override
  String get fieldJobTitle => '役職';

  @override
  String get fieldPhone => '電話';

  @override
  String get fieldMobile => '携帯電話';

  @override
  String get fieldWorkPhone => '勤務先電話';

  @override
  String get fieldHomePhone => '自宅電話';

  @override
  String get fieldFax => 'FAX';

  @override
  String get fieldEmail => 'メール';

  @override
  String get fieldWebsite => 'ウェブサイト';

  @override
  String get fieldAddress => '住所';

  @override
  String get fieldBirthday => '誕生日';

  @override
  String get fieldNote => 'メモ';

  @override
  String get fieldTo => '宛先';

  @override
  String get fieldCc => 'CC';

  @override
  String get fieldBcc => 'BCC';

  @override
  String get fieldSubject => '件名';

  @override
  String get fieldMessage => '本文';

  @override
  String get fieldNumber => '番号';

  @override
  String get fieldLatitude => '緯度';

  @override
  String get fieldLongitude => '経度';

  @override
  String get fieldAltitude => '高度';

  @override
  String get fieldQuery => '場所';

  @override
  String get fieldTitle => 'タイトル';

  @override
  String get fieldLink => 'リンク';

  @override
  String get fieldStart => '開始';

  @override
  String get fieldEnd => '終了';

  @override
  String get fieldLocation => '場所';

  @override
  String get fieldDescription => '説明';

  @override
  String get fieldNetwork => 'ネットワーク名（SSID）';

  @override
  String get fieldPassword => 'パスワード';

  @override
  String get fieldSecurity => 'セキュリティ';

  @override
  String get fieldHidden => '非公開ネットワーク';

  @override
  String get fieldEapMethod => 'EAP方式';

  @override
  String get fieldIdentity => 'ID';

  @override
  String get fieldRecipient => '受取人';

  @override
  String get fieldIban => 'IBAN';

  @override
  String get fieldBic => 'BIC';

  @override
  String get fieldAmount => '金額';

  @override
  String get fieldPurpose => '目的コード';

  @override
  String get fieldReference => '参照番号';

  @override
  String get fieldRemittance => '振込メモ';

  @override
  String get fieldInfo => '支払者へのメモ';

  @override
  String get typeOtp => 'ワンタイムパスワード（2FA）';

  @override
  String get infoSupport => 'サポート';

  @override
  String get fieldIssuer => '発行者';

  @override
  String get fieldAccount => 'アカウント';

  @override
  String get fieldSecret => '秘密鍵';

  @override
  String get fieldOtpType => '方式';

  @override
  String get fieldAlgorithm => 'アルゴリズム';

  @override
  String get fieldDigits => '桁数';

  @override
  String get fieldPeriod => '間隔（秒）';

  @override
  String get fieldCounter => 'カウンター';

  @override
  String get formatMicroQr => 'マイクロQRコード';

  @override
  String get formatUnknown => '不明';

  @override
  String formatLine(String format) {
    return '形式：$format';
  }

  @override
  String hostLine(String host) {
    return 'ホスト：$host';
  }

  @override
  String get copied => 'クリップボードにコピーしました';

  @override
  String get copy => 'コピー';

  @override
  String get openEllipsis => '開く…';

  @override
  String get openLinkTitle => 'リンクを開きますか？';

  @override
  String get open => '開く';

  @override
  String get cancel => 'キャンセル';

  @override
  String get historyClear => '履歴を消去';

  @override
  String get historyClearTitle => '履歴を消去しますか？';

  @override
  String get historyClearBody => '保存されたすべての内容が削除されます。';

  @override
  String get delete => '削除';

  @override
  String get historyEmpty => 'スキャンした内容はまだありません。';

  @override
  String get infoDeveloper => '開発者';

  @override
  String get infoVersion => 'バージョン';

  @override
  String infoVersionValue(String version, String build) {
    return '$version（ビルド $build）';
  }

  @override
  String get infoBuildDate => 'ビルド日';

  @override
  String get infoInstalled => 'インストール日';

  @override
  String get valueUnknown => '不明';

  @override
  String get licenses => 'ライセンス';

  @override
  String get close => '閉じる';
}
