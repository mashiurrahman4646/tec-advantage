import 'dart:typed_data';
import '../../../services/network_caller.dart';
import '../models/business_plan_model.dart';
import '../../../config_service.dart';

class BusinessPlanApiService {
  static Future<List<QuizQuestion>?> getQuizQuestions() async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get('/business/plan/quiz');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          final questions =
              data.map((json) => QuizQuestion.fromJson(json)).toList();
          return questions;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> submitBusinessPlan(Map<String, dynamic> data) async {
    try {
      final caller = NetworkCaller();
      final res = await caller.post('/business/plan/responses', body: data);
      return res.isSuccess;
    } catch (e) {
      return false;
    }
  }

  static String getPdfUrl() {
    return '${ApiConfig.baseUrl}/business/plan/responses/pdf';
  }

  static Future<Uint8List?> downloadPdf() async {
    try {
      final caller = NetworkCaller();
      return await caller.getBinary('/business/plan/responses/pdf');
    } catch (e) {
      return null;
    }
  }
}
