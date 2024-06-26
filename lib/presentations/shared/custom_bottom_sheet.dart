// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/presentations/shared/action_bottom_sheet.dart';

/// アイコン設定を選択するボトムシート
Future<bool?> showSelectIconSettingBottomSheet(
  BuildContext context, {
  ValueKey<String>? trueKey,
  ValueKey<String>? falseKey,
}) async {
  // 非同期処理の結果を管理するためのオブジェクト
  final completer = Completer<bool?>();

  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        valueKey: trueKey,
        icon: Icons.power,
        text: '有効',
        // completerにtrueを渡している
        onTap: () => completer.complete(true),
        // 以下のようにしてもtrueを返せない
        // 非同期処理の完了を待つ必要がある
        // onTap: () => true,
      ),
      ActionItem(
        valueKey: falseKey,
        icon: Icons.power_off,
        text: '無効',
        // completerにfalseを渡している
        onTap: () => completer.complete(false),
      ),
    ],
  );
  // 受け取った値を最終的にここで返す
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
        text: 'No Title',
        onTap: () => completer.complete('No Title'),
      ),
    ],
  );
  return completer.future;
}
