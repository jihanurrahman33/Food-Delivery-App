import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../theme/text_styles.dart';

enum SnackbarType { success, error, warning, info, cart }

class AppSnackbar {
  AppSnackbar._();

  static void success(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    HapticFeedback.mediumImpact();
    _show(
      title: title,
      message: message,
      type: SnackbarType.success,
      icon: Icons.check_circle_rounded,
      duration: duration,
    );
  }

  static void error(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    HapticFeedback.heavyImpact();
    _show(
      title: title,
      message: message,
      type: SnackbarType.error,
      icon: Icons.error_rounded,
      duration: duration,
    );
  }

  static void warning(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    HapticFeedback.lightImpact();
    _show(
      title: title,
      message: message,
      type: SnackbarType.warning,
      icon: Icons.warning_rounded,
      duration: duration,
    );
  }

  static void info(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    HapticFeedback.selectionClick();
    _show(
      title: title,
      message: message,
      type: SnackbarType.info,
      icon: Icons.info_rounded,
      duration: duration,
    );
  }

  static void cartAdded({
    String? itemName,
    String? foodName,
    double? price,
    VoidCallback? onCheckout,
  }) {
    HapticFeedback.mediumImpact();
    if (Get.context == null) return;
    final isDark = Get.isDarkMode;
    final displayName = foodName ?? itemName ?? 'Item';
    final priceStr = price != null && price > 0 ? ' • \$${price.toStringAsFixed(2)}' : '';

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space12),
      padding: EdgeInsets.zero,
      duration: const Duration(seconds: 3),
      animationDuration: AppDurations.medium,
      forwardAnimationCurve: AppCurves.iosSpring,
      messageText: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radius18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(AppDimens.space14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard.withValues(alpha: 0.88) : Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(AppDimens.radius18),
              border: Border.all(
                color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
                width: 1.2,
              ),
              boxShadow: AppColors.glassShadow,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimens.space10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppDimens.radius12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: AppColors.primary,
                    size: AppDimens.iconMd,
                  ),
                ),
                const SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Added to Basket',
                        style: AppTextStyles.caption(
                          color: AppColors.primary,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.space2),
                      Text(
                        '$displayName$priceStr',
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (onCheckout != null)
                  TextButton(
                    onPressed: onCheckout,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radius10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.space12,
                        vertical: AppDimens.space8,
                      ),
                    ),
                    child: const Text('View Cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _show({
    required String title,
    required String message,
    required SnackbarType type,
    required IconData icon,
    required Duration duration,
  }) {
    if (Get.context == null) return;
    final isDark = Get.isDarkMode;

    Color accentColor;
    switch (type) {
      case SnackbarType.success:
        accentColor = AppColors.success;
        break;
      case SnackbarType.error:
        accentColor = AppColors.error;
        break;
      case SnackbarType.warning:
        accentColor = AppColors.warning;
        break;
      case SnackbarType.info:
      case SnackbarType.cart:
        accentColor = AppColors.info;
        break;
    }

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space12),
      padding: EdgeInsets.zero,
      duration: duration,
      animationDuration: AppDurations.medium,
      forwardAnimationCurve: AppCurves.iosSpring,
      messageText: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radius18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard.withValues(alpha: 0.88) : Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(AppDimens.radius18),
              border: Border.all(
                color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
                width: 1.2,
              ),
              boxShadow: AppColors.glassShadow,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimens.space8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accentColor, size: AppDimens.iconMd),
                ),
                const SizedBox(width: AppDimens.space14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.space2),
                      Text(
                        message,
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
