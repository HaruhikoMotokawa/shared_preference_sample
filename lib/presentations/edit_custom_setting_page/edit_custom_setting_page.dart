import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preference_sample/data/repositories/key_value_repository/provider.dart';
import 'package:shared_preference_sample/domains/custom_setting.dart';
import 'package:shared_preference_sample/presentations/shared/custom_bottom_sheet.dart';

///
class EditCustomSettingPage extends HookConsumerWidget {
  ///
  const EditCustomSettingPage({
    super.key,
    this.iconSetting,
    this.backgroundColorNumber,
    this.titleText,
  });

  /// アイコン設定
  final bool? iconSetting;

  /// 背景色番号
  final int? backgroundColorNumber;

  /// タイトルテキスト
  final String? titleText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一時的に変更内容を保持するためのステート達
    final iconSettingState = useState<bool?>(null);
    final backgroundColorNumberState = useState<int?>(null);
    final titleTextState = useState<String?>(null);

    // 画面が生成された時にそれぞれの設定内容をステートに保持
    useEffect(
      () {
        iconSettingState.value = iconSetting;
        backgroundColorNumberState.value = backgroundColorNumber;
        titleTextState.value = titleText;
        return null;
      },
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('カスタム設定編集'),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: ListTile(
                title: const Text('アイコンの設定'),
                trailing: switch (iconSettingState.value) {
                  true => const Icon(Icons.power),
                  false => const Icon(Icons.power_off),
                  _ => const Icon(Icons.clear),
                },
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text('背景色の番号'),
                trailing: Text(backgroundColorNumberState.value.toString()),
                tileColor: switch (backgroundColorNumberState.value) {
                  0 => Colors.transparent,
                  1 => Colors.red,
                  2 => Colors.blue,
                  _ => Colors.grey,
                },
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text('タイトルの文字'),
                trailing: Text(titleTextState.value ?? '値なし'),
              ),
            ),
            const Divider(),
            Flexible(
              child: ElevatedButton(
                child: const Text('アイコンの設定を変更'),
                onPressed: () async {
                  final result =
                      await showSelectIconSettingBottomSheet(context);
                  iconSettingState.value = result;
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text('背景色番号を設定'),
                onPressed: () async {
                  final result = await showSelectColorBottomSheet(context);
                  backgroundColorNumberState.value = result;
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text('タイトルの文字を設定'),
                onPressed: () async {
                  final result = await showSelectTitleBottomSheet(context);
                  titleTextState.value = result;
                },
              ),
            ),
            const Gap(40),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  child: const Text('保 存'),
                  onPressed: () async {
                    const setting = CustomSetting();
                    final updateSetting = setting.copyWith(
                      iconSetting: iconSettingState.value,
                      backgroundColorNumber: backgroundColorNumberState.value,
                      titleText: titleTextState.value,
                    );
                    if (setting == updateSetting) {
                      Navigator.pop(context);
                      return;
                    }
                    await ref
                        .read(keyValueRepositoryProvider)
                        .setCustomSetting(updateSetting);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
