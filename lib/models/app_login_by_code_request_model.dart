import 'dart:convert';

class AppLoginByCodeRequestModel {
  AppLoginByCodeRequestModel({
    this.phone,
    this.code,
  });

  final String phone;
  final String code;

  AppLoginByCodeRequestModel copyWith({
    String phone,
    String code,
  }) =>
      AppLoginByCodeRequestModel(
        phone: phone ?? this.phone,
        code: code ?? this.code,
      );

  factory AppLoginByCodeRequestModel.fromJson(String str) =>
      AppLoginByCodeRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppLoginByCodeRequestModel.fromMap(Map<String, dynamic> json) =>
      AppLoginByCodeRequestModel(
        phone: json["phone"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone,
        "code": code,
      };
}
