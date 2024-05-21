import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

part 'edit_custom_setting_page_view_model.g.dart';

/// EditCustomSettingPageの処理を司るクラス
@riverpod
class EditCustomSettingPage extends _$EditCustomSettingPage {
  @override
  Future<void> build() async {}

  /// カスタム設定を保存する
  Future<void> saveCustomSetting(CustomSetting value) =>
      ref.read(keyValueRepositoryProvider).setCustomSetting(value);
}
