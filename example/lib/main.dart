import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location_plugin_example/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: HomeScreen(),
    );
  }
}
