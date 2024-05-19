// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/logger.dart';
import 'package:shared_preference_sample/presentations/edit_custom_setting_page/edit_custom_setting_page.dart';
import 'package:shared_preference_sample/presentations/shared/custom_bottom_sheet.dart';
import 'package:shared_preference_sample/presentations/shared/info_list_tile.dart';

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
              const Flexible(
                child: _ConsumerWidget(
                  title: 'アイコンの設定',
                  type: ProviderType.iconSetting,
                ),
              ),
              const Flexible(
                child: _ConsumerWidget(
                  title: '背景色の番号',
                  type: ProviderType.backgroundColorNumber,
                ),
              ),
              const Flexible(
                child: _ConsumerWidget(
                  title: 'タイトルの文字列',
                  type: ProviderType.titleText,
                ),
              ),
              const Flexible(
                child: _ConsumerWidget(
                  title: 'JSONで複数の設定',
                  type: ProviderType.customSetting,
                ),
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('アイコンの表示と非表示を切り替え'),
                onPressed: () async {
                  final result =
                      await showSelectIconSettingBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(keyValueRepositoryProvider)
                        .setIconSetting(value: result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('背景色番号を設定'),
                onPressed: () async {
                  final result = await showSelectColorBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(keyValueRepositoryProvider)
                        .setBackgroundColorNumber(result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('タイトルを選択'),
                onPressed: () async {
                  final result = await showSelectTitleBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(keyValueRepositoryProvider)
                        .setTitleText(result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('複数の条件を設定'),
                onPressed: () async {
                  final customSetting =
                      await ref.read(customSettingProvider.future);
                  if (context.mounted) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<EditCustomSettingPage>(
                        builder: (builder) => EditCustomSettingPage(
                          iconSetting: customSetting?.iconSetting,
                          backgroundColorNumber:
                              customSetting?.backgroundColorNumber,
                          titleText: customSetting?.titleText,
                        ),
                      ),
                    );
                  }
                },
              ),
              const Gap(50),
              ElevatedButton(
                child: const Text(
                  'shared_preferenceを初期化',
                  style: TextStyle(color: Colors.red),
                ),
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

class _ConsumerWidget extends ConsumerWidget {
  const _ConsumerWidget({
    required this.title,
    required this.type,
  });

  final ProviderType type;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = switch (type) {
      ProviderType.iconSetting => ref.watch(iconSettingProvider),
      ProviderType.backgroundColorNumber =>
        ref.watch(backgroundColorNumberProvider),
      ProviderType.titleText => ref.watch(titleTextProvider),
      ProviderType.customSetting => ref.watch(customSettingProvider),
    };

    return stream.when(
      data: (data) => InfoListTile<bool>(
        value: data,
        title: title,
      ),
      error: (error, stack) => _ErrorTextWidget(
        error,
        stack,
        title: title,
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

enum ProviderType {
  iconSetting,
  backgroundColorNumber,
  titleText,
  customSetting,
}

class _ErrorTextWidget extends StatelessWidget {
  const _ErrorTextWidget(
    this.error,
    this.stack, {
    required this.title,
  });

  final Object error;
  final StackTrace stack;
  final String title;
  @override
  Widget build(BuildContext context) {
    logger.e(
      'エラー',
      error: error,
      stackTrace: stack,
    );
    return Text('$titleのエラーです');
  }
}
