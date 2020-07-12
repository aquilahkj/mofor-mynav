import 'package:flutter/material.dart';
import 'package:mynav/common/app_error.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/net/error_handle.dart';
import 'package:mynav/utils/toast.dart';

class ErrorUtils {
  static void processError(BuildContext context, dynamic e, {bool expiredLogout = false}) {
    if (e is NetError) {
      if (e.code == 401 && expiredLogout == true) {
        Application.logout(context);
        Toast.show("登录凭证已失效，请重新登录。", duration: 5000);
      } else {
        Toast.show(e.message);
      }
    } else if (e is AppError) {
      Toast.show(e.message);
    } else {
      // TODO l10n
      Toast.show('发生未知异常');
    }
  }
}
