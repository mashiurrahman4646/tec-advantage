import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
import 'forgetpassotp_controller.dart';

class ForgetPasswordOtpScreen extends StatelessWidget {
  final String email;

  ForgetPasswordOtpScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    final ForgetPassOtpController _controller =
        Get.put(ForgetPassOtpController(email: email));

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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: AppColors.textPrimary),
                          onPressed: () => Get.back(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Lock icon from Figma
                      Center(
                        child: Image.asset(
                          'assets/icons/lockss.png',
                          width: 80,
                          height: 80,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Title
                      Center(
                        child: Text(
                          'OTP',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 24,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Description
                      Text(
                        'A six digits code has been sent to your email',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Enter code text
                      Text(
                        'Enter four digit code',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // OTP Input Fields - 4 digits
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightGrey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _controller.otpControllers[index],
                              focusNode: _controller.focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _controller.handleOtpChange(
                                      value, index, context);
                                } else {
                                  _controller.handleBackspace(
                                      value, index, context);
                                }
                              },
                              onTap: () {
                                _controller.focusNodes[index].requestFocus();
                                _controller.otpControllers[index].selection =
                                    TextSelection(
                                  baseOffset: 0,
                                  extentOffset: _controller
                                      .otpControllers[index].text.length,
                                );
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // Timer - Only this part needs to be reactive
                      Obx(() => Text(
                            'Code expires in: ${_controller.getFormattedTime()}',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )),

                      const SizedBox(height: 30),

                      // Continue button
                      GestureDetector(
                        onTap: _controller.verifyCode,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: AppTextStyles.buttonText.copyWith(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Back to sign in
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Back to sign in',
                              style:
                                  AppTextStyles.onboardingDescription.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Resend code
                      GestureDetector(
                        onTap: _controller.resendCode,
                        child: Text.rich(
                          TextSpan(
                            text: 'Don\'t receive any code? ',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Resend',
                                style: AppTextStyles.onboardingDescription
                                    .copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(child: SizedBox.shrink()),
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
