import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/shared/action_bottom_sheet.dart';

/// 背景色を選択するボトムシート
Future<void> showSelectColorBottomSheet(BuildContext context) async {
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.fire_truck,
        text: '赤に変更（１）',
        onTap: () => 1,
      ),
      ActionItem(
        icon: Icons.water,
        text: '青に変更（2）',
        onTap: () => 2,
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（0）',
        onTap: () => 0,
      ),
    ],
  );
}

/// タイトルを選択するボトムシート
Future<void> showSelectTitleBottomSheet(BuildContext context) async {
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.apple,
        text: 'iOS',
        onTap: () => 'Sample Title',
      ),
      ActionItem(
        icon: Icons.adb,
        text: 'Android',
        onTap: () => 'Android',
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（なし）',
        onTap: () => 'No Title',
      ),
    ],
  );
}
