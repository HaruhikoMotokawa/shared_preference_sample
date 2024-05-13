// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preference_sample/custom_bottom_sheet.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/logger.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final iconSetting =
                        ref.watch(iconSettingProvider).asData?.value;
                    logger.d('アイコンのタイルを再ビルド');
                    return ListTile(
                      title: const Text('アイコンの表示・非表示'),
                      trailing: switch (iconSetting) {
                        true => const Icon(Icons.light),
                        _ => null,
                      },
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final backGroundColorNumber =
                        ref.watch(backgroundColorNumberProvider).asData?.value;
                    // TODO(self): ここは２回呼ばれるので正しいの？初回流して、
                    logger.d('背景色のタイルを再ビルド');
                    return ListTile(
                      title: const Text('背景色の番号'),
                      trailing: Text(backGroundColorNumber.toString()),
                      tileColor: switch (backGroundColorNumber) {
                        0 => Colors.transparent,
                        1 => Colors.red,
                        2 => Colors.blue,
                        _ => Colors.grey,
                      },
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final titleText =
                        ref.watch(titleTextProvider).asData?.value;
                    logger.d('タイトルのタイルを再ビルド');
                    return ListTile(
                      title: const Text('タイトルの文字'),
                      trailing: Text(titleText ?? '値がない'),
                    );
                  },
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Text('JSONで複数の設定'),
                      const Spacer(),
                      Expanded(
                        child: Text(
                          'text' * 20,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('アイコンの表示と非表示を切り替え'),
                onPressed: () {
                  showSelectIconSettingBottomSheet(context, ref);
                },
              ),
              ElevatedButton(
                child: const Text('背景色番号を設定'),
                onPressed: () => showSelectColorBottomSheet(context, ref),
              ),
              ElevatedButton(
                child: const Text('タイトルを選択'),
                onPressed: () => showSelectTitleBottomSheet(context, ref),
              ),
              ElevatedButton(
                child: const Text('複数の条件を設定'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('shared_preferenceを初期化'),
                onPressed: () =>
                    ref.read(keyValueRepositoryProvider).initData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
