import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/controllers/home_controller.dart';

class FilterScreen extends GetView<HomeController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: CustomAppBar(
        title: 'Filter Restaurants',
        actions: [
          TextButton(
            onPressed: controller.resetFilters,
            child: Text(
              'Reset',
              style: AppTextStyles.subtitle2(color: AppColors.error),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sort By
                      Text(
                        'SORT BY',
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Wrap(
                          spacing: 10,
                          children: [
                            'Recommended',
                            'Fast Delivery',
                            'Top Rated',
                          ].map((sortOption) {
                            final isSel = controller.sortBy.value == sortOption;
                            return ChoiceChip(
                              label: Text(sortOption),
                              selected: isSel,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSel ? Colors.white : (isDark ? Colors.white : Colors.black87),
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) => controller.sortBy.value = sortOption,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Minimum Rating
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MINIMUM RATING',
                              style: AppTextStyles.subtitle2(
                                color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                              ),
                            ),
                            Text(
                              '${controller.minRating.value.toStringAsFixed(1)} ★',
                              style: AppTextStyles.subtitle1(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Slider(
                          value: controller.minRating.value,
                          min: 3.0,
                          max: 5.0,
                          divisions: 4,
                          activeColor: AppColors.primary,
                          onChanged: (val) => controller.minRating.value = val,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Max Delivery Fee
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MAX DELIVERY FEE',
                              style: AppTextStyles.subtitle2(
                                color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                              ),
                            ),
                            Text(
                              '\$${controller.maxDeliveryFee.value.toStringAsFixed(2)}',
                              style: AppTextStyles.subtitle1(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Slider(
                          value: controller.maxDeliveryFee.value,
                          min: 0.0,
                          max: 10.0,
                          divisions: 10,
                          activeColor: AppColors.primary,
                          onChanged: (val) => controller.maxDeliveryFee.value = val,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Dietary Preference
                      Text(
                        'DIETARY PREFERENCES',
                        style: AppTextStyles.subtitle2(
                          color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Wrap(
                          spacing: 10,
                          children: ['All', 'Vegetarian', 'Spicy'].map((diet) {
                            final isSel = controller.selectedDietary.value == diet;
                            return ChoiceChip(
                              label: Text(diet),
                              selected: isSel,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSel ? Colors.white : (isDark ? Colors.white : Colors.black87),
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) => controller.selectedDietary.value = diet,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Apply button
              CustomButton(
                text: 'APPLY FILTERS',
                onPressed: controller.applyFilters,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
