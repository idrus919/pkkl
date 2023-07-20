import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pkkl/src/models/auth.dart';
import 'package:pkkl/src/models/evaluation.dart';
import 'package:pkkl/src/models/indicator.dart';
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

  static Future score(
    EvolutionInput? input, {
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    const url = 'v1/evaluation/score';
    try {
      await Api.post(
        url,
        body: jsonEncode(input?.toJson),
        onSuccess: (json) => onSuccess(),
        onError: (error) => throw error,
      );
    } catch (e) {
      onError();
      Utils.snackbar(e.toString());
      debugPrint(e.toString());
    }
  }

  static Future keplings({
    required Function(List<UserModel?> values) onSuccess,
  }) async {
    const url = 'v1/evaluation/kepling';

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

  static Future scores(
    int? id,
    int? year, {
    required Function(
      List<EvaluationModel?> values,
      List<IndicatorModel?> indicators,
    ) onSuccess,
  }) async {
    final url = 'v1/evaluation/$id/$year/scores';

    await Api.get(
      url,
      onSuccess: (json) {
        List<EvaluationModel?> result = [];
        if (Utils.isList(json['data'])) {
          final data = json['data'] as List;
          result = data.map((f) => EvaluationModel.fromJson(f)).toList();
        }

        List<IndicatorModel?> indicators = [];
        if (Utils.isList(json['indicators'])) {
          final data = json['indicators'] as List;
          indicators = data.map((f) => IndicatorModel.fromJson(f)).toList();
        }

        onSuccess(result, indicators);
      },
      onError: (error) {
        Utils.snackbar(error);
        debugPrint(error);
      },
    );
  }
}
