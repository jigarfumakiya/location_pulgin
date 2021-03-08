import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location_plugin/location_plugin.dart';

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

      await _locationPlugin.locationLog(request: apiRequest);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Calling form Native: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: initPlatformState,
          child: IconButton(
            onPressed: initPlatformState,
            icon: Icon(Icons.location_on),
          ),
        ),
      ),
    );
  }
}
