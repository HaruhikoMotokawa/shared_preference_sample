import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

part 'provider.g.dart';

/// `KeyValueRepositoryBase` のインスタンスを生成
@Riverpod(keepAlive: true)
KeyValueRepositoryBase keyValueRepository(KeyValueRepositoryRef ref) {
  return KeyValueRepository(ref);
}

/// アイコン設定の値を提供するStreamを生成
/// `IconSettingRef`を通じてリポジトリにアクセスし、現在のアイコン設定を取得し、
/// その後、アイコン設定が変更されるたびに新しい値を提供します。
@riverpod
Stream<bool?> iconSetting(IconSettingRef ref) async* {
  // キー値リポジトリのプロバイダーからリポジトリオブジェクトを取得します。
  final repository = ref.read(keyValueRepositoryProvider);

  // 最初のアイコン設定の値を取得し、yieldを使用してStreamに出力します。
  yield await repository.getIconSetting();

  // リポジトリの値変更通知を購読し、アイコン設定キーの変更のみにフィルターをかけます。
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.iconSettingKey)) {
    // アイコン設定キーが変更されたとき、新しいアイコン設定の値を取得し、yieldでStreamに出力します。
    yield await repository.getIconSetting();
  }
}

/// 背景色番号の値を提供するStreamを生成
@riverpod
Stream<int?> backgroundColorNumber(BackgroundColorNumberRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getBackgroundColorNumber();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.backgroundColorNumberKey)) {
    yield await repository.getBackgroundColorNumber();
  }
}

/// タイトルテキストの値を提供するStreamを生成
@riverpod
Stream<String?> titleText(TitleTextRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getTileText();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.titleTextKey)) {
    yield await repository.getTileText();
  }
}

/// タイトルテキストの値を提供するStreamを生成
@riverpod
Stream<CustomSetting?> customSetting(CustomSettingRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getCustomSetting();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.customSettingKey)) {
    yield await repository.getCustomSetting();
  }
}
