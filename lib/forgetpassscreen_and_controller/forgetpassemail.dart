import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import '../services/network_caller.dart';
import '../config_service.dart';
import 'forgetpassotp/forget_password_otp_screen.dart';

class ForgetEmailVerify extends StatefulWidget {
  @override
  _ForgetEmailVerifyState createState() => _ForgetEmailVerifyState();
}

class _ForgetEmailVerifyState extends State<ForgetEmailVerify> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendForgetPasswordRequest() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await NetworkCaller().post(
        ApiConfig.forgetPassword,
        body: {'email': email},
      );

      setState(() {
        _isLoading = false;
      });

      if (response.isSuccess) {
        Get.snackbar(
          'Success',
          'OTP has been sent to your email',
          backgroundColor: Colors.green,
          colorText: AppColors.white,
        );
        // Navigate to OTP screen and pass the email
        Get.to(() => ForgetPasswordOtpScreen(email: email));
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage,
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    }
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
                          icon: Icon(Icons.arrow_back,
                              color: AppColors.textPrimary),
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
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Please enter your email address',
                                hintStyle: AppTextStyles.onboardingDescription
                                    .copyWith(
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

                      // Continue button
                      GestureDetector(
                        onTap: _isLoading ? null : _sendForgetPasswordRequest,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                _isLoading ? AppColors.grey : AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: _isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
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
