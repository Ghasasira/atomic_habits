package com.gasasira.atomichabits

import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "atomichabits/settings")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    // Deep-links to this app's notification settings so the user
                    // can re-enable notifications after a permanent denial.
                    // ACTION_APP_NOTIFICATION_SETTINGS exists since API 26 = minSdk.
                    "openNotificationSettings" -> {
                        startActivity(
                            Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS)
                                .putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
                        )
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
