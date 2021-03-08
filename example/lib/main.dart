import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location_plugin_example/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  LocationPlugin _locationPlugin = new LocationPlugin();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      String baseUrl =
          'https://6045d210f0c6dc00177b0cba.mockapi.io/postGeoInfo';
      Map<String,dynamic> postData = new Map<String,dynamic>();
      postData['lat'] = 22.2587;
      postData['long'] = 71.1924;
      postData['extra'] = 'Gujarat';

      APIRequest apiRequest = new APIRequest(
          baseUrl: baseUrl, methods: RequestMethods.POST, data: postData);

     String response= await _locationPlugin.locationLog(request: apiRequest);

    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()], //2.
      home: HomeScreen(),
    );
  }
}
