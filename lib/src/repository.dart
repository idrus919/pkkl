import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pkkl/src/models/auth.dart';
import 'package:pkkl/src/models/question.dart';
import 'package:pkkl/src/models/user.dart';
import 'package:pkkl/src/pages/input.dart';
import 'package:pkkl/src/pages/login/input.dart';
import 'package:pkkl/src/services/api.dart';
import 'package:pkkl/src/utils/indext.dart';

class Repository {
  static Future me({
    required Function(UserModel? member) onSuccess,
    required VoidCallback onError,
  }) async {
    const url = 'v1/auth/me';

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

  static Future login({
    required LoginInput? body,
    required Function(AuthModel? value) onSuccess,
  }) async {
    const url = 'v1/auth/login';
    try {
      final jsonString = jsonEncode(body?.toJson);
      await Api.post(
        url,
        body: jsonString,
        onSuccess: (json) => onSuccess(AuthModel.fromJson(json['data'])),
        onError: (error) => throw error,
      );
    } catch (e) {
      Utils.snackbar(e.toString());
      debugPrint(e.toString());
    }
  }

  static Future logout({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    const url = 'v1/auth/logout';
    try {
      await Api.post(
        url,
        onSuccess: (json) {
          onSuccess();
          Utils.snackbar(json.toString());
        },
        onError: (error) => throw error,
      );
    } catch (e) {
      onError();
      Utils.snackbar(e.toString());
      debugPrint(e.toString());
    }
  }

  static Future users(
    EvolutionInput? input, {
    required Function(List<UserModel?> values) onSuccess,
  }) async {
    final url = 'v1/evaluation/users${input?.paramUser}';

    await Api.get(
      url,
      onSuccess: (json) {
        List<UserModel?> result = [];
        if (Utils.isList(json['data'])) {
          final data = json['data'] as List;
          result = data.map((f) => UserModel.fromJson(f)).toList();
        }

        onSuccess(result);
      },
      onError: (error) {
        Utils.snackbar(error);
        debugPrint(error);
      },
    );
  }

  static Future questions(
    EvolutionInput? input, {
    required Function(List<QuestionModel?> values) onSuccess,
  }) async {
    const url = 'v1/master/questions';

    await Api.get(
      url,
      onSuccess: (json) {
        List<QuestionModel?> result = [];
        if (Utils.isList(json['data'])) {
          final data = json['data'] as List;
          result = data.map((f) => QuestionModel.fromJson(f)).toList();
        }

        onSuccess(result);
      },
      onError: (error) {
        Utils.snackbar(error);
        debugPrint(error);
      },
    );
  }
}
