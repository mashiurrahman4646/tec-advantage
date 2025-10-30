import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_colors.dart';
import '../../app_text_styles.dart';
import '../small business assessment result/small business assessment.dart';


class BusinessAssessmentScreen extends StatefulWidget {
  @override
  _BusinessAssessmentScreenState createState() => _BusinessAssessmentScreenState();
}

class _BusinessAssessmentScreenState extends State<BusinessAssessmentScreen> {
  // Question 1 (radio)
  String? businessTypeValue;

  // Question 2 (radio)
  String? hasCrmValue;

  // Question 3 (radio)
  String? toolsValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

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
      body: SingleChildScrollView(
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
                  value: 0.33,
                  minHeight: 6,
                  backgroundColor: AppColors.lightGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: 24),
                Text(
                  'Business Overview',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 24),

                // Question 1
                _buildQuestion(
                  '1. What type of business do you run?',
                  _buildRadioOptions(
                    [
                      'Service-based',
                      'Product-based',
                      'Hybrid',
                      'Non-profit',
                      'Other'
                    ],
                    businessTypeValue,
                        (value) {
                      setState(() {
                        businessTypeValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Question 2
                _buildQuestion(
                  '2. Do you currently have a CRM or business management system?',
                  _buildRadioOptions(
                    ['Yes', 'No'],
                    hasCrmValue,
                        (value) {
                      setState(() {
                        hasCrmValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Question 3
                _buildQuestion(
                  '3. What tools do you currently use?',
                  _buildRadioOptions(
                    [
                      'Spreadsheets',
                      'QuickBooks',
                      'Email/Calendar',
                      'Social Media',
                      'Basic Website',
                      'Other'
                    ],
                    toolsValue,
                        (value) {
                      setState(() {
                        toolsValue = value;
                      });
                    },
                  ),
                ),
                const Spacer(),

                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
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
                          // Navigate to assessment result screen
                          Get.to(() => AssessmentResultScreen(
                            score: 4/20,
                            recommendations: [
                              'add automations for X',
                              'connect Y to Z',
                              '1 coaching session to lock a simple process',
                            ],
                          ));
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
                          'Next',
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
      ),
    );
  }

  Widget _buildQuestion(String question, Widget options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        options,
      ],
    );
  }

  Widget _buildRadioOptions(List<String> options, String? selectedValue, Function(String?) onChanged) {
    return Column(
      children: options.map((option) {
        return Row(
          children: [
            Radio<String>(
              value: option,
              groupValue: selectedValue,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              option,
              style: AppTextStyles.bodyText,
            ),
          ],
        );
      }).toList(),
    );
  }
}