import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../controllers/profile_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'App Settings'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification Settings
              _buildSectionTitle('NOTIFICATIONS', isDark),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => SwitchListTile(
                        title: Text(
                          'Push Notifications',
                          style: AppTextStyles.subtitle2(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        subtitle: Text(
                          'Receive real-time courier and order updates',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        activeColor: AppColors.primary,
                        value: controller.pushNotifications.value,
                        onChanged: controller.togglePush,
                      ),
                    ),
                    const Divider(height: 1),
                    Obx(
                      () => SwitchListTile(
                        title: Text(
                          'Promotional Offers',
                          style: AppTextStyles.subtitle2(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        subtitle: Text(
                          'Special discounts, weekend deals, and vouchers',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        activeColor: AppColors.primary,
                        value: controller.promoNotifications.value,
                        onChanged: controller.togglePromo,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Security & Auth
              _buildSectionTitle('SECURITY', isDark),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Obx(
                  () => SwitchListTile(
                    title: Text(
                      'Biometric / Face ID Login',
                      style: AppTextStyles.subtitle2(
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                      ),
                    ),
                    subtitle: Text(
                      'Faster login with biometric sensors',
                      style: AppTextStyles.caption(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    activeColor: AppColors.primary,
                    value: controller.biometricLogin.value,
                    onChanged: controller.toggleBiometric,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Preferences
              _buildSectionTitle('PREFERENCES', isDark),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language_rounded, color: AppColors.primary),
                      title: Text(
                        'Language',
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                      ),
                      trailing: Obx(
                        () => Text(
                          controller.selectedLanguage.value,
                          style: AppTextStyles.bodyMedium(color: AppColors.primary),
                        ),
                      ),
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Choose Language',
                          content: Column(
                            children: ['English (US)', 'Español', 'Français', 'Bengali'].map((lang) {
                              return ListTile(
                                title: Text(lang),
                                onTap: () {
                                  controller.selectedLanguage.value = lang;
                                  Get.back();
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.attach_money_rounded, color: AppColors.primary),
                      title: Text(
                        'Currency',
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                      ),
                      trailing: Obx(
                        () => Text(
                          controller.selectedCurrency.value,
                          style: AppTextStyles.bodyMedium(color: AppColors.primary),
                        ),
                      ),
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Choose Currency',
                          content: Column(
                            children: ['USD (\$)', 'EUR (€)', 'GBP (£)', 'BDT (৳)'].map((curr) {
                              return ListTile(
                                title: Text(curr),
                                onTap: () {
                                  controller.selectedCurrency.value = curr;
                                  Get.back();
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Center(
                child: Text(
                  'BiteFlow v1.0.0 (Build 52 Figma Editions)',
                  style: AppTextStyles.caption(
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                  ),
                ),
              ),
            ],
          ),
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
}
