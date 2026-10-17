import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand palette (Warm energetic orange matching Figma)
  static const Color primary = Color(0xFFFF7622);
  static const Color primaryLight = Color(0xFFFFECE5);
  static const Color primaryDark = Color(0xFFE05E0D);
  static const Color primaryGradientStart = Color(0xFFFF7622);
  static const Color primaryGradientEnd = Color(0xFFFF944D);

  // Secondary & Accents
  static const Color secondary = Color(0xFF181C2E);
  static const Color accentYellow = Color(0xFFFFC529);
  static const Color accentGreen = Color(0xFF059C6A);
  static const Color accentRed = Color(0xFFFF334B);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);

  // Backgrounds & Surfaces - Light
  static const Color backgroundLight = Color(0xFFF6F8FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color inputLight = Color(0xFFF0F5FA);

  // Backgrounds & Surfaces - Dark
  static const Color backgroundDark = Color(0xFF121223);
  static const Color surfaceDark = Color(0xFF181C2E);
  static const Color cardDark = Color(0xFF1E2337);
  static const Color inputDark = Color(0xFF242A42);

  // Glassmorphic / Apple Frosted Glass Tokens
  static const Color glassBackgroundLight = Color(0xCCFFFFFF);
  static const Color glassBackgroundDark = Color(0xB3181C2E);
  static const Color glassBorderLight = Color(0x33FFFFFF);
  static const Color glassBorderDark = Color(0x22FFFFFF);

  // Skeleton Shimmer Tokens
  static const Color shimmerBaseLight = Color(0xFFE2E8F0);
  static const Color shimmerHighlightLight = Color(0xFFF8FAFC);
  static const Color shimmerBaseDark = Color(0xFF23283E);
  static const Color shimmerHighlightDark = Color(0xFF333A56);

  // Convenient Aliases
  static const Color textPrimary = textPrimaryLight;
  static const Color textSecondary = textSecondaryLight;
  static const Color textTertiary = textTertiaryLight;

  static const Color darkTextPrimary = textPrimaryDark;
  static const Color darkTextSecondary = textSecondaryDark;
  static const Color darkTextTertiary = textTertiaryDark;

  static const Color darkSurface = surfaceDark;
  static const Color darkCard = cardDark;
  static const Color darkBackground = backgroundDark;

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF181C2E);
  static const Color textSecondaryLight = Color(0xFF646982);
  static const Color textTertiaryLight = Color(0xFFA0A5BA);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFA0A5BA);
  static const Color textTertiaryDark = Color(0xFF646982);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF2C324B);
  static const Color dividerLight = Color(0xFFEEF2F6);
  static const Color dividerDark = Color(0xFF232738);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Snackbar Toast Glass Gradients
  static const Color snackbarSuccess = Color(0xFF059669);
  static const Color snackbarError = Color(0xFFDC2626);
  static const Color snackbarWarning = Color(0xFFD97706);
  static const Color snackbarInfo = Color(0xFF2563EB);

  // Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF969696).withValues(alpha: 0.10),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.32),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get glassShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];
}
