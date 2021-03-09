import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:location_plugin/network-layer/APIRequest.dart';
export 'package:location_plugin/network-layer/APIRequest.dart';
export 'package:geolocator_platform_interface/src/models/position.dart';
export 'package:geolocator_platform_interface/src/enums/location_accuracy.dart';
class LocationPlugin {
  static const MethodChannel _channel = const MethodChannel('location_plugin');

  static Future<String> get platformVersion async {
    ///this methods is just checking which android version running
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> locationLog({APIRequest request}) async {
    ///calling methods to Native Android
    ///convert user data to Map
    final String location = await _channel
        .invokeMethod('getLocation', {'apiclient': request.toMap()});
    return location;
  }

  Future<Position> getUserPosition({LocationAccuracy accuracy}) async {
    bool serviceEnabled;
    LocationPermission permission;

    /// check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// Location services are not enabled don't continue
      /// accessing the position and request users of the
      /// App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        /// Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        /// Permissions are denied, next time you could try
        /// requesting permissions again (this is also where
        /// Android's shouldShowRequestPermissionRationale
        /// returned true. According to Android guidelines
        /// your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: accuracy ?? LocationAccuracy.best);
    } catch (e) {
      return Future.error(e);
    }
  }
}
