import 'dart:convert';

class AppLoginRequestModel {
    AppLoginRequestModel({
        this.userName,
        this.password,
        this.userType,
    });

    String userName;
    String password;
    int userType;

    AppLoginRequestModel copyWith({
        String userName,
        String password,
        int userType,
    }) => 
        AppLoginRequestModel(
            userName: userName ?? this.userName,
            password: password ?? this.password,
            userType: userType ?? this.userType,
        );

    factory AppLoginRequestModel.fromJson(String str) => AppLoginRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppLoginRequestModel.fromMap(Map<String, dynamic> json) => AppLoginRequestModel(
        userName: json["userName"] == null ? null : json["userName"],
        password: json["password"] == null ? null : json["password"],
        userType: json["userType"] == null ? null : json["userType"],
    );

    Map<String, dynamic> toMap() => {
        "userName": userName == null ? null : userName,
        "password": password == null ? null : password,
        "userType": userType == null ? null : userType,
    };
}
