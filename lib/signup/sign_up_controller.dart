// File: lib/signup/sign_up_controller.dart
import 'package:get/get.dart';
import 'api_service/api_service.dart';

class SignUpController extends GetxController {
  // Form fields
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var agreeToTerms = false.obs;

  // Loading state
  final isLoading = false.obs;

  // Error messages
  var fullNameError = RxString('');
  var emailError = RxString('');
  var passwordError = RxString('');
  var confirmPasswordError = RxString('');
  var termsError = RxString('');

  // Validate full name
  void validateFullName(String value) {
    fullName.value = value;
    if (value.isEmpty) {
      fullNameError.value = 'Please enter your full name';
    } else if (value.length < 3) {
      fullNameError.value = 'Name must be at least 3 characters';
    } else {
      fullNameError.value = '';
    }
  }

  // Validate email
  void validateEmail(String value) {
    email.value = value;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value.isEmpty) {
      emailError.value = 'Please enter your email address';
    } else if (!emailRegex.hasMatch(value)) {
      emailError.value = 'Please enter a valid email address';
    } else {
      emailError.value = '';
    }
  }

  // Validate password
  void validatePassword(String value) {
    password.value = value;
    if (value.isEmpty) {
      passwordError.value = 'Please enter your password';
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = '';
    }

    // Also validate confirm password if it's not empty
    if (confirmPassword.value.isNotEmpty) {
      validateConfirmPassword(confirmPassword.value);
    }
  }

  // Validate confirm password
  void validateConfirmPassword(String value) {
    confirmPassword.value = value;
    if (value.isEmpty) {
      confirmPasswordError.value = 'Please re-enter your password';
    } else if (value != password.value) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  // Validate terms agreement
  void validateTerms(bool value) {
    agreeToTerms.value = value;
    if (!value) {
      termsError.value = 'You must agree to the Terms and Conditions';
    } else {
      termsError.value = '';
    }
  }

  // Check if form is valid
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

  // Reset form
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

  Future<void> register() async {
    if (!isFormValid()) {
      Get.snackbar('Error', 'Please fill all fields correctly');
      return;
    }
    isLoading.value = true;
    try {
      await ApiService.registerUser(
        name: fullName.value,
        email: email.value,
        password: password.value,
      );
      // Navigate to verification with email passed as argument
      Get.toNamed('/verification', arguments: {'email': email.value});
    } catch (e) {
      Get.snackbar('Registration failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}