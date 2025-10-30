import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ Business Planning/completed assessment/completes assessment.dart';
import '../../Coaching Page/welcome to coaching page/welcome_to_coaching_page.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
// Import the business planning screen

class AspiringEntrepreneurResultsScreen extends StatelessWidget {
  final String resultType; // 'explorer', 'builder', or 'scaling'

  const AspiringEntrepreneurResultsScreen({Key? key, required this.resultType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define content based on result type
    final Map<String, Map<String, dynamic>> content = {
      'explorer': {
        'title': "You're in the Exploration Phase",
        'subtitle': "You're exploring ideas and finding your entrepreneurial direction. This is where great journeys begin!",
        'findings': [
          "You're still discovering your business passion",
          "Market research and validation needed",
          "Basic business fundamentals to learn"
        ],
        'recommendations': [
          "Idea Validation Workshop",
          "Market Research Fundamentals Course",
          "Entrepreneur Mindset Coaching"
        ]
      },
      'builder': {
        'title': "You're Ready to Build!",
        'subtitle': "You have a solid idea and are ready to turn it into a real business. Let's build your foundation.",
        'findings': [
          "Clear business idea identified",
          "Ready to develop business plan",
          "Need guidance on execution"
        ],
        'recommendations': [
          "Business Plan Development Program",
          "Minimum Viable Product (MVP) Strategy",
          "Funding Preparation Workshop"
        ]
      },
      'scaling': {
        'title': "You're Prepared for Growth",
        'subtitle': "Your business is established and you're ready to scale. Let's optimize and expand your impact.",
        'findings': [
          "Existing business with traction",
          "Ready for strategic growth",
          "Prepared for investment opportunities"
        ],
        'recommendations': [
          "Scale-Up Strategy Session",
          "Investor Pitch Preparation",
          "Growth Team Building Workshop"
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
                  // Navigate to Business Planning screen
                  Get.to(() => BusinessPlanningScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Launch the Business Plan',
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
                  // Handle "Book a Strategy Session" action
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
                          title: Text('Explorer Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/aspiring-entrepreneur-results', arguments: {'type': 'explorer'});
                          },
                        ),
                        ListTile(
                          title: Text('Builder Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/aspiring-entrepreneur-results', arguments: {'type': 'builder'});
                          },
                        ),
                        ListTile(
                          title: Text('Scaling Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/aspiring-entrepreneur-results', arguments: {'type': 'scaling'});
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