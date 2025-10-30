// tech_career_assessment/tech_career_results_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Coaching Page/welcome to coaching page/welcome_to_coaching_page.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
import '../../bootcamp/bootcamp welcome/bootcampwelcome.dart';
 // Add this import

class TechCareerResultsScreen extends StatelessWidget {
  final String resultType; // 'beginner', 'intermediate', or 'advanced'

  const TechCareerResultsScreen({Key? key, required this.resultType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define content based on result type
    final Map<String, Map<String, dynamic>> content = {
      'beginner': {
        'title': "You're Starting Your Tech Journey",
        'subtitle': "You're new to tech and ready to build a strong foundation. This is where amazing careers begin!",
        'findings': [
          "Basic tech knowledge to develop",
          "Career path exploration needed",
          "Foundational skills to build"
        ],
        'recommendations': [
          "Tech Fundamentals Bootcamp",
          "Career Path Discovery Workshop",
          "Beginner Coding Foundations"
        ]
      },
      'intermediate': {
        'title': "You're Building Tech Proficiency",
        'subtitle': "You have some tech experience and are ready to specialize and advance your skills.",
        'findings': [
          "Basic tech understanding established",
          "Ready for specialized training",
          "Career advancement preparation needed"
        ],
        'recommendations': [
          "Specialized Tech Track Program",
          "Portfolio Development Project",
          "Interview Preparation Intensive"
        ]
      },
      'advanced': {
        'title': "You're Ready for Tech Leadership",
        'subtitle': "You have strong tech skills and are prepared for advanced roles and leadership positions.",
        'findings': [
          "Strong technical foundation",
          "Ready for advanced specialization",
          "Leadership skills development needed"
        ],
        'recommendations': [
          "Advanced Specialization Course",
          "Tech Leadership Program",
          "Executive Career Coaching"
        ]
      }
    };

    final currentContent = content[resultType]!;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main title
            Text(
              currentContent['title'] as String,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            Text(
              currentContent['subtitle'] as String,
              style: AppTextStyles.onboardingDescription.copyWith(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),

            // What We Found section
            Text(
              'What We Found',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            ...(currentContent['findings'] as List<String>).map((finding) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      Expanded(
                        child: Text(
                          finding,
                          style: AppTextStyles.onboardingDescription.copyWith(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ).toList(),

            const SizedBox(height: 32),

            // Recommended Next Steps section
            Text(
              'Recommended Next Steps',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            ...(currentContent['recommendations'] as List<String>).map((recommendation) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: AppTextStyles.onboardingDescription.copyWith(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ).toList(),

            const SizedBox(height: 40),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Bootcamp Welcome Screen
                  Get.to(() => BootcampWelcomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get into BootCamp',
                  style: AppTextStyles.buttonText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(()=>CoachingWelcomeScreen());
                  // Handle "Book Career Consultation" action
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: AppColors.primary),
                ),
                child: Text(
                  'Book a Session',
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Debug menu (hidden - long press on title to show)
            GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Test Different Results'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Beginner Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/tech-career-results', arguments: {'type': 'beginner'});
                          },
                        ),
                        ListTile(
                          title: Text('Intermediate Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/tech-career-results', arguments: {'type': 'intermediate'});
                          },
                        ),
                        ListTile(
                          title: Text('Advanced Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/tech-career-results', arguments: {'type': 'advanced'});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 20, // Invisible area for long press
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}