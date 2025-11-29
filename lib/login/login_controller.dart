// lib/controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/fcm_service.dart';
import '../token_service/token_service.dart';
import 'api_service/login_api_service.dart'; // এই লাইনটি সঠিক করুন

class LoginController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();
  }

  Future<void> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe.value = prefs.getBool('remember_me') ?? false;
    if (rememberMe.value) {
      emailController.text = prefs.getString('remember_email') ?? '';
      passwordController.text = prefs.getString('remember_password') ?? '';
    }
  }

  Future<void> saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe.value) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('remember_email', emailController.text);
      await prefs.setString('remember_password', passwordController.text);
    } else {
      await prefs.remove('remember_me');
      await prefs.remove('remember_email');
      await prefs.remove('remember_password');
    }
  }

  Future<void> login() async {
    // ইনপুট চেক
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
      email: emailController.text,
      password: passwordController.text,
      fcmToken: fcmToken,
    );

    isLoading(false);

    // সফল/ব্যর্থতা চেক
    if (result != null && result['success'] == true) {
      // ✅ Token save করুন
      final tokenSaved = await TokenService.ingestLoginResponse(result);

      if (tokenSaved) {
        // Save credentials if Remember Me is checked
        await saveCredentials();

        // Initialize FCM service (permissions, handlers, send token to backend)
        FcmService.initialize();

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
