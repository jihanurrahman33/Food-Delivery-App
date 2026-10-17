import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/order_controller.dart';

class RateOrderScreen extends GetView<OrderTrackingController> {
  const RateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final feedbackTags = [
      'Delicious Food',
      'Hot & Fresh',
      'Super Fast',
      'Polite Courier',
      'Neat Packaging',
      'Great Value',
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(title: 'Rate & Review'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Quality Rating
              Text(
                'How was the food quality?',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Rose Garden Bakehouse',
                style: AppTextStyles.bodyMedium(color: AppColors.primary),
              ),
              const SizedBox(height: 14),
              Obx(
                () => Row(
                  children: List.generate(5, (index) {
                    final star = index + 1;
                    return IconButton(
                      icon: Icon(
                        star <= controller.restaurantRating.value
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: AppColors.accentYellow,
                        size: 38,
                      ),
                      onPressed: () =>
                          controller.restaurantRating.value = star.toDouble(),
                    );
                  }),
                ),
              ),
              const Divider(height: 36),

              // Courier Delivery Rating
              Text(
                'How was the courier delivery?',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Robert Fox (Courier)',
                style: AppTextStyles.bodyMedium(color: AppColors.primary),
              ),
              const SizedBox(height: 14),
              Obx(
                () => Row(
                  children: List.generate(5, (index) {
                    final star = index + 1;
                    return IconButton(
                      icon: Icon(
                        star <= controller.riderRating.value
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: AppColors.accentYellow,
                        size: 38,
                      ),
                      onPressed: () =>
                          controller.riderRating.value = star.toDouble(),
                    );
                  }),
                ),
              ),
              const Divider(height: 36),

              // Feedback Tags
              Text(
                'What did you like the most?',
                style: AppTextStyles.subtitle1(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: feedbackTags.map((tag) {
                    final isSelected =
                        controller.selectedReviewTags.contains(tag);
                    return FilterChip(
                      label: Text(tag),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white : Colors.black87),
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor:
                          isDark ? AppColors.surfaceDark : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                      ),
                      onSelected: (_) => controller.toggleReviewTag(tag),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 28),

              // Written Comment
              Text(
                'Write your feedback',
                style: AppTextStyles.subtitle1(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.reviewCommentController,
                maxLines: 3,
                style: AppTextStyles.bodyMedium(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
                decoration: InputDecoration(
                  hintText: 'Share your experience to help others...',
                  filled: true,
                  fillColor: isDark ? AppColors.inputDark : AppColors.inputLight,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Submit Button
              CustomButton(
                text: 'SUBMIT REVIEW',
                onPressed: controller.submitReview,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
