import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pkkl/src/utils/dio/interceptor.dart';

class DioClient {
  final String? accessToken;
  DioClient({this.accessToken});

  Dio get request {
    var dio = Dio(BaseOptions(
      baseUrl: '/',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      headers: {'Authorization': accessToken},
    ));

    dio.interceptors.addAll({AppInterceptors()});

    return dio;
  }
}
