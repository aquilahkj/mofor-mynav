import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/localization/app_localizations.dart';
import 'package:mynav/modules/home/provider/app_info_provider.dart';
import 'package:mynav/res/gaps.dart';
import 'package:mynav/res/styles.dart';
import 'package:mynav/utils/error_utils.dart';
import 'package:mynav/utils/toast.dart';
import 'package:mynav/widgets/app_bar.dart';
import 'package:mynav/widgets/general_button.dart';
import 'package:mynav/widgets/general_scroll_view.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPagetate createState() => _TestPagetate();
}

class _TestPagetate extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        // title: AppLocalizations.of(context).verificationCodeLogin,
      ),
      body: GeneralScrollView(
        // keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2, _nodeText3]),
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(context),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    return <Widget>[
      Text(
        AppLocalizations.of(context).title,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      Container(
          child: Consumer<AppInfoProvider>(
              builder: (_, provider, __) => Column(
                    children: <Widget>[
                      Container(
                          height: 250.0,
                          alignment: Alignment.centerRight,
                          child: Text(
                            provider.userInfo.toJson(),
                            style: Theme.of(context).textTheme.subtitle2,
                          )),
                      Gaps.vGap24,
                      GeneralButton(
                        key: const Key('logout'),
                        onPressed: _logout,
                        text: AppLocalizations.of(context).login,
                      ),
                      Gaps.vGap24,
                      GeneralButton(
                        key: const Key('refresh'),
                        onPressed: () => _refresh(provider),
                        text: AppLocalizations.of(context).openYourAccount,
                      ),
                    ],
                  ))),
    ];
  }

  void _logout() {
    Application.logout(context);
  }

  void _refresh(AppInfoProvider provider) {
    provider.refreshUserInfo(onSuccess: () {
      Toast.show("刷新成功");
    }, onError: (e) {
      ErrorUtils.processError(context, e, expiredLogout: true);
    });
  }
}
