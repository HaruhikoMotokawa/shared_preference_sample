import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

part 'my_home_page_view_model.g.dart';

/// MyHomePageで行う操作の処理を司るクラス
@riverpod
class MyHomePageViewModel extends _$MyHomePageViewModel {
  @override
  Future<void> build() async {}

  /// アイコン設定を保存する
  Future<void> saveIconSetting({required bool value}) =>
      ref.read(keyValueRepositoryProvider).setIconSetting(value: value);

  /// 背景色番号を保存する
  Future<void> saveBackgroundColorNumber(int value) =>
      ref.read(keyValueRepositoryProvider).setBackgroundColorNumber(value);

  /// タイトルを保存する
  Future<void> saveTitleText(String value) =>
      ref.read(keyValueRepositoryProvider).setTitleText(value);

  /// CustomSettingを保存する
  Future<void> saveCustomSetting(CustomSetting value) =>
      ref.read(keyValueRepositoryProvider).setCustomSetting(value);

  /// shared_preferenceを初期化する
  Future<void> initAllData() => ref.read(keyValueRepositoryProvider).initData();
}
