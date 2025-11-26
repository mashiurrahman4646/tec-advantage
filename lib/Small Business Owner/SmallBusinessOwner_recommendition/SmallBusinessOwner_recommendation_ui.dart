import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../Coaching Page/welcome to coaching page/welcome_to_coaching_page.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
import '../../small business exm/completed assessment/completed_assessment.dart';
 // Import the new screen

class SuccessPathResultsScreen extends StatelessWidget {
  const SuccessPathResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final Map<String, dynamic>? apiData = args is Map ? args['apiData'] as Map<String, dynamic>? : null;
    final String? typeArg = args is Map ? args['type'] as String? : null;
    final Map<String, Map<String, dynamic>> content = {
      'basics': {
        'title': "You're Building the Basics",
        'subtitle': "You're just getting started with systems and processes. Now's the time to lay a strong foundation.",
        'findings': [
          "Manual work is limiting your time.",
          "You don't yet have consistent marketing systems."
        ],
        'recommendations': [
          "Custom Starter CRM (basic contact tracking, simple pipeline)",
          "Marketing Basics (social media setup, lead capture forms)",
          "SWOT+Strategy Session"
        ]
      },
      'growth': {
        'title': "You're on the Growth Track!",
        'subtitle': "Your business has a solid foundation, but you need better systems and marketing to grow with confidence.",
        'findings': [
          "Manual tasks are slowing you down.",
          "Limited forecasting/reporting makes planning harder.",
          "Marketing efforts may not be generating consistent leads."
        ],
        'recommendations': [
          "Standard CRM + Automations - streamline invoicing, scheduling, and reminders.",
          "Marketing Funnels + Campaigns - attract leads and nurture them automatically.",
          "Quarterly SWOT & Strategy Coaching - align your growth plans with clear actions."
        ]
      },
      'scale': {
        'title': "You're Ready to Scale",
        'subtitle': "Your systems are working, but now it's time to expand, optimize, and prepare for investors or funding.",
        'findings': [
          "You have tools in place, but advanced integrations could save more time.",
          "Reporting may not yet be compliance-ready for funders or boards.",
          "Growth is possible with more automation and AI."
        ],
        'recommendations': [
          "Advanced CRM + AI Integrations",
          "Funding-Ready Reporting & Compliance Package",
          "Growth Coaching + KPI Dashboard"
        ]
      }
    };

    final Map<String, dynamic>? currentApi = apiData;
    final String selectedKey = (typeArg != null && (typeArg == 'basics' || typeArg == 'growth' || typeArg == 'scale')) ? typeArg : 'basics';

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
              currentApi != null ? (currentApi['begineerData'] as String? ?? 'Results') : (content[selectedKey]!['title'] as String),
              style: AppTextStyles.heading2.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            Text(
              currentApi != null ? (currentApi['IntermediateData'] as String? ?? '') : (content[selectedKey]!['subtitle'] as String),
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

            ...(currentApi != null ? <String>[
              currentApi['range']?.toString() ?? '',
              currentApi['proData']?.toString() ?? '',
            ] : (content[selectedKey]!['findings'] as List<String>)).map((finding) =>
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

            ...(currentApi != null ? <String>[
              currentApi['proData']?.toString() ?? '',
            ] : (content[selectedKey]!['recommendations'] as List<String>)).map((recommendation) =>
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
                  // Navigate to the new screen
                  Get.to(() => SmallBusinessCongratulationsScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Launch the Small Business',
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
                  // Handle "Book a Session" action
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
                          title: Text('Basics Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/small-business-results', arguments: {'type': 'basics'});
                          },
                        ),
                        ListTile(
                          title: Text('Growth Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/small-business-results', arguments: {'type': 'growth'});
                          },
                        ),
                        ListTile(
                          title: Text('Scale Level'),
                          onTap: () {
                            Get.back();
                            Get.offNamed('/small-business-results', arguments: {'type': 'scale'});
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