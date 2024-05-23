import 'package:flutter/material.dart';
import 'package:shared_preference_sample/core/logger.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';
import 'package:shared_preference_sample/domains/tile_type.dart';

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
  /// `AsyncValue`の戻り値`data`は`Object`型でそこに対応するため
  /// ここに直接intやboolを渡しても対応できる
  final Object? value;

  /// Tileのタイプ
  final TileType type;
  @override
  Widget build(BuildContext context) {
    logger.d('${type.title}のタイルをビルド');
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
