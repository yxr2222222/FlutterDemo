import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("<-- ${options.method.toUpperCase()}");

    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('$k: $v'));

    debugPrint("queryParameters:");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));

    if (options.data != null) {
      debugPrint("Body: ${options.data}");
    }
    debugPrint("END ${options.method.toUpperCase()} -->\n");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}");

    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));

    debugPrint("Response: ${response.data}");
    debugPrint("END HTTP -->\n");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    debugPrint("${err.response != null ? err.response!.data : 'Unknown Error'}");
    debugPrint("End error -->\n");
    super.onError(err, handler);
  }
}
