import '../../../services/network_caller.dart';
import '../../../token_service/token_service.dart';
import '../models/coach_model.dart';

class CoachingApiService {
  static Future<List<CoachModel>?> getCoaches() async {
    try {
      final caller = NetworkCaller();
      // Endpoint: http://10.10.7.102:3000/api/v1/coaching/coach
      // Assuming ApiConfig has a base URL, we might need to adjust or add a new config
      // For now, I'll use the full URL or relative if ApiConfig supports it.
      // Let's assume we can use ApiConfig.baseUrl + '/coaching/coach'

      final res = await caller.get('/coaching/coach');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => CoachModel.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<CoachDetailsModel?> getCoachDetails(String id) async {
    try {
      final caller = NetworkCaller();
      // Endpoint: http://10.10.7.102:3000/api/v1/coaching/coach/{id}
      final res = await caller.get('/coaching/coach/$id');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'];
        if (data != null) {
          return CoachDetailsModel.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> applyForCoaching({
    required String coachId,
    required String name,
    required String email,
    required String date,
    required String timeRange,
  }) async {
    try {
      final token = await TokenService.readToken();
      if (token == null) return false;
      final userId = TokenService.getUserId(token);

      // User ID might be null if token is invalid, but let's proceed if we have a token.
      // If userId is strictly required and we can't get it, we should fail.
      if (userId == null) return false;

      final body = {
        "userId": userId,
        "coachId": coachId,
        "name": name,
        "email": email,
        "date": date,
        "time": [
          {"range": timeRange}
        ]
      };

      final caller = NetworkCaller();
      final res = await caller.post(
        '/coaching/user',
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      return res.isSuccess;
    } catch (e) {
      return false;
    }
  }
}
