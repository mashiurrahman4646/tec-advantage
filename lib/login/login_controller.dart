// lib/controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/fcm_service.dart';
import '../token_service/token_service.dart';
import 'api_service/login_api_service.dart'; // এই লাইনটি সঠিক করুন

class LoginController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    // ইনপুট চেক
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);

    // FCM Token নেওয়া
    String? fcmToken = await FcmService.getAndSaveToken();
    if (fcmToken == null) {
      Get.snackbar("Error", "Failed to get FCM Token",
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading(false);
      return;
    }

    // API কল
    final result = await ApiService.login(
      email: email.value,
      password: password.value,
      fcmToken: fcmToken,
    );

    isLoading(false);

    // সফল/ব্যর্থতা চেক
    if (result != null && result['success'] == true) {
      // ✅ Token save করুন
      final tokenSaved = await TokenService.ingestLoginResponse(result);

      if (tokenSaved) {
        Get.offAllNamed('/home');
        Get.snackbar("Success", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Failed to save authentication token",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", result?['message'] ?? "Invalid email or password",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
