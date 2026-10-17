import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/checkout_controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Checkout'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Address Card
                    _buildSectionTitle('DELIVERY ADDRESS', isDark),
                    const SizedBox(height: 10),
                    Obx(() {
                      final addr = controller.selectedAddress.value;
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDark ? [] : AppColors.cardShadow,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.location_on_rounded,
                                  color: AppColors.primary, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addr?.label ?? 'Address',
                                    style: AppTextStyles.subtitle2(
                                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    addr?.fullAddress ?? 'Select delivery address',
                                    style: AppTextStyles.bodySmall(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.addresses),
                              child: Text(
                                'Change',
                                style: AppTextStyles.subtitle2(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // Delivery Schedule Options
                    _buildSectionTitle('DELIVERY TIME', isDark),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: _buildScheduleOption(
                              title: 'Deliver Now',
                              subtitle: '25-35 min',
                              isSelected: controller.isDeliverNow.value,
                              onTap: () => controller.isDeliverNow.value = true,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildScheduleOption(
                              title: 'Schedule',
                              subtitle: controller.scheduledTime.value,
                              isSelected: !controller.isDeliverNow.value,
                              onTap: () => controller.isDeliverNow.value = false,
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Method Card
                    _buildSectionTitle('PAYMENT METHOD', isDark),
                    const SizedBox(height: 10),
                    Obx(() {
                      final card = controller.selectedPaymentCard.value;
                      final type = controller.selectedPaymentMethodType.value;

                      String title = 'Cash on Delivery';
                      IconData icon = Icons.money_rounded;
                      if (type == 'card' && card != null) {
                        title = '${card.brand} ${card.cardNumber}';
                        icon = Icons.credit_card_rounded;
                      } else if (type == 'paypal') {
                        title = 'PayPal Account';
                        icon = Icons.account_balance_wallet_rounded;
                      } else if (type == 'applepay') {
                        title = 'Apple Pay';
                        icon = Icons.apple;
                      }

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDark ? [] : AppColors.cardShadow,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(icon, color: AppColors.primary, size: 22),
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
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.paymentMethods),
                              child: Text(
                                'Change',
                                style: AppTextStyles.subtitle2(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // Notes for courier
                    _buildSectionTitle('DRIVER INSTRUCTIONS (OPTIONAL)', isDark),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.driverNotesController,
                      maxLines: 2,
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                      ),
                      decoration: InputDecoration(
                        hintText: 'e.g. Ring the bell, leave at front door...',
                        filled: true,
                        fillColor: isDark ? AppColors.inputDark : AppColors.inputLight,
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Items Overview
                    _buildSectionTitle('ORDER ITEMS (${controller.cartController.totalItemCount})', isDark),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isDark ? [] : AppColors.cardShadow,
                      ),
                      child: Column(
                        children: controller.cartController.items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                Text(
                                  '${item.quantity}x',
                                  style: AppTextStyles.subtitle2(color: AppColors.primary),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.foodItem.name,
                                    style: AppTextStyles.bodyMedium(
                                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                ),
                                Text(
                                  CurrencyFormatter.format(item.totalPrice),
                                  style: AppTextStyles.subtitle2(
                                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Place Order Action
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Obx(
                () => CustomButton(
                  text: 'PLACE ORDER • ${CurrencyFormatter.format(controller.cartController.total)}',
                  isLoading: controller.isPlacingOrder.value,
                  onPressed: controller.placeOrder,
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

  Widget _buildScheduleOption({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.6)
              : (isDark ? AppColors.cardDark : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.subtitle2(
                color: isSelected ? AppColors.primary : (isDark ? Colors.white : AppColors.textPrimaryLight),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTextStyles.caption(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
