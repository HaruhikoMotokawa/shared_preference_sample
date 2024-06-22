import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });
  tearDown(() {
    container.dispose();
  });
  // TODO: 使用するときにskipを外す
  group('apple test', skip: true, () {
    test('titleができる', () {});
    test('titleができる', () {});
    test('titleができる', () {});
  });
  // TODO: 使用するときにskipを外す
  group('orange test', skip: true, () {
    test('titleができる', () {});
    test('titleができる', () {});
    test('titleができる', () {});
  });
}
