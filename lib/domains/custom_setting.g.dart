// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomSettingImpl _$$CustomSettingImplFromJson(Map<String, dynamic> json) =>
    _$CustomSettingImpl(
      iconSetting: json['icon_setting'] as bool?,
      backgroundColorNumber: (json['background_color_number'] as num?)?.toInt(),
      titleText: json['title_text'] as String?,
    );

Map<String, dynamic> _$$CustomSettingImplToJson(_$CustomSettingImpl instance) =>
    <String, dynamic>{
      'icon_setting': instance.iconSetting,
      'background_color_number': instance.backgroundColorNumber,
      'title_text': instance.titleText,
    };
