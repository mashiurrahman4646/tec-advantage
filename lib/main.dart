// main.dart
import 'package:business_onboarding_app/success_path_assessment/success_path_assessment.dart';
import 'package:business_onboarding_app/success_path_assessment/sucess_path_assessment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'AspiringEntrepreneur/AspiringEntrepreneur_recommendation/AspiringEntrepreneur_recommendation_ui.dart';
import 'AspiringEntrepreneur/AspiringEntrepreneur_test/aspiringenterpreneure_test_ui.dart';
import 'LookingtoGetIntoTech/LookingtoGetIntoTech_recommendation/LookingtoGetIntoTech_recommendation_ui.dart';
import 'LookingtoGetIntoTech/LookingtoGetIntoTech_test/LookingtoGetIntoTech_test_ui.dart';
import 'Small Business Owner/SmallBusinessOwner_recommendition/SmallBusinessOwner_recommendation_ui.dart';
import 'Small Business Owner/SmallBusinessOwner_test/SmallBusinessOwner_test_ui.dart';
import 'app_colors.dart';
import 'forgetpassscreen_and_controller/forgetpassemail.dart';
import 'forgetpassscreen_and_controller/forgetpassotp/forget_password_otp_screen.dart';
import 'forgetpassscreen_and_controller/setnewpassword/setnewpassword_ui.dart';
import 'homepage/home_ui.dart';
import 'login/login_ui.dart';
import 'onbording/onbording_ui.dart';
import 'signup/sign_up_ui.dart';
import 'signupemailverification/emailverification_ui.dart';
import 'signupemailverification/RegistrationSuccessScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'T3CH ADVANTAGE',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
      ),
      initialRoute: '/onboarding',
      getPages: [
        GetPage(
          name: '/onboarding',
          page: () => OnboardingScreen(),
          transition: Transition.fade,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/verification',
          page: () => VerificationScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/registration-success',
          page: () => RegistrationSuccessScreen(),
          transition: Transition.fade,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/forgot-password',
          page: () => ForgetEmailVerify(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/forgot-password-otp',
          page: () => ForgetPasswordOtpScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/reset-password',
          page: () => ResetPasswordScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          transition: Transition.fade,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/success-path-selection',
          page: () => SuccessPathSelectionScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => SuccessPathSelectionController());
          }),
        ),
        GetPage(
          name: '/small-business-assessment',
          page: () => SmallBusinessAssessmentScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/small-business-results',
          page: () => SmallBusinessResultsScreen(resultType: Get.arguments['type'] ?? 'basics'),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/aspiring-entrepreneur-assessment',
          page: () => AspiringEntrepreneurAssessmentScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/aspiring-entrepreneur-results',
          page: () => AspiringEntrepreneurResultsScreen(resultType: Get.arguments['type'] ?? 'explorer'),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/tech-career-assessment',
          page: () => TechCareerAssessmentScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
        GetPage(
          name: '/tech-career-results',
          page: () => TechCareerResultsScreen(resultType: Get.arguments['type'] ?? 'beginner'),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 300),
        ),
      ],
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}