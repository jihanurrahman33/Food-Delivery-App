import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/mock_data_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/order_entity.dart';

class OrderReceiptScreen extends StatelessWidget {
  const OrderReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderEntity? ?? MockDataService.activeOrder;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'Order Invoice',
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              Get.snackbar('Receipt Shared', 'PDF Invoice exported successfully');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Receipt Container styled like a modern invoice receipt
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand & Order ID
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.receipt_rounded,
                                color: Colors.white, size: 28),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            order.restaurantName,
                            style: AppTextStyles.heading3(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Order #${order.id}',
                            style: AppTextStyles.subtitle2(color: AppColors.primary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')} • ${order.createdAt.hour}:${order.createdAt.minute.toString().padLeft(2, '0')}',
                            style: AppTextStyles.caption(
                              color: isDark
                                  ? AppColors.textTertiaryDark
                                  : AppColors.textTertiaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 36),

                    // Destination info
                    _buildMetaRow('Delivered To:', order.deliveryAddress, isDark),
                    const SizedBox(height: 8),
                    _buildMetaRow('Payment Method:', order.paymentMethod, isDark),
                    const Divider(height: 36),

                    // Itemized list
                    Text(
                      'ITEMS ORDERED',
                      style: AppTextStyles.caption().copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.quantity}x',
                              style: AppTextStyles.subtitle2(color: AppColors.primary),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.foodItem.name,
                                    style: AppTextStyles.bodyMedium(
                                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  if (item.selectedAddons.isNotEmpty)
                                    Text(
                                      '+ ${item.selectedAddons.map((a) => a.name).join(', ')}',
                                      style: AppTextStyles.caption(
                                        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                                      ),
                                    ),
                                ],
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
                    }),
                    const Divider(height: 36),

                    // Financial Summary
                    _buildFeeRow('Subtotal', CurrencyFormatter.format(order.subtotal), isDark),
                    const SizedBox(height: 8),
                    _buildFeeRow('Delivery Fee', CurrencyFormatter.format(order.deliveryFee), isDark),
                    const SizedBox(height: 8),
                    _buildFeeRow('Estimated Tax', CurrencyFormatter.format(order.tax), isDark),
                    if (order.discount > 0) ...[
                      const SizedBox(height: 8),
                      _buildFeeRow('Promo Discount', '-${CurrencyFormatter.format(order.discount)}',
                          isDark, color: AppColors.accentGreen),
                    ],
                    const Divider(height: 28),
                    _buildFeeRow(
                      'Total Paid',
                      CurrencyFormatter.format(order.total),
                      isDark,
                      isBold: true,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              CustomButton(
                text: 'DOWNLOAD RECEIPT (PDF)',
                icon: const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                onPressed: () {
                  Get.snackbar('Downloaded', 'Invoice saved to your downloads');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: AppTextStyles.caption(
              color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodySmall(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildFeeRow(
    String label,
    String value,
    bool isDark, {
    bool isBold = false,
    double fontSize = 14,
    Color? color,
  }) {
    final textCol = isDark ? Colors.white : AppColors.textPrimaryLight;

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
            color: color ?? textCol,
          ),
        ),
      ],
    );
  }
}
