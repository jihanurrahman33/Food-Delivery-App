import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../cart_checkout/presentation/controllers/cart_controller.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../controllers/restaurant_controller.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;
  final List<FoodAddon> _selectedAddons = [];
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final food = Get.arguments as FoodItemEntity? ??
        Get.find<RestaurantController>().selectedFood.value!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();

    double calculatedPrice = food.price;
    for (var a in _selectedAddons) {
      calculatedPrice += a.price;
    }
    calculatedPrice *= _quantity;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Hero Image
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: food.imageUrl,
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 48,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 18),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 48,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        child: IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.redAccent : Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // Details body
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant tag
                      Text(
                        food.restaurantName,
                        style: AppTextStyles.subtitle2(color: AppColors.primary),
                      ),
                      const SizedBox(height: 6),

                      // Dish Title
                      Text(
                        food.name,
                        style: AppTextStyles.heading2(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Rating & Badges
                      Row(
                        children: [
                          RatingBadge(rating: food.rating, count: food.ratingCount),
                          const SizedBox(width: 16),
                          _buildFoodMetric(
                            icon: Icons.local_fire_department_outlined,
                            text: '${food.calories} kcal',
                            isDark: isDark,
                          ),
                          const SizedBox(width: 12),
                          _buildFoodMetric(
                            icon: Icons.timer_outlined,
                            text: '${food.prepTimeMinutes} min',
                            isDark: isDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Text(
                        'Description',
                        style: AppTextStyles.subtitle1(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
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
                      const SizedBox(height: 24),

                      // Choice of Add-ons
                      if (food.availableAddons.isNotEmpty) ...[
                        Text(
                          'Choice of Add-ons',
                          style: AppTextStyles.subtitle1(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...food.availableAddons.map((addon) {
                          final isSelected =
                              _selectedAddons.any((a) => a.id == addon.id);
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              addon.name,
                              style: AppTextStyles.bodyMedium(
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                            secondary: Text(
                              '+${CurrencyFormatter.format(addon.price)}',
                              style: AppTextStyles.subtitle2(
                                  color: AppColors.primary),
                            ),
                            value: isSelected,
                            activeColor: AppColors.primary,
                            onChanged: (val) {
                              setState(() {
                                if (val == true) {
                                  _selectedAddons.add(addon);
                                } else {
                                  _selectedAddons
                                      .removeWhere((a) => a.id == addon.id);
                                }
                              });
                            },
                          );
                        }),
                      ],
                      const SizedBox(height: 100), // padding for sticky button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sticky Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // Quantity Stepper
                    Container(
                      decoration: BoxDecoration(
                        color:
                            isDark ? AppColors.inputDark : AppColors.inputLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20),
                            onPressed: () {
                              if (_quantity > 1) {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            },
                          ),
                          Text(
                            '$_quantity',
                            style: AppTextStyles.subtitle1(
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textPrimaryLight,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20),
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Add to Cart button
                    Expanded(
                      child: CustomButton(
                        text:
                            'Add to Cart • ${CurrencyFormatter.format(calculatedPrice)}',
                        onPressed: () {
                          cartController.addItem(
                            foodItem: food,
                            quantity: _quantity,
                            selectedAddons: List.from(_selectedAddons),
                          );
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodMetric({
    required IconData icon,
    required String text,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.caption(
            color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
