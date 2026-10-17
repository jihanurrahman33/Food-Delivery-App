import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../../routes/app_routes.dart';
import '../../../home/presentation/controllers/home_controller.dart';

class RestaurantListScreen extends GetView<HomeController> {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'All Restaurants',
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => Get.toNamed(AppRoutes.filter),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: controller.featuredRestaurants.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              final rest = controller.featuredRestaurants[index];
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.restaurantDetail, arguments: rest),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: rest.imageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  rest.name,
                                  style: AppTextStyles.subtitle1(
                                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                  ),
                                ),
                                RatingBadge(
                                    rating: rest.rating, count: rest.ratingCount),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              rest.tags.join(' • '),
                              style: AppTextStyles.bodySmall(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.delivery_dining_rounded,
                                    size: 18, color: AppColors.primary),
                                const SizedBox(width: 4),
                                Text(
                                  rest.deliveryFee == 0
                                      ? 'Free Delivery'
                                      : '\$${rest.deliveryFee.toStringAsFixed(2)} Delivery',
                                  style: AppTextStyles.caption().copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.timer_outlined,
                                    size: 16, color: AppColors.primary),
                                const SizedBox(width: 4),
                                Text(
                                  rest.deliveryTime,
                                  style: AppTextStyles.caption().copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
