import 'dart:convert';

class RefreshTokenRequestModel {
  RefreshTokenRequestModel({
    this.refreshToken,
  });

  final String refreshToken;

  RefreshTokenRequestModel copyWith({
    String refreshToken,
  }) =>
      RefreshTokenRequestModel(
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory RefreshTokenRequestModel.fromJson(String str) =>
      RefreshTokenRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefreshTokenRequestModel.fromMap(Map<String, dynamic> json) =>
      RefreshTokenRequestModel(
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toMap() => {
        "refreshToken": refreshToken,
      };
}
