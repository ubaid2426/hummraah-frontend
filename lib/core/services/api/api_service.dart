import 'api_client.dart';
import 'api_endpoints.dart';

class ApiService {
  final ApiClient client = ApiClient();

  // 🔹 SIGNUP
  Future<dynamic> register(Map<String, dynamic> data) async {
    return await client.post(ApiEndpoints.register, data);
  }

  // 🔹 LOGIN (OTP verify wala)
  Future<dynamic> login(Map<String, dynamic> data) async {
    return await client.post(ApiEndpoints.login, data);
  }

  // 🔹 SEND OTP
  Future<dynamic> sendOtp(String email) async {
    return await client.post(ApiEndpoints.sendOtp, {"email": email});
  }
  // 🔹 BOOKING
  // Future<dynamic> getBookings() async {
  // return await client.post(ApiEndpoints.getBookings, {});
  // }
  Future<dynamic> getBookings() async {
    return await client.get(ApiEndpoints.getBookings);
  }
  

}
