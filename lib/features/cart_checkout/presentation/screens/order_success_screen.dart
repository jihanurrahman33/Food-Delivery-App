import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../../../orders_tracking/domain/entities/order_entity.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderEntity?;
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
              // Animated Success Checkmark Graphic
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGreen.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .then()
                  .shimmer(duration: 1000.ms),
              const SizedBox(height: 36),

              Text(
                'Congratulations!',
                style: AppTextStyles.heading2(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You placed the order successfully',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 20),

              // Order ID badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.inputDark : AppColors.inputLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Order ID: #${order?.id ?? 'FD-98421'}',
                  style: AppTextStyles.subtitle2(color: AppColors.primary),
                ),
              ),
              const Spacer(),

              // Track Order button
              CustomButton(
                text: 'TRACK ORDER',
                onPressed: () {
                  Get.offNamed(AppRoutes.orderTracking, arguments: order);
                },
              ),
              const SizedBox(height: 14),

              // Back to Home
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.mainNav);
                },
                child: Text(
                  'BACK TO HOME',
                  style: AppTextStyles.subtitle2(
                    color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                  ),
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
