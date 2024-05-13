// ignore_for_file: public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_setting.freezed.dart';
part 'custom_setting.g.dart';

@freezed
class CustomSetting with _$CustomSetting {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomSetting({
    // アイコン設定
    @Default(true) bool isIconEnable,
    // 背景色番号
    @Default(0) int backgroundColorNumber,
    // タイトル
    @Default('No Title') String titleText,
  }) = _CustomSetting;

  factory CustomSetting.fromJson(Map<String, dynamic> json) =>
      _$CustomSettingFromJson(json);
}
