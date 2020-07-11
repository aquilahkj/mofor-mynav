import 'package:mynav/models/user_info_detail_model.dart';
import 'package:mynav/provider/base_provider.dart';
import 'package:mynav/services/deliveryman_service.dart';

class AppInfoProvider extends BaseProvider {
  final _userService = UserService();

  UserInfoDetailModel _userInfo = UserInfoDetailModel();

  UserInfoDetailModel get userInfo => _userInfo;

  void refreshUserInfo({Function onSuccess, Function onDone, Function onError}) {
    final stream = Stream<UserInfoDetailModel>.fromFuture(_userService.getDetail());
    process(stream, (data) {
      _userInfo = data;
    }, onSuccess: onSuccess, onDone: onDone, onError: onError);
  }
}
