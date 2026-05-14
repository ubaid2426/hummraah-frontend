import 'package:http/http.dart';

import 'api_client.dart';
import 'api_endpoints.dart';

class ApiService {
  final ApiClient client;

  ApiService(this.client);

  Future<dynamic> register(Map<String, dynamic> data) async {
    return await client.post(ApiEndpoints.register, data);
  }


  Future<dynamic> sendOtp(String email) async {
    return await client.post(ApiEndpoints.sendOtp, {"email": email});
  }

  Future<dynamic> getBookings() async {
    return await client.get(ApiEndpoints.getBookings);
  }
    Future<dynamic> verifyOtp(String email, String otp) async {
    return await client.post(ApiEndpoints.verifyOtp, {
      "email": email,
      "otp": otp,
    });
  }

      // Get profile
  Future<dynamic> getProfile() async {
    return await client.get(ApiEndpoints.profile);
  }

  // Update profile
  Future<dynamic> updateProfile(Map<String, dynamic> data) async {
    return await client.put(ApiEndpoints.completeProfile, data);
  }

    Future<dynamic> createBooking(Map<String, dynamic> data) async {
    return await client.post(ApiEndpoints.postBooking, data);
  }
}
