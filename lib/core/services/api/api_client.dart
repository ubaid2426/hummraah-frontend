// core/services/api/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/local_storage_service.dart';
import 'api_endpoints.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => message;
}

class ApiClient {
  final LocalStorageService _storageService = LocalStorageService();
  
  Future<Map<String, String>> get headers async {
    final token = await _storageService.getString('token');
    print('🔑 Token being sent: ${token != null ? "Present (${token.substring(0, min(20, token.length))}...)" : "NOT PRESENT"}');
    
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    final headersMap = await headers;
    final response = await http.post(uri, headers: headersMap, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    final headersMap = await headers;
    
    print('📡 Making GET request to: $endpoint');
    print('🔑 Headers: $headersMap');
    
    final response = await http.get(uri, headers: headersMap);
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    final headersMap = await headers;
    final response = await http.put(uri, headers: headersMap, body: jsonEncode(body));
    return _handleResponse(response);
  }

  bool _isJWTExpired(String message) {
    final lowerMsg = message.toLowerCase();
    return lowerMsg.contains('jwt expired') || 
           lowerMsg.contains('token expired') ||
           (lowerMsg.contains('expired') && lowerMsg.contains('jwt'));
  }

  dynamic _handleResponse(http.Response response) {
    print('=== API Response ===');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    print('==================');
    
    final data = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    // Success
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    String message = "Something went wrong";
    if (data != null) {
      message = data['message'] ?? data['error'] ?? message;
    }

    // Check for missing authorization header
    if (message.contains('Authorization') && message.contains('not present')) {
      throw ApiException("Please login to continue.", statusCode: 401);
    }

    // Check for JWT expiration
    if (_isJWTExpired(message)) {
      print('⚠️ JWT expired detected');
      throw ApiException("Your session has expired. Please login again.", statusCode: 401);
    }

    // Handle authentication errors
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw ApiException("Your session has expired. Please login again.", statusCode: response.statusCode);
    }
    
    // Handle server errors
    if (response.statusCode >= 500) {
      throw ApiException("Server error. Please try again later.", statusCode: response.statusCode);
    }

    throw ApiException(message, statusCode: response.statusCode);
  }
}

int min(int a, int b) => a < b ? a : b;