import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';
import '../../../cart_checkout/presentation/controllers/cart_controller.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();

    final vouchers = [
      {
        'title': '50% OFF Your First Order',
        'code': 'WELCOME50',
        'discount': '50% OFF',
        'minSpend': '\$20.00 min spend',
        'validity': 'Valid until 31 Dec 2026',
        'color': AppColors.primary,
      },
      {
        'title': '20% OFF Delicious Meals',
        'code': 'SAVE20',
        'discount': '20% OFF',
        'minSpend': '\$15.00 min spend',
        'validity': 'Valid for next 5 orders',
        'color': AppColors.accentGreen,
      },
      {
        'title': 'Free Delivery Pass',
        'code': 'FREEDEL',
        'discount': 'FREE DEL',
        'minSpend': 'No minimum spend',
        'validity': 'Valid this weekend',
        'color': AppColors.accentBlue,
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Offers & Vouchers'),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: vouchers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final voucher = vouchers[index];
            final color = voucher['color'] as Color;

            return Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isDark ? [] : AppColors.cardShadow,
                border: Border.all(color: color.withOpacity(0.3), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          voucher['discount'] as String,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        voucher['validity'] as String,
                        style: AppTextStyles.caption(
                          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    voucher['title'] as String,
                    style: AppTextStyles.subtitle1(
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    voucher['minSpend'] as String,
                    style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.inputDark : AppColors.inputLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            voucher['code'] as String,
                            style: AppTextStyles.subtitle2(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ).copyWith(letterSpacing: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          final code = voucher['code'] as String;
                          Clipboard.setData(ClipboardData(text: code));
                          cartController.applyPromo(code);
                          Get.toNamed(AppRoutes.cart);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: const Text('Apply in Cart'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
