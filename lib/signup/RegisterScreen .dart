// lib/screens/register_screen.dart

import 'package:business_onboarding_app/signup/RegisterController.dart';
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

                      // Title
                      Text(
                        'Registration to T3CH ADVANTAGE',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 18,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),

                      // Full Name Field
                      _buildTextField(
                        label: 'Full Name',
                        hint: 'Please enter your full name',
                        onChanged: _controller.validateFullName,
                        error: _controller.fullNameError,
                      ),
                      SizedBox(height: 20),

                      // Email Field
                      _buildTextField(
                        label: 'Email',
                        hint: 'Please enter your email address',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: _controller.validateEmail,
                        error: _controller.emailError,
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      _buildTextField(
                        label: 'Password',
                        hint: 'Please enter your password',
                        obscureText: true,
                        onChanged: _controller.validatePassword,
                        error: _controller.passwordError,
                      ),
                      SizedBox(height: 20),

                      // Confirm Password Field
                      _buildTextField(
                        label: 'Confirm Password',
                        hint: 'Please re-enter your password',
                        obscureText: true,
                        onChanged: _controller.validateConfirmPassword,
                        error: _controller.confirmPasswordError,
                      ),
                      SizedBox(height: 20),

                      // Terms and Conditions
                      _buildTermsCheckbox(),
                      SizedBox(height: 30),

                      // Sign Up Button
                      Obx(() => GestureDetector(
                        onTap: _controller.isLoading.value
                            ? null
                            : () => _controller.register(), // API CALL HERE
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _controller.isLoading.value
                                ? AppColors.grey
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: _controller.isLoading.value
                                ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              'Sign Up',
                              style: AppTextStyles.buttonText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 30),

                      // Already have account?
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

                      // Push content up on small screens
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

  // Reusable TextField
  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required Function(String) onChanged,
    required RxString error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              hintText: hint,
              hintStyle: AppTextStyles.onboardingDescription.copyWith(
                color: AppColors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Obx(() => error.value.isNotEmpty
            ? Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            error.value,
            style: TextStyle(color: AppColors.error, fontSize: 12),
          ),
        )
            : SizedBox.shrink()),
      ],
    );
  }

  // Terms Checkbox
  Widget _buildTermsCheckbox() {
    return Column(
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
                    ? Icon(Icons.check, size: 16, color: AppColors.white)
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
            style: TextStyle(color: AppColors.error, fontSize: 12),
          ),
        )
            : SizedBox.shrink()),
      ],
    );
  }
}