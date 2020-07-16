import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynav/localization/app_localizations.dart';
import 'package:mynav/modules/home/provider/app_info_provider.dart';
import 'package:mynav/modules/login/providers/login_provider.dart';
import 'package:mynav/res/gaps.dart';
import 'package:mynav/res/styles.dart';
import 'package:mynav/routers/fluro_navigator.dart';
import 'package:mynav/routers/routes.dart';
import 'package:mynav/utils/error_utils.dart';
import 'package:mynav/utils/toast.dart';
import 'package:mynav/utils/utils.dart';
import 'package:mynav/widgets/my_app_bar.dart';
import 'package:mynav/widgets/my_button.dart';
import 'package:mynav/widgets/my_scroll_view.dart';
import 'package:mynav/widgets/input_text_field.dart';
import 'package:provider/provider.dart';

import '../login_router.dart';

/// design/1注册登录/index.html
class LoginPage extends StatefulWidget {
  // final String message;

  // LoginPage({this.message});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  void dispose() {
    _nodeText1.dispose();
    _nodeText2.dispose();
    super.dispose();
  }

  void _login(LoginProvider provider) {
    provider.login(onSuccess: () {
      _initData(provider);
    }, onError: (e) {
      ErrorUtils.processError(context, e);
    });
  }

  void _goHome() {
    NavigatorUtils.push(context, Routes.home, replace: true, clearStack: true);
  }

  void _initData(LoginProvider provider) {
    var appProvider = Provider.of<AppInfoProvider>(context, listen: false);
    appProvider.refreshUserInfo(onSuccess: () {
      _goHome();
    }, onError: (e) {
      provider.resetloginStatus();
      ErrorUtils.processError(context, e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: Scaffold(
          appBar: MyAppBar(
            isBack: false,
            actionName: AppLocalizations.of(context).verificationCodeLogin,
            onPressed: () {
              NavigatorUtils.push(context, LoginRouter.smsLoginPage);
            },
          ),
          body: MyScrollView(
            keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            children: _buildBody(context),
          )),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    return <Widget>[
      Text(
        AppLocalizations.of(context).passwordLogin,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      Container(
          child: Consumer<LoginProvider>(
              builder: (_, provider, __) => Column(
                    children: <Widget>[
                      InputTextField(
                        key: const Key('phone'),
                        keyName: 'phone',
                        focusNode: _nodeText1,
                        controller: provider.nameController,
                        maxLength: 16,
                        keyboardType: TextInputType.text,
                        hintText: AppLocalizations.of(context).inputUsernameHint,
                      ),
                      Gaps.vGap8,
                      InputTextField(
                        key: const Key('password'),
                        keyName: 'password',
                        focusNode: _nodeText2,
                        isInputPwd: true,
                        controller: provider.passwordController,
                        maxLength: 16,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: AppLocalizations.of(context).inputPasswordHint,
                      ),
                      Gaps.vGap24,
                      MyButton(
                        key: const Key('login'),
                        onPressed: provider.verifyPass && !provider.loading && !provider.loginSuccess
                            ? () => _login(provider)
                            : null,
                        text: AppLocalizations.of(context).login,
                      ),
                    ],
                  ))),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text(
            AppLocalizations.of(context).forgotPasswordLink,
            key: const Key('forgotPassword'),
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      ),
      Gaps.vGap16,
      Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text(
              AppLocalizations.of(context).noAccountRegisterLink,
              key: const Key('noAccountRegister'),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
          ))
    ];
  }
}
