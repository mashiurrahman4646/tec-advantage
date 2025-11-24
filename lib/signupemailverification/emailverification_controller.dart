import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RegistrationSuccessScreen.dart';
import 'api_service/verify_email_api_service.dart';

class VerificationController extends GetxController {
  // Timer for code expiration
  var timerDuration = 180.obs; // 3 minutes in seconds
  var timerActive = true.obs;

  // OTP code - Updated to 4 digits
  var otpCode = List<String>.filled(4, '').obs;

  // Email passed from RegisterScreen
  late final String email;

  // Loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    email = (args is Map && args['email'] is String) ? args['email'] as String : '';
    if (email.isEmpty) {
      // Warn if email missing
      Get.snackbar('Error', 'Email not found for verification');
    }
    startTimer();
  }

  void startTimer() {
    timerActive.value = true;
    Future.delayed(Duration(seconds: 1), () {
      if (timerDuration.value > 0 && timerActive.value) {
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

  void resendCode() {
    timerDuration.value = 180;
    otpCode.value = List<String>.filled(4, '');
    timerActive.value = true;
    startTimer();

    Get.snackbar(
      'Code Sent',
      'A new verification code has been sent to your email',
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
    );
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

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required for verification',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final codeStr = otpCode.join('');
    final code = int.tryParse(codeStr);
    if (code == null) {
      Get.snackbar(
        'Invalid Code',
        'Code must be numeric',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      await VerifyEmailApiService.verifyEmail(email: email, oneTimeCode: code);
      Get.off(() => RegistrationSuccessScreen());
    } catch (e) {
      Get.snackbar(
        'Verification Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    timerActive.value = false;
    super.onClose();
  }
}