import 'dart:async';

import 'package:flutter/services.dart';

class FakeTouch {
  static const MethodChannel _channel = const MethodChannel('fake_touch');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> sendFakeNativeTap(int x, int y, {duration = 0.3}) async {
    Map<String, Object> map = {
      "x": x,
      "y": y,
      "duration": duration,
    };
    final String isGood = await _channel.invokeMethod('fake_native_tap', map);
    return isGood;
  }

  //留待以后扩展

  static Future<String> sendFakeNaiveEventTouchBegin() async {
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    // return version;
  }

  static Future<String> sendFakeNaiveEventTouchEnd() async {
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    // return version;
  }
  static Future<String> sendFakeNaiveEventTouchMove() async {
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    // return version;
  }
}
