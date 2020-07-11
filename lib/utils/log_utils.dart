import 'package:flutter/material.dart';
import 'package:mynav/common/app_error.dart';
import 'package:mynav/common/constant.dart';

/// 输出Log工具类
class LogUtils {
  static String _tag = 'APP-LOG';

  static bool _isDebug = !Constant.inProduction;

  static int _maxLength = 500;

  static void init({bool isDebug, String tag, int maxLength}) {
    if (isDebug != null) {
      _isDebug = isDebug;
    }
    if (tag != null && tag.isNotEmpty) {
      _tag = tag;
    }
    if (maxLength != null && maxLength > 0) {
      _maxLength = maxLength;
    }
    // LogUtil.init(isDebug: !Constant.inProduction);
  }

  static void e(dynamic object, {String tag}) {
    _printLog(tag, object);
  }

  static void es(dynamic error, {dynamic stack, String tag}) {
    _printLog(tag, error);
    if (stack != null) {
      _printLog(tag, "-------- stack --------");
      _printLog("", stack);
    }
  }

  static void v(dynamic object, {String tag}) {
    if (_isDebug) {
      _printLog(tag, object);
    }
  }

  static void _printLog(String tag, dynamic object) {
    String m = _conv(object);
    String t = (tag == null) ? _tag : tag;
    while (m.isNotEmpty) {
      String data;
      if (m.length > _maxLength) {
        data = m.substring(0, _maxLength);
        m = m.substring(_maxLength, m.length);
      } else {
        data = m;
        m = "";
      }
      if (_isDebug) {
        debugPrint("$t : $data");
      } else {
        print("$t : $data");
      }
    }
  }

  static String _conv(dynamic object) {
    if (object == null) return "";
    if (object is String) return object;
    return object.toString();
  }
}
