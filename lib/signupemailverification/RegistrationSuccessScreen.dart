import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                      // Success Icon
                      Image.asset(
                        'assets/icons/right1.png',
                        width: 80,
                        height: 80,

                      ),
                      SizedBox(height: 30),
                      // Title
                      Text(
                        'Hi Ericka',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 24,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Success Message
                      Text(
                        'Your Registration Successful',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 20,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      // Congratulations Message
                      Text(
                        'Congratulations! Your journey to smarter\ngrowth starts now.',
                        style: AppTextStyles.onboardingDescription,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      // Continue button
                      GestureDetector(
                        onTap: () {
                          // Navigate to home page
                          Get.offAllNamed('/home');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: AppTextStyles.buttonText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}