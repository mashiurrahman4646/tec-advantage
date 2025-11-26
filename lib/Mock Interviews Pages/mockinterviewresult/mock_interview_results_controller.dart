import 'package:get/get.dart';
import '../../services/network_caller.dart';

class MockInterviewResultsController extends GetxController {
  final score = 0.obs;
  final loading = true.obs;
  final error = RxnString();
  final recommendationText = RxnString();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['score'] is int) {
      score.value = args['score'] as int;
    }
    fetchAssessment();
  }

  Future<void> fetchAssessment() async {
    loading.value = true;
    error.value = null;
    final caller = NetworkCaller();
    final res = await caller.get('/mock/interview/assessments/by-range', params: {'value': score.value});
    if (res.isSuccess) {
      final data = res.responseData?['data'];
      if (data is Map) {
        recommendationText.value = data['recomandedText']?.toString() ?? data['recommendedText']?.toString();
      } else if (data is List && data.isNotEmpty && data.first is Map) {
        recommendationText.value = (data.first as Map)['recomandedText']?.toString() ?? (data.first as Map)['recommendedText']?.toString();
      } else {
        recommendationText.value = null;
      }
      loading.value = false;
    } else {
      loading.value = false;
      error.value = res.errorMessage;
    }
  }
}