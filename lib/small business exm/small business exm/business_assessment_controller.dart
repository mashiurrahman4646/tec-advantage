import 'package:get/get.dart';
import '../../services/network_caller.dart';

class BusinessAssessmentController extends GetxController {
  final String section;
  BusinessAssessmentController({required this.section});

  final loading = true.obs;
  final error = RxnString();
  final questions = <Map<String, dynamic>>[].obs;
  final selected = <int, String>{}.obs;
  final currentPage = 0.obs;
  final int pageSize = 3;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    loading.value = true;
    error.value = null;
    questions.clear();
    selected.clear();
    currentPage.value = 0;
    final caller = NetworkCaller();
    final res = await caller.get('/small/business/$section/questions');
    if (res.isSuccess) {
      final List<dynamic> data = (res.responseData?['data'] as List<dynamic>? ?? []);
      questions.assignAll(data.map((e) => (e as Map).cast<String, dynamic>()));
      loading.value = false;
    } else {
      error.value = res.errorMessage;
      loading.value = false;
    }
  }

  void selectAnswer(int qIndex, String value) {
    selected[qIndex] = value;
    selected.refresh();
  }

  bool get allAnswered => questions.isNotEmpty && selected.length == questions.length;

  int get totalPages {
    if (questions.isEmpty) return 0;
    final q = questions.length;
    final pages = q ~/ pageSize + (q % pageSize > 0 ? 1 : 0);
    return pages;
  }

  int get startIndex => currentPage.value * pageSize;

  int get endIndex {
    final end = startIndex + pageSize;
    return end > questions.length ? questions.length : end;
  }

  List<Map<String, dynamic>> get visibleQuestions =>
      questions.sublist(startIndex, endIndex);

  bool get isFirstPage => currentPage.value == 0;
  bool get isLastPage => totalPages == 0 ? true : currentPage.value == totalPages - 1;

  void nextPage() {
    if (!isLastPage) {
      currentPage.value = currentPage.value + 1;
    }
  }

  void prevPage() {
    if (!isFirstPage) {
      currentPage.value = currentPage.value - 1;
    }
  }

  double get progress {
    if (totalPages == 0) return 0.0;
    return (currentPage.value + 1) / totalPages;
  }

  int get totalScore {
    int sum = 0;
    for (var i = 0; i < questions.length; i++) {
      final sel = selected[i];
      if (sel == null) continue;
      final answers = (questions[i]['answers'] as List<dynamic>? ?? [])
          .map((e) => (e as Map).cast<String, dynamic>())
          .toList();
      for (final ans in answers) {
        final text = ans['text'];
        if (text is String && text == sel) {
          final s = ans['score'];
          if (s is int) {
            sum += s;
          } else if (s is double) {
            sum += s.round();
          } else if (s is String) {
            final parsed = int.tryParse(s);
            if (parsed != null) sum += parsed;
          }
          break;
        }
      }
    }
    return sum;
  }

  String get resultType {
    final score = totalScore;
    if (score <= 10) return 'basics';
    if (score <= 20) return 'growth';
    return 'scale';
  }
}