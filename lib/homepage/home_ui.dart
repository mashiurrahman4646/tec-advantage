// home_ui.dart
import 'package:business_onboarding_app/business_plan/views/business_overview_screen.dart';
import 'package:business_onboarding_app/success_path_assessment/success_path_assessment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ Business Planning/business planning exm/business planning exm.dart';
import '../Coaching Page/welcome to coaching page/welcome_to_coaching_page.dart';
import '../Community/Community.dart';
import '../Mock Interviews Pages/mock interview quc/mocquc.dart';
import '../Mock Interviews Pages/welcome to mock interview page/welcome_to_mock_interview_page.dart';
import '../Terms & Conditions/Terms & Conditions.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import '../bootcamp/bootcamp welcome/bootcampwelcome.dart';
import '../getnotification/notification.dart';
import '../notification/notification_setting.dart';
// Add this import for notification page
import '../small business exm/small business exm/small business exm.dart';
import '../user_profile/user profile dart.dart';
import '../token_service/token_service.dart';
import '../services/fcm_service.dart';
import '../user_profile/controllers/user_profile_controller.dart';
import '../config_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserProfileController());
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: GetBuilder<UserProfileController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Text('Loading...');
            }
            final userData = controller.userProfileModel?.data;
            final String? imagePath = userData?.image;
            final String imageUrl = imagePath != null
                ? '${ApiConfig.baseUrl.replaceAll('/api/v1', '')}$imagePath'
                : '';

            return Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  onBackgroundImageError: (exception, stackTrace) {},
                  child: imageUrl.isEmpty
                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hi ${userData?.name ?? 'User'}',
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/icons/notification.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                      size: 24,
                    );
                  },
                ),
                onPressed: () {
                  // Navigate to notification page
                  Get.to(() => NotificationPage());
                },
              ),
              // Optional: Add notification badge
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Path Assessment Section with image
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Success Path Assessment',
                          style: AppTextStyles.heading2.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Every success story has a starting point. Take this quick assessment to unlock your personalized roadmap.',
                          style: AppTextStyles.onboardingDescription.copyWith(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'It\'s starts here!',
                          style: AppTextStyles.onboardingDescription.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/success-path-selection');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Let\'s Start',
                              style: AppTextStyles.buttonText.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/YourImage1.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.assessment,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Your Business Toolkit Section
            Text(
              'Your Business Toolkit',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Toolkit List Items
            _buildToolkitListItem(
              iconPath: 'assets/icons/smallbusniess.png',
              title: 'Small Business',
              description:
                  'Tell us about your business and unlock a free personalized assessment with tailored recommendations to help you grow.',
              onTap: () {
                Get.toNamed('/success-path-welcome',
                    arguments: {'slug': 'small-business'});
              },
            ),

            _buildToolkitListItem(
              iconPath: 'assets/icons/businessplanning.png',
              title: 'Business Planning',
              description:
                  'Build your business blueprint—complete our guided template, export to PDF, or request a deeper, customized plan for your goals.',
              onTap: () {
                Get.to(() => BusinessPlanOverviewScreen());
                // Navigate to business planning section
              },
            ),

            _buildToolkitListItem(
              iconPath: 'assets/icons/mockinterview.png',
              title: 'Mock Interviews',
              description:
                  'Practice real interview questions and get instant feedback to sharpen your skills.',
              onTap: () {
                Get.to(() => const MockInterviewWelcomeScreen());
              },
            ),

            _buildToolkitListItem(
              iconPath: 'assets/icons/bootcamp.png',
              title: 'Bootcamp',
              description:
                  'A one-stop boot camp for people looking to get into tech and entrepreneurs. Build your tech knowledge, master business strategies, and grow with every lesson.',
              onTap: () {
                Get.to(() => BootcampWelcomeScreen());
                // Navigate to bootcamp section
              },
            ),

            _buildToolkitListItem(
              iconPath: 'assets/icons/applyforcoaching.png',
              title: 'Apply For Coaching',
              description:
                  'Get matched with a business coach to scale smarter—practice interviews, refine your strategy, and gain confidence to succeed.',
              onTap: () {
                Get.to(() => CoachingWelcomeScreen());
                // Navigate to coaching application
              },
            ),

            _buildToolkitListItem(
              iconPath: 'assets/icons/community.png',
              title: 'Community',
              description:
                  'Join interactive rooms where entrepreneurs connect, share ideas, and support each other on the journey to success.',
              onTap: () {
                Get.to(() => CommunityPage()); // Navigate to community page
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Section
              GetBuilder<UserProfileController>(
                builder: (controller) {
                  final userData = controller.userProfileModel?.data;
                  final String? imagePath = userData?.image;
                  final String imageUrl = imagePath != null
                      ? '${ApiConfig.baseUrl.replaceAll('/api/v1', '')}$imagePath'
                      : '';
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                        onBackgroundImageError: (exception, stackTrace) {},
                        child: imageUrl.isEmpty
                            ? Icon(Icons.person, size: 40, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData?.name ?? 'User Name',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData?.email ?? 'email@example.com',
                        style: AppTextStyles.onboardingDescription.copyWith(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 40),

              // Menu Options
              Expanded(
                child: Column(
                  children: [
                    _buildDrawerOption(
                      icon: Icons.person_outline,
                      title: 'User Profile',
                      description: 'Change profile image, name or password',
                      onTap: () {
                        Navigator.pop(context); // Close drawer first
                        Get.to(() => UserProfilePage()); // Then navigate
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildDrawerOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notification Setting',
                      description: 'Manage your notifications',
                      onTap: () {
                        Navigator.pop(context); // Close drawer first
                        Get.to(
                            () => NotificationSettingsPage()); // Then navigate
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildDrawerOption(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      description: 'Read terms & conditions before use',
                      onTap: () {
                        Navigator.pop(context); // Close drawer first
                        Get.to(() => TermsConditionsPage()); // Then navigate
                      },
                    ),
                  ],
                ),
              ),

              // Logout Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  TokenService.clearToken();
                  Get.offAllNamed('/login');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.grey[700], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: AppTextStyles.buttonText.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolkitListItem({
    required String iconPath,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.business_center,
                      size: 24,
                      color: AppColors.primary,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.onboardingDescription.copyWith(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.grey[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.onboardingDescription.copyWith(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
