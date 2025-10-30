// File: lib/screens/verification_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';
import 'emailverification_controller.dart';

class VerificationScreen extends StatelessWidget {
  final VerificationController _controller = Get.put(VerificationController());

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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      // Title
                      Text(
                        'Please check your email',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 20,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      // Description
                      Text(
                        'A four digits code has been sent to your email',
                        style: AppTextStyles.onboardingDescription,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      // Enter code text
                      Text(
                        'Enter four digit code',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      // OTP Input Fields - Updated to 4 digits
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Obx(() => TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: _controller.otpCode[index].isEmpty ? '-' : null,
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && value.length == 1) {
                                    _controller.otpCode[index] = value;
                                    if (index < 3) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  } else if (value.isEmpty) {
                                    _controller.otpCode[index] = '';
                                    if (index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  }
                                },
                              )),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Timer
                      Obx(() => Text(
                        'Code expires in: ${_controller.getFormattedTime()}',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      SizedBox(height: 30),
                      // Continue button
                      GestureDetector(
                        onTap: _controller.verifyCode,
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
                      SizedBox(height: 30),
                      // Resend code
                      GestureDetector(
                        onTap: _controller.resendCode,
                        child: Text.rich(
                          TextSpan(
                            text: 'Don\'t receive any code? ',
                            style: AppTextStyles.onboardingDescription,
                            children: [
                              TextSpan(
                                text: 'Resend',
                                style: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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