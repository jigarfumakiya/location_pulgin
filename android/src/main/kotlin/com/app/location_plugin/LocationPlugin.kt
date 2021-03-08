package com.app.location_plugin

import android.content.Context
import androidx.annotation.NonNull
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** LocationPlugin */
class LocationPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext;
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "location_plugin")
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "getCurrentLocation") {
            result.success(getCurrentLocation());
        } else if (call.method == "getLocation") {
            getLocation(call.arguments(), result);
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // to get the user current location and call API.
    private fun getCurrentLocation(): String {
        return "Null";
    }


    private fun getLocation(apiRequest: HashMap<String, Any>, result: Result) {
        //user will send data and will just call post request
        createAPIClient(apiRequest["apiclient"] as HashMap<String, Any>, result);

    }

    private fun createAPIClient(mapData: HashMap<String, Any>, result: Result) {
        ///create API Client and pass all the data Accordingly
        val BASE_URL: String = mapData["baseUrl"].toString();

        //we are returing string response so user can manipulate how ever they want
        val stringRequest: StringRequest = object : StringRequest(Method.POST, BASE_URL,
                Response.Listener { response ->
                    //return the response came form the server so user can do whatever they want
                    result.success(response);
                },
                Response.ErrorListener { error ->
                    //return the error object so user can find out what is the issue
                    result.error(error.networkResponse.toString(), error.message, error.localizedMessage);
                }) {
              //pass map herer that user send form flutter
            override fun getParams(): Map<String, String> {
                //here is the data what user sent us
                val params = mapData["data"] as Map<String, String>;
                val convertedMap = HashMap<String, String>();

                //converted all user map to string map so user don't face any issue because volley supports only Map<String,String>
                for (strKey in params.keys) {
                    convertedMap[strKey] = params[strKey].toString()
                }

                return convertedMap
            }

            override fun getHeaders(): MutableMap<String, String> {
                ///user can pass the header accordingly there Request

                val header = mapData["header"] as MutableMap<String, String>;
                return header;

            }
        }
        val requestQueue = Volley.newRequestQueue(applicationContext)
        requestQueue.add(stringRequest)


    }


}
