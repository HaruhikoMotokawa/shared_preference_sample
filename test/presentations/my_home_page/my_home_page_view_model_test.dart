import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/repository.dart';
import 'package:shared_preference_sample/presentations/my_home_page/my_home_page_view_model.dart';

import 'my_home_page_view_model_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<KeyValueRepositoryBase>(),
])
void main() {
  late ProviderContainer container;
  late MockKeyValueRepositoryBase keyValueRepository;

  group('my_home_page_view_model test', () {
    setUp(() {
      keyValueRepository = MockKeyValueRepositoryBase();

      container = ProviderContainer(
        overrides: [
          keyValueRepositoryProvider.overrideWithValue(keyValueRepository),
        ],
      );
    });
    tearDownAll(() {
      container.dispose();
    });

    test('アイコン設定を保存する', () async {
      const value = true;
      // アイコン設定をtrueで保存する
      await container
          .read(myHomePageViewModelProvider.notifier)
          .saveIconSetting(value: value);

      // アイコン設定を保存するメソッドが呼び出されている
      verify(keyValueRepository.setIconSetting(value: value)).called(1);
    });
    test('背景色番号を保存する', () async {
      const value = 1;
      // 背景色の番号を1で保存する
      await container
          .read(myHomePageViewModelProvider.notifier)
          .saveBackgroundColorNumber(value);

      // 背景色をを保存するメソッドが呼び出されている
      verify(keyValueRepository.setBackgroundColorNumber(value)).called(1);
    });
    test('タイトルを保存する', () async {
      const value = 'iOS';
      // タイトルを'iOS'で保存する
      await container
          .read(myHomePageViewModelProvider.notifier)
          .saveTitleText(value);

      // タイトルを保存するメソッドが呼び出されている
      verify(keyValueRepository.setTitleText(value)).called(1);
    });
    test('shared_preferenceを初期化する', () async {
      /// shared_preferenceを初期化する
      await container.read(myHomePageViewModelProvider.notifier).initAllData();

      // 初期化のメソッドが呼び出されている
      verify(keyValueRepository.initData()).called(1);
    });
  });
}
