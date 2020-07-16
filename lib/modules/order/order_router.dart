import 'package:fluro/fluro.dart';
import 'package:mynav/routers/router_init.dart';

import 'pages/order_info_page.dart';
import 'pages/order_page.dart';
// import 'pages/order_search_page.dart';
// import 'pages/order_track_page.dart';

class OrderRouter implements IRouterProvider {
  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  // static String orderTrackPage = '/order/track';

  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => OrderPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, __) => OrderInfoPage()));
    // router.define(orderSearchPage, handler: Handler(handlerFunc: (_, __) => OrderSearchPage()));
    // router.define(orderTrackPage, handler: Handler(handlerFunc: (_, __) => OrderTrackPage()));
  }
}
