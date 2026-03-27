import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import 'user_model.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<String> register(String email, String password) async {
    final response = await _dio.post(
      '/users/add',
      data: {'email': email, 'password': password, 'username': email},
    );
    if (response.statusCode == 201) {
      final token = response.data['id'].toString();
      await TokenStorage.saveToken(token);
      return token;
    }
    throw Exception('Помилка реєстрації');
  }

  Future<String> login(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'username': 'emilys', 'password': 'emilyspass'},
    );
    if (response.statusCode == 200) {
      final token = response.data['accessToken'] as String;
      await TokenStorage.saveToken(token);
      if (rememberMe) await TokenStorage.saveEmail(email);
      return token;
    }
    throw Exception(response.data['message'] ?? 'Помилка входу');
  }

  Future<UserModel> getProfile() async {
    final response = await _dio.get('/users/1');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    }
    throw Exception('Не вдалося отримати профіль');
  }

  Future<Map<String, dynamic>> updateProfile(String name, String job) async {
    final response = await _dio.put(
      '/users/1',
      data: {
        'firstName': name,
        'company': {'title': job}
      },
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw Exception('Не вдалося оновити профіль');
  }

  Future<void> logout() async => TokenStorage.clearAll();

  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null;
  }
}
