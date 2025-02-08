import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:raddi_web/core/constants/constants.dart';

class Api {
  final tokenDio = _createTokenDio();
  final dioFormData = _createDioFormData();

  static Dio _createTokenDio() {
    var dio = Dio(BaseOptions(
      baseUrl: ConstantApi.url,
      receiveTimeout: const Duration(minutes: 3),
      connectTimeout: const Duration(minutes: 3),
      sendTimeout: const Duration(minutes: 3),
    ));
    dio.interceptors.addAll({_AppInterceptors(dio)});
    return dio;
  }

  static Dio _createDioFormData() {
    var dio = Dio(BaseOptions(
      baseUrl: ConstantApi.url,
      connectTimeout: const Duration(hours: 2),
      receiveTimeout: const Duration(hours: 2),
      sendTimeout: const Duration(hours: 2),
    ));
    dio.interceptors.addAll({_AppInterceptors(dio)});
    return dio;
  }
}

class _AppInterceptors extends Interceptor {
  final Dio dio;

  _AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("====================================================================");
    log(err.message.toString());
    log(err.response.toString());
    handler.next(err);
  }
}
