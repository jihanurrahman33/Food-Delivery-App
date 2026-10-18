import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/chef_controller.dart';

class ChefDashboardScreen extends GetView<ChefController> {
  const ChefDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'Chef Kitchen Studio',
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book_rounded),
            tooltip: 'Menu Management',
            onPressed: () => Get.toNamed(AppRoutes.chefMenu),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kitchen Open/Close Status Card
              Obx(() {
                final isOpen = controller.isKitchenOpen.value;
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                    border: Border.all(
                      color: isOpen ? AppColors.accentGreen : AppColors.error,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (isOpen ? AppColors.accentGreen : AppColors.error)
                              .withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isOpen ? Icons.door_front_door : Icons.door_back_door,
                          color: isOpen ? AppColors.accentGreen : AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isOpen ? 'Kitchen is OPEN' : 'Kitchen is CLOSED',
                              style: AppTextStyles.subtitle1(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              isOpen ? 'Accepting new customer orders' : 'Paused orders',
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
                        value: isOpen,
                        activeColor: AppColors.accentGreen,
                        onChanged: controller.toggleKitchenStatus,
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Overview Metrics 2x2 Grid
              Obx(
                () => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.3,
                  children: [
                    _buildMetricCard(
                      title: 'Today Sales',
                      value: CurrencyFormatter.format(controller.todaySales.value),
                      icon: Icons.payments_outlined,
                      color: AppColors.accentGreen,
                      isDark: isDark,
                      onTap: () => Get.toNamed(AppRoutes.chefEarnings),
                    ),
                    _buildMetricCard(
                      title: 'Orders Today',
                      value: '${controller.todayOrdersCount.value}',
                      icon: Icons.receipt_long_outlined,
                      color: AppColors.primary,
                      isDark: isDark,
                      onTap: () => Get.toNamed(AppRoutes.chefOrders),
                    ),
                    _buildMetricCard(
                      title: 'Pending Tickets',
                      value: '${controller.kitchenOrders.length}',
                      icon: Icons.pending_actions_rounded,
                      color: AppColors.warning,
                      isDark: isDark,
                      onTap: () => Get.toNamed(AppRoutes.chefOrders),
                    ),
                    _buildMetricCard(
                      title: 'Kitchen Rating',
                      value: '${controller.chefRating.value} ★',
                      icon: Icons.star_outline_rounded,
                      color: AppColors.accentYellow,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Quick Action Navigation Cards
              Text(
                'Kitchen Operations',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 14),

              _buildOperationTile(
                icon: Icons.restaurant_menu_rounded,
                title: 'Manage Kitchen Menu',
                subtitle: 'Toggle in-stock items, adjust dish pricing',
                onTap: () => Get.toNamed(AppRoutes.chefMenu),
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildOperationTile(
                icon: Icons.add_circle_outline_rounded,
                title: 'Add New Food Item',
                subtitle: 'Publish new specialty dishes to your menu',
                onTap: () => Get.toNamed(AppRoutes.chefAddDish),
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildOperationTile(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Earnings & Bank Payouts',
                subtitle: 'Withdraw accumulated kitchen earnings',
                onTap: () => Get.toNamed(AppRoutes.chefEarnings),
                isDark: isDark,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isDark ? [] : AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption(
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                  ),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            Text(
              value,
              style: AppTextStyles.heading2(
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark ? [] : AppColors.cardShadow,
      ),
      child: Material(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: AppTextStyles.subtitle2(
            color: isDark ? Colors.white : AppColors.textPrimaryLight,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.caption(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        onTap: onTap,
      ),
    ),
  );
}
}
