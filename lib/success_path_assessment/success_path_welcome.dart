import 'package:business_onboarding_app/small%20business%20exm/small%20business%20exm/small%20business%20exm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class SuccessPathWelcomeScreen extends StatelessWidget {
  const SuccessPathWelcomeScreen({Key? key}) : super(key: key);

  String _titleForSlug(String slug) {
    switch (slug) {
      case 'small-business':
        return 'Small Business';
      case 'aspiring-entrepreneur':
        return 'Aspiring Entrepreneur';
      case 'looking-to-get-into-tech':
        return 'Tech Career';
      default:
        return 'Success Path';
    }
  }

  String _welcomeForSlug(String slug) {
    switch (slug) {
      case 'small-business':
        return 'Welcome to Small Business';
      case 'aspiring-entrepreneur':
        return 'Welcome to Aspiring Entrepreneur';
      case 'looking-to-get-into-tech':
        return 'Welcome to Tech Career';
      default:
        return 'Welcome';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final slug = (args is Map && args['slug'] is String)
        ? args['slug'] as String
        : 'small-business';
    final title = _titleForSlug(slug);
    final welcome = _welcomeForSlug(slug);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.check, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 24),
            Text(
              welcome,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Tell us about your business and unlock a free personalized assessment with tailored recommendations to help you grow.",
              style: AppTextStyles.onboardingDescription.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (slug == 'small-business') {
                    Get.to(BusinessAssessmentScreen());
                  } else {
                    Get.toNamed('/success-path-assessment',
                        arguments: {'slug': slug});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.buttonText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
