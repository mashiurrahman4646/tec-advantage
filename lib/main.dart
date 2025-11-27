import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

import 'package:business_onboarding_app/success_path_assessment/success_path_assessment.dart';
import 'package:business_onboarding_app/success_path_assessment/sucess_path_assessment_controller.dart';
import 'success_path_assessment/success_path_welcome.dart';
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
import 'token_service/token_service.dart';
import 'services/fcm_service.dart';

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background notification: ${message.notification?.title}');
}

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

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Set up foreground message handler
  FirebaseMessaging.onMessage.listen(FcmService.handleForegroundMessage);

  // Set up notification tap handler (when app is in background or terminated)
  FirebaseMessaging.onMessageOpenedApp.listen(FcmService.handleMessageTap);

  // Check if app was opened from a notification (terminated state)
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FcmService.handleMessageTap(initialMessage);
  }

  final bool hasSession = await TokenService.hasToken();
  runApp(MyApp(initialRoute: hasSession ? '/home' : '/onboarding'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({super.key, this.initialRoute = '/onboarding'});
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
      initialRoute: initialRoute,
      getPages: [
        GetPage(
            name: '/onboarding',
            page: () => OnboardingScreen(),
            transition: Transition.fade),
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/register',
            page: () => RegisterScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/verification',
            page: () => VerificationScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/registration-success',
            page: () => RegistrationSuccessScreen(),
            transition: Transition.fade),
        GetPage(
            name: '/forgot-password',
            page: () => ForgetEmailVerify(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/forgot-password-otp',
            page: () => ForgetPasswordOtpScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/reset-password',
            page: () => ResetPasswordScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/home', page: () => HomePage(), transition: Transition.fade),
        GetPage(
          name: '/success-path-selection',
          page: () => SuccessPathSelectionScreen(),
          transition: Transition.rightToLeft,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => SuccessPathSelectionController());
          }),
        ),
        GetPage(
            name: '/success-path-welcome',
            page: () => SuccessPathWelcomeScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/success-path-assessment',
            page: () => SuccessPathAssessmentScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/success-path-results',
            page: () => SuccessPathResultsScreen(),
            transition: Transition.rightToLeft),
      ],
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
