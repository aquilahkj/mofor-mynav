import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';

import 'constant.dart';

class Application {
  static Router router;

  static BuildContext rootContext;

  static void logout(String message) {
    if (router != null && rootContext != null) {}
  }

  static void setToken(String accessToken, String refreshToken) {
    if (accessToken != null)
      SpUtil.putString(Constant.accessToken, accessToken);
    if (refreshToken != null)
      SpUtil.putString(Constant.refreshToken, refreshToken);
  }

  static String getAccessToken() {
    return SpUtil.getString(Constant.accessToken);
  }

  static String getRefreshToken() {
    return SpUtil.getString(Constant.refreshToken);
  }
}
