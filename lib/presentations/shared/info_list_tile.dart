// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';
import 'package:shared_preference_sample/logger.dart';

class InfoListTile<T> extends StatelessWidget {
  const InfoListTile({
    required this.value,
    required this.title,
    super.key,
  });

  final Object? value;
  final String title;
  @override
  Widget build(BuildContext context) {
    logger.d('$titleのタイルをビルド');
    return switch (value) {
      final bool boolValue => ListTile(
          title: Text(title),
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
              Text(title),
              const Spacer(),
              Expanded(
                child: Text(
                  customSettingValue.toString(),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      _ => ListTile(
          title: Text(title),
          trailing: const Text('値がnullまたは対応しない型です'),
        ),
    };
  }
}
