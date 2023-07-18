import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pkkl/src/utils/dio/interceptor.dart';
import 'package:pkkl/src/utils/indext.dart';

class DioClient {
  Future<Dio> get request async {
    final token = await Utils.getToken();
    var dio = Dio(BaseOptions(
      baseUrl: 'https://alhubb919.cloud/',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      headers: {'Authorization': token},
    ));

    dio.interceptors.addAll({AppInterceptors()});

    return dio;
  }
}
