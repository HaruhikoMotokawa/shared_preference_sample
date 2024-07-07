import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/applications/log/logger.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

/// 現在の設定内容を表示するListTile
class InfoListTile extends StatelessWidget {
  /// 現在の設定内容を表示するListTile
  const InfoListTile({
    required this.value,
    required this.type,
    super.key,
  });

  /// 値のObject
  ///
  /// ここでは多様な型に対応できるようにObjectで定義している
  final Object? value;

  /// Tileのタイプ
  final TileType type;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isMacOS) {
      logger.d('${type.title}のタイルをビルド');
    }
    return switch (value) {
      null => ListTile(
          title: Text(type.title),
          trailing: const Text('値がnullです'),
        ),
      final bool boolValue => ListTile(
          title: Text(type.title),
          trailing: switch (boolValue) {
            true => const Icon(Icons.power),
            false => const Icon(Icons.power_off),
          },
        ),
      final int intValue => ListTile(
          title: const Text('背景色の番号'),
          trailing: Text(intValue.toString()),
          tileColor: switch (intValue) {
            1 => Colors.red,
            2 => Colors.blue,
            _ => Colors.transparent,
          },
        ),
      final String stringValue => ListTile(
          title: const Text('タイトルの文字'),
          trailing: Text(stringValue),
        ),
      final CustomSetting customSettingValue => Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(type.title),
              const Spacer(),
              Expanded(
                child: Text(
                  customSettingValue.toJson().toString(),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      _ => ListTile(
          title: Text(type.title),
          trailing: const Text('対応しない型です'),
        ),
    };
  }
}

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
