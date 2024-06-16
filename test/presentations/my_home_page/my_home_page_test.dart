import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';
import 'package:shared_preference_sample/presentations/my_home_page/my_home_page.dart';

void main() {
  late ProviderContainer container;
  late UncontrolledProviderScope scope;
  late StreamController<bool> iconSettingStreamController;

  group('my_home_page test', () {
    setUp(() {
      iconSettingStreamController = StreamController<bool>();
      container = ProviderContainer(
        overrides: [
          iconSettingProvider.overrideWith(
            (_) => iconSettingStreamController.stream,
          ),
          backgroundColorNumberProvider.overrideWith((_) => Stream.value(1)),
          titleTextProvider.overrideWith((_) => Stream.value('iOS')),
          customSettingProvider.overrideWith(
            (_) => Stream.value(
              const CustomSetting(
                iconSetting: true,
                backgroundColorNumber: 1,
                titleText: 'Android',
              ),
            ),
          ),
        ],
      );
      scope = UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: MyHomePage()),
      );
      // 初期値のストリームを流す
      iconSettingStreamController.add(false);
    });
    tearDown(() {
      container.dispose();
      iconSettingStreamController.close();
    });
    testWidgets('ホーム画面が表示されている', (WidgetTester tester) async {
      // 画面を生成
      await tester.pumpWidget(scope);

      // アイコンの設定を取得
      await container.read(iconSettingProvider.future);

      // MyHomePageが表示されている
      expect(find.byType(MyHomePage), findsOneWidget);

      // 完全に描画されるまで一旦待つ
      await tester.pumpAndSettle();

      // アイコン設定のリストタイルが表示されている
      expect(find.byKey(MyHomePage.iconSettingListTileKey), findsOneWidget);

      // 背景色のリストタイルが表示されている
      expect(
        find.byKey(MyHomePage.backgroundColorNumberListTileKey),
        findsOneWidget,
      );

      // タイトルのリストタイルが表示されている
      expect(find.byKey(MyHomePage.titleTextListTileKey), findsOneWidget);

      // カスタム設定のリストタイルが表示されている
      expect(find.byKey(MyHomePage.customSettingListTileKey), findsOneWidget);

      // アイコンの設定を変更するボタンが表示されている
      expect(find.byKey(MyHomePage.changeIconSettingButtonKey), findsOneWidget);

      // 背景色の設定を変更するボタンが表示されている
      expect(
        find.byKey(MyHomePage.changeBackgroundColorButtonKey),
        findsOneWidget,
      );

      // タイトルの設定を変更するボタンが表示されている
      expect(
        find.byKey(MyHomePage.changeTitleButtonKey),
        findsOneWidget,
      );

      // 複数の設定を変更するボタンが表示されている
      expect(
        find.byKey(MyHomePage.changeMultipleSettingsButtonKey),
        findsOneWidget,
      );

      // shared_preferenceを初期化するボタンが表示されている
      expect(
        find.byKey(MyHomePage.initializeSharedPreferencesButtonKey),
        findsOneWidget,
      );

      // 画面全体でのwatchを切り替えるボタンが表示されている
      expect(
        find.byKey(MyHomePage.toggleWatchProviderButtonKey),
        findsOneWidget,
      );
    });

    testWidgets('アイコンの設定を変更し、表示を変えることができる', (WidgetTester tester) async {
      // 画面を生成
      await tester.pumpWidget(scope);

      // アイコンの設定を取得
      var iconSetting = await container.read(iconSettingProvider.future);

      // 完全に描画されるまで一旦待つ
      await tester.pumpAndSettle();

      // アイコンの設定はfalseである
      expect(iconSetting, isFalse);

      // アイコンの設定を表示しているListTile
      final iconSettingListTile = find.byKey(MyHomePage.iconSettingListTileKey);

      // リストタイルの中にあるアイコンはpower_offである
      expect(
        find.descendant(
          of: iconSettingListTile,
          matching: find.byIcon(Icons.power_off),
        ),
        findsOneWidget,
      );

      // アイコンの設定ボタンをタップする
      await tester.tap(find.byKey(MyHomePage.changeIconSettingButtonKey));

      // ボトムシートが生成されるのをまつ
      await tester.pumpAndSettle();

      // アイコン設定を有効にする
      await tester.tap(find.byKey(MyHomePage.iconSettingTrueKey));

      // ストリームを流す
      iconSettingStreamController.add(true);

      // ボトムシートが完全に閉じられるのを待つ
      await tester.pumpAndSettle();

      // アイコンの設定を取得
      iconSetting = await container.read(iconSettingProvider.future);

      // アイコンの設定はtrueである
      expect(iconSetting, isTrue);

      // リストタイルの中にあるアイコンはIcons.powerである
      expect(
        find.descendant(
          of: iconSettingListTile,
          matching: find.byIcon(Icons.power),
        ),
        findsOneWidget,
      );
    });
    testWidgets('a', (WidgetTester tester) async {});
    testWidgets('a', (WidgetTester tester) async {});
  });
}
