import 'package:flutter/material.dart';
import 'package:mynav/localization/app_localizations.dart';
import 'package:mynav/modules/home/provider/home_provider.dart';
import 'package:mynav/modules/home/test_page.dart';
import 'package:mynav/modules/order/pages/order_page.dart';
import 'package:mynav/res/resources.dart';
import 'package:mynav/utils/double_tap_back_exit_app.dart';
import 'package:mynav/utils/image_utils.dart';
import 'package:mynav/utils/theme_utils.dart';
import 'package:mynav/widgets/load_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pageList;
  List<String> _icons;

  // final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<LoadAssetImagePair> _list;
  List<LoadAssetImagePair> _listDark;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  void _preCacheImage() {
    _icons.forEach((path) {
      precacheImage(ImageUtils.getAssetImage(path), context);
    });
  }

  void initData() {
    _pageList = [
      // TestPage(title: "Order"),
      OrderPage(),
      TestPage(),
      TestPage(title: "Statistics"),
      TestPage(title: "My Info "),
    ];
    _icons = [
      "home/icon_order",
      "home/icon_bill",
      "home/icon_statistics",
      "home/icon_statistics",
    ];
  }

  List<LoadAssetImagePair> _getImageList() {
    if (_list == null) {
      _list = List.generate(4, (i) {
        return LoadAssetImagePair(
          LoadAssetImage(
            _icons[i],
            width: 25.0,
            color: Colours.unselected_item_color,
          ),
          LoadAssetImage(
            _icons[i],
            width: 25.0,
            color: Colours.app_main,
          ),
        );
      });
    }
    return _list;
  }

  List<LoadAssetImagePair> _getDarkImageList() {
    if (_listDark == null) {
      _listDark = List.generate(4, (i) {
        return LoadAssetImagePair(
          LoadAssetImage(
            _icons[i],
            width: 25.0,
            color: Colours.dark_unselected_item_color,
          ),
          LoadAssetImage(
            _icons[i],
            width: 25.0,
            color: Colours.dark_app_main,
          ),
        );
      });
    }
    return _listDark;
  }

  List<BottomNavigationBarItem> _buildItems(bool isDark) {
    final List<String> nameList = [
      AppLocalizations.of(context).order,
      AppLocalizations.of(context).bill,
      AppLocalizations.of(context).statistics,
      AppLocalizations.of(context).myInfo,
    ];
    final List<LoadAssetImagePair> imageList = isDark ? _getDarkImageList() : _getImageList();
    final list = List.generate(4, (i) {
      return BottomNavigationBarItem(
          icon: imageList[i].unactive,
          activeIcon: imageList[i].active,
          title: Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: Text(
              nameList[i],
              key: Key(nameList[i]),
            ),
          ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
            bottomNavigationBar: Consumer<HomeProvider>(
              builder: (_, provider, __) {
                return BottomNavigationBar(
                  backgroundColor: ThemeUtils.getBackgroundColor(context),
                  items: _buildItems(isDark),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: provider.value,
                  elevation: 5.0,
                  iconSize: 21.0,
                  selectedFontSize: Dimens.font_sp10,
                  unselectedFontSize: Dimens.font_sp10,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                  onTap: (index) => _pageController.jumpToPage(index),
                );
              },
            ),
            // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
            body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pageList,
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            )),
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }
}
