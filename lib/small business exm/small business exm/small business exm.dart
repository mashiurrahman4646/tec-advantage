import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_colors.dart';
import '../../app_text_styles.dart';
import 'business_assessment_controller.dart';
import '../completed assessment/completed_assessment.dart';


class BusinessAssessmentScreen extends StatelessWidget {
  const BusinessAssessmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final args = Get.arguments;
    final section = (args is Map && args['section'] is String) ? args['section'] as String : 'business-overview';
    final c = Get.isRegistered<BusinessAssessmentController>(tag: section)
        ? Get.find<BusinessAssessmentController>(tag: section)
        : Get.put(BusinessAssessmentController(section: section), tag: section, permanent: true);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Small Business',
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (c.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (c.error.value != null) {
          return Center(child: Text(c.error.value!, style: const TextStyle(color: Colors.red)));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 24.0,
            vertical: 16.0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Assessment',
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: c.progress,
                    minHeight: 6,
                    backgroundColor: AppColors.lightGrey,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    section.replaceAll('-', ' ').split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' '),
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(c.visibleQuestions.length, (localIndex) {
                    final q = c.visibleQuestions[localIndex];
                    final int qIndex = c.startIndex + localIndex;
                    final String qText = (q['questionText'] as String?) ?? '';
                    final List<Map<String, dynamic>> answers = ((q['answers'] as List<dynamic>? ?? [])
                        .map((e) => (e as Map).cast<String, dynamic>()))
                        .toList();
                    final selectedValue = c.selected[qIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${qIndex + 1}. $qText',
                          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: answers.map((ans) {
                            final optionText = (ans['text'] as String?) ?? '';
                            return Row(
                              children: [
                                Radio<String>(
                                  value: optionText,
                                  groupValue: selectedValue,
                                  onChanged: (v) {
                                    if (v != null) c.selectAnswer(qIndex, v);
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(optionText, style: AppTextStyles.bodyText),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            if (c.isFirstPage) {
                              Get.back();
                            } else {
                              c.prevPage();
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: AppTextStyles.buttonText.copyWith(color: AppColors.primary),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!c.isLastPage) {
                              c.nextPage();
                            } else {
                              final value = c.totalScore;
                              Get.to(() => SmallBusinessCongratulationsScreen(), arguments: {'value': value});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            c.isLastPage ? 'Finish' : 'Next',
                            style: AppTextStyles.buttonText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}