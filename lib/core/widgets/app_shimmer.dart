import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBaseLight,
      highlightColor: isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlightLight,
      period: AppDurations.shimmer,
      child: child,
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final ShapeBorder? shape;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppDimens.radius8,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: shape != null
          ? ShapeDecoration(color: Colors.white, shape: shape!)
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
    );
  }
}

class RestaurantCardSkeleton extends StatelessWidget {
  const RestaurantCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppShimmer(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.space16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius18),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image skeleton
            const ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.radius18)),
              child: ShimmerBox(
                width: double.infinity,
                height: 160,
                borderRadius: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.space14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ShimmerBox(width: 160, height: 18, borderRadius: AppDimens.radius6),
                      ShimmerBox(width: 50, height: 18, borderRadius: AppDimens.radius12),
                    ],
                  ),
                  const SizedBox(height: AppDimens.space10),
                  Row(
                    children: const [
                      ShimmerBox(width: 60, height: 14, borderRadius: AppDimens.radius6),
                      SizedBox(width: AppDimens.space12),
                      ShimmerBox(width: 80, height: 14, borderRadius: AppDimens.radius6),
                      SizedBox(width: AppDimens.space12),
                      ShimmerBox(width: 70, height: 14, borderRadius: AppDimens.radius6),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItemCardSkeleton extends StatelessWidget {
  const FoodItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(AppDimens.space12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Row(
          children: [
            const ShimmerBox(width: 80, height: 80, borderRadius: AppDimens.radius12),
            const SizedBox(width: AppDimens.space14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(width: 140, height: 16, borderRadius: AppDimens.radius6),
                  SizedBox(height: AppDimens.space8),
                  ShimmerBox(width: 90, height: 12, borderRadius: AppDimens.radius6),
                  SizedBox(height: AppDimens.space10),
                  ShimmerBox(width: 65, height: 16, borderRadius: AppDimens.radius6),
                ],
              ),
            ),
            const ShimmerBox(width: 32, height: 32, borderRadius: AppDimens.radius10),
          ],
        ),
      ),
    );
  }
}

class CategoryItemSkeleton extends StatelessWidget {
  const CategoryItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Padding(
        padding: EdgeInsets.only(right: AppDimens.space12),
        child: ShimmerBox(
          width: 90,
          height: 48,
          borderRadius: 30,
        ),
      ),
    );
  }
}

class BannerSkeleton extends StatelessWidget {
  const BannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: ShimmerBox(
        width: double.infinity,
        height: 155,
        borderRadius: AppDimens.radius18,
      ),
    );
  }
}

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppShimmer(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.space14),
        padding: const EdgeInsets.all(AppDimens.space16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 120, height: 16, borderRadius: AppDimens.radius6),
                ShimmerBox(width: 70, height: 16, borderRadius: AppDimens.radius12),
              ],
            ),
            const SizedBox(height: AppDimens.space12),
            const ShimmerBox(width: double.infinity, height: 12, borderRadius: AppDimens.radius6),
            const SizedBox(height: AppDimens.space8),
            const ShimmerBox(width: 180, height: 12, borderRadius: AppDimens.radius6),
            const SizedBox(height: AppDimens.space14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 80, height: 20, borderRadius: AppDimens.radius6),
                ShimmerBox(width: 100, height: 36, borderRadius: AppDimens.radius10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
