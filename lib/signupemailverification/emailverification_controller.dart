import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RegistrationSuccessScreen.dart';

class VerificationController extends GetxController {
  // Timer for code expiration
  var timerDuration = 180.obs; // 3 minutes in seconds
  var timerActive = true.obs;

  // OTP code - Updated to 4 digits
  var otpCode = List<String>.filled(4, '').obs;

  @override
  void onInit() {
    super.onInit();
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

  void verifyCode() {
    if (isCodeComplete) {
      // Here you would typically verify the code with your backend
      // Navigate to registration success screen after verification
      Get.off(() => RegistrationSuccessScreen());
    } else {
      Get.snackbar(
        'Incomplete Code',
        'Please enter all 4 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    timerActive.value = false;
    super.onClose();
  }
}