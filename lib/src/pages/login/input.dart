class LoginInput {
  String? username, password;

  LoginInput({this.username, this.password});

  bool get enable {
    final username = (this.username ?? '').isNotEmpty;
    final password = (this.password ?? '').length > 5;

    return username && password;
  }

  Map<String, dynamic> get toJson {
    return {'username': username, 'password': password};
  }
}
