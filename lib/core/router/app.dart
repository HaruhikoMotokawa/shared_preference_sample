// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:shared_preference_sample/presentations/my_home_page/my_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}
