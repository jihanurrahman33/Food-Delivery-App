import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../../routes/app_routes.dart';
import '../../../cart_checkout/presentation/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class SearchScreen extends GetView<HomeController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input Row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.inputDark : AppColors.inputLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: controller.searchTextController,
                        onChanged: controller.search,
                        style: AppTextStyles.bodyLarge(
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search dishes, restaurants...',
                          hintStyle: AppTextStyles.bodyMedium(
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiaryLight,
                          ),
                          prefixIcon: const Icon(Icons.search_rounded,
                              color: AppColors.primary, size: 22),
                          suffixIcon: Obx(
                            () => controller.currentSearchQuery.value.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear_rounded, size: 18),
                                    onPressed: () {
                                      controller.searchTextController.clear();
                                      controller.search('');
                                    },
                                  )
                                : const SizedBox.shrink(),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Button
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.filter),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Content: Recent searches if empty query, or results if query entered
              Expanded(
                child: Obx(() {
                  if (controller.currentSearchQuery.value.isEmpty) {
                    return _buildRecentAndPopularKeywords(isDark);
                  }

                  if (controller.searchRestaurantResults.isEmpty &&
                      controller.searchFoodResults.isEmpty) {
                    return const EmptyView(
                      icon: Icons.search_off_rounded,
                      title: 'No Food or Restaurant Found',
                      subtitle:
                          'Try searching with a different keyword or check your spelling.',
                    );
                  }

                  return _buildSearchResults(cartController, isDark);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentAndPopularKeywords(bool isDark) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (controller.recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: AppTextStyles.subtitle1(
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                TextButton(
                  onPressed: controller.clearRecentSearches,
                  child: Text(
                    'Clear All',
                    style: AppTextStyles.caption(color: AppColors.error),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.recentSearches.map((term) {
                return ActionChip(
                  label: Text(term),
                  avatar: const Icon(Icons.history_rounded, size: 16),
                  backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                  labelStyle: AppTextStyles.bodySmall(
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  onPressed: () {
                    controller.searchTextController.text = term;
                    controller.search(term);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
          ],

          // Popular Fast Keywords
          Text(
            'Popular Fast Keywords',
            style: AppTextStyles.subtitle1(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              '🍔 Burger',
              '🍕 Pizza',
              '🍜 Ramen',
              '🌮 Tacos',
              '🍰 Cheesecake',
              '🥤 Bubble Tea',
              '🍗 Fried Chicken',
              '🥗 Vegan Salad',
            ].map((keyword) {
              return ActionChip(
                label: Text(keyword),
                backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                labelStyle: AppTextStyles.bodySmall(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                onPressed: () {
                  final clean = keyword.split(' ').last;
                  controller.searchTextController.text = clean;
                  controller.search(clean);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(CartController cartController, bool isDark) {
    return ListView(
      children: [
        if (controller.searchRestaurantResults.isNotEmpty) ...[
          Text(
            'Restaurants (${controller.searchRestaurantResults.length})',
            style: AppTextStyles.subtitle1(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),
          ...controller.searchRestaurantResults.map((rest) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: rest.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                rest.name,
                style: AppTextStyles.subtitle2(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              subtitle: Text(
                '${rest.tags.join(', ')} • ${rest.deliveryTime}',
                style: AppTextStyles.caption(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              trailing: RatingBadge(rating: rest.rating),
              onTap: () =>
                  Get.toNamed(AppRoutes.restaurantDetail, arguments: rest),
            );
          }),
          const SizedBox(height: 24),
        ],
        if (controller.searchFoodResults.isNotEmpty) ...[
          Text(
            'Dishes & Meals (${controller.searchFoodResults.length})',
            style: AppTextStyles.subtitle1(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),
          ...controller.searchFoodResults.map((food) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: food.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                food.name,
                style: AppTextStyles.subtitle2(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              subtitle: Text(
                food.restaurantName,
                style: AppTextStyles.caption(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    CurrencyFormatter.format(food.price),
                    style: AppTextStyles.subtitle2(
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primary),
                    onPressed: () => cartController.addItem(foodItem: food),
                  ),
                ],
              ),
              onTap: () => Get.toNamed(AppRoutes.foodDetail, arguments: food),
            );
          }),
        ],
      ],
    );
  }
}
