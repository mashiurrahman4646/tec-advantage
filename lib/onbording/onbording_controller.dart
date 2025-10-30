// File: lib/controllers/onboarding_controller.dart
import 'package:get/get.dart';

import 'onbording_model.dart';


class OnboardingController extends GetxController {
  // Observable current page index
  var currentPage = 0.obs;

  // List of onboarding data
  // File: lib/onbording/onbording_controller.dart
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/images/onbording1.png', // Changed from onboarding1.png
      title: 'Set Your Business Goals',

      description: 'Every business is unique-your solution should reflect that. Rather than settling for generic, out-of-the-box software that only scratches the surface, we design customized solutions built to grow with you. Our tailored approach ensures your business scales efficiently, effectively, and on your terms.',
    ),
    OnboardingModel(
      image: 'assets/images/onbording2.png', // Changed from onboarding2.png
      title: 'Small Business Solutions',
      description: 'Identify your strengths and map out the path to achieve your entrepreneurial dreams.',

    ),
    OnboardingModel(
      image: 'assets/images/onbording3.png', // Changed from onboarding3.png
      title: 'Become a Successful Entrepreneur',
      description: 'Turn your vision into reality with the right guidance, practice, and confidence.',
    ),
  ];

  // Navigate to next page or login if on last page
  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
    } else {
      // Navigate to login screen on last page continue
      goToLogin();
    }
  }

  // Skip onboarding and go to login
  void skipOnboarding() {
    // Navigate to login screen when skip is pressed from any page
    goToLogin();
  }

  // Navigate to login screen
  void goToLogin() {
    // Navigate to login screen and remove all previous routes
    Get.offAllNamed('/login');
  }

  // Navigate to previous page
  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  // Get current onboarding data
  OnboardingModel get currentOnboardingData => onboardingPages[currentPage.value];

  // Check if current page is last page
  bool get isLastPage => currentPage.value == onboardingPages.length - 1;

  // Get total pages count
  int get totalPages => onboardingPages.length;

  // Reset to first page (optional method for future use)
  void resetToFirstPage() {
    currentPage.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any data if needed
  }

  @override
  void onClose() {
    super.onClose();
    // Clean up resources if needed
  }
}