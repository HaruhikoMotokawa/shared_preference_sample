// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomSettingImpl _$$CustomSettingImplFromJson(Map<String, dynamic> json) =>
    _$CustomSettingImpl(
      isIconEnable: json['is_icon_enable'] as bool? ?? true,
      backgroundColorNumber:
          (json['background_color_number'] as num?)?.toInt() ?? 0,
      titleText: json['title_text'] as String? ?? 'No Title',
    );

Map<String, dynamic> _$$CustomSettingImplToJson(_$CustomSettingImpl instance) =>
    <String, dynamic>{
      'is_icon_enable': instance.isIconEnable,
      'background_color_number': instance.backgroundColorNumber,
      'title_text': instance.titleText,
    };
