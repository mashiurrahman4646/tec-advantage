// File: lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';
import 'onbording_controller.dart';


class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            _buildStatusBar(),

            // Main Content
            Expanded(
              child: Obx(() => _buildOnboardingContent()),
            ),

            // Bottom Navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // Build status bar widget
  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: AppTextStyles.statusBar,
          ),
          // Status bar icons
          Row(
            children: [
              Icon(
                Icons.signal_cellular_4_bar,
                size: 16,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.wifi,
                size: 16,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.battery_full,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build main onboarding content
  Widget _buildOnboardingContent() {
    final currentData = controller.currentOnboardingData;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Image Container
          Expanded(
            flex: 3,
            child: _buildImageContainer(currentData),
          ),

          SizedBox(height: 40),

          // Title and Description
          Expanded(
            flex: 2,
            child: _buildTextContent(currentData),
          ),
        ],
      ),
    );
  }

  // Build image container widget
  Widget _buildImageContainer(currentData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          currentData.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildImagePlaceholder(currentData);
          },
        ),
      ),
    );
  }

  // Build image placeholder when image fails to load
  Widget _buildImagePlaceholder(currentData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForPage(controller.currentPage.value),
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              currentData.image.split('/').last,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build text content (title and description)
  Widget _buildTextContent(currentData) {
    return Column(
      children: [
        // Title
        Text(
          currentData.title,
          style: AppTextStyles.onboardingTitle,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16),

        // Description
        Text(
          currentData.description,
          style: AppTextStyles.onboardingDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Build bottom navigation widget
  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button
          _buildSkipButton(),

          // Page Indicators
          _buildPageIndicators(),

          // Continue/Get Started Button
          _buildContinueButton(),
        ],
      ),
    );
  }

  // Build skip button
  Widget _buildSkipButton() {
    return TextButton(
      onPressed: controller.skipOnboarding,
      child: Text(
        'Skip',
        style: AppTextStyles.skipButtonText,
      ),
    );
  }

  // Build page indicators
  Widget _buildPageIndicators() {
    return Obx(() => Row(
      children: List.generate(
        controller.totalPages,
            (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: controller.currentPage.value == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: controller.currentPage.value == index
                ? AppColors.textPrimary
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ));
  }

  // Build continue/get started button
  Widget _buildContinueButton() {
    return Obx(() => TextButton(
      onPressed: controller.nextPage,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.isLastPage ? 'Get Started' : 'Continue',
            style: AppTextStyles.buttonText,
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    ));
  }

  // Get icon for current page
  IconData _getIconForPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return Icons.trending_up;
      case 1:
        return Icons.business_center;
      case 2:
        return Icons.rocket_launch;
      default:
        return Icons.business;
    }
  }
}