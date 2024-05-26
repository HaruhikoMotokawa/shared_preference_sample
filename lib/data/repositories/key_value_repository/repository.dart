import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preference_sample/applications/log/logger.dart';
import 'package:shared_preference_sample/data/local_sources/shared_preference.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';

/// キーバリューペアを管理するための抽象インターフェース
abstract interface class KeyValueRepositoryBase {
  /// 値の変更を監視するためのストリーム
  ///
  /// このストリームは、保存された値が変更された時に値の変更通知を送信する
  Stream<String?> get onValueChange;

  /// アイコン設定の値を取得する
  Future<bool?> getIconSetting();

  /// アイコン設定の値を設定する
  Future<void> setIconSetting({bool? value});

  /// 背景色の番号を取得する
  Future<int?> getBackgroundColorNumber();

  /// 背景色の番号を設定する
  Future<void> setBackgroundColorNumber(int? value);

  /// タイトルのテキストを取得する
  Future<String?> getTileText();

  /// タイトルのテキストを設定する
  Future<void> setTitleText(String? value);

  /// カスタム設定の値を取得する
  Future<CustomSetting?> getCustomSetting();

  /// カスタム設定の値を設定する
  Future<void> setCustomSetting(CustomSetting? value);

  /// 全てのデータを初期化する
  Future<void> initData();
}

/// アプリケーションのキー・バリュー設定を管理するクラス
class KeyValueRepository implements KeyValueRepositoryBase {
  /// アプリケーションのキー・バリュー設定を管理するクラス
  KeyValueRepository(this.ref);

  /// レフ
  ///
  /// 今後の変更で変えられるように固定のレフではなくする
  final ProviderRef<dynamic> ref;

  // SharedPreferencesはkeyとvalueで紐づけて保存する
  // ここでキーを設定するが、各設定の値を関係するプロバイダーに指定できるように
  // staticで定義する

  /// アイコン設定のキー
  static const iconSettingKey = 'iconSetting';

  /// 背景色番号のキー
  static const backgroundColorNumberKey = 'backgroundColorNumber';

  /// タイトルのキー
  static const titleTextKey = 'titleText';

  /// カスタム設定のキー
  static const customSettingKey = 'customSetting';

  /// 設定値の変更をアプリケーション全体にブロードキャストするための`StreamController`
  final _onValueChanged = StreamController<String>.broadcast();

  @override
  Stream<String> get onValueChange => _onValueChanged.stream;

  @override
  Future<bool?> getIconSetting() => _get(iconSettingKey);

  @override
  Future<void> setIconSetting({bool? value}) => _set(iconSettingKey, value);

  @override
  Future<int?> getBackgroundColorNumber() => _get(backgroundColorNumberKey);

  @override
  Future<void> setBackgroundColorNumber(int? value) =>
      _set(backgroundColorNumberKey, value);

  @override
  Future<String?> getTileText() => _get(titleTextKey);

  @override
  Future<void> setTitleText(String? value) => _set(titleTextKey, value);

  @override
  Future<CustomSetting?> getCustomSetting() async {
    final mapValue = await _get<Map<dynamic, dynamic>>(customSettingKey);
    if (mapValue == null) {
      return null;
    }
    final customSetting = CustomSetting.fromJson(mapValue.cast());
    return customSetting;
  }

  @override
  Future<void> setCustomSetting(CustomSetting? value) {
    final json = switch (value) {
      final v? => jsonEncode(v.toJson()),
      _ => null,
    };
    return _set(customSettingKey, json);
  }

  @override
  Future<void> initData() async {
    final pref = await ref.read(sharedPreferencesProvider.future);
    final result = await pref.clear();
    logger.d(result);
    // カスケード記法で重複する`_onValueChanged`を一つに省略している
    _onValueChanged
      ..add(iconSettingKey)
      ..add(backgroundColorNumberKey)
      ..add(titleTextKey)
      ..add(customSettingKey);
  }

