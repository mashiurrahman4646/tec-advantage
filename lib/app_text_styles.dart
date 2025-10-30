import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Onboarding Title Style
  // font-family: Inter; font-weight: 700; font-size: 20px; line-height: 120%; text-align: center; color: #000000
  static TextStyle onboardingTitle = GoogleFonts.inter(
    fontWeight: FontWeight.w700, // Bold
    fontSize: 20,
    height: 1.2, // 120% line height
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // Onboarding Description Style
  // font-family: Inter; font-weight: 500; font-size: 14px; line-height: 150%; text-align: center; color: #000000
  static TextStyle onboardingDescription = GoogleFonts.inter(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 14,
    height: 1.5, // 150% line height
    letterSpacing: 0,
    color: AppColors.textSecondary,
  );

  // Status bar text style
  static TextStyle statusBar = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  // Button text styles
  static TextStyle buttonText = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.white, // Changed to white for buttons
  );

  // Skip button text style
  static TextStyle skipButtonText = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.grey,
  );

  // App bar title style
  static TextStyle appBarTitle = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  // Large heading style
  static TextStyle heading1 = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  // Medium heading style
  static TextStyle heading2 = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  // Body text style
  static TextStyle bodyText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // Caption text style
  static TextStyle caption = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.3,
    color: AppColors.grey,
  );

  // Additional text styles for specific use cases
  static TextStyle hintText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.grey,
  );

  static TextStyle errorText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.error,
  );

  static TextStyle successText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.success,
  );

  static TextStyle linkText = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}