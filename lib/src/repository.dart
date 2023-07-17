import 'package:flutter/material.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/services/api.dart';
import 'package:pkkl/src/utils/indext.dart';

class Repository {
  static Future me({
    required Function(UserModel? member) onSuccess,
    required VoidCallback onError,
  }) async {
    const url = 'v1/me';

    await Api.get(
      url,
      onSuccess: (json) {
        final member = UserModel.fromJson(json['data']);
        onSuccess(member);
      },
      onError: (error) {
        onError();
        Utils.snackbar(error);
        debugPrint(error);
      },
    );
  }
}
