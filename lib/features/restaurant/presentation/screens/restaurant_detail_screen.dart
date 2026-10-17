import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../../routes/app_routes.dart';
import '../../../cart_checkout/presentation/controllers/cart_controller.dart';
import '../controllers/restaurant_controller.dart';
import 'food_customization_sheet.dart';

class RestaurantDetailScreen extends GetView<RestaurantController> {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Obx(() {
        final rest = controller.currentRestaurant.value;
        if (rest == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            // Sliver App Bar with Hero Image
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 18),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
              actions: [
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: Icon(
                      rest.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: rest.isFavorite ? Colors.redAccent : Colors.white,
                      size: 20,
                    ),
                    onPressed: controller.toggleFavorite,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      Get.snackbar('Share', 'Link copied to clipboard!');
                    },
                  ),
                ),
                const SizedBox(width: 12),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: rest.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Restaurant Info Section
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            rest.name,
                            style: AppTextStyles.heading2(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(AppRoutes.restaurantReviews,
                              arguments: rest),
                          child: RatingBadge(
                              rating: rest.rating, count: rest.ratingCount),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            rest.address,
                            style: AppTextStyles.bodySmall(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _buildInfoTag(
                          icon: Icons.delivery_dining_rounded,
                          label: rest.deliveryFee == 0
                              ? 'Free'
                              : '\$${rest.deliveryFee.toStringAsFixed(2)}',
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _buildInfoTag(
                          icon: Icons.timer_outlined,
                          label: rest.deliveryTime,
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _buildInfoTag(
                          icon: Icons.directions_bike_outlined,
                          label: '${rest.distanceKm} km',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Menu Category Selector
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu Dishes',
                      style: AppTextStyles.heading3(
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.restaurantReviews,
                          arguments: rest),
                      child: Text(
                        'Read Reviews',
                        style: AppTextStyles.subtitle2(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Menu Items List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final food = controller.menuItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isDark ? [] : AppColors.cardShadow,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: food.imageUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: AppTextStyles.subtitle1(
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  food.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      CurrencyFormatter.format(food.price),
                                      style: AppTextStyles.subtitle1(
                                        color: isDark
                                            ? Colors.white
                                            : AppColors.textPrimaryLight,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.openCustomization(food);
                                        Get.bottomSheet(
                                          FoodCustomizationSheet(
                                            food: food,
                                            onAddToCart: (qty, addons, notes) {
                                              cartController.addItem(
                                                foodItem: food,
                                                quantity: qty,
                                                selectedAddons: addons,
                                                specialInstructions: notes,
                                              );
                                              Get.back();
                                            },
                                          ),
                                          isScrollControlled: true,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text('Add'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: controller.menuItems.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        );
      }),
    );
  }

  Widget _buildInfoTag({
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.inputDark : AppColors.inputLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.caption(
              color: isDark ? Colors.white : AppColors.textPrimaryLight,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
