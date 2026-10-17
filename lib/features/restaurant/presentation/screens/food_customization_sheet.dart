import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../controllers/restaurant_controller.dart';

class FoodCustomizationSheet extends StatelessWidget {
  final FoodItemEntity food;
  final Function(int quantity, List<FoodAddon> addons, String? notes) onAddToCart;

  const FoodCustomizationSheet({
    super.key,
    required this.food,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RestaurantController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Food Title & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  food.name,
                  style: AppTextStyles.heading3(
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              Text(
                CurrencyFormatter.format(food.price),
                style: AppTextStyles.heading3(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            food.description,
            style: AppTextStyles.bodyMedium(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 20),

          // Add-ons list
          if (food.availableAddons.isNotEmpty) ...[
            Text(
              'CHOICE OF ADD-ONS',
              style: AppTextStyles.caption().copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            ...food.availableAddons.map((addon) {
              return Obx(() {
                final isSelected = controller.isAddonSelected(addon);
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    addon.name,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ),
                  ),
                  secondary: Text(
                    '+${CurrencyFormatter.format(addon.price)}',
                    style: AppTextStyles.subtitle2(color: AppColors.primary),
                  ),
                  value: isSelected,
                  activeColor: AppColors.primary,
                  onChanged: (_) => controller.toggleAddon(addon),
                );
              });
            }),
            const SizedBox(height: 12),
          ],

          // Special instructions input
          Text(
            'SPECIAL INSTRUCTIONS',
            style: AppTextStyles.caption().copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.specialInstructionsController,
            maxLines: 2,
            style: AppTextStyles.bodyMedium(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
            decoration: InputDecoration(
              hintText: 'e.g. Extra sauce, no onions, allergies...',
              filled: true,
              fillColor: isDark ? AppColors.inputDark : AppColors.inputLight,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Quantity Stepper & Add Button Row
          Row(
            children: [
              // Stepper
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.inputDark : AppColors.inputLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 20),
                      onPressed: controller.decrementCustomizationQuantity,
                    ),
                    Obx(
                      () => Text(
                        '${controller.customizationQuantity.value}',
                        style: AppTextStyles.subtitle1(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: controller.incrementCustomizationQuantity,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Sticky Add to Cart button with live price
              Expanded(
                child: Obx(
                  () => CustomButton(
                    text:
                        'Add to Cart • ${CurrencyFormatter.format(controller.customizedPrice)}',
                    onPressed: () {
                      onAddToCart(
                        controller.customizationQuantity.value,
                        List.from(controller.selectedAddons),
                        controller.specialInstructionsController.text.trim(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
