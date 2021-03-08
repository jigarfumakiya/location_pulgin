package com.app.location_plugin

import android.content.Context
import androidx.annotation.NonNull
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*
import kotlin.collections.HashMap

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
            print("onmethodscall" + call.arguments.toString());
            result.success(getLocation(call.arguments()));
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // to get the user current location
    private fun getCurrentLocation(): String {
        return "Null";
    }

    private fun getLocation(apiRequest: HashMap<String, Any>): String {
        createAPIClient("jigar");
        return "";
    }

    private fun createAPIClient(baseUrl: String) {
        val BASE_URL: String = baseUrl;

        val queue = Volley.newRequestQueue(applicationContext)

        // Request a string response from the provided URL.
        val stringReq = StringRequest(Request.Method.POST, BASE_URL,
                Response.Listener<String> { response ->


                },
                Response.ErrorListener {

                })
        queue.add(stringReq)
    }
}
