import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/shared/action_bottom_sheet.dart';

/// 背景色を選択するボトムシート
Future<void> showSelectColorBottomSheet(
  BuildContext context,
  WidgetRef ref,
) async {
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.fire_truck,
        text: '赤に変更（１）',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setBackgroundColorNumber(1),
      ),
      ActionItem(
        icon: Icons.water,
        text: '青に変更（2）',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setBackgroundColorNumber(2),
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（0）',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setBackgroundColorNumber(0),
      ),
    ],
  );
}

/// タイトルを選択するボトムシート
Future<void> showSelectTitleBottomSheet(
  BuildContext context,
  WidgetRef ref,
) async {
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.apple,
        text: 'iOS',
        onTap: () => ref.read(keyValueRepositoryProvider).setTitleText('iOS'),
      ),
      ActionItem(
        icon: Icons.adb,
        text: 'Android',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setTitleText('Android'),
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（なし）',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setTitleText('No Title'),
      ),
    ],
  );
}

/// タイトルを選択するボトムシート
Future<void> showSelectIconSettingBottomSheet(
  BuildContext context,
  WidgetRef ref,
) async {
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.power,
        text: '有効',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setIconSetting(value: true),
      ),
      ActionItem(
        icon: Icons.power_off,
        text: '無効',
        onTap: () =>
            ref.read(keyValueRepositoryProvider).setIconSetting(value: false),
      ),
    ],
  );
}
