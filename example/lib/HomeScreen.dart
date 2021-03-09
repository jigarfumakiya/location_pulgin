import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location_plugin/location_plugin.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _response = 'Unknown';
  LocationPlugin _locationPlugin = new LocationPlugin();

  //class methods and utils
  Future<void> postRequest() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Making server request',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 5),
              CircularProgressIndicator(strokeWidth: 5),
            ],
          ),
        );
      },
    );
    try {
      String baseUrl =
          'https://6045d210f0c6dc00177b0cba.mockapi.io/postGeoInfo';
      Map<String, dynamic> postData = new Map<String, dynamic>();
      postData['lat'] = 22.2587;
      postData['long'] = 71.1924;
      postData['extra'] = 'Gujarat';

      APIRequest apiRequest = new APIRequest(
          baseUrl: baseUrl, methods: RequestMethods.POST, data: postData);

      String response = await _locationPlugin.locationLog(request: apiRequest);
      setState(() {
        _response = response;
      });

      BotToast.showText(text: response);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      BotToast.showText(text: e.toString());
      throw e;
    }
  }

  Future<void> getLocationPostRequest(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5),
              Text(
                'Getting user location and Making server request',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 5),
              CircularProgressIndicator(strokeWidth: 5),
            ],
          ),
        );
      },
    );
    String baseUrl = 'https://6045d210f0c6dc00177b0cba.mockapi.io/postGeoInfo';

    try {
      //this methods will get user current location
      Position _userPos = await _locationPlugin.getUserPosition(
          accuracy: LocationAccuracy.best);

      Map<String, dynamic> postData = new Map<String, dynamic>();
      postData['lat'] = _userPos.latitude;
      postData['long'] = _userPos.latitude;
      postData['extra'] = _userPos.accuracy.toString();

      APIRequest apiRequest = new APIRequest(
          baseUrl: baseUrl, methods: RequestMethods.POST, data: postData);

      //this methods will post user location to server.
      String response = await _locationPlugin.locationLog(request: apiRequest);
      setState(() {
        _response = response;
      });

      BotToast.showText(text: response);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      BotToast.showText(text: e.toString());
      throw e;
    }
  }

  //class widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Response ' + _response,
                style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: postRequest,
              child:
                  Text('Location Log', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, padding: EdgeInsets.all(10)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => getLocationPostRequest(context),
              child: Text('Get Location Log',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, padding: EdgeInsets.all(10)),
            )
          ],
        ),
      ),
    );
  }
}
