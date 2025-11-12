import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _keyAuthToken = 'auth_token';

  // Login por token save
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthToken, token);
    // Debug log
    // print('[TOKEN] Saved');
  }

  // Saved token read
  static Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAuthToken);
  }

  // Token ache kina
  static Future<bool> hasToken() async {
    final t = await readToken();
    return t != null && t.isNotEmpty;
  }

  // Logout por token remove
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAuthToken);
  }

  // Protected API headers build
  static Future<Map<String, String>> authHeaders() async {
    final token = await readToken();
    if (token == null || token.isEmpty) return {};
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Optional: enforce auth headers, token na thakle throw
  static Future<Map<String, String>> requireAuthHeaders() async {
    final headers = await authHeaders();
    if (headers.isEmpty) {
      throw 'Not authenticated';
    }
    return headers;
  }

  // JWT payload decode (best-effort)
  static Map<String, dynamic> decodePayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return {};
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(decoded);
      return map is Map<String, dynamic> ? map : {};
    } catch (_) {
      return {};
    }
  }

  // Token expiry check
  static bool isExpired(String token, {Duration leeway = Duration.zero}) {
    final payload = decodePayload(token);
    final exp = payload['exp'];
    if (exp is int) {
      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiry.subtract(leeway));
    }
    return false;
  }

  // Convenience getters from token
  static String? getEmail(String token) {
    final payload = decodePayload(token);
    final email = payload['email'] ?? payload['sub'];
    return email is String ? email : null;
  }

  static String? getUserId(String token) {
    final payload = decodePayload(token);
    final id = payload['userId'] ?? payload['uid'] ?? payload['id'];
    return id is String ? id : null;
  }

  static String? getRole(String token) {
    final payload = decodePayload(token);
    final role = payload['role'];
    return role is String ? role : null;
  }

  // Flexible token extraction from login response
  static String? extractToken(Map<String, dynamic> result) {
    // Common shapes: { token }, { data: token }, { data: { token } }
    final dynamic data = result['data'];
    if (result['token'] is String && (result['token'] as String).isNotEmpty) {
      return result['token'] as String;
    }
    if (data is String && data.isNotEmpty) {
      return data;
    }
    if (data is Map && data['token'] is String && (data['token'] as String).isNotEmpty) {
      return data['token'] as String;
    }
    return null;
  }

  // Login response ingest: extract + save token
  static Future<bool> ingestLoginResponse(Map<String, dynamic> result) async {
    final token = extractToken(result);
    if (token != null && token.isNotEmpty) {
      await saveToken(token);
      return true;
    }
    return false;
  }
}