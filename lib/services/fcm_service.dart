import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // FCM Token নেওয়া + স্টোর
  static Future<String?> getAndSaveToken() async {
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
        print("FCM Token Saved: $token");
      }
      return token;
    } catch (e) {
      print("FCM Token Error: $e");
      return null;
    }
  }

  // Token রিফ্রেশ হলে আপডেট
  static void setupTokenRefresh(Function(String) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);
      print("FCM Token Refreshed: $newToken");
      onRefresh(newToken);
    });
  }

  // স্টোর করা টোকেন পড়া
  static Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }
}