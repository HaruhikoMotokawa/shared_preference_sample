import 'package:flutter/material.dart';

/// ボトムシートの原型
///
/// ここでがグローバルで宣言しているが[ActionBottomSheet]のstatic methodで宣言してもいい
/// null許容にしているのは、ボトムシートの外をタップしたりスワイプすると
/// 何も選択しないでボトムシートを閉じられてしまう可能性があるから
Future<void> showActionBottomSheet(
  BuildContext context, {
  required List<ActionItem> actions,
}) {
  // Flutter標準のボトムシートの関数を呼び出す
  // 細かな設定はここで行う
  // 引数のbuilderに[ActionBottomSheet]を返す
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    showDragHandle: true,
    builder: (context) {
      // 引数のactionsはここではなくて呼び出し元で設定するので、
      // [showActionBottomSheet]の引数にする
      return ActionBottomSheet(actions: actions);
    },
  );
}

/// ボトムシートの土台
class ActionBottomSheet extends StatelessWidget {
  /// ボトムシートの土台
  const ActionBottomSheet({
    required this.actions,
    super.key,
  });

  /// アクションは別に受け取るようにする
  final List<ActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: actions,
      ),
    );
  }
}

/// [ActionBottomSheet]にのせる選択肢
class ActionItem extends StatelessWidget {
  /// [ActionBottomSheet]にのせる選択肢
  const ActionItem({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  /// アイコンデータ
  final IconData icon;

  /// テキスト
  final String text;

  /// タップ処理を後で書きたい時のためにあえてnull許容にする
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        onTap: () {
          // ここでボトムシートを閉じることは確定させておく
          Navigator.pop(context);
          // ここで引数に入った場合は処理が呼ばれる
          onTap?.call();
        },
      ),
    );
  }
}
