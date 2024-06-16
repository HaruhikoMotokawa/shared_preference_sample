// ignore_for_file: public_member_api_docs

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

  static const _prefs = 'MyHomePage.';

  static const iconSettingListTileFromPageWatchingKey =
      ValueKey('${_prefs}iconSettingListTileFromPageWatching');

  static const iconSettingListTileKey =
      ValueKey('${_prefs}iconSettingListTile');
  static const backgroundColorNumberListTileKey =
      ValueKey('${_prefs}backgroundColorNumberListTile');
  static const titleTextListTileKey = ValueKey('${_prefs}titleTextListTile');
  static const customSettingListTileKey =
      ValueKey('${_prefs}customSettingListTile');
  static const changeIconSettingButtonKey =
      ValueKey('${_prefs}changeIconSettingButton');
  static const iconSettingTrueKey = ValueKey('${_prefs}iconSettingTrue');
  static const iconSettingFalseKey = ValueKey('${_prefs}iconSettingFalse');
  static const changeBackgroundColorButtonKey =
      ValueKey('${_prefs}changeBackgroundColorButton');
  static const changeTitleButtonKey = ValueKey('${_prefs}changeTitleButton');
  static const changeMultipleSettingsButtonKey =
      ValueKey('${_prefs}changeMultipleSettingsButton');
  static const initializeSharedPreferencesButtonKey =
      ValueKey('${_prefs}initializeSharedPreferencesButton');
  static const toggleWatchProviderButtonKey =
      ValueKey('${_prefs}toggleWatchProviderButton');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(myHomePageViewModelProvider.notifier);

    /// 画面全体で値をwatchするテストを行うかどうかのフラグ
    final isWatchProviderFromPage = useState(false);

    /// テスト用のwidget
    Widget? testIconSettingWidget;

    // もしisWatchProviderFromPageがtrueの場合は画面全体でiconSettingProviderをwatchし、
    // watchした値を反映するwidgetをtestIconSettingWidgetに設定する
    if (isWatchProviderFromPage.value) {
      final iconSetting = ref.watch(iconSettingProvider);
      testIconSettingWidget = Column(
        key: iconSettingListTileFromPageWatchingKey,
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
                      key: iconSettingListTileKey,
                      value: iconSetting.valueOrNull,
                      type: TileType.iconSetting,
                    );
                  },
                ),
              ),
              Flexible(
                child: Consumer(
                  key: backgroundColorNumberListTileKey,
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
                  key: titleTextListTileKey,
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
                  key: customSettingListTileKey,
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
                key: changeIconSettingButtonKey,
                child: const Text('アイコンの設定を変更'),
                onPressed: () async {
                  final result = await showSelectIconSettingBottomSheet(
                    context,
                    trueKey: iconSettingTrueKey,
                    falseKey: iconSettingFalseKey,
                  );
                  if (result != null) {
                    await viewModel.saveIconSetting(value: result);
                  }
                },
              ),
              ElevatedButton(
                key: changeBackgroundColorButtonKey,
                child: const Text('背景色の番号を変更'),
                onPressed: () async {
                  final result = await showSelectColorBottomSheet(context);
                  if (result != null) {
                    await viewModel.saveBackgroundColorNumber(result);
                  }
                },
              ),
              ElevatedButton(
                key: changeTitleButtonKey,
                child: const Text('タイトルを変更'),
                onPressed: () async {
                  final result = await showSelectTitleBottomSheet(context);
                  if (result != null) {
                    await viewModel.saveTitleText(result);
                  }
                },
              ),
              ElevatedButton(
                key: changeMultipleSettingsButtonKey,
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
                key: initializeSharedPreferencesButtonKey,
                onPressed: viewModel.initAllData,
                child: const Text(
                  'shared_preferenceを初期化',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Gap(10),
              ElevatedButton(
                key: toggleWatchProviderButtonKey,
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
