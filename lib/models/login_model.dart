import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final int id;
  final String token;
  final String refreshToken;

  LoginModel({
    required this.id,
    required this.token,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refreshToken": refreshToken,
      };
}
