import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/localization/app_localizations.dart';
import 'package:mynav/models/delivery_task_model.dart';
import 'package:mynav/models/delivery_task_query.dart';
import 'package:mynav/modules/home/provider/app_info_provider.dart';
import 'package:mynav/res/gaps.dart';
import 'package:mynav/res/styles.dart';
import 'package:mynav/services/delivery_task_service.dart';
import 'package:mynav/utils/error_utils.dart';
import 'package:mynav/utils/toast.dart';
import 'package:mynav/widgets/my_app_bar.dart';
import 'package:mynav/widgets/my_button.dart';
import 'package:mynav/widgets/my_scroll_view.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  final String title;

  TestPage({this.title}) {
    print('Create Test Page $title');
  }

  @override
  _TestPagetate createState() => _TestPagetate();
}

class _TestPagetate extends State<TestPage> with AutomaticKeepAliveClientMixin<TestPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('Create Test State ${widget.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        // title: AppLocalizations.of(context).verificationCodeLogin,
      ),
      body: MyScrollView(
        // keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2, _nodeText3]),
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(context),
      ),
    );
  }

  String _data;

  List<Widget> _buildBody(BuildContext context) {
    return <Widget>[
      Text(
        widget.title ?? AppLocalizations.of(context).title,
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      Container(
          child: Consumer<AppInfoProvider>(
              builder: (_, provider, __) => Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          alignment: Alignment.center,
                          child: Text(
                            // provider.userInfo.toJson(),
                            _data != null ? _data.toString() : "no data",
                            style: Theme.of(context).textTheme.subtitle2,
                          )),
                      Gaps.vGap24,
                      MyButton(
                        key: const Key('logout'),
                        onPressed: _logout,
                        text: AppLocalizations.of(context).logout,
                      ),
                      Gaps.vGap24,
                      MyButton(
                        key: const Key('refresh'),
                        onPressed: () => _refresh(provider),
                        text: AppLocalizations.of(context).refreshAppInfo,
                      ),
                    ],
                  ))),
    ];
  }

  void _logout() {
    Application.logout(context);
  }

  void _refresh(AppInfoProvider provider) {
    DeliveryTaskService service = DeliveryTaskService();
    service
        .query(DeliveryTaskQuery(status: 1, longitude: 113.3269562, latitude: 23.1204656, pageSize: 100))
        .then((value) {
      final index = Random().nextInt(value.data.length);
      _data = value.data[index].toJson();
      setState(() {});
    }).catchError((e) {
      ErrorUtils.processError(context, e, expiredLogout: true);
    });
    // provider.refreshUserInfo(onSuccess: () {
    //   Toast.show("刷新成功");
    // }, onError: (e) {
    //   ErrorUtils.processError(context, e, expiredLogout: true);
    // });
  }
}
