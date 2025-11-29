import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/network_caller.dart';
import '../../config_service.dart';
import '../setnewpassword/setnewpassword_ui.dart';

class ForgetPassOtpController extends GetxController {
  final String email;

  ForgetPassOtpController({required this.email});

  // Timer for code expiration - make this observable
  var timerDuration = 179.obs; // 3 minutes in seconds
  var isLoading = false.obs;

  // OTP code - 4 digits (not observable since we're using TextEditingController)
  final List<String> otpCode = List.filled(4, '');

  // Focus nodes for OTP fields - 4 fields
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (timerDuration.value > 0) {
        timerDuration.value--;
        startTimer();
      }
    });
  }

  String getFormattedTime() {
    int minutes = timerDuration.value ~/ 60;
    int seconds = timerDuration.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isCodeComplete => otpCode.every((digit) => digit.isNotEmpty);

  void handleOtpChange(String value, int index, BuildContext context) {
    if (value.isNotEmpty) {
      // Update the OTP code
      otpCode[index] = value;
      otpControllers[index].text = value;

      // Move to next field if available
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        // If last field, unfocus
        focusNodes[index].unfocus();

        // Auto-submit if all fields are filled
        if (isCodeComplete) {
          verifyCode();
        }
      }
    }
  }

  void handleBackspace(String value, int index, BuildContext context) {
    if (value.isEmpty && index > 0) {
      // If field is empty and backspace is pressed, move to previous field
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      // Clear the previous field
      otpCode[index - 1] = '';
      otpControllers[index - 1].clear();
    }
  }

  Future<void> resendCode() async {
    try {
      final response = await NetworkCaller().post(
        ApiConfig.forgetPassword,
        body: {'email': email},
      );

      if (response.isSuccess) {
        timerDuration.value = 179;
        // Clear all OTP fields
        for (int i = 0; i < 4; i++) {
          otpCode[i] = '';
          otpControllers[i].clear();
        }
        startTimer();

        // Reset focus to first field
        FocusScope.of(Get.context!).requestFocus(focusNodes[0]);

        Get.snackbar(
          'Code Sent',
          'A new verification code has been sent to your email',
          backgroundColor: Get.theme.primaryColor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend code. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyCode() async {
    if (!isCodeComplete) {
      Get.snackbar(
        'Incomplete Code',
        'Please enter all 4 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      String enteredOtp = otpCode.join('');

      final response = await NetworkCaller().post(
        ApiConfig.verifyEmail,
        body: {
          'email': email,
          'oneTimeCode': int.parse(enteredOtp),
        },
      );

      isLoading.value = false;

      if (response.isSuccess) {
        Get.snackbar(
          'Success',
          'OTP verified successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to password reset screen
        Get.to(() => ResetPasswordScreen(email: email));
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to verify OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
