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
