/// ListTileの種類
enum TileType {
  /// アイコン設定
  iconSetting(title: 'アイコンの設定'),

  /// 背景色の番号
  backgroundColorNumber(title: '背景色の番号'),

  /// タイトルのテキスト
  titleText(title: 'タイトルの文字'),

  /// CustomSetting
  customSetting(title: 'JSONで複数の設定'),
  ;

  const TileType({required this.title});

  /// ListTileのtitleWidgetに表示する文字列
  final String title;
}
