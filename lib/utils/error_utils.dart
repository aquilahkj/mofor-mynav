import 'package:mynav/net/error_handle.dart';
import 'package:mynav/utils/toast.dart';

class ErrorUtils {
  static void dispatchFailure(dynamic e) {
    if (e is NetError) {
      Toast.show(e.msg);
    } else {
      Toast.show('发生未知异常');
    }
  }
}
