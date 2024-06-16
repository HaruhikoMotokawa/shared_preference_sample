import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

import 'provider_test.mocks.dart';

/// モッククラスを生成するアノテーション
@GenerateNiceMocks([
  MockSpec<KeyValueRepositoryBase>(),
])

/// テストはメイン関数の中で行う
void main() {
  // lateを使うことでここで宣言した値に各テストトランザクションからアクセスできる

  /// Riverpodを使用しているので、ProviderContainerを経由する
  late ProviderContainer container;

  /// mockしたMockKeyValueRepositoryBaseを使って機能にアクセスする
  late MockKeyValueRepositoryBase keyValueRepository;

  /// keyValueRepositoryのonValueChangeをモックするためのStreamController
  late StreamController<String> onValueChangeController;

  group('key_value_repository_provider test', () {
    /// テスト前の設定をここで行う
    setUp(() {
      // モックリポジトリのインスタンスを作成
      keyValueRepository = MockKeyValueRepositoryBase();
      // ストリームコントローラーを作成
      onValueChangeController = StreamController<String>();
      // プロバイダーのコンテナを作成し、リポジトリをオーバーライド
      container = ProviderContainer(
        overrides: [
          keyValueRepositoryProvider.overrideWithValue(keyValueRepository),
        ],
      );

      // keyValueRepositoryのonValueChangeはStreamだが、
      // そのStreamをテスト内のonValueChangeControllerに差し替えている
      // これにより、onValueChangeのイベントをテスト内で制御できるようにする
      when(keyValueRepository.onValueChange)
          .thenAnswer((_) => onValueChangeController.stream);
    });

    /// テスト後のクリーンアップを行う
    tearDownAll(() async {
      container.dispose();
      await onValueChangeController.close();
    });
    test('iconSettingProviderは設定の変更をストリームで配信することができる', () async {
      // 初回のgetIconSettingをスタブ化
      when(keyValueRepository.getIconSetting())
          .thenAnswer((_) => Future.value(false));

      // 初期値を確認する
      var iconSetting = await container.read(iconSettingProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 左が検査対象、右が該当する結果
      expect(iconSetting, isFalse);

      // trueに変更する
      // getIconSettingのスタブを上書きする
      when(keyValueRepository.getIconSetting())
          .thenAnswer((_) => Future.value(true));
      // ストリームを流す => await forの中の２回目のgetIconSettingが呼ばれる
      onValueChangeController.add(KeyValueRepository.iconSettingKey);

      // 現在のiconSettingの値を取り出す
      iconSetting = await container.read(iconSettingProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 設定が変わってtrueになる
      expect(iconSetting, isTrue);

      //　このテスト内で実行された処理の順番
      verifyInOrder([
        // 初期値を確認した時のget
        keyValueRepository.getIconSetting(),
        // ストリームを流す処理
        keyValueRepository.onValueChange,
        // 現在のiconSettingの値を取り出した際の初回get
        keyValueRepository.getIconSetting(),
        // onValueChangeを検知して２回目のget
        keyValueRepository.getIconSetting(),
      ]);
    });

    test(
        'backgroundColorNumberProviderは'
        '設定の変更をストリームで配信することができる', () async {
      // getBackgroundColorNumberのスタブで初回は1を返す
      when(keyValueRepository.getBackgroundColorNumber())
          .thenAnswer((_) => Future.value(1));
      // 初期値を確認する
      var backgroundColorNumber =
          await container.read(backgroundColorNumberProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 左が検査対象、右が該当する結果
      expect(backgroundColorNumber, 1);

      // getBackgroundColorNumberのスタブを上書きして、２を返す
      when(keyValueRepository.getBackgroundColorNumber())
          .thenAnswer((_) => Future.value(2));

      // ストリームを流す => await forの中の２回目のgetBackgroundColorNumberが呼ばれる
      onValueChangeController.add(KeyValueRepository.backgroundColorNumberKey);

      // 現在のbackgroundColorNumberの値を取り出す
      backgroundColorNumber =
          await container.read(backgroundColorNumberProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 設定が変わって２になる
      expect(backgroundColorNumber, 2);

      //　このテスト内で実行された処理の順番
      verifyInOrder([
        // 初期値を確認した時のget
        keyValueRepository.getBackgroundColorNumber(),
        // ストリームを流す処理
        keyValueRepository.onValueChange,
        // 現在のbackgroundColorNumberの値を取り出した時の初回のget
        keyValueRepository.getBackgroundColorNumber(),
        // onValueChangeを検知して２回目のget
        keyValueRepository.getBackgroundColorNumber(),
      ]);
    });

    test('titleTextProviderは設定の変更をストリームで配信することができる', () async {
      const iOS = 'iOS';
      const android = 'Android';
      // getTileTextのスタブで初回は'iOS'を返す
      when(keyValueRepository.getTileText())
          .thenAnswer((_) => Future.value('iOS'));
      // 初期値を確認する
      var tileText = await container.read(titleTextProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 左が検査対象、右が該当する結果
      expect(tileText, iOS);

      // getTileTextのスタブを上書きして、'Android'を返す
      when(keyValueRepository.getTileText())
          .thenAnswer((_) => Future.value(android));

      // ストリームを流す => await forの中の２回目のgetBackgroundColorNumberが呼ばれる
      onValueChangeController.add(KeyValueRepository.titleTextKey);

      // 現在のtitleTextProviderの値を取り出す
      tileText = await container.read(titleTextProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 設定が変わって'Android'になる
      expect(tileText, android);

      //　このテスト内で実行された処理の順番
      verifyInOrder([
        // 初期値を確認した時のget
        keyValueRepository.getTileText(),
        // ストリームを流す処理
        keyValueRepository.onValueChange,
        // 現在のbackgroundColorNumberの値を取り出した時の初回のget
        keyValueRepository.getTileText(),
        // onValueChangeを検知して２回目のget
        keyValueRepository.getTileText(),
      ]);
    });
    test('titleTextProviderは設定の変更をストリームで配信することができる', () async {
      const firstSetting = CustomSetting(
        iconSetting: false,
        backgroundColorNumber: 0,
        titleText: 'No Title',
      );

      const updateSetting = CustomSetting(
        iconSetting: true,
        backgroundColorNumber: 1,
        titleText: 'iOS',
      );

      // getCustomSettingのスタブで初回はcustomSettingを返す
      when(keyValueRepository.getCustomSetting())
          .thenAnswer((_) => Future.value(firstSetting));
      // 初期値を確認する
      var customSetting = await container.read(customSettingProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 左が検査対象、右が該当する結果
      expect(customSetting, firstSetting);

      // getCustomSettingのスタブを上書きして、updateSettingを返す
      when(keyValueRepository.getCustomSetting())
          .thenAnswer((_) => Future.value(updateSetting));

      // ストリームを流す => await forの中の２回目のgetCustomSettingが呼ばれる
      onValueChangeController.add(KeyValueRepository.customSettingKey);

      // 現在のgetCustomSettingProviderの値を取り出す
      customSetting = await container.read(customSettingProvider.future);

      // 非同期の処理なので一旦待機させる
      await Future.delayed(Durations.short1, () => null);

      // 設定が変わって'Android'になる
      expect(customSetting, updateSetting);

      //　このテスト内で実行された処理の順番
      verifyInOrder([
        // 初期値を確認した時のget
        keyValueRepository.getCustomSetting(),
        // ストリームを流す処理
        keyValueRepository.onValueChange,
        // 現在のbackgroundColorNumberの値を取り出した時の初回のget
        keyValueRepository.getCustomSetting(),
        // onValueChangeを検知して２回目のget
        keyValueRepository.getCustomSetting(),
      ]);
    });
  });
}
