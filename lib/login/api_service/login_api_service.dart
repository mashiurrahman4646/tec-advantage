import '../../config_service.dart';
import '../../services/network_caller.dart';


class ApiService {
  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final caller = NetworkCaller();
      final res = await caller.post(ApiConfig.login, body: {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
        'device_type': DateTime.now().millisecondsSinceEpoch % 2 == 0 ? 'android' : 'ios',
      });
      if (res.isSuccess) {
        return res.responseData ?? {};
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}