import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = _mapError(err);
    final newErr = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
    );
    handler.next(newErr);
  }

  String _mapError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return 'Час очікування підключення вичерпано';
      case DioExceptionType.sendTimeout:
        return 'Час відправки запиту вичерпано';
      case DioExceptionType.receiveTimeout:
        return 'Сервер не відповідає';
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode;
        if (code == 400) return 'Невірні дані';
        if (code == 401) return 'Невірний email або пароль';
        if (code == 404) return 'Не знайдено';
        if (code == 422) return 'Email вже використовується';
        return 'Помилка сервера ($code)';
      case DioExceptionType.cancel:
        return 'Запит скасовано';
      case DioExceptionType.connectionError:
        return 'Немає підключення до інтернету';
      default:
        return 'Помилка мережі';
    }
  }
}
