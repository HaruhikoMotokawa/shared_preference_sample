// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/custom_bottom_sheet.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: ListTile(
                  title: Text('アイコンの表示・非表示'),
                  trailing: Icon(Icons.light),
                ),
              ),
              const Flexible(
                child: ListTile(
                  title: Text('背景色の番号'),
                  trailing: Text('1'),
                ),
              ),
              const Flexible(
                child: ListTile(
                  title: Text('タイトルの文字列'),
                  trailing: Text('hoge'),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Text('JSONで複数の設定'),
                      const Spacer(),
                      Expanded(
                        child: Text(
                          'text' * 20,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ElevatedButton(
                child: const Text('アイコンの表示と非表示を切り替え'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('背景色番号を設定'),
                onPressed: () => showSelectColorBottomSheet(context),
              ),
              ElevatedButton(
                child: const Text('タイトルを選択'),
                onPressed: () => showSelectTitleBottomSheet(context),
              ),
              ElevatedButton(
                child: const Text('複数の条件を設定'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
