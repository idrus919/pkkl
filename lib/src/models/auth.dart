import 'package:pkkl/src/models/user.dart';

class AuthModel {
  final UserModel? user;
  final String? accessToken, tokenType;

  AuthModel({this.user, this.accessToken, this.tokenType});

  static AuthModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return AuthModel(
      user: UserModel.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
