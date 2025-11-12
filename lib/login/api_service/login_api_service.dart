import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config_service.dart';


class ApiService {
  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.login}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'fcm_token': fcmToken,
          'device_type': DateTime.now().millisecondsSinceEpoch % 2 == 0 ? 'android' : 'ios',
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Login Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }
}