import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart';
import 'package:mynav/common/common.dart';
import 'package:mynav/utils/toast.dart';
// import 'package:mynav/localization/app_localizations.dart';
// import 'package:mynav/res/resources.dart';
// import 'package:mynav/routers/fluro_navigator.dart';
// import 'package:mynav/store/store_router.dart';
// import 'package:mynav/utils/utils.dart';
// import 'package:mynav/widgets/app_bar.dart';
// import 'package:mynav/widgets/my_button.dart';
// import 'package:mynav/widgets/my_scroll_view.dart';
// import 'package:mynav/widgets/text_field.dart';

// import '../login_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
    this.message,
  }) : super(key: key);

  final String message;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.message != null && widget.message.isNotEmpty) {
        Toast.show(widget.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Login Page"),
    );
  }
}

// /// design/1注册登录/index.html
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   //定义一个controller
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _nodeText1 = FocusNode();
//   final FocusNode _nodeText2 = FocusNode();
//   bool _clickable = false;

//   @override
//   void initState() {
//     super.initState();
//     //监听输入改变
//     _nameController.addListener(_verify);
//     _passwordController.addListener(_verify);
//     _nameController.text = SpUtil.getString(Constant.phone);
//   }

//   @override
//   void dispose() {
//     _nameController.removeListener(_verify);
//     _passwordController.removeListener(_verify);
//     _nameController.dispose();
//     _passwordController.dispose();
//     _nodeText1.dispose();
//     _nodeText2.dispose();
//     super.dispose();
//   }

//   void _verify() {
//     final String name = _nameController.text;
//     final String  password = _passwordController.text;
//     bool clickable = true;
//     if (name.isEmpty || name.length < 11) {
//       clickable = false;
//     }
//     if (password.isEmpty || password.length < 6) {
//       clickable = false;
//     }

//     /// 状态不一样在刷新，避免重复不必要的setState
//     if (clickable != _clickable) {
//       setState(() {
//         _clickable = clickable;
//       });
//     }
//   }

//   void _login() {
//     SpUtil.putString(Constant.phone, _nameController.text);
//     NavigatorUtils.push(context, StoreRouter.auditPage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         isBack: false,
//         actionName: AppLocalizations.of(context).verificationCodeLogin,
//         onPressed: () {
//           NavigatorUtils.push(context, LoginRouter.smsLoginPage);
//         },
//       ),
//       body: MyScrollView(
//         keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
//         children: _buildBody,
//       ),
//     );
//   }

//   List<Widget> get _buildBody => <Widget>[
//     Text(
//       AppLocalizations.of(context).passwordLogin,
//       style: TextStyles.textBold26,
//     ),
//     Gaps.vGap16,
//     MyTextField(
//       key: const Key('phone'),
//       focusNode: _nodeText1,
//       controller: _nameController,
//       maxLength: 11,
//       keyboardType: TextInputType.phone,
//       hintText: AppLocalizations.of(context).inputUsernameHint,
//     ),
//     Gaps.vGap8,
//     MyTextField(
//       key: const Key('password'),
//       keyName: 'password',
//       focusNode: _nodeText2,
//       isInputPwd: true,
//       controller: _passwordController,
//       keyboardType: TextInputType.visiblePassword,
//       maxLength: 16,
//       hintText: AppLocalizations.of(context).inputPasswordHint,
//     ),
//     Gaps.vGap24,
//     MyButton(
//       key: const Key('login'),
//       onPressed: _clickable ? _login : null,
//       text: AppLocalizations.of(context).login,
//     ),
//     Container(
//       height: 40.0,
//       alignment: Alignment.centerRight,
//       child: GestureDetector(
//         child: Text(
//           AppLocalizations.of(context).forgotPasswordLink,
//           key: const Key('forgotPassword'),
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//         onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
//       ),
//     ),
//     Gaps.vGap16,
//     Container(
//       alignment: Alignment.center,
//       child: GestureDetector(
//         child: Text(
//           AppLocalizations.of(context).noAccountRegisterLink,
//           key: const Key('noAccountRegister'),
//           style: TextStyle(
//             color: Theme.of(context).primaryColor
//           ),
//         ),
//         onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
//       )
//     )
//   ];
// }
