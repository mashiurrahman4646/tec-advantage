import 'package:get/get.dart';
import '../../services/network_caller.dart';

class SuccessPathAssessmentController extends GetxController {
  final String slug;
  SuccessPathAssessmentController({required this.slug});

  final loading = true.obs;
  final error = RxnString();
  final questions = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;
  final yesCount = 0.obs;
  final selectedIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    loading.value = true;
    error.value = null;
    questions.clear();
    currentIndex.value = 0;
    yesCount.value = 0;
    selectedIndex.value = null;
    final caller = NetworkCaller();
    final res = await caller.get('/success/path/$slug');
    if (res.isSuccess) {
      final data = res.responseData?['data'];
      final List<dynamic> qs = (data?['questions'] as List<dynamic>? ?? []);
      questions.assignAll(qs.map((e) => (e as Map).cast<String, dynamic>()));
      loading.value = false;
    } else {
      error.value = res.errorMessage;
      loading.value = false;
    }
  }

  void selectAnswer(int idx) {
    selectedIndex.value = idx;
  }

  void next() {
    final sel = selectedIndex.value;
    if (sel == null) return;
    final answers = ((questions[currentIndex.value]['answers'] as List<dynamic>?) ?? const []).cast<String>();
    if (answers.isNotEmpty && sel >= 0 && sel < answers.length) {
      final chosen = answers[sel];
      if (chosen.toLowerCase() == 'yes') {
        yesCount.value = yesCount.value + 1;
      }
    }
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value = currentIndex.value + 1;
      selectedIndex.value = null;
    } else {
      final caller = NetworkCaller();
      caller.get('/success/path/assessments/$slug/range', params: {'value': yesCount.value.toString()}).then((res) {
        if (res.isSuccess) {
          final data = res.responseData?['data'] ?? {};
          Get.offNamed('/success-path-results', arguments: {'apiData': data});
        } else {
          Get.snackbar('Error', res.errorMessage, backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
        }
      });
    }
  }
}