package com.thurainhein.system_info_agent

import android.os.Build
import android.webkit.WebSettings
import android.webkit.WebView
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SystemInfoAgentPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: android.content.Context

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "system_info_agent")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getProperties" -> {
                val map = mapOf(
                    "userAgent" to getDalvikUserAgent(),
                    "webViewUserAgent" to getWebViewUserAgent()
                )
                result.success(map)
            }
            else -> result.notImplemented()
        }
    }

    // Dalvik format userAgent
    private fun getDalvikUserAgent(): String {
        val version = System.getProperty("java.vm.version") ?: "2.1.0"
        val os = "Linux; U; Android ${Build.VERSION.RELEASE}; ${Build.MODEL} Build/${Build.ID}"
        return "Dalvik/$version ($os)"
    }

    // Actual WebView user agent
    private fun getWebViewUserAgent(): String {
        return WebSettings.getDefaultUserAgent(context)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}





