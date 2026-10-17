import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../routes/app_routes.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authController = Get.find<AuthController>();
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Personal Profile',
          style: AppTextStyles.subtitle1(
            color: isDark ? Colors.white : AppColors.textPrimaryLight,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // User Card Header
              Obx(() {
                final user = controller.currentUser.value ?? authController.currentUser;
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: user?.avatarUrl != null
                            ? CachedNetworkImageProvider(user!.avatarUrl!)
                            : null,
                        child: user?.avatarUrl == null
                            ? const Icon(Icons.person, size: 36)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Jihanur Rahman',
                              style: AppTextStyles.heading3(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'jihanurrahman33@gmail.com',
                              style: AppTextStyles.caption(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '👑 Foodie Gold Member',
                                style: AppTextStyles.caption(color: AppColors.primary)
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                        onPressed: () => Get.toNamed(AppRoutes.editProfile),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Mode / Role Switcher Banner (Customer vs Chef vs Rider)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'APP EXPERIENCE MODE',
                      style: AppTextStyles.caption().copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: _buildRoleButton(
                              label: 'Customer',
                              icon: Icons.person_rounded,
                              role: 'customer',
                              isSelected: controller.activeRole.value == 'customer',
                              onTap: () => controller.switchRole('customer'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildRoleButton(
                              label: 'Chef',
                              icon: Icons.restaurant_rounded,
                              role: 'chef',
                              isSelected: controller.activeRole.value == 'chef',
                              onTap: () {
                                controller.switchRole('chef');
                                Get.toNamed(AppRoutes.chefDashboard);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildRoleButton(
                              label: 'Rider',
                              icon: Icons.two_wheeler_rounded,
                              role: 'rider',
                              isSelected: controller.activeRole.value == 'rider',
                              onTap: () {
                                controller.switchRole('rider');
                                Get.toNamed(AppRoutes.riderOrders);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu Links
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'Favorite Picks',
                      onTap: () => Get.toNamed(AppRoutes.favorites),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery Addresses',
                      onTap: () => Get.toNamed(AppRoutes.addresses),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.credit_card_rounded,
                      title: 'Payment Methods',
                      onTap: () => Get.toNamed(AppRoutes.paymentMethods),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.local_offer_outlined,
                      title: 'Offers & Vouchers',
                      onTap: () => Get.toNamed(AppRoutes.offers),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () => Get.toNamed(AppRoutes.notifications),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & FAQ Support',
                      onTap: () => Get.toNamed(AppRoutes.helpSupport),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.grid_view_rounded,
                      title: 'Explore All 52 Screens',
                      subtitle: 'Master community gallery',
                      onTap: () => Get.toNamed(AppRoutes.screenCatalog),
                      isDark: isDark,
                    ),
                    _buildMenuItem(
                      icon: Icons.wifi_off_rounded,
                      title: 'System States (Offline & Maintenance)',
                      onTap: () => Get.toNamed(AppRoutes.systemStates),
                      isDark: isDark,
                    ),
                    // Dark Mode Toggle Tile
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Dark Theme Mode',
                              style: AppTextStyles.subtitle2(
                                color: isDark ? Colors.white : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          Obx(
                            () => Switch(
                              value: settingsController.isDarkMode.value,
                              activeColor: AppColors.primary,
                              onChanged: settingsController.toggleDarkMode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Log out button
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                  ),
                  title: Text(
                    'Log Out',
                    style: AppTextStyles.subtitle2(color: AppColors.error),
                  ),
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Log Out',
                      middleText: 'Are you sure you want to log out of your account?',
                      textConfirm: 'Log Out',
                      textCancel: 'Cancel',
                      confirmTextColor: Colors.white,
                      buttonColor: AppColors.error,
                      onConfirm: authController.logout,
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required String label,
    required IconData icon,
    required String role,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : AppColors.primary, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: AppTextStyles.subtitle2(
          color: isDark ? Colors.white : AppColors.textPrimaryLight,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTextStyles.caption(
                color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
              ),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}
