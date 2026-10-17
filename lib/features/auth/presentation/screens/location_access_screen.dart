import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Map Pin Graphic
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(isDark ? 0.15 : 0.7),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              Text(
                'Find restaurants near you',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please allow location access to discover open kitchens, nearby restaurants, and get accurate delivery estimates.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const Spacer(),

              // Access location button
              CustomButton(
                text: AppStrings.accessLocation,
                icon: const Icon(Icons.my_location_rounded, color: Colors.white, size: 20),
                onPressed: () {
                  Get.offAllNamed(AppRoutes.mainNav);
                },
              ),
              const SizedBox(height: 16),

              // Manual entry option
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.mainNav);
                },
                child: Text(
                  'ENTER LOCATION MANUALLY',
                  style: AppTextStyles.subtitle2(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
