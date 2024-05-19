import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/domains/tile_type.dart';
import 'package:shared_preference_sample/logger.dart';
import 'package:shared_preference_sample/presentations/edit_custom_setting_page/edit_custom_setting_page.dart';
import 'package:shared_preference_sample/presentations/shared/custom_bottom_sheet.dart';
import 'package:shared_preference_sample/presentations/shared/info_list_tile.dart';

/// ホーム画面
class MyHomePage extends ConsumerWidget {
  /// ホーム画面のコンストラクタ
  const MyHomePage({
    required this.isWatchProvider,
    super.key,
  });

  /// 画面全体で値をwatchするテストを行うかどうかのフラグ
  final bool isWatchProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// テスト用のwidget
    Widget? testIconSettingWidget;

    // もしisWatchProviderがtrueの場合は画面全体でiconSettingProviderをwatchし、
    // watchした値を反映するwidgetをtestIconSettingWidgetに設定する
    if (isWatchProvider) {
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
            error: (error, stack) => _ErrorTextWidget(
              error,
              stack,
              type: TileType.iconSetting,
            ),
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
              // isWatchProviderがtrueだったら生成する
              if (isWatchProvider && testIconSettingWidget != null)
                testIconSettingWidget,
              const Flexible(
                child: _ConsumerWidget(type: TileType.iconSetting),
              ),
              const Flexible(
                child: _ConsumerWidget(type: TileType.backgroundColorNumber),
              ),
              const Flexible(
                child: _ConsumerWidget(type: TileType.titleText),
              ),
              const Flexible(
                child: _ConsumerWidget(type: TileType.customSetting),
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('アイコンの設定を変更'),
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
                child: const Text('背景色の番号を変更'),
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
                child: const Text('タイトルを変更'),
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
                child: const Text('複数の条件を変更'),
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

/// 引数のTileTypeによってwatchする内容を切り替えて、対応する内容のListTileを返却する
class _ConsumerWidget extends ConsumerWidget {
  const _ConsumerWidget({required this.type});

  final TileType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = switch (type) {
      TileType.iconSetting => ref.watch(iconSettingProvider),
      TileType.backgroundColorNumber =>
        ref.watch(backgroundColorNumberProvider),
      TileType.titleText => ref.watch(titleTextProvider),
      TileType.customSetting => ref.watch(customSettingProvider),
    };

    return stream.when(
      data: (data) => InfoListTile(
        value: data,
        type: type,
      ),
      error: (error, stack) => _ErrorTextWidget(
        error,
        stack,
        type: type,
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}


class _ErrorTextWidget extends StatelessWidget {
  const _ErrorTextWidget(
    this.error,
    this.stack, {
    required this.type,
  });

  final Object error;
  final StackTrace stack;
  final TileType type;
  @override
  Widget build(BuildContext context) {
    logger.e(
      'エラー',
      error: error,
      stackTrace: stack,
    );
    return Text('${type.title}のエラーです');
  }
}
