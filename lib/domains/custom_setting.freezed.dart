// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomSetting _$CustomSettingFromJson(Map<String, dynamic> json) {
  return _CustomSetting.fromJson(json);
}

/// @nodoc
mixin _$CustomSetting {
// アイコン設定
  bool? get iconSetting => throw _privateConstructorUsedError; // 背景色番号
  int? get backgroundColorNumber => throw _privateConstructorUsedError; // タイトル
  String? get titleText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomSettingCopyWith<CustomSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomSettingCopyWith<$Res> {
  factory $CustomSettingCopyWith(
          CustomSetting value, $Res Function(CustomSetting) then) =
      _$CustomSettingCopyWithImpl<$Res, CustomSetting>;
  @useResult
  $Res call({bool? iconSetting, int? backgroundColorNumber, String? titleText});
}

/// @nodoc
class _$CustomSettingCopyWithImpl<$Res, $Val extends CustomSetting>
    implements $CustomSettingCopyWith<$Res> {
  _$CustomSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iconSetting = freezed,
    Object? backgroundColorNumber = freezed,
    Object? titleText = freezed,
  }) {
    return _then(_value.copyWith(
      iconSetting: freezed == iconSetting
          ? _value.iconSetting
          : iconSetting // ignore: cast_nullable_to_non_nullable
              as bool?,
      backgroundColorNumber: freezed == backgroundColorNumber
          ? _value.backgroundColorNumber
          : backgroundColorNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      titleText: freezed == titleText
          ? _value.titleText
          : titleText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomSettingImplCopyWith<$Res>
    implements $CustomSettingCopyWith<$Res> {
  factory _$$CustomSettingImplCopyWith(
          _$CustomSettingImpl value, $Res Function(_$CustomSettingImpl) then) =
      __$$CustomSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? iconSetting, int? backgroundColorNumber, String? titleText});
}

/// @nodoc
class __$$CustomSettingImplCopyWithImpl<$Res>
    extends _$CustomSettingCopyWithImpl<$Res, _$CustomSettingImpl>
    implements _$$CustomSettingImplCopyWith<$Res> {
  __$$CustomSettingImplCopyWithImpl(
      _$CustomSettingImpl _value, $Res Function(_$CustomSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iconSetting = freezed,
    Object? backgroundColorNumber = freezed,
    Object? titleText = freezed,
  }) {
    return _then(_$CustomSettingImpl(
      iconSetting: freezed == iconSetting
          ? _value.iconSetting
          : iconSetting // ignore: cast_nullable_to_non_nullable
              as bool?,
      backgroundColorNumber: freezed == backgroundColorNumber
          ? _value.backgroundColorNumber
          : backgroundColorNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      titleText: freezed == titleText
          ? _value.titleText
          : titleText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CustomSettingImpl implements _CustomSetting {
  const _$CustomSettingImpl(
      {this.iconSetting, this.backgroundColorNumber, this.titleText});

  factory _$CustomSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomSettingImplFromJson(json);

// アイコン設定
  @override
  final bool? iconSetting;
// 背景色番号
  @override
  final int? backgroundColorNumber;
// タイトル
  @override
  final String? titleText;

  @override
  String toString() {
    return 'CustomSetting(iconSetting: $iconSetting, backgroundColorNumber: $backgroundColorNumber, titleText: $titleText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomSettingImpl &&
            (identical(other.iconSetting, iconSetting) ||
                other.iconSetting == iconSetting) &&
            (identical(other.backgroundColorNumber, backgroundColorNumber) ||
                other.backgroundColorNumber == backgroundColorNumber) &&
            (identical(other.titleText, titleText) ||
                other.titleText == titleText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, iconSetting, backgroundColorNumber, titleText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomSettingImplCopyWith<_$CustomSettingImpl> get copyWith =>
      __$$CustomSettingImplCopyWithImpl<_$CustomSettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomSettingImplToJson(
      this,
    );
  }
}

abstract class _CustomSetting implements CustomSetting {
  const factory _CustomSetting(
      {final bool? iconSetting,
      final int? backgroundColorNumber,
      final String? titleText}) = _$CustomSettingImpl;

  factory _CustomSetting.fromJson(Map<String, dynamic> json) =
      _$CustomSettingImpl.fromJson;

  @override // アイコン設定
  bool? get iconSetting;
  @override // 背景色番号
  int? get backgroundColorNumber;
  @override // タイトル
  String? get titleText;
  @override
  @JsonKey(ignore: true)
  _$$CustomSettingImplCopyWith<_$CustomSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
