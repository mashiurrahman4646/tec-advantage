// lib/controllers/register_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_service/api_service.dart';


class RegisterController extends GetxController {
  // Form fields
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var agreeToTerms = false.obs;

  // Errors
  var fullNameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var termsError = ''.obs;

  // Loading
  var isLoading = false.obs;

  // === VALIDATION ===
  void validateFullName(String value) {
    final trimmed = value.trim();
    fullName.value = trimmed;
    fullNameError.value = trimmed.isEmpty
        ? 'Please enter your full name'
        : trimmed.length < 3
        ? 'Name must be at least 3 characters'
        : '';
  }

  void validateEmail(String value) {
    final trimmed = value.trim();
    email.value = trimmed;
    // Allow modern TLDs and simple, robust email structure
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    emailError.value = trimmed.isEmpty
        ? 'Please enter your email address'
        : !emailRegex.hasMatch(trimmed)
        ? 'Please enter a valid email address'
        : '';
  }

  void validatePassword(String value) {
    final trimmed = value.trim();
    password.value = trimmed;
    passwordError.value = trimmed.isEmpty
        ? 'Please enter your password'
        : trimmed.length < 6
        ? 'Password must be at least 6 characters'
        : '';
    if (confirmPassword.value.isNotEmpty) {
      validateConfirmPassword(confirmPassword.value);
    }
  }

  void validateConfirmPassword(String value) {
    final trimmed = value.trim();
    confirmPassword.value = trimmed;
    confirmPasswordError.value = trimmed.isEmpty
        ? 'Please re-enter your password'
        : trimmed != password.value
        ? 'Passwords do not match'
        : '';
  }

  void validateTerms(bool value) {
    agreeToTerms.value = value;
    termsError.value = value ? '' : 'You must agree to the Terms and Conditions';
  }

  bool isFormValid() {
    validateFullName(fullName.value);
    validateEmail(email.value);
    validatePassword(password.value);
    validateConfirmPassword(confirmPassword.value);
    validateTerms(agreeToTerms.value);

    return fullNameError.value.isEmpty &&
        emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty &&
        termsError.value.isEmpty &&
        fullName.value.isNotEmpty &&
        email.value.isNotEmpty &&
        password.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        agreeToTerms.value;
  }

  // === API CALL: DIRECTLY CALLS ApiService ===
  Future<void> register() async {
    if (!isFormValid()) {
      Get.snackbar(
        'Error',
        'Please fill all fields correctly',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isLoading.value = true;

    try {
      // API CALL HAPPENS HERE — DIRECTLY
      await ApiService.registerUser(
        name: fullName.value,
        email: email.value,
        password: password.value,
      );

      Get.snackbar(
        'Success',
        'Registration successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Pass the email to VerificationScreen for OTP verification
      Get.toNamed('/verification', arguments: {'email': email.value});
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    fullName.value = '';
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
    agreeToTerms.value = false;
    fullNameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    termsError.value = '';
  }
}