import 'dart:convert';

class BaseQuery {
  BaseQuery({
    this.keyword,
    this.page,
    this.pageSize,
    this.totalCount,
    this.order,
  });

  final String keyword;
  final int page;
  final int pageSize;
  final int totalCount;
  final String order;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (keyword != null) {
      map["keyword"] = keyword;
    }
    if (page != null) {
      map["page"] = page;
    }
    if (pageSize != null) {
      map["pageSize"] = pageSize;
    }
    if (totalCount != null) {
      map["totalCount"] = totalCount;
    }
    if (order != null) {
      map["order"] = order;
    }
    return map;
  }
}
