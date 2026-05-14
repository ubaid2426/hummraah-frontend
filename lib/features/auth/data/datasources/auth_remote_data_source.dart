// data/datasources/auth_remote_data_source.dart
import 'package:hummraah/core/services/api/api_service.dart';
import 'package:hummraah/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<void> sendOtp(String email);
  Future<UserModel> signup(Map<String, dynamic> data);
  Future<UserModel> verifyOtp(String email, String otp);
}

class AuthRemoteDataSourceImpl implements AuthDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);


  @override
  Future<void> sendOtp(String email) async {
    await apiService.sendOtp(email);
  }

  @override
  Future<UserModel> signup(Map<String, dynamic> data) async {
    final response = await apiService.register(data);
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> verifyOtp(String email, String otp) async {
    final response = await apiService.verifyOtp(email, otp);
    return UserModel.fromJson(response);
  }
}