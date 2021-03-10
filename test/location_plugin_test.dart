import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_plugin/location_plugin.dart';
import 'package:mockito/mockito.dart';

Position get mockPosition => Position(
    latitude: 52.561270,
    longitude: 5.639382,
    timestamp: DateTime.fromMillisecondsSinceEpoch(
      500,
      isUtc: true,
    ),
    altitude: 3000.0,
    accuracy: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0);
String mockResponse = 'Data Added';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockLocationPlugin locationPlugin;

  group('Location_Plugin', ()  {
    setUp(() {
      locationPlugin = new MockLocationPlugin();
    });

    test('getUserPosition', () async {
      final position = await locationPlugin.getUserPosition();

      expect(position, mockPosition);
    });

    test('locationLog', () async {
      Map<String, dynamic> postData = new Map<String, dynamic>();
      postData['lat'] = 22.2587;
      postData['long'] = 71.1924;
      postData['extra'] = 'Gujarat';
      APIRequest apiRequest = new APIRequest(
          baseUrl: 'https://6045d210f0c6dc00177b0cba.mockapi.io/postGeoInfo',
          methods: RequestMethods.POST,
          data: postData);

      final response = await locationPlugin.locationLog(request: apiRequest);

      expect(mockResponse, response);
    });
  });
}

class MockLocationPlugin extends Mock  {
  Future<Position> getUserPosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
  }) async {
    return Future.value(mockPosition);
  }

  Future<String> locationLog({APIRequest request}) async {
    return Future.value(mockResponse);
  }
}
