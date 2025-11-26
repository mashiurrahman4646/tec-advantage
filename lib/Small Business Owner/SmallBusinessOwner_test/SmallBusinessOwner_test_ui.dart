import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
import 'small_business_assessment_controller.dart';

class SuccessPathAssessmentScreen extends StatelessWidget {
  const SuccessPathAssessmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final slug = (args is Map && args['slug'] is String) ? args['slug'] as String : 'small-business';
    final c = Get.isRegistered<SuccessPathAssessmentController>(tag: slug)
        ? Get.find<SuccessPathAssessmentController>(tag: slug)
        : Get.put(SuccessPathAssessmentController(slug: slug), tag: slug, permanent: true);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Success Path Assessment',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (c.loading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (c.error.value != null) {
            return Center(child: Text(c.error.value!, style: TextStyle(color: Colors.red)));
          }
          if (c.questions.isEmpty) {
            return Center(child: Text('No questions available'));
          }
          final total = c.questions.length;
          final index = c.currentIndex.value;
          final q = c.questions[index];
          final answers = ((q['answers'] as List<dynamic>?) ?? const []).cast<String>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${index + 1} of $total',
                style: AppTextStyles.onboardingDescription.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: total == 0 ? 0 : (index + 1) / total,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                ((q['questionText'] as String?) ?? '').trim(),
                style: AppTextStyles.heading2.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              ...List.generate(answers.length, (i) {
                final isSelected = c.selectedIndex.value == i;
                return Padding(
                  padding: EdgeInsets.only(bottom: i == answers.length - 1 ? 0 : 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => c.selectAnswer(i),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        answers[i],
                        style: AppTextStyles.buttonText.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Take your time to choose the answer that best represents you',
                  style: AppTextStyles.onboardingDescription.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Back',
                        style: AppTextStyles.buttonText.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: c.selectedIndex.value != null ? c.next : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index < total - 1 ? 'Next' : 'Submit',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ),
    );
  }
}