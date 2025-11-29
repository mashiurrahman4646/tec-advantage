import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_colors.dart';
import '../../app_text_styles.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Image.asset('assets/icons/T3logo.png',
                          width: 80, height: 80),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome Back to T3CH ADVANTAGE',
                        style: AppTextStyles.heading2
                            .copyWith(fontSize: 18, height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      _buildTextField(
                        label: 'Email',
                        hint: 'Please enter your email address',
                        controller: controller.emailController,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        label: 'Password',
                        hint: 'Please enter your password',
                        obscureText: true,
                        controller: controller.passwordController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Obx(() => Checkbox(
                                  value: controller.rememberMe.value,
                                  onChanged: (val) => controller
                                      .rememberMe.value = val ?? false,
                                  activeColor: AppColors.primary,
                                )),
                            Text('Remember Me',
                                style: AppTextStyles.onboardingDescription),
                          ]),
                          GestureDetector(
                            onTap: () => Get.toNamed('/forgot-password'),
                            child: Text('Forget Password?',
                                style: AppTextStyles.onboardingDescription
                                    .copyWith(color: AppColors.primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Obx(() => GestureDetector(
                            onTap: controller.isLoading.value
                                ? null
                                : controller.login,
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: controller.isLoading.value
                                    ? AppColors.lightGrey
                                    : AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text('Login',
                                        style: AppTextStyles.buttonText
                                            .copyWith(color: AppColors.white)),
                              ),
                            ),
                          )),
                      const SizedBox(height: 30),
                      _buildDivider(),
                      const SizedBox(height: 30),
                      _buildRegisterLink(),
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

  Widget _buildTextField(
      {required String label,
      required String hint,
      bool obscureText = false,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.onboardingDescription
                .copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.lightGrey)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Or continue with',
                style: AppTextStyles.onboardingDescription)),
        Expanded(child: Divider(color: AppColors.lightGrey)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            child: Image.asset('assets/icons/facebook.png',
                width: 40, height: 40)),
        const SizedBox(width: 20),
        GestureDetector(
            child:
                Image.asset('assets/icons/google.png', width: 40, height: 40)),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return GestureDetector(
      onTap: () => Get.toNamed('/register'),
      child: Text.rich(
        TextSpan(
          text: 'Don\'t have an account? ',
          style: AppTextStyles.onboardingDescription,
          children: [
            TextSpan(
                text: 'Register',
                style: AppTextStyles.onboardingDescription.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
