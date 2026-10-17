import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._();

  // Spacing & Paddings
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;

  // Corner Radii
  static const double radius6 = 6.0;
  static const double radius8 = 8.0;
  static const double radius10 = 10.0;
  static const double radius12 = 12.0;
  static const double radius14 = 14.0;
  static const double radius16 = 16.0;
  static const double radius18 = 18.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radius28 = 28.0;
  static const double radiusFull = 999.0;

  // Common Component Sizes
  static const double buttonHeight = 56.0;
  static const double buttonHeightSm = 44.0;
  static const double inputHeight = 56.0;
  static const double iconSm = 16.0;
  static const double iconMd = 22.0;
  static const double iconLg = 28.0;
  static const double iconXl = 36.0;

  // Common Edge Insets
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets modalPadding = EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 28.0);
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration normal = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration shimmer = Duration(milliseconds: 1400);
}

class AppCurves {
  AppCurves._();

  // Apple iOS standard fluid spring & ease curves
  static const Curve iosSpring = Cubic(0.25, 1.0, 0.5, 1.0);
  static const Curve iosEaseOut = Cubic(0.16, 1.0, 0.3, 1.0);
  static const Curve iosEaseInOut = Cubic(0.42, 0.0, 0.58, 1.0);
  static const Curve bounce = Curves.elasticOut;
}
