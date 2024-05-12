import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';

part 'provider.g.dart';

/// `KeyValueRepositoryBase` のインスタンスを生成
@Riverpod(keepAlive: true)
KeyValueRepositoryBase keyValueRepository(KeyValueRepositoryRef ref) {
  return KeyValueRepository(ref);
}

/// アイコン設定の値を提供するStreamを生成します。
/// `IconSettingRef`を通じてリポジトリにアクセスし、現在のアイコン設定を取得し、
/// その後、アイコン設定が変更されるたびに新しい値を提供します。
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

///
@riverpod
Stream<int?> backgroundColorNumber(BackgroundColorNumberRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getBackgroundColorNumber();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.backgroundColorNumberKey)) {
    yield await repository.getBackgroundColorNumber();
  }
}

///
@riverpod
Stream<String?> titleText(TitleTextRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getTileText();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.titleTextKey)) {
    yield await repository.getTileText();
  }
}
