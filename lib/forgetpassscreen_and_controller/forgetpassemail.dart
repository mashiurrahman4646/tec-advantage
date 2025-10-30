import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import 'forgetpassotp/forget_password_otp_screen.dart';
 // Import the OTP screen

class ForgetEmailVerify extends StatefulWidget {
  @override
  _ForgetEmailVerifyState createState() => _ForgetEmailVerifyState();
}

class _ForgetEmailVerifyState extends State<ForgetEmailVerify> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                          onPressed: () => Get.back(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Lock icon
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
                          'Forget Password',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 24,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please enter your email address',
                                hintStyle: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Information text
                      Text(
                        'You may receive notifications via SMS or email from us for security and login purposes.',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Continue button - UPDATED to navigate to OTP screen
                      GestureDetector(
                        onTap: () {
                          if (_emailController.text.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please enter your email address',
                              backgroundColor: AppColors.error,
                              colorText: AppColors.white,
                            );
                          } else {
                            // Navigate to OTP verification screen
                            Get.to(() => ForgetPasswordOtpScreen());
                          }
                        },
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
                              ),
                            ),
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