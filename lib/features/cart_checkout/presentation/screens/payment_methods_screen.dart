import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/checkout_controller.dart';

class PaymentMethodsScreen extends GetView<CheckoutController> {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Payment Methods'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saved Cards Section
                    _buildSectionTitle('CREDIT & DEBIT CARDS', isDark),
                    const SizedBox(height: 12),
                    Obx(
                      () => Column(
                        children: controller.paymentCards.map((card) {
                          final isSelected = controller
                                      .selectedPaymentMethodType.value ==
                                  'card' &&
                              controller.selectedPaymentCard.value?.id == card.id;

                          return GestureDetector(
                            onTap: () {
                              controller.selectPaymentCard(card);
                              Get.back();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.cardDark : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: isDark ? [] : AppColors.cardShadow,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: card.brand == 'Visa'
                                          ? const Color(0xFF1A1F71).withOpacity(0.1)
                                          : const Color(0xFFEB001B).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.credit_card_rounded,
                                      color: card.brand == 'Visa'
                                          ? const Color(0xFF1A1F71)
                                          : const Color(0xFFEB001B),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${card.brand} ${card.cardNumber}',
                                          style: AppTextStyles.subtitle2(
                                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Expires ${card.expiryDate}',
                                          style: AppTextStyles.caption(
                                            color: isDark
                                                ? AppColors.textSecondaryDark
                                                : AppColors.textSecondaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Radio<bool>(
                                    value: true,
                                    groupValue: isSelected,
                                    activeColor: AppColors.primary,
                                    onChanged: (_) {
                                      controller.selectPaymentCard(card);
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Add Card Button
                    OutlinedButton.icon(
                      onPressed: () => Get.toNamed(AppRoutes.addCard),
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      label: const Text('Add New Card'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // More Payment Options
                    _buildSectionTitle('OTHER PAYMENT METHODS', isDark),
                    const SizedBox(height: 12),
                    _buildMethodTile(
                      type: 'applepay',
                      title: 'Apple Pay',
                      icon: Icons.apple,
                      isDark: isDark,
                    ),
                    _buildMethodTile(
                      type: 'paypal',
                      title: 'PayPal',
                      icon: Icons.account_balance_wallet_rounded,
                      isDark: isDark,
                    ),
                    _buildMethodTile(
                      type: 'cash',
                      title: 'Cash on Delivery',
                      icon: Icons.payments_outlined,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: AppTextStyles.caption().copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),
    );
  }

  Widget _buildMethodTile({
    required String type,
    required String title,
    required IconData icon,
    required bool isDark,
  }) {
    return Obx(() {
      final isSelected = controller.selectedPaymentMethodType.value == type;

      return GestureDetector(
        onTap: () {
          controller.selectPaymentMethod(type);
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDark ? [] : AppColors.cardShadow,
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.subtitle2(
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                activeColor: AppColors.primary,
                onChanged: (_) {
                  controller.selectPaymentMethod(type);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
