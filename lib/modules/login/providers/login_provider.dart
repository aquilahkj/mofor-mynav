import 'package:flustars/flustars.dart';
import 'package:flutter/widgets.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/common/constant.dart';
// import 'package:rxdart/rxdart.dart';

import 'package:mynav/models/app_login_request_model.dart';
import 'package:mynav/models/json_web_token_model.dart';
import 'package:mynav/provider/base_provider.dart';
import 'package:mynav/services/oauth_service.dart';

class LoginProvider extends BaseProvider {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final OAuthService _authService = OAuthService();
  bool _verifyPass = false;
  bool _loginSuccess = false;

  LoginProvider() {
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = SpUtil.getString(Constant.phone);
  }

  TextEditingController get nameController => _nameController;

  TextEditingController get passwordController => _passwordController;

  String get name => _nameController.text;

  String get password => _passwordController.text;

  bool get verifyPass => _verifyPass;

  bool get loginSuccess => _loginSuccess;

  void login({Function onSuccess, Function onDone, Function(dynamic) onError}) {
    final model = AppLoginRequestModel(userName: name, password: password, userType: 2);
    final stream = Stream<JsonWebTokenModel>.fromFuture(_authService.signIn(model));
    process(stream, (data) {
      SpUtil.putString(Constant.phone, name);
      Application.setToken(data.accessToken, data.refreshToken);
      _loginSuccess = true;
    }, onSuccess: onSuccess, onDone: onDone, onError: onError);
  }

  void resetloginStatus() {
    _loginSuccess = false;
    notifyListeners();
  }

  void _verify() {
    final String name = _nameController.value.text;
    final String password = _passwordController.value.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    if (clickable != _verifyPass) {
      _verifyPass = clickable;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_verify);
    _passwordController.removeListener(_verify);
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
