import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';

part 'provider.g.dart';

/// `KeyValueRepositoryBase` のインスタンスを生成
@Riverpod(keepAlive: true)
KeyValueRepositoryBase keyValueRepository(KeyValueRepositoryRef ref) {
  return KeyValueRepository(ref);
}

///
@riverpod
Stream<bool?> iconSetting(IconSettingRef ref) async* {
  final repository = ref.read(keyValueRepositoryProvider);
  yield await repository.getIconSetting();
  await for (final _ in repository.onValueChange
      .where((key) => key == KeyValueRepository.iconSettingKey)) {
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
