import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('>>> REQUEST: ${options.method} ${options.uri}');
    // ignore: avoid_print
    print('>>> HEADERS: ${options.headers}');
    if (options.data != null) {
      // ignore: avoid_print
      print('>>> BODY: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('<<< RESPONSE: ${response.statusCode}');
    // ignore: avoid_print
    print('<<< DATA: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('!!! ERROR: ${err.message}');
    handler.next(err);
  }
}
