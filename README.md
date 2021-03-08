# location_plugin

Location plugin provides the mechanism to geolocation information to a designated server with Post request

## What is it?
I have created methods channel that communicate wth Native code.User can create Post request and Just call Location methods and plugin will call Post request behind the seen form Native code android.
For Now I am using [Volley by Google](https://developer.android.com/training/volley) for handling network request.

After post request successful you will get the response in String so user can manipulate the response however want.

## How is it works?
### You can use below code to Make your Post request.

``` LocationPermissions _locationPermissions = LocationPermissions();

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

### Note-:This Project is just demo purpose.





