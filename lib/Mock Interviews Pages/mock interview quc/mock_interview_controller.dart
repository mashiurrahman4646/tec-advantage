import 'package:get/get.dart';
import '../../services/network_caller.dart';

class MockInterviewController extends GetxController {
  final loading = true.obs;
  final error = RxnString();
  final questions = <Map<String, dynamic>>[].obs;
  final currentPage = 0.obs;
  final selectedIndex = RxnInt();
  final selectedIndices = <int?>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    loading.value = true;
    error.value = null;
    final caller = NetworkCaller();
    final res = await caller.get('/mock/interview/quiz');
    if (res.isSuccess) {
      final List<dynamic> data = (res.responseData?['data'] as List<dynamic>? ?? []);
      questions.assignAll(data.map((e) => (e as Map).cast<String, dynamic>()));
      selectedIndices.assignAll(List<int?>.filled(questions.length, null));
      selectedIndex.value = null;
      currentPage.value = 0;
      loading.value = false;
    } else {
      loading.value = false;
      error.value = res.errorMessage;
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    selectedIndex.value = selectedIndices[page];
  }

  void selectAnswer(int index) {
    selectedIndex.value = index;
  }

  bool get canProceed => selectedIndex.value != null;

  int computeTotalScore() {
    int total = 0;
    for (int i = 0; i < questions.length; i++) {
      final sel = selectedIndices[i];
      if (sel != null) {
        final ans = questions[i]['answers'][sel];
        final sc = (ans is Map && ans['score'] is int) ? ans['score'] as int : 0;
        total += sc;
      }
    }
    return total;
  }
}