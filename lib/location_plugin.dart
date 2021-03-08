import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:location_plugin/network-layer/APIRequest.dart';
export 'package:location_plugin/network-layer/APIRequest.dart';

class LocationPlugin {
  static const MethodChannel _channel = const MethodChannel('location_plugin');
  LocationPermissions _locationPermissions = LocationPermissions();

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> locationLog({APIRequest request}) async {
    ///calling methods to Native Android
    ///Convert user data to Map
    final String location = await _channel
        .invokeMethod('getLocation', {'apiclient': request.toMap()});
    return location;
  }

  Future<String> getUserLocationLog() async {
    PermissionStatus status = await _requestPermission();
    if (status == PermissionStatus.granted) {
      try {
        final String location =
            await _channel.invokeMethod('getCurrentLocation');
        return location;
      } catch (e) {
        throw e;
      }
    } else if (status == PermissionStatus.restricted) {
      _locationPermissions.openAppSettings();
    }
  }

  Future<PermissionStatus> _checkForPermission() async {
    PermissionStatus permission =
        await _locationPermissions.checkPermissionStatus();

    //check the permission status
    switch (permission) {
      case PermissionStatus.unknown:
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.granted:
        return permission;
        break;
      case PermissionStatus.restricted:
        // TODO: Handle this case.

        break;
    }
  }

  Future<PermissionStatus> _requestPermission(
      {LocationPermissionLevel level =
          LocationPermissionLevel.location}) async {
    PermissionStatus permission =
        await _locationPermissions.requestPermissions(permissionLevel: level);
    print(permission.index);
    print(permission);
    return permission;
  }
}
