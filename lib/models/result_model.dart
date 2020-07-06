import 'dart:convert';

class ResultModel {
  ResultModel(
    this.code,
    this.message,
    this.operationTime,
    this.data,
  );

  int code;
  String message;
  DateTime operationTime;
  dynamic data;

  factory ResultModel.fromJson(String str) =>
      ResultModel.fromMap(json.decode(str));

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        json["code"] == null ? null : json["code"],
        json["message"] == null ? null : json["message"],
        json["operationTime"] == null ? null: DateTime.parse(json["operationTime"]),
        json["data"] == null ? null : json["data"],
      );
}
