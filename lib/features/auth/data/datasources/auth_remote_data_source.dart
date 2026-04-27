// import 'package:dio/dio.dart';
// import '../models/user_model.dart';

// abstract class AuthDataSource {
//   Future<UserModel> login(String email, String password);
// }

// class AuthRemoteDataSource implements AuthDataSource {
//   final Dio client;

//   AuthRemoteDataSource({required this.client});

//   @override
//   Future<UserModel> login(String email, String password) async {
//     final response = await client.post('https://example.com/api/login', data: {
//       'email': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       return UserModel.fromJson(response.data);
//     } else {
//       throw Exception('Login failed');
//     }
//   }
// }
import '/core/services/api/api_service.dart';
import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(Map<String, dynamic> data);
}
class AuthRemoteDataSource implements AuthDataSource {
  final ApiService apiService;

  AuthRemoteDataSource(this.apiService);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiService.login({
      "email": email,
      "password": password,
    });

    return UserModel.fromJson(response);
  }

  @override
  Future<void> register(Map<String, dynamic> data) async {
    await apiService.register(data);
  }
}
