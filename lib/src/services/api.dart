import 'package:flutter/cupertino.dart';
import 'package:pkkl/src/utils/dio/index.dart';
import 'package:pkkl/src/utils/indext.dart';

class Api {
  static Future get(
    String url, {
    String? accessToken,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final token = await Utils.getToken();
      final dio = DioClient(accessToken: accessToken ?? token);

      debugPrint(token);
      debugPrint(url);

      final response = await dio.request.get(url);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future put(
    String url, {
    String? body,
    String? accessToken,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final token = await Utils.getToken();
      final dio = DioClient(accessToken: accessToken ?? token);

      debugPrint(token);
      debugPrint(url);
      debugPrint(body);

      final response = await dio.request.put(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future post(
    String url, {
    String? body,
    String? accessToken,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final token = await Utils.getToken();
      final dio = DioClient(accessToken: accessToken ?? token);

      debugPrint(accessToken);
      debugPrint(token);
      debugPrint(url);
      debugPrint(body);

      final response = await dio.request.post(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future delete(
    String url, {
    String? body,
    String? accessToken,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final token = await Utils.getToken();
      final dio = DioClient(accessToken: accessToken ?? token);

      debugPrint(token);
      debugPrint(url);
      debugPrint(body);

      final response = await dio.request.delete(url);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future patch(
    String url, {
    String? body,
    String? accessToken,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final token = await Utils.getToken();
      final dio = DioClient(accessToken: accessToken ?? token);

      debugPrint(token);
      debugPrint(url);
      debugPrint(body);

      final response = await dio.request.patch(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      onError(e.toString());
    }
  }
}
