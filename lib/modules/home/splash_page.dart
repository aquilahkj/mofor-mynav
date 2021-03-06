import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/common/constant.dart';
import 'package:mynav/modules/home/home_page.dart';
import 'package:mynav/modules/home/provider/app_info_provider.dart';
import 'package:mynav/modules/login/login_router.dart';
import 'package:mynav/routers/fluro_navigator.dart';
import 'package:mynav/routers/routes.dart';
import 'package:mynav/utils/error_utils.dart';
import 'package:mynav/utils/image_utils.dart';
import 'package:mynav/utils/jwt_utils.dart';
import 'package:mynav/utils/theme_utils.dart';
import 'package:mynav/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flustars/flustars.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      // await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription = Stream.value(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        final accessToken = Application.getAccessToken();
        final refreshToken = Application.getRefreshToken();
        if (accessToken != null && accessToken.isNotEmpty && refreshToken != null && refreshToken.isNotEmpty) {
          try {
            final map = JwtUtils.parseJwt(refreshToken);
            final int exp = map["exp"];
            if (DateTime.now().millisecondsSinceEpoch / 1000 < exp) {
              _initData();
              return;
            }
          } catch (e) {
            LogUtil.e(e);
          }
        }
        _goLogin();
      }
    });
  }

  void _initData() {
    var provider = Provider.of<AppInfoProvider>(context, listen: false);
    provider.refreshUserInfo(onSuccess: () {
      _goHome();
    }, onError: (e) {
      ErrorUtils.processError(context, e, expiredLogout: true);
    });
  }

  void _goHome() {
    NavigatorUtils.push(context, Routes.home, replace: true);
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: _status == 0
            ? FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: const LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }
}
