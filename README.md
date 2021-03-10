# location_plugin

Location plugin provides the mechanism to geolocation information to a designated server with Post request

## What is it?
I have created methods channel that communicate wth Native code.User can create Post request and Just call Location methods and plugin will call Post request behind the seen form Native code android.
For Now I am using [Volley by Google](https://developer.android.com/training/volley) for handling network request. If you want take look at Native Android code [here](https://github.com/jigarfumakiya/location_pulgin/blob/dev/android/src/main/kotlin/com/app/location_plugin/LocationPlugin.kt)

After post request successful you will get the response in String so user can manipulate the response however want.

###Declare below two permission in your Android manifest file
```
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```
## Plugin depencies
 
Behind the scene, I am using a [geolocator](https://pub.dev/packages/geolocator) to get user location and communicating with location_plugin and the user can have position object.

## Methods
As off now plugin support two methods **locationLog** methods provides functionally Post Geolocation information to designated sever, and **getUserPosition** provides current location if you want get user location and make Post request.
Both Methods work Out of the box for getting user location you don't have ask for permission plugin ask itself.This is plugin supports only Android as of now.

## How is it works?
### getLocationPostRequest.

```dart
  LocationPermissions _locationPermissions = LocationPermissions();

    Future<void> getLocationPostRequest() async {

    try {
      String baseUrl ='baseUrl+EndPoint';
      Map<String, dynamic> postData = new Map<String, dynamic>();
      postData['lat'] = 22.2587;
      postData['long'] = 71.1924;
      postData['extra'] = 'Gujarat';

      APIRequest apiRequest = new APIRequest(
          baseUrl: baseUrl, methods: RequestMethods.POST, data: postData);

      String response = await _locationPlugin.getUserLocationLog(request: apiRequest);
      setState(() {
        _response = response;
      });

    } catch (e) {

      throw e;
    }
  }

```

### getUserPosition.

```dart
  enum LocationAccuracy {
    /// Location is accurate within a distance of 3000m on iOS and 500m on Android
    lowest,
  
    /// Location is accurate within a distance of 1000m on iOS and 500m on Android
    low,
  
    /// Location is accurate within a distance of 100m on iOS and between 100m and
    /// 500m on Android
    medium,
  
    /// Location is accurate within a distance of 10m on iOS and between 0m and
    /// 100m on Android
    high,
  
    /// Location is accurate within a distance of ~0m on iOS and between 0m and
    /// 100m on Android
    best,
  
    /// Location accuracy is optimized for navigation on iOS and matches the
    /// [LocationAccuracy.best] on Android
    bestForNavigation
  }

    LocationPermissions _locationPermissions = LocationPermissions();
    Position _userPos = await _locationPlugin.getUserPosition(accuracy: LocationAccuracy.best);
    
  
```

###Test
I have added some basic test cases for plugin methods if you want take look [here](https://github.com/jigarfumakiya/location_pulgin/blob/main/test/location_plugin_test.dart)





### Note-:This Project is just demo purpose.





