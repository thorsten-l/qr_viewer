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
  String get menu => 'メニュー';

  @override
  String get settings => '設定';

  @override
  String get enableActions => 'アクションを有効にする';

  @override
  String get enableActionsHint =>
      '結果ページに「開く」「電話」「検索」などのボタンを表示します。オフの場合は表示とコピーのみです。';

  @override
  String get scanFromPhoto => '写真からスキャン';

  @override
  String get scanFromPhotoHint =>
      'ライトの横に写真ボタンを表示します。写真から画像を選ぶと、その中のコードを読み取ります。アプリが受け取るのは選んだ画像だけです。';

  @override
  String get pickPhoto => '写真をスキャン';

  @override
  String get analyzingPhoto => '写真を解析中…';

  @override
  String get noCodeInPhoto => '写真にコードが見つかりませんでした。';

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
  String get showCode => 'コードを表示';

  @override
  String shownAsQr(String format) {
    return '$format はここでは描画できないため、QRコードで表示しています。';
  }

  @override
  String get codeTooLarge => '内容が大きすぎてコードとして描画できません。';

  @override
  String get close => '閉じる';

  @override
  String get actionEmail => 'メールを作成…';

  @override
  String get actionCall => '電話をかける…';

  @override
  String get actionSms => 'SMSを作成…';

  @override
  String get actionMap => '地図で表示…';

  @override
  String get actionOtp => '認証アプリで開く…';

  @override
  String get actionLookUp => 'オンラインで調べる…';

  @override
  String get actionAddContact => '連絡先に追加…';

  @override
  String get actionAddEvent => 'カレンダーに追加…';

  @override
  String get actionTrack => '追跡する…';

  @override
  String get noAppFound => '開けるアプリが見つかりません。';

  @override
  String get share => '共有';

  @override
  String get historySearch => '履歴を検索';

  @override
  String get historyNoMatches => '一致する項目はありません';

  @override
  String get historyExport => 'エクスポート';

  @override
  String get exportCsv => 'CSVで共有';

  @override
  String get exportJson => 'JSONで共有';

  @override
  String get historyEntryDeleted => '項目を削除しました';

  @override
  String get undo => '元に戻す';

  @override
  String get otpNotSaved => '2FAコードは履歴に保存されません。';

  @override
  String get typeJson => 'JSON';

  @override
  String get typePostage => '切手（Deutsche Post）';

  @override
  String get fieldGtin => '商品番号 (GTIN)';

  @override
  String get fieldCheckDigit => 'チェックディジット';

  @override
  String get fieldGs1Prefix => '登録国 (GS1)';

  @override
  String get fieldIsbn => 'ISBN';

  @override
  String get fieldIsbn10 => 'ISBN-10';

  @override
  String get fieldIssn => 'ISSN';

  @override
  String get fieldTrackingNumber => '追跡番号';

  @override
  String get valueValid => '有効';

  @override
  String get valueInvalid => '無効';

  @override
  String get valueInStore => '店内コード';

  @override
  String get valueCoupon => 'クーポン';

  @override
  String get valueGs1Global => 'GS1 Global Office';

  @override
  String get dataInfo => 'このデータについて';

  @override
  String get infoLocal =>
      'QR Viewer はこの情報をコードから直接読み取りました。処理はすべてこの端末内で行われ、インターネットには何も送信されません。';

  @override
  String infoOnline(String action, String host) {
    return '「$action」をタップすると、ブラウザでウェブサイト $host が開きます。そのサイトには、何を調べているかと、どのサイトでも同じようにあなたのインターネット上のアドレスが伝わります。表示される内容はアプリの外部から来るもので、QR Viewer はその正しさを確認できません。';
  }

  @override
  String infoOtherApp(String action) {
    return '「$action」をタップすると、データは端末上の別のアプリ（メール、電話、マップ、カレンダーなど）に渡されます。その後の扱いはそのアプリ次第です。';
  }

  @override
  String get infoKindText => 'ただのテキストです。コードにはこの文字だけが含まれ、それ以外はありません。';

  @override
  String get infoKindUrl =>
      'ウェブアドレス（リンク）です。インターネット上のページを開いたり、別のアプリを起動したりします。リンクの行き先は何でもあり得るので、コードの出どころが信頼できる場合にだけ開いてください。';

  @override
  String get infoKindEmail =>
      'メールアドレスです。件名や本文があらかじめ入っていることもあります。メールアプリで自分で送信するまで、何も送られません。';

  @override
  String get infoKindPhone =>
      '電話番号です。QR Viewer が勝手に発信することはなく、番号が入力された状態で電話アプリが開くだけです。';

  @override
  String get infoKindSms =>
      'SMS の本文があらかじめ入った電話番号です。自分で送信しない限り送られません。SMS には料金がかかる場合があります。';

  @override
  String get infoKindGeo => '緯度と経度の座標で表された地球上の場所です。地図アプリでその位置を確認できます。';

  @override
  String get infoKindContact => '名前、電話番号、住所など、人の情報が入ったデジタル名刺です。連絡先に保存できます。';

  @override
  String get infoKindEvent => '日付・時刻、多くの場合は場所も含む予定です。カレンダーに追加できます。';

  @override
  String get infoKindWifi =>
      'Wi-Fi ネットワークの接続情報（ネットワーク名と、通常はパスワード）です。このコードを見た人は誰でもそのネットワークを使えます。';

  @override
  String get infoKindPayment =>
      'あらかじめ用意された銀行振込（GiroCode）です。受取人、IBAN、金額、振込目的が含まれます。銀行アプリで利用できますが、支払う前にすべての内容を確認してください。';

  @override
  String get infoKindOtp =>
      '2 段階認証（2FA）用の秘密鍵です。認証アプリはこれを使って短いログインコードを作ります。他人に知られないようにしてください。QR Viewer は履歴に保存しません。';

  @override
  String get infoKindProduct =>
      '商品のバーコードにある商品番号（GTIN/EAN）です。商品を識別するだけで、名前・価格・原材料はコードに含まれません。最初の数字は番号を割り当てた国を示し、製造国とは限りません。';

  @override
  String get infoKindBook =>
      '書籍（ISBN）または雑誌（ISSN）の番号です。この版を正確に識別しますが、タイトルや著者はコードに含まれません。';

  @override
  String get infoKindJson =>
      'コンピュータープログラム同士がやり取りする JSON 形式の構造化データです。QR Viewer は見やすく字下げして表示するだけです。';

  @override
  String get infoKindPostage =>
      'ドイツポスト（Deutsche Post）の切手や Internetmarke に印刷されたコードで、郵便物の追跡番号が入っています。';

  @override
  String get infoKindVdv =>
      'バスや電車の電子乗車券（VDV eTicket、例：Deutschlandticket）です。デジタル署名で改ざんから守られており、QR Viewer は交通事業者の公開鍵で署名を確認します。';

  @override
  String get typeMatter => 'Matterデバイス';

  @override
  String get fieldVendorId => 'ベンダーID';

  @override
  String get fieldProductId => '製品ID';

  @override
  String get fieldDiscriminator => 'ディスクリミネーター';

  @override
  String get fieldSetupCode => 'セットアップコード（PIN）';

  @override
  String get fieldManualCode => '手動ペアリングコード';

  @override
  String get fieldDiscovery => 'セットアップ方法';

  @override
  String get fieldFlow => 'セットアップの流れ';

  @override
  String get valueFlowStandard => '標準';

  @override
  String get valueFlowUserAction => '先に機器を有効にしてください（例：ボタンを押す）';

  @override
  String get valueFlowCustom => 'メーカーのアプリが必要';

  @override
  String get valueDiscoverySoftAp => 'Wi-Fi アクセスポイント（SoftAP）';

  @override
  String get valueDiscoveryOnNetwork => '既存のネットワーク';

  @override
  String get infoKindMatter =>
      'Matter 規格に対応したスマートホーム機器のセットアップデータです。スマートホームアプリ（例：Apple ホーム、Google Home）はこれを使って機器を追加します。そのアプリでコードをスキャンするか、手動ペアリングコードを入力してください。機器がセットアップモードの間は、このコードを知っている人なら誰でもペアリングできます。';

  @override
  String get infoManuals => 'マニュアル';

  @override
  String get typeBookmark => 'ブックマーク';

  @override
  String get infoKindBookmark =>
      'ブックマーク：名前付きのウェブサイトへのリンクです（MEBKM 形式）。どんなリンクも行き先はさまざまです。コードの出所を信頼できる場合にだけ開いてください。';
}
