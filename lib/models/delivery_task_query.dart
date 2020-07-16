import 'dart:convert';

import 'package:mynav/models/base_query.dart';

class DeliveryTaskQuery extends BaseQuery {
  DeliveryTaskQuery({
    this.wayBillSheet,
    this.status,
    this.longitude,
    this.latitude,
    String keyword,
    int page,
    int pageSize,
    int totalCount,
    String order,
  }) : super(
          keyword: keyword,
          page: page,
          pageSize: pageSize,
          totalCount: totalCount,
          order: order,
        );

  final String wayBillSheet;
  final int status;
  final double longitude;
  final double latitude;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (wayBillSheet != null) {
      map["wayBillSheet"] = wayBillSheet;
    }
    if (status != null) {
      map["status"] = status;
    }
    if (longitude != null) {
      map["longitude"] = longitude;
    }
    if (latitude != null) {
      map["latitude"] = latitude;
    }
    map.addAll(super.toMap());
    return map;
  }
}
