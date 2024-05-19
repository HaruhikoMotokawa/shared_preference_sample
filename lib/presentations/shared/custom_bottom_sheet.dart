import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/presentations/shared/action_bottom_sheet.dart';

/// アイコン設定を選択するボトムシート
Future<bool?> showSelectIconSettingBottomSheet(BuildContext context) async {
  final completer = Completer<bool?>();
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.power,
        text: '有効',
        onTap: () => completer.complete(true),
      ),
      ActionItem(
        icon: Icons.power_off,
        text: '無効',
        onTap: () => completer.complete(false),
      ),
    ],
  );
  return completer.future;
}

/// 背景色を選択するボトムシート
Future<int?> showSelectColorBottomSheet(BuildContext context) async {
  final completer = Completer<int?>();
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.fire_truck,
        text: '赤に変更（１）',
        onTap: () => completer.complete(1),
      ),
      ActionItem(
        icon: Icons.water,
        text: '青に変更（2）',
        onTap: () => completer.complete(2),
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（0）',
        onTap: () => completer.complete(0),
      ),
    ],
  );
  return completer.future;
}

/// タイトルを選択するボトムシート
Future<String?> showSelectTitleBottomSheet(BuildContext context) async {
  final completer = Completer<String?>();
  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.apple,
        text: 'iOS',
        onTap: () => completer.complete('iOS'),
      ),
      ActionItem(
        icon: Icons.adb,
        text: 'Android',
        onTap: () => completer.complete('Android'),
      ),
      ActionItem(
        icon: Icons.refresh,
        text: 'デフォルトに戻す（なし）',
        onTap: () => completer.complete('No Title'),
      ),
    ],
  );
  return completer.future;
}
