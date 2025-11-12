import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;


import 'package:business_onboarding_app/success_path_assessment/success_path_assessment.dart';
import 'package:business_onboarding_app/success_path_assessment/sucess_path_assessment_controller.dart';
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
import 'signup/RegisterScreen .dart';
import 'signupemailverification/emailverification_ui.dart';
import 'signupemailverification/RegistrationSuccessScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // শুধু Firebase চালু করা
  try {
    if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAxNEz5IqWVf3mFJ5ejrF9ysSF1nhwrQrU',
          appId: '1:127639352924:ios:79deb98a4d79a77b2a5899',
          messagingSenderId: '127639352924',
          projectId: 'tec-advantage',
          iosBundleId: 'com.erc.tecadvantage',
          storageBucket: 'tec-advantage.firebasestorage.app',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    // সহায়ক লগ
    debugPrint('Firebase init error: $e');
    rethrow;
  }

  // iOS এর জন্য Permission (একবারই চাই)
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

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
        GetPage(name: '/onboarding', page: () => OnboardingScreen(), transition: Transition.fade),
        GetPage(name: '/login', page: () => LoginScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/register', page: () => RegisterScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/verification', page: () => VerificationScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/registration-success', page: () => RegistrationSuccessScreen(), transition: Transition.fade),
        GetPage(name: '/forgot-password', page: () => ForgetEmailVerify(), transition: Transition.rightToLeft),
        GetPage(name: '/forgot-password-otp', page: () => ForgetPasswordOtpScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/reset-password', page: () => ResetPasswordScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/home', page: () => HomePage(), transition: Transition.fade),
        GetPage(
          name: '/success-path-selection',
          page: () => SuccessPathSelectionScreen(),
          transition: Transition.rightToLeft,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => SuccessPathSelectionController());
          }),
        ),
        GetPage(name: '/small-business-assessment', page: () => SmallBusinessAssessmentScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/small-business-results', page: () => SmallBusinessResultsScreen(resultType: Get.arguments['type'] ?? 'basics'), transition: Transition.rightToLeft),
        GetPage(name: '/aspiring-entrepreneur-assessment', page: () => AspiringEntrepreneurAssessmentScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/aspiring-entrepreneur-results', page: () => AspiringEntrepreneurResultsScreen(resultType: Get.arguments['type'] ?? 'explorer'), transition: Transition.rightToLeft),
        GetPage(name: '/tech-career-assessment', page: () => TechCareerAssessmentScreen(), transition: Transition.rightToLeft),
        GetPage(name: '/tech-career-results', page: () => TechCareerResultsScreen(resultType: Get.arguments['type'] ?? 'beginner'), transition: Transition.rightToLeft),
      ],
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
