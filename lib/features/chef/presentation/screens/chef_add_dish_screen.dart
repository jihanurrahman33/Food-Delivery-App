import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/chef_controller.dart';

class ChefAddDishScreen extends GetView<ChefController> {
  const ChefAddDishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(title: 'Add New Food Item'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload Photo Box
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.inputDark : AppColors.inputLight,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isDark ? AppColors.borderDark : AppColors.borderLight,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_upload_outlined,
                                color: AppColors.primary, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              'Upload Dish Photography',
                              style: AppTextStyles.subtitle2(color: AppColors.primary),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'PNG, JPG up to 10MB',
                              style: AppTextStyles.caption(
                                color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Dish Name
                      CustomTextField(
                        label: 'DISH NAME',
                        hintText: 'e.g. Truffle Bacon Smash Burger',
                        controller: controller.dishNameController,
                      ),
                      const SizedBox(height: 18),

                      // Price
                      CustomTextField(
                        label: 'PRICE (\$)',
                        hintText: 'e.g. 12.99',
                        controller: controller.dishPriceController,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.attach_money_rounded, color: AppColors.primary),
                      ),
                      const SizedBox(height: 18),

                      // Prep Time & Calories Row
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'PREP TIME (MINS)',
                              hintText: '15',
                              controller: controller.dishPrepTimeController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: 'CALORIES (KCAL)',
                              hintText: '500',
                              controller: controller.dishCaloriesController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Description
                      CustomTextField(
                        label: 'DESCRIPTION & INGREDIENTS',
                        hintText: 'Describe the ingredients, seasoning, and allergy warnings...',
                        controller: controller.dishDescriptionController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              CustomButton(
                text: 'PUBLISH DISH TO MENU',
                onPressed: controller.addNewDish,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
