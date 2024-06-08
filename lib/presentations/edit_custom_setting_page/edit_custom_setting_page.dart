import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preference_sample/presentations/edit_custom_setting_page/edit_custom_setting_page_view_model.dart';
import 'package:shared_preference_sample/presentations/shared/custom_bottom_sheet.dart';
import 'package:shared_preference_sample/presentations/shared/info_list_tile.dart';

/// CustomSettingを編集する画面
class EditCustomSettingPage extends HookWidget {
  /// CustomSettingを編集する画面
  const EditCustomSettingPage({
    this.iconSetting,
    this.backgroundColorNumber,
    this.titleText,
    super.key,
  });

  /// アイコン設定
  final bool? iconSetting;

  /// 背景色番号
  final int? backgroundColorNumber;

  /// タイトルテキスト
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    // 一時的に変更内容を保持するためのステート達
    final iconSettingState = useState<bool?>(null);
    final backgroundColorNumberState = useState<int?>(null);
    final titleTextState = useState<String?>(null);

    // 画面が生成された時にそれぞれの設定内容をuseStateに代入
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
              child: InfoListTile(
                value: iconSettingState.value,
                type: TileType.iconSetting,
              ),
            ),
            Flexible(
              child: InfoListTile(
                value: backgroundColorNumberState.value,
                type: TileType.backgroundColorNumber,
              ),
            ),
            Flexible(
              child: InfoListTile(
                value: titleTextState.value,
                type: TileType.iconSetting,
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
              child: Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      child: const Text('保 存'),
                      onPressed: () async {
                        await ref
                            .read(editCustomSettingPageProvider.notifier)
                            .saveCustomSetting(
                              iconSetting: iconSettingState.value,
                              backgroundColorNumber:
                                  backgroundColorNumberState.value,
                              titleText: titleTextState.value,
                            );
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
