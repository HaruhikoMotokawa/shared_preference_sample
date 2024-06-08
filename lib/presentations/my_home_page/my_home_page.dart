import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preference_sample/applications/log/logger.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/presentations/edit_custom_setting_page/edit_custom_setting_page.dart';
import 'package:shared_preference_sample/presentations/my_home_page/my_home_page_view_model.dart';
import 'package:shared_preference_sample/presentations/shared/custom_bottom_sheet.dart';
import 'package:shared_preference_sample/presentations/shared/info_list_tile.dart';

/// ホーム画面
class MyHomePage extends HookConsumerWidget {
  /// ホーム画面のコンストラクタ
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 画面全体で値をwatchするテストを行うかどうかのフラグ
    final isWatchProviderFromPage = useState(false);

    /// テスト用のwidget
    Widget? testIconSettingWidget;

    // もしisWatchProviderFromPageがtrueの場合は画面全体でiconSettingProviderをwatchし、
    // watchした値を反映するwidgetをtestIconSettingWidgetに設定する
    if (isWatchProviderFromPage.value) {
      final iconSetting = ref.watch(iconSettingProvider);
      testIconSettingWidget = Column(
        children: [
          iconSetting.when(
            data: (data) {
              logger.d('画面でwatchした場合のビルドです');
              return ListTile(
                title: Text('画面でwatchした値の${TileType.iconSetting.title}'),
                trailing: switch (data) {
                  true => const Icon(Icons.power),
                  false => const Icon(Icons.power_off),
                  null => const Text('値がnullです')
                },
              );
            },
            error: (error, stack) {
              logger.e(
                'エラー',
                error: error,
                stackTrace: stack,
              );
              return const Text('エラーです');
            },
            loading: () => const CircularProgressIndicator(),
          ),
          const Divider(),
        ],
      );
    }

    logger.d('画面全体のビルドです');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // isWatchProviderFromPageがtrueだったら生成する
              if (isWatchProviderFromPage.value &&
                  testIconSettingWidget != null)
                testIconSettingWidget,
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final iconSetting = ref.watch(iconSettingProvider);
                    return InfoListTile(
                      value: iconSetting.valueOrNull,
                      type: TileType.iconSetting,
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final backgroundColorNumber =
                        ref.watch(backgroundColorNumberProvider);
                    return InfoListTile(
                      value: backgroundColorNumber.valueOrNull,
                      type: TileType.backgroundColorNumber,
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final titleText = ref.watch(titleTextProvider);
                    return InfoListTile(
                      value: titleText.valueOrNull,
                      type: TileType.titleText,
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final customSetting = ref.watch(customSettingProvider);
                    return InfoListTile(
                      value: customSetting.valueOrNull,
                      type: TileType.customSetting,
                    );
                  },
                ),
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('アイコンの設定を変更'),
                onPressed: () async {
                  final result =
                      await showSelectIconSettingBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(myHomePageViewModelProvider.notifier)
                        .saveIconSetting(value: result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('背景色の番号を変更'),
                onPressed: () async {
                  final result = await showSelectColorBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(myHomePageViewModelProvider.notifier)
                        .saveBackgroundColorNumber(result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('タイトルを変更'),
                onPressed: () async {
                  final result = await showSelectTitleBottomSheet(context);
                  if (result != null) {
                    await ref
                        .read(myHomePageViewModelProvider.notifier)
                        .saveTitleText(result);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('複数の条件を変更'),
                onPressed: () async {
                  // customSettingProviderはAsyncValueなので現時点での値を読み取る場合は
                  // .futureで待つ必要がある
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
              const Gap(30),
              ElevatedButton(
                child: const Text(
                  'shared_preferenceを初期化',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => ref
                    .read(myHomePageViewModelProvider.notifier)
                    .initAllData(),
              ),
              const Gap(10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    isWatchProviderFromPage.value ? Colors.yellow : Colors.grey,
                  ),
                ),
                onPressed: () {
                  final currentIsWatch = isWatchProviderFromPage.value;
                  final newValue = !currentIsWatch;
                  isWatchProviderFromPage.value = newValue;
                },
                child: Text(
                  '画面全体でのWatchを'
                  '${isWatchProviderFromPage.value ? '停止' : '開始'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
