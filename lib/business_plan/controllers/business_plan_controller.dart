import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/business_plan_model.dart';
import '../services/business_plan_api_service.dart';
import '../../ Business Planning/business planning assessment result/business planning assessment result.dart';

class BusinessPlanController extends GetxController {
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  // Business Overview Fields
  final businessNameController = TextEditingController();
  final businessTypeController = TextEditingController();
  final missionController = TextEditingController();
  final visionController = TextEditingController();

  // Quiz
  final quizQuestions = <QuizQuestion>[].obs;
  final quizAnswers = <String, String>{}.obs; // questionId -> selectedAnswer
  final currentQuizIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuizQuestions();
  }

  @override
  void onClose() {
    businessNameController.dispose();
    businessTypeController.dispose();
    missionController.dispose();
    visionController.dispose();
    super.onClose();
  }

  Future<void> fetchQuizQuestions() async {
    isLoading(true);
    try {
      final result = await BusinessPlanApiService.getQuizQuestions();
      if (result != null && result.isNotEmpty) {
        quizQuestions.value = result;
      }
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectQuizAnswer(String questionId, String answer) {
    quizAnswers[questionId] = answer;
    quizAnswers.refresh(); // Force UI update
  }

  Future<void> submitPlan() async {
    if (quizAnswers.length < quizQuestions.length) {
      Get.snackbar(
        'Error',
        'Please answer all quiz questions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }

    isSubmitting(true);

    List<QuizAnswer> quizList = [];
    quizAnswers.forEach((questionId, answer) {
      // Find question text
      final question = quizQuestions.firstWhere((q) => q.id == questionId);
      quizList.add(QuizAnswer(
        question: question.questionText,
        selectedAnswer: answer,
      ));
    });

    final data = {
      'businessName': businessNameController.text,
      'businessType': businessTypeController.text,
      'mission': missionController.text,
      'vision': visionController.text,
      'quizAnswers': quizList.map((e) => e.toJson()).toList(),
    };

    final success = await BusinessPlanApiService.submitBusinessPlan(data);

    isSubmitting(false);

    if (success) {
      // Navigate to result page
      Get.offAll(() => BusinessPlanCompleteScreen());
    } else {
      if (Get.isSnackbarOpen == false) {
        Get.snackbar(
          'Error',
          'Failed to submit business plan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    }
  }
}
