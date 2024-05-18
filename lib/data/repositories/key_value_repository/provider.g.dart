// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$keyValueRepositoryHash() =>
    r'aa88153e6e212e188875b8cf9bec98f2ace0a655';

/// `KeyValueRepositoryBase` のインスタンスを生成
///
/// Copied from [keyValueRepository].
@ProviderFor(keyValueRepository)
final keyValueRepositoryProvider = Provider<KeyValueRepositoryBase>.internal(
  keyValueRepository,
  name: r'keyValueRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$keyValueRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KeyValueRepositoryRef = ProviderRef<KeyValueRepositoryBase>;
String _$iconSettingHash() => r'15c8a9e1f504032cff23207a2eccde095d9de2a9';

/// アイコン設定の値を提供するStreamを生成
/// `IconSettingRef`を通じてリポジトリにアクセスし、現在のアイコン設定を取得し、
/// その後、アイコン設定が変更されるたびに新しい値を提供します。
///
/// Copied from [iconSetting].
@ProviderFor(iconSetting)
final iconSettingProvider = AutoDisposeStreamProvider<bool?>.internal(
  iconSetting,
  name: r'iconSettingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$iconSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IconSettingRef = AutoDisposeStreamProviderRef<bool?>;
String _$backgroundColorNumberHash() =>
    r'0be40d4bdcb71afe619ca0cbe9832d48c9c5802f';

/// 背景色番号の値を提供するStreamを生成
///
/// Copied from [backgroundColorNumber].
@ProviderFor(backgroundColorNumber)
final backgroundColorNumberProvider = AutoDisposeStreamProvider<int?>.internal(
  backgroundColorNumber,
  name: r'backgroundColorNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backgroundColorNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BackgroundColorNumberRef = AutoDisposeStreamProviderRef<int?>;
String _$titleTextHash() => r'de402e0019246486f527a33f07a27696baf56aa1';

/// タイトルテキストの値を提供するStreamを生成
///
/// Copied from [titleText].
@ProviderFor(titleText)
final titleTextProvider = AutoDisposeStreamProvider<String?>.internal(
  titleText,
  name: r'titleTextProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$titleTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TitleTextRef = AutoDisposeStreamProviderRef<String?>;
String _$customSettingHash() => r'ec326a71e2a83a3a78a1ac87421b09f4eec1367e';

/// タイトルテキストの値を提供するStreamを生成
///
/// Copied from [customSetting].
@ProviderFor(customSetting)
final customSettingProvider =
    AutoDisposeStreamProvider<CustomSetting?>.internal(
  customSetting,
  name: r'customSettingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomSettingRef = AutoDisposeStreamProviderRef<CustomSetting?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
