// terms_conditions_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            Text(
              'Please read these Terms and Conditions carefully before using our Bootcamp mobile application ("the App"). By accessing or using the App, you agree to be bound by these terms.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            SizedBox(height: 24),

            // Section 1: Acceptance of Terms
            _buildSection(
              '1. Acceptance of Terms',
              'By creating an account and accessing the Bootcamp App, you accept and agree to comply with these Terms and Conditions. If you do not agree, you may not use the App.',
            ),

            SizedBox(height: 20),

            // Section 2: User Accounts
            _buildSection(
              '2. User Accounts',
              'By creating an account, you agree to provide accurate, complete, and current information. You are solely responsible for safeguarding your account details and password, and you accept responsibility for all activities that occur under your account. If you suspect any unauthorized use, you must notify us immediately.',
            ),

            SizedBox(height: 20),

            // Section 3: Privacy Policy
            _buildSection(
              '3. Privacy Policy',
              'The App provides access to learning resources including Udemy courses, YouTube videos, and exclusive content uploaded by Admin. While Udemy and YouTube content are governed by their respective platforms\' policies, Admin-uploaded materials are provided for your personal learning only and may not be copied, distributed, or resold. The quizzes offered within the App are designed to help you discover your strengths, and based on your results, personalized video recommendations may be shown. These recommendations are intended for educational purposes only and should not be considered professional, business, or financial advice.',
            ),

            SizedBox(height: 20),

            // Section 4: Governing Law
            _buildSection(
              '4. Governing Law',
              'We reserve the right to update or modify these Terms and Conditions at any time. Continued use of the App after any changes means that you accept the revised terms. These Terms shall be governed by and construed under the laws of [Your Region].',
            ),

            SizedBox(height: 20),

            // Section 5: Content Usage
            _buildSection(
              '5. Content Usage',
              'All content within the App, including but not limited to text, graphics, logos, images, and software, is the property of the App or its content suppliers and is protected by copyright and other intellectual property laws. You may not reproduce, distribute, or create derivative works from any content without explicit permission.',
            ),

            SizedBox(height: 20),

            // Section 6: Limitation of Liability
            _buildSection(
              '6. Limitation of Liability',
              'The App and its services are provided "as is" without any warranties. We shall not be liable for any direct, indirect, incidental, or consequential damages arising from your use of the App. Your use of the App is at your own risk.',
            ),

            SizedBox(height: 20),

            // Section 7: Termination
            _buildSection(
              '7. Termination',
              'We reserve the right to terminate or suspend your account at any time, with or without cause, and with or without notice. Upon termination, your right to use the App will cease immediately.',
            ),

            SizedBox(height: 20),

            // Section 8: Contact Information
            _buildSection(
              '8. Contact Information',
              'If you have any questions about these Terms and Conditions, please contact us at support@bootcampapp.com or through the contact form within the App.',
            ),

            SizedBox(height: 32),

            // Last Updated
            Center(
              child: Text(
                'Last Updated: January 2025',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}