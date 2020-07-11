import 'package:mynav/net/error_handle.dart';
import 'package:mynav/utils/toast.dart';

class ErrorUtils {
  static void showError(dynamic e) {
    if (e is NetError) {
      Toast.show(e.message);
    } else {
      // TODO l10n
      Toast.show('发生未知异常');
    }
  }
}
