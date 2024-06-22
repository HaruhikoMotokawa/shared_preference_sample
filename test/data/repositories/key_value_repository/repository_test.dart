import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('key_value_repository test', () {
    /// KeyValueRepositoryBaseを使ってKeyValueRepositoryの機能にアクセスする
    late KeyValueRepositoryBase keyValueRepository;

    /// Riverpodを使用しているので、ProviderContainerを経由する
    late ProviderContainer container;

    setUp(() async {
      // 最初にmockの初期値を設定
      // これを最初に実行しないとローカルデータベースに影響が出る
      // 設定しておきたい初期値があるならここで設定する
      SharedPreferences.setMockInitialValues({
        // 例
        // KeyValueRepository.iconSettingKey : true,
      });
      container = ProviderContainer();
      keyValueRepository = container.read(keyValueRepositoryProvider);
    });
    tearDown(() {
      container.dispose();
    });

    test('値の変更を監視する', () async {
      // ストリームの値が流れてきたら格納する変数を定義
      final histories = <String>[];

      // onValueChangeの購読を宣言し、ストリームが流れてきたらhistoriesに追加する
      keyValueRepository.onValueChange.listen(histories.add);

      // setIconSettingメソッドを実行する
      await keyValueRepository.setIconSetting(value: true);

      // 結果が反映されるまで少し待機
      await Future<void>.delayed(Durations.short1);

      // 格納されている値は'iconSetting'である
      expect(histories, [KeyValueRepository.iconSettingKey]);
    });

    test('アイコンの設定を取得し、保存できる', () async {
      // アイコンの設定を取得
      var iconSetting = await keyValueRepository.getIconSetting();

      // 初期値はnullである
      expect(iconSetting, isNull);

      // アイコンの設定をtrueで保存
      await keyValueRepository.setIconSetting(value: true);

      // アイコンの設定を取得
      iconSetting = await keyValueRepository.getIconSetting();

      // アイコンの設定はtrueである
      expect(iconSetting, true);
    });
    test('背景色の番号を取得し、保存できる', () async {
      // 背景色の番号を取得
      var backgroundColorNumber =
          await keyValueRepository.getBackgroundColorNumber();

      // 初期値はnullである
      expect(backgroundColorNumber, isNull);

      // 背景色の番号を1で保存
      await keyValueRepository.setBackgroundColorNumber(1);

      // 背景色の番号を取得
      backgroundColorNumber =
          await keyValueRepository.getBackgroundColorNumber();

      // 背景色の番号は1である
      expect(backgroundColorNumber, 1);
    });
    test('タイトルのテキストを取得し、保存できる', () async {
      // タイトルのテキストを取得
      var tileText = await keyValueRepository.getTileText();

      // 初期値はnullである
      expect(tileText, isNull);

      // タイトルのテキストを'iOS'で保存
      await keyValueRepository.setTitleText('iOS');

      // タイトルのテキストを取得
      tileText = await keyValueRepository.getTileText();

      // タイトルのテキストは'iOS'である
      expect(tileText, 'iOS');
    });
    test('カスタム設定を取得し、保存できる', () async {
      // カスタム設定を取得
      var customSetting = await keyValueRepository.getCustomSetting();

      // 初期値はnullである
      expect(customSetting, isNull);

      // 保存するカスタム設定を定義
      const saveCustomSetting = CustomSetting(
        iconSetting: true,
        backgroundColorNumber: 1,
        titleText: 'iOS',
      );

      // カスタム設定を保存
      await keyValueRepository.setCustomSetting(saveCustomSetting);

      // カスタム設定を取得
      customSetting = await keyValueRepository.getCustomSetting();

      // カスタム設定はsaveCustomSettingと同じである
      expect(customSetting, saveCustomSetting);
    });
    test('全てのデータを初期化できる', () async {
      // アイコンの設定をtrueで保存
      await keyValueRepository.setIconSetting(value: true);

      // 背景色の番号を1で保存
      await keyValueRepository.setBackgroundColorNumber(1);

      // タイトルのテキストを'iOS'で保存
      await keyValueRepository.setTitleText('iOS');

      // 保存するカスタム設定を定義
      const saveCustomSetting = CustomSetting(
        iconSetting: true,
        backgroundColorNumber: 1,
        titleText: 'iOS',
      );

      // カスタム設定を保存
      await keyValueRepository.setCustomSetting(saveCustomSetting);

      // アイコンの設定を取得
      var iconSetting = await keyValueRepository.getIconSetting();

      // 背景色の番号を取得
      var backgroundColorNumber =
          await keyValueRepository.getBackgroundColorNumber();

      // タイトルのテキストを取得
      var tileText = await keyValueRepository.getTileText();

      // カスタム設定を取得
      var customSetting = await keyValueRepository.getCustomSetting();

      // アイコンの設定はtrueである
      expect(iconSetting, true);
      // 背景色の番号は1である
      expect(backgroundColorNumber, 1);
      // タイトルのテキストは'iOS'である
      expect(tileText, 'iOS');
      // カスタム設定はsaveCustomSettingと同じである
      expect(customSetting, saveCustomSetting);

      // 全てのデータを初期化
      await keyValueRepository.initData();

      // アイコンの設定を取得
      iconSetting = await keyValueRepository.getIconSetting();

      // 背景色の番号を取得
      backgroundColorNumber =
          await keyValueRepository.getBackgroundColorNumber();

      // タイトルのテキストを取得
      tileText = await keyValueRepository.getTileText();

      // カスタム設定を取得
      customSetting = await keyValueRepository.getCustomSetting();

      // アイコンの設定はnullである
      expect(iconSetting, isNull);
      // 背景色の番号はnullである
      expect(backgroundColorNumber, isNull);
      // タイトルのテキストはnullである
      expect(tileText, isNull);
      // カスタム設定はnullと同じである
      expect(customSetting, isNull);
    });
  });
}
