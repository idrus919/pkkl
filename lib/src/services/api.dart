import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:pkkl/src/constants/route.dart';
import 'package:pkkl/src/services/index.dart';
import 'package:pkkl/src/utils/dio/index.dart';
import 'package:pkkl/src/utils/indext.dart';

class Api {
  static DioClient dio = DioClient();

  static Future get(
    String url, {
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final request = await dio.request;
      debugPrint(url);

      final response = await request.get(url);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      if (e.toString() == 'Unauthorized') {
        final currentRoute = Get.currentRoute;
        if (currentRoute != loginRoute) {
          await Utils.removeToken();
          await AppService.find.checkLogged();
          Get.offAllNamed(loginRoute);
        }
        onError('');
        return;
      }
      onError(e.toString());
    }
  }

  static Future put(
    String url, {
    String? body,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final request = await dio.request;
      debugPrint(url);
      debugPrint(body);

      final response = await request.put(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      Object error = e;
      final unauthError = error is UnauthorizedException;
      if (unauthError) {
        final currentRoute = Get.currentRoute;
        if (currentRoute != loginRoute) {
          await Utils.removeToken();
          await AppService.find.checkLogged();
          Get.offAllNamed(loginRoute);
        }
        onError('');
        return;
      }
      onError(e.toString());
    }
  }

  static Future post(
    String url, {
    String? body,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final request = await dio.request;

      debugPrint(url);
      debugPrint(body);

      final response = await request.post(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      Object error = e;
      final unauthError = error is UnauthorizedException;
      if (unauthError) {
        final currentRoute = Get.currentRoute;
        if (currentRoute != loginRoute) {
          await Utils.removeToken();
          await AppService.find.checkLogged();
          Get.offAllNamed(loginRoute);
        }
        onError('');
        return;
      }
      onError(e.toString());
    }
  }

  static Future delete(
    String url, {
    String? body,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final request = await dio.request;

      debugPrint(url);
      debugPrint(body);

      final response = await request.delete(url);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      Object error = e;
      final unauthError = error is UnauthorizedException;
      if (unauthError) {
        final currentRoute = Get.currentRoute;
        if (currentRoute != loginRoute) {
          await Utils.removeToken();
          await AppService.find.checkLogged();
          Get.offAllNamed(loginRoute);
        }
        onError('');
        return;
      }
      onError(e.toString());
    }
  }

  static Future patch(
    String url, {
    String? body,
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final request = await dio.request;

      debugPrint(url);
      debugPrint(body);

      final response = await request.patch(url, data: body);

      if (response.statusCode != 200) {
        throw response.statusMessage ?? 'Error';
      }

      debugPrint(response.data.toString());

      onSuccess(response.data);
    } catch (e) {
      Object error = e;
      final unauthError = error is UnauthorizedException;
      if (unauthError) {
        final currentRoute = Get.currentRoute;
        if (currentRoute != loginRoute) {
          await Utils.removeToken();
          await AppService.find.checkLogged();
          Get.offAllNamed(loginRoute);
        }
        onError('');
        return;
      }
      onError(e.toString());
    }
  }
}
