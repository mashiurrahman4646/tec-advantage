import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../config_service.dart';

class VerifyEmailApiService {
  static Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required int oneTimeCode,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.verifyEmail}');

    try {
      print('[VERIFY] POST ${url.toString()}');
      print('[VERIFY] Payload: {email: $email, oneTimeCode: $oneTimeCode}');
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'oneTimeCode': oneTimeCode,
        }),
      )
          .timeout(const Duration(seconds: 15));

      print('[VERIFY] Status: ${response.statusCode}');
      print('[VERIFY] Body: ${response.body}');

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      if (response.statusCode == 200) {
        return data is Map<String, dynamic> ? data : {};
      }
      throw data is Map && data['message'] != null
          ? data['message']
          : 'Verification failed';
    } on TimeoutException {
      throw 'Verification timed out. Please try again.';
    } catch (e) {
      if (e.toString().contains('Failed host') || e.toString().contains('Connection refused')) {
        throw 'No internet. Check your connection.';
      }
      rethrow;
    }
  }
}