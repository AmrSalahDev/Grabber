package com.blackcode.grabber

import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // private val CHANNEL = "com.blackcode.grabber/ui"

    // override fun onCreate(savedInstanceState: Bundle?) {
    //     super.onCreate(savedInstanceState)
    //     //hideSystemUI()
    // }

    // override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    //     super.configureFlutterEngine(flutterEngine)

    //     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
    //         when (call.method) {
    //             "hideSystemUI" -> {
    //                 hideSystemUI()
    //                 result.success(null)
    //             }
    //             "showSystemUI" -> {
    //                 showSystemUI()
    //                 result.success(null)
    //             }
    //             else -> result.notImplemented()
    //         }
    //     }
    // }

    // private fun hideSystemUI() {
    //     if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
    //         window.setDecorFitsSystemWindows(false)
    //         window.insetsController?.let {
    //             it.hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
    //             it.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
    //         }
    //     } else {
    //         @Suppress("DEPRECATION")
    //         window.decorView.systemUiVisibility =
    //             (View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
    //                     or View.SYSTEM_UI_FLAG_FULLSCREEN
    //                     or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
    //                     or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
    //                     or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
    //                     or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
    //     }
    // }

    // private fun showSystemUI() {
    //     if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
    //         window.setDecorFitsSystemWindows(true)
    //         window.insetsController?.show(
    //             WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars()
    //         )
    //     } else {
    //         @Suppress("DEPRECATION")
    //         window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_VISIBLE
    //     }
    // }

   
}
