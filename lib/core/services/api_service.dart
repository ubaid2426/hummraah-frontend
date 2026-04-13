// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('${AppConstants.baseUrl}$endpoint')
          .replace(queryParameters: queryParams);
      
      final response = await http.get(uri, headers: headers);
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse('${AppConstants.baseUrl}$endpoint');
      
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(body),
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Server error');
      default:
        throw Exception('Unknown error: ${response.statusCode}');
    }
  }
}