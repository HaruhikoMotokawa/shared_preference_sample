import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_setting.freezed.dart';
part 'custom_setting.g.dart';

/// カスタム設定
@freezed
class CustomSetting with _$CustomSetting {
  /// カスタム設定
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomSetting({
    // アイコン設定
    bool? iconSetting,
    // 背景色番号
    int? backgroundColorNumber,
    // タイトル
    String? titleText,
  }) = _CustomSetting;

  factory CustomSetting.fromJson(Map<String, dynamic> json) =>
      _$CustomSettingFromJson(json);
}
