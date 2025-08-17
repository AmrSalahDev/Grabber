import 'package:flutter/services.dart';

class SystemUIService {
  static const _channel = MethodChannel("com.blackcode.grabber/ui");

  // static Future<void> hideSystemUI() async {
  //   await _channel.invokeMethod("hideSystemUI");
  // }

  // static Future<void> showSystemUI() async {
  //   await _channel.invokeMethod("showSystemUI");
  // }
}