  /// 指定されたキーに関連付けられたデータをSharedPreferencesから取得します。
  ///
  /// [key] には取得したいデータのキーを指定します。
  /// この関数は、ジェネリック型[T]に基づいて適切なデータ型の取得を試みます。
  ///
  /// 型[T]に応じて以下の取得方法が使用されます:
  /// - `int`: SharedPreferences.getIntを使用して整数を取得。
  /// - `double`: SharedPreferences.getDoubleを使用して浮動小数点数を取得。
  /// - `String`: SharedPreferences.getStringを使用して文字列を取得。
  /// - `bool`: SharedPreferences.getBoolを使用してブーリアン値を取得。
  /// - `DateTime`: 文字列として保存された日時を[DateTime.parse]を使用して解析。
  /// - `List`: JSON文字列として保存されたリストを`json.decode`を使用して解析。
  /// - `Map`: JSON文字列として保存されたマップを`json.decode`を使用して解析。
  ///
  /// [T]がサポートされていない型の場合、[UnsupportedError]がスローされます。
  ///
  /// この関数は非同期であり、結果は`Future<T?>`として返されます。
  ///
  /// @param key 取得したいデータのキー。
  /// @return [Future<T?>] 取得したデータを含むFuture、もしくはnull。
  /// @throws [UnsupportedError] 指定された型がサポートされていない場合。
  Future<T?> _get<T>(String key) async {
    final pref = await ref.read(sharedPreferencesProvider.future);

    switch (T) {
      case int:
        return pref.getInt(key) as T?;
      case double:
        return pref.getDouble(key) as T?;
      case String:
        return pref.getString(key) as T?;
      case bool:
        return pref.getBool(key) as T?;
      case DateTime:
        return switch (pref.getString(key)) {
          final dateTimeString? => DateTime.parse(dateTimeString) as T,
          _ => null,
        };
      case const (List<dynamic>):
        final value = pref.get(key);
        if (value is List<String>) {
          return value as T?;
        }

        return switch (value) {
          final String stringValue => json.decode(stringValue) as T,
          _ => null,
        };
      case const (Map<dynamic, dynamic>):
        return switch (pref.getString(key)) {
          final value? => json.decode(value) as T,
          _ => null,
        };
      case _:
        throw UnsupportedError('対応していない型です');
    }
  }

  /// 指定されたキーと値をSharedPreferencesに保存します。
  ///
  /// - 値の型に基づいて適切なSharedPreferencesのメソッドを使用します。
  /// - 値が`null`の場合はキーを削除します。
  /// - 値の保存後、変更があったキーを_onValueChanged Streamに通知します。
  ///
  /// `SharedPreferences`に値を保存する際、値の型に基づいて適切な保存方法を選択します。
  /// - `int`型の場合はを`SharedPreferences.setInt`を呼び出します。
  /// - `double`型の場合は、`SharedPreferences.setDouble`を呼び出します。
  /// - `bool`型の場合は、`SharedPreferences.setBool`を呼び出します。
  /// - `String`型の場合は、`SharedPreferences.setString`を呼び出します。
  /// - `DateTime`型の場合はISO8601文字列に変換し、`SharedPreferences.setString`を呼び出します。
  /// - `List<String>`型の場合は、`SharedPreferences.setStringList`を呼び出します。
  /// - 値が`null`の場合は、対応するキーのデータを削除します。
  /// - 上記のどの型にも該当しない場合は、値をJSON文字列にエンコードし、`SharedPreferences.setString`を呼び出します。
  Future<void> _set(String key, Object? value) async {
    final pref = await ref.read(sharedPreferencesProvider.future);

    switch (value) {
      case final int intValue:
        await pref.setInt(key, intValue);
      case final double doubleValue:
        await pref.setDouble(key, doubleValue);
      case final bool boolValue:
        await pref.setBool(key, boolValue);
      case final String stringValue:
        await pref.setString(key, stringValue);
      case final DateTime dateTimeValue:
        await pref.setString(key, dateTimeValue.toIso8601String());
      case final List<String> listStringValue:
        await pref.setStringList(key, listStringValue);
      case null:
        await pref.remove(key);
      case _:
        await pref.setString(key, jsonEncode(value));
    }

    _onValueChanged.add(key);
  }
}
