import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/checkout_controller.dart';

class AddressListScreen extends GetView<CheckoutController> {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'My Addresses'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final addr = controller.addresses[index];
                    final isSelected = controller.selectedAddress.value?.id == addr.id;

                    return GestureDetector(
                      onTap: () {
                        controller.selectAddress(addr);
                        Get.back();
                      },
                      child: Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark ? AppColors.inputDark : AppColors.inputLight),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                addr.label.toLowerCase() == 'home'
                                    ? Icons.home_rounded
                                    : (addr.label.toLowerCase() == 'office'
                                        ? Icons.work_rounded
                                        : Icons.location_on_rounded),
                                color: isSelected ? Colors.white : AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        addr.label,
                                        style: AppTextStyles.subtitle1(
                                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                        ),
                                      ),
                                      if (addr.isDefault) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryLight,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'Default',
                                            style: AppTextStyles.caption(
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    addr.fullAddress,
                                    style: AppTextStyles.bodyMedium(
                                      color: isDark
                                          ? AppColors.textSecondaryDark
                                          : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                  if (addr.deliveryNotes != null &&
                                      addr.deliveryNotes!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Note: ${addr.deliveryNotes}',
                                      style: AppTextStyles.caption(
                                        color: isDark
                                            ? AppColors.textTertiaryDark
                                            : AppColors.textTertiaryLight,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Radio<String>(
                              value: addr.id,
                              groupValue: controller.selectedAddress.value?.id,
                              activeColor: AppColors.primary,
                              onChanged: (_) {
                                controller.selectAddress(addr);
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  text: 'ADD NEW ADDRESS',
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  onPressed: () => Get.toNamed(AppRoutes.addAddress),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
