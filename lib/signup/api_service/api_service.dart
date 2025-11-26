// lib/services/api_service.dart

import 'dart:async';
import '../../config_service.dart';
import '../../services/network_caller.dart';


class ApiService {
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final caller = NetworkCaller(timeout: const Duration(seconds: 15));
    try {
      final res = await caller.post(ApiConfig.user, body: {
        'name': name,
        'email': email,
        'password': password,
      });
      if (res.isSuccess) {
        return res.responseData ?? {};
      }
      throw res.errorMessage;
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