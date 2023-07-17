import 'package:dio/dio.dart';
import 'package:pkkl/src/utils/dio/error.dart';

class AppInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw DeadlineExceededException(err.requestOptions, err.response);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 401:
            throw UnauthorizedException(err.requestOptions, err.response);
          case 404:
            throw NotFoundException(err.requestOptions, err.response);
          case 405:
            throw MethodNotAllowedException(err.requestOptions, err.response);
          case 409:
            throw ConflictException(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(
              err.requestOptions,
              err.response,
            );
          case 503:
            throw MaintenanceException(err.requestOptions, err.response);
          default:
            throw err.response?.data;
        }
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        throw UnknownException(err.requestOptions, err.response);
    }
  }
}
