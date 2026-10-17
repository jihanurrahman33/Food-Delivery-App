import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/cart_controller.dart';
import 'empty_cart_screen.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.items.isEmpty) {
        return const EmptyCartScreen();
      }

      return Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        appBar: CustomAppBar(
          title: 'My Cart (${controller.totalItemCount})',
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
              onPressed: () {
                Get.defaultDialog(
                  title: 'Clear Basket?',
                  middleText: 'Are you sure you want to remove all items from your cart?',
                  textConfirm: 'Clear',
                  textCancel: 'Cancel',
                  confirmTextColor: Colors.white,
                  buttonColor: AppColors.error,
                  onConfirm: () {
                    controller.clearCart();
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(isDark ? 0.15 : 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.storefront_rounded,
                                color: AppColors.primary, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                controller.currentRestaurantName.value,
                                style: AppTextStyles.subtitle2(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Cart Items List
                      ...controller.items.map((cartItem) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.cardDark : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isDark ? [] : AppColors.cardShadow,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: cartItem.foodItem.imageUrl,
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.foodItem.name,
                                      style: AppTextStyles.subtitle2(
                                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                      ),
                                    ),
                                    if (cartItem.selectedAddons.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        '+ ${cartItem.selectedAddons.map((a) => a.name).join(', ')}',
                                        style: AppTextStyles.caption(
                                          color: isDark
                                              ? AppColors.textTertiaryDark
                                              : AppColors.textTertiaryLight,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Text(
                                      CurrencyFormatter.format(cartItem.totalPrice),
                                      style: AppTextStyles.subtitle1(
                                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              // Stepper
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, size: 22),
                                    color: AppColors.primary,
                                    onPressed: () => controller.decrementQuantity(cartItem.id),
                                  ),
                                  Text(
                                    '${cartItem.quantity}',
                                    style: AppTextStyles.subtitle2(
                                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle, size: 22),
                                    color: AppColors.primary,
                                    onPressed: () => controller.incrementQuantity(cartItem.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),

                      // Promo Code Section
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_offer_outlined,
                                color: AppColors.primary, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: controller.promoTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Promo Code (e.g. SAVE20)',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.transparent,
                                ),
                                style: AppTextStyles.bodyMedium(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.applyPromo(controller.promoTextController.text);
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Price Summary Breakdown
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: isDark ? [] : AppColors.cardShadow,
                        ),
                        child: Column(
                          children: [
                            _buildSummaryRow(
                              'Subtotal',
                              CurrencyFormatter.format(controller.subtotal),
                              isDark: isDark,
                            ),
                            const SizedBox(height: 10),
                            _buildSummaryRow(
                              'Delivery Fee',
                              controller.deliveryFee == 0
                                  ? 'FREE'
                                  : CurrencyFormatter.format(controller.deliveryFee),
                              isDark: isDark,
                              color: controller.deliveryFee == 0 ? AppColors.accentGreen : null,
                            ),
                            const SizedBox(height: 10),
                            _buildSummaryRow(
                              'Estimated Tax',
                              CurrencyFormatter.format(controller.tax),
                              isDark: isDark,
                            ),
                            if (controller.discountAmount > 0) ...[
                              const SizedBox(height: 10),
                              _buildSummaryRow(
                                'Coupon Discount',
                                '-${CurrencyFormatter.format(controller.discountAmount)}',
                                isDark: isDark,
                                color: AppColors.accentGreen,
                              ),
                            ],
                            const Divider(height: 24),
                            _buildSummaryRow(
                              'Total Amount',
                              CurrencyFormatter.format(controller.total),
                              isDark: isDark,
                              isBold: true,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100), // spacing for checkout button
                    ],
                  ),
                ),
              ),

              // Bottom Checkout Action
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
                child: CustomButton(
                  text: 'PROCEED TO CHECKOUT • ${CurrencyFormatter.format(controller.total)}',
                  onPressed: () => Get.toNamed(AppRoutes.checkout),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    required bool isDark,
    bool isBold = false,
    double fontSize = 14,
    Color? color,
  }) {
    final defaultTextColor = isDark ? Colors.white : AppColors.textPrimaryLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: color ?? (isBold ? defaultTextColor : defaultTextColor),
          ),
        ),
      ],
    );
  }
}
