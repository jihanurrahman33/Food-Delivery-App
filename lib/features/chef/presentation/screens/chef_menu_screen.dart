import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/chef_controller.dart';

class ChefMenuScreen extends GetView<ChefController> {
  const ChefMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Kitchen Menu Catalog'),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Dish'),
        onPressed: () => Get.toNamed(AppRoutes.chefAddDish),
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
            itemCount: controller.chefDishes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final dish = controller.chefDishes[index];

              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: dish.imageUrl,
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
                            dish.name,
                            style: AppTextStyles.subtitle2(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            CurrencyFormatter.format(dish.price),
                            style: AppTextStyles.subtitle1(color: AppColors.primary)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Prep: ${dish.prepTimeMinutes} mins • ${dish.calories} kcal',
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'In Stock',
                          style: AppTextStyles.caption(color: AppColors.accentGreen)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: true,
                          activeColor: AppColors.accentGreen,
                          onChanged: (val) {
                            AppSnackbar.info(
                              'Inventory Updated',
                              '${dish.name} set to ${val ? "In Stock" : "Sold Out"}',
                              duration: const Duration(seconds: 1),
                            );
                          },
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
