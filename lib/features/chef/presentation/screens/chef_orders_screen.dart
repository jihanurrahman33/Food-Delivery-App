import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/chef_controller.dart';

class ChefOrdersScreen extends GetView<ChefController> {
  const ChefOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Kitchen Order Tickets'),
      body: SafeArea(
        child: Obx(() {
          if (controller.kitchenOrders.isEmpty) {
            return Center(
              child: Text(
                'No pending kitchen orders.',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: controller.kitchenOrders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final order = controller.kitchenOrders[index];
              final status = order['status'] as String;

              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${order['id']}',
                          style: AppTextStyles.subtitle1(color: AppColors.primary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: status == 'Preparing'
                                ? AppColors.primary.withOpacity(0.12)
                                : (status == 'Ready for Pickup'
                                    ? AppColors.accentGreen.withOpacity(0.12)
                                    : AppColors.warning.withOpacity(0.12)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: status == 'Preparing'
                                  ? AppColors.primary
                                  : (status == 'Ready for Pickup'
                                      ? AppColors.accentGreen
                                      : AppColors.warning),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Customer Name & Time
                    Row(
                      children: [
                        Text(
                          order['customerName'] as String,
                          style: AppTextStyles.subtitle2(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${order['time']}',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Ordered Items Checklist
                    ...(order['items'] as List<String>).map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 16, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: AppTextStyles.bodyMedium(
                                  color: isDark ? Colors.white70 : AppColors.textPrimaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    if (order['notes'] != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.inputDark : AppColors.inputLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Note: ${order['notes']}',
                          style: AppTextStyles.caption(
                            color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                    const Divider(height: 24),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          CurrencyFormatter.format((order['total'] as num).toDouble()),
                          style: AppTextStyles.subtitle1(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            if (status == 'Pending') ...[
                              TextButton(
                                onPressed: () => controller.rejectOrder(order['id'] as String),
                                child: Text('Decline', style: AppTextStyles.subtitle2(color: AppColors.error)),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => controller.acceptOrder(order['id'] as String),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Accept & Cook'),
                              ),
                            ] else if (status == 'Preparing') ...[
                              ElevatedButton(
                                onPressed: () => controller.markOrderReady(order['id'] as String),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentGreen,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Mark as Ready'),
                              ),
                            ] else ...[
                              OutlinedButton(
                                onPressed: () => Get.toNamed(AppRoutes.chefOrderDetail, arguments: order),
                                child: const Text('View Ticket'),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
