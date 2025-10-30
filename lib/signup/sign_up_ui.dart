// File: lib/screens/register_screen.dart
import 'package:business_onboarding_app/signup/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());

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
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                          onPressed: () => Get.back(),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Logo
                      Image.asset(
                        'assets/icons/T3logo.png',
                        width: 80,
                        height: 80,
                      ),

                      SizedBox(height: 20),

                      // Registration title
                      Text(
                        'Registration to T3CH ADVANTAGE',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 18,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40),

                      // Full Name field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: _controller.validateFullName,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please enter your full name',
                                hintStyle: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(() => _controller.fullNameError.value.isNotEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              _controller.fullNameError.value,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
                      ),

                      SizedBox(height: 20),

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
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: _controller.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please enter your email address',
                                hintStyle: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(() => _controller.emailError.value.isNotEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              _controller.emailError.value,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Password field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: _controller.validatePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please enter your password',
                                hintStyle: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(() => _controller.passwordError.value.isNotEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              _controller.passwordError.value,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Confirm Password field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confirm Password',
                            style: AppTextStyles.onboardingDescription.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              onChanged: _controller.validateConfirmPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please re-enter your password',
                                hintStyle: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(() => _controller.confirmPasswordError.value.isNotEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              _controller.confirmPasswordError.value,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Terms and Conditions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.validateTerms(!_controller.agreeToTerms.value);
                                },
                                child: Obx(() => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _controller.agreeToTerms.value
                                        ? AppColors.primary
                                        : AppColors.background,
                                    border: Border.all(
                                      color: _controller.agreeToTerms.value
                                          ? AppColors.primary
                                          : AppColors.lightGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: _controller.agreeToTerms.value
                                      ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: AppColors.white,
                                  )
                                      : null,
                                )),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: 'By creating an account or signing you agree to our ',
                                    style: AppTextStyles.onboardingDescription,
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: AppTextStyles.onboardingDescription.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => _controller.termsError.value.isNotEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              _controller.termsError.value,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Sign Up button - FIXED THIS SECTION
                      GestureDetector(
                        onTap: () { // Changed from onPressed to onTap
                          if (_controller.isFormValid()) {
                            // Navigate to verification screen
                            Get.toNamed('/verification');
                          } else {
                            // Show error message
                            Get.snackbar(
                              'Error',
                              'Please fill all fields correctly',
                              backgroundColor: AppColors.error,
                              colorText: AppColors.white,
                            );
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
                              'Sign Up',
                              style: AppTextStyles.buttonText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Already have an account
                      GestureDetector(
                        onTap: () => Get.offAllNamed('/login'),
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyles.onboardingDescription,
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: AppTextStyles.onboardingDescription.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Add flexible space to push content up on smaller screens
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