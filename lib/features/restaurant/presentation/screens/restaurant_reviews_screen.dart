import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../domain/entities/restaurant_entity.dart';

class RestaurantReviewsScreen extends StatelessWidget {
  const RestaurantReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rest = Get.arguments as RestaurantEntity?;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final reviews = [
      {
        'author': 'Alex Johnson',
        'rating': 5.0,
        'date': '2 days ago',
        'comment':
            'Hands down the best smash burgers in the neighborhood! The buns were fresh and buttery, and delivery was 10 minutes earlier than expected.',
        'avatar':
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100',
        'reply':
            'Thank you Alex! We take huge pride in our daily fresh baked brioche buns. Glad you loved it!',
      },
      {
        'author': 'Emily Watson',
        'rating': 4.5,
        'date': '1 week ago',
        'comment':
            'Super juicy patties and loved the caramelized onions. The spicy fries were incredible too. Will order again!',
        'avatar':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
        'reply': null,
      },
      {
        'author': 'Marcus Brody',
        'rating': 5.0,
        'date': '2 weeks ago',
        'comment':
            'The packaging was immaculate and still piping hot. True 5-star experience.',
        'avatar':
            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=100',
        'reply': null,
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(title: '${rest?.name ?? "Restaurant"} Reviews'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Overview Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Row(
                  children: [
                    // Score
                    Column(
                      children: [
                        Text(
                          '${rest?.rating ?? 4.8}',
                          style: AppTextStyles.heading1(
                            color: isDark ? Colors.white : AppColors.textPrimaryLight,
                          ).copyWith(fontSize: 44, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        RatingBadge(rating: rest?.rating ?? 4.8, fontSize: 16),
                        const SizedBox(height: 4),
                        Text(
                          '${rest?.ratingCount ?? 382} Reviews',
                          style: AppTextStyles.caption(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    // Star bars
                    Expanded(
                      child: Column(
                        children: [
                          _buildStarBar(5, 0.85, isDark),
                          _buildStarBar(4, 0.10, isDark),
                          _buildStarBar(3, 0.03, isDark),
                          _buildStarBar(2, 0.01, isDark),
                          _buildStarBar(1, 0.01, isDark),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Customer Feedback',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 14),

              // Reviews list
              ...reviews.map((rev) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppAvatar(
                            radius: 20,
                            imageUrl: rev['avatar'] as String?,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rev['author'] as String,
                                  style: AppTextStyles.subtitle2(
                                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                  ),
                                ),
                                Text(
                                  rev['date'] as String,
                                  style: AppTextStyles.caption(
                                    color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RatingBadge(rating: rev['rating'] as double),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        rev['comment'] as String,
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      if (rev['reply'] != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.inputDark : AppColors.inputLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Restaurant Response:',
                                style: AppTextStyles.caption(color: AppColors.primary)
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                rev['reply'] as String,
                                style: AppTextStyles.bodySmall(
                                  color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarBar(int star, double fraction, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$star★', style: AppTextStyles.caption()),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 6,
                backgroundColor: isDark ? Colors.white12 : AppColors.inputLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentYellow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
