package com.irohasu.mconnect.chatbot

import android.content.ActivityNotFoundException
import android.content.Intent
import android.provider.CalendarContract
import android.provider.Settings
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.irohasu.mconnect/app_settings",
        ).setMethodCallHandler { call, result ->
            if (call.method != "open") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            try {
                startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                    data = Uri.parse("package:$packageName")
                })
                result.success(true)
            } catch (_: ActivityNotFoundException) {
                result.success(false)
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.irohasu.mconnect/device_calendar",
        ).setMethodCallHandler { call, result ->
            if (call.method != "openCreateEvent") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val title = call.argument<String>("title")
            val startMillis = call.argument<Number>("startMillis")?.toLong()
            val endMillis = call.argument<Number>("endMillis")?.toLong()
            if (title.isNullOrBlank() || startMillis == null || endMillis == null) {
                result.error("invalid_arguments", "Calendar event data is invalid", null)
                return@setMethodCallHandler
            }
            val intent = Intent(Intent.ACTION_INSERT).apply {
                data = CalendarContract.Events.CONTENT_URI
                putExtra(CalendarContract.Events.TITLE, title)
                putExtra(
                    CalendarContract.Events.DESCRIPTION,
                    call.argument<String>("description"),
                )
                putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startMillis)
                putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endMillis)
                putExtra(
                    CalendarContract.EXTRA_EVENT_ALL_DAY,
                    call.argument<Boolean>("isAllDay") == true,
                )
            }
            if (intent.resolveActivity(packageManager) == null) {
                result.success("unavailable")
                return@setMethodCallHandler
            }
            try {
                startActivity(intent)
                result.success("opened")
            } catch (_: ActivityNotFoundException) {
                result.success("unavailable")
            } catch (error: Exception) {
                result.error("calendar_failed", error.message, null)
            }
        }
    }
}
