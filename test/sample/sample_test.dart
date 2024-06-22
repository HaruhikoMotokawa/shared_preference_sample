import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preference_sample/applications/log/logger.dart';

void main() {
  // 最初に使用する変数をここで宣言

  // Riverpodを使用して状態管理やDIしている場合はテストの時も定義が必要
  // lateで定義しておくことでテストごとに設定など柔軟にできるので大体ここでいい
  // late ProviderContainer container;

  // mockなどの対象があればここで宣言
  // 例）　late MockHogeRepository repository;

  // テスト全体で使う変数があればここで宣言
  const someBool = true;
  const someString = '文字です';
  const someInt = 1;
  const someIntList = [1, 2, 3];
  const someNull = null;

  // テスト全体で使う設定
  // main直下に配置すると、全てのテストの最初に実行される
  setUp(() {
    logger.d('main直下で宣言したsetup');
    // ProviderContainerを設定するoverrideとかをここで設定する
    // container = ProviderContainer();
  });
  // テストが終了するごとに呼ばれる
  // StreamControllerやProviderContainerなどのリソース解放を行う
  tearDown(() {
    logger.d('main直下で宣言したtearDownを実行');
    // container.dispose();
  });

  group('sample testその１', () {
    setUp(() {
      logger.d('group直下で宣言したsetup');
    });

    int? testMethod({required bool? flag}) {
      return switch (flag) {
        true => 1,
        false => 2,
        null => null,
      };
    }

    tearDown(() {
      logger.d('main直下で宣言したtearDownを実行');
    });

    test('マッチャーを使ったテスト', () {
      // 第一引数に検査対象、第二引数に期待値を入れる
      // 期待値をMatcher型で定義されたものから選べる
      expect(someBool, isTrue);
      expect(someString, isNotEmpty);
      expect(someInt, isNonZero);
      expect(someIntList, isList);
      expect(someNull, isNull);
    });
    test('期待値を直接入れる場合', () {
      expect(someBool, true);
      expect(someString, '文字です');
      expect(someInt, 1);
    });
    test('比較対象の値を少し編集する場合', () {
      expect(someInt < 2, isTrue);
      expect(someIntList.length, 3);
    });
    test('少し複雑な期待値をマッチャーで表現する', () {
      expect(someInt, lessThan(2));
      expect(someIntList, hasLength(3));
    });
    test('メソッドをテストする', () {
      int? result;

      result = testMethod(flag: true);
      expect(result, 1);

      result = testMethod(flag: false);
      expect(result, 2);

      result = testMethod(flag: null);
      expect(result, isNull);
    });
  });
  group('sample testその２', skip: false, () {
    setUp(() {
      logger.d('二つ目のgroup直下で宣言したsetup');
    });
    // 引数のskipに値を入れるとflutter testコマンドでのtestにスキップされる
    // このフォルダ内でテストの実行はできる
    // カバレッジにまだ含めたくない場合などで使うといい。
    // 型はdynamicだが、boolかStringでしか有効化できない
    // ちなみにgroup自体にも引数`skip:`はある
    test('スキップされるテスト１', skip: '今回のリリースには関係ないのでスキップ', () {
      expect(someBool, isTrue);
    });
    // falseにするとスキップされない <= 引数自体消す
    test('スキップされるテスト２', skip: true, () {
      expect(someBool, isTrue);
    });
  });
}
