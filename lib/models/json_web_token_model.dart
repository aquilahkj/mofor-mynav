import 'dart:convert';

class JsonWebTokenModel {
    JsonWebTokenModel({
        this.accessToken,
        this.accessTokenUtcExpires,
        this.refreshToken,
        this.refreshUtcExpires,
    });

    String accessToken;
    int accessTokenUtcExpires;
    String refreshToken;
    int refreshUtcExpires;

    JsonWebTokenModel copyWith({
        String accessToken,
        int accessTokenUtcExpires,
        String refreshToken,
        int refreshUtcExpires,
    }) => 
        JsonWebTokenModel(
            accessToken: accessToken ?? this.accessToken,
            accessTokenUtcExpires: accessTokenUtcExpires ?? this.accessTokenUtcExpires,
            refreshToken: refreshToken ?? this.refreshToken,
            refreshUtcExpires: refreshUtcExpires ?? this.refreshUtcExpires,
        );

    factory JsonWebTokenModel.fromJson(String str) => JsonWebTokenModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory JsonWebTokenModel.fromMap(Map<String, dynamic> json) => JsonWebTokenModel(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        accessTokenUtcExpires: json["accessTokenUtcExpires"] == null ? null : json["accessTokenUtcExpires"],
        refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
        refreshUtcExpires: json["refreshUtcExpires"] == null ? null : json["refreshUtcExpires"],
    );

    Map<String, dynamic> toMap() => {
        "accessToken": accessToken == null ? null : accessToken,
        "accessTokenUtcExpires": accessTokenUtcExpires == null ? null : accessTokenUtcExpires,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "refreshUtcExpires": refreshUtcExpires == null ? null : refreshUtcExpires,
    };
}
