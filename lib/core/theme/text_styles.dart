import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1({Color? color}) => GoogleFonts.sen(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle heading2({Color? color}) => GoogleFonts.sen(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle heading3({Color? color}) => GoogleFonts.sen(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle subtitle1({Color? color}) => GoogleFonts.sen(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle subtitle2({Color? color}) => GoogleFonts.sen(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color ?? AppColors.textSecondaryLight,
      );

  static TextStyle bodyLarge({Color? color}) => GoogleFonts.sen(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color ?? AppColors.textPrimaryLight,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.sen(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.textSecondaryLight,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.sen(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.textTertiaryLight,
      );

  static TextStyle button({Color? color}) => GoogleFonts.sen(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: color ?? Colors.white,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.sen(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textTertiaryLight,
      );
}
