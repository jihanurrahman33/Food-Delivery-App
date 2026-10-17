import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/rider_controller.dart';

class RiderOrdersScreen extends GetView<RiderController> {
  const RiderOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'Delivery Courier Hub',
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: 'Earnings & Metrics',
            onPressed: () => Get.toNamed(AppRoutes.riderEarnings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Online / Offline Switch Card
              Obx(() {
                final isOnline = controller.isOnline.value;
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                    border: Border.all(
                      color: isOnline ? AppColors.accentGreen : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (isOnline ? AppColors.accentGreen : Colors.grey)
                              .withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.two_wheeler_rounded,
                          color: isOnline ? AppColors.accentGreen : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isOnline ? 'You are ONLINE' : 'You are OFFLINE',
                              style: AppTextStyles.subtitle1(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              isOnline
                                  ? 'Matching nearby customer orders'
                                  : 'Turn on to start receiving deliveries',
                              style: AppTextStyles.caption(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isOnline,
                        activeColor: AppColors.accentGreen,
                        onChanged: controller.toggleOnlineStatus,
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Metrics Row
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: isDark ? [] : AppColors.cardShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Today Trips', style: AppTextStyles.caption()),
                            const SizedBox(height: 4),
                            Text(
                              '${controller.todayTrips.value} deliveries',
                              style: AppTextStyles.subtitle1(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: isDark ? [] : AppColors.cardShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Today Earnings', style: AppTextStyles.caption()),
                            const SizedBox(height: 4),
                            Text(
                              CurrencyFormatter.format(controller.todayEarnings.value),
                              style: AppTextStyles.subtitle1(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Active Delivery Banner if any
              Obx(() {
                final active = controller.activeDelivery.value;
                if (active == null) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE TRIP IN PROGRESS',
                      style: AppTextStyles.caption().copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.riderNavigation),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.navigation_rounded, color: Colors.white, size: 28),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    active['restaurantName'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    controller.deliveryStep.value,
                                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                );
              }),

              // Available Delivery Requests
              Text(
                'Available Deliveries Nearby',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 14),

              Obx(() {
                if (controller.availableDeliveries.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36.0),
                      child: Text(
                        'Searching for deliveries in your zone...',
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: controller.availableDeliveries.map((delivery) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isDark ? [] : AppColors.cardShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                delivery['restaurantName'] as String,
                                style: AppTextStyles.heading3(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.format((delivery['payout'] as num).toDouble()),
                                style: AppTextStyles.heading3(color: AppColors.accentGreen),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.storefront_outlined, size: 16, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  delivery['pickupAddress'] as String,
                                  style: AppTextStyles.bodySmall(
                                    color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.accentGreen),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  delivery['deliveryAddress'] as String,
                                  style: AppTextStyles.bodySmall(
                                    color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${delivery['distance']} • ${delivery['itemsCount']} items',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.acceptDelivery(delivery),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Accept Delivery'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
