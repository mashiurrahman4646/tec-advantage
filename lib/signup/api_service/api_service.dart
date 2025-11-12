// lib/services/api_service.dart

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../config_service.dart';


class ApiService {
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.user}');

    try {
      // Log request
      print('[REGISTER] POST ${url.toString()}');
      print('[REGISTER] Payload: {name: $name, email: $email, password: ******}');

      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 15));

      // Log response
      print('[REGISTER] Status: ${response.statusCode}');
      print('[REGISTER] Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data is Map<String, dynamic> ? data : {};
      } else {
        throw data['message'] ?? 'Registration failed';
      }
    } on TimeoutException {
      throw 'Request timed out. Please try again.';
    } catch (e) {
      if (e.toString().contains('Failed host') || e.toString().contains('Connection refused')) {
        throw 'No internet. Check your connection.';
      }
      rethrow;
    }
  }
}