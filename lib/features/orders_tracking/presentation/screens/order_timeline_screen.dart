import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class OrderTimelineScreen extends StatelessWidget {
  const OrderTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final steps = [
      {
        'title': 'Order Placed',
        'subtitle': 'We have received your order #FD-98421',
        'time': '12:30 PM',
        'isDone': true,
        'icon': Icons.receipt_long_rounded,
      },
      {
        'title': 'Order Confirmed',
        'subtitle': 'Rose Garden Bakehouse accepted your order',
        'time': '12:32 PM',
        'isDone': true,
        'icon': Icons.check_circle_outline_rounded,
      },
      {
        'title': 'Food Being Prepared',
        'subtitle': 'Chef is cooking your fresh burgers & sides',
        'time': '12:36 PM',
        'isDone': true,
        'icon': Icons.restaurant_rounded,
      },
      {
        'title': 'Courier Assigned',
        'subtitle': 'Robert Fox (Vespa NYC-5491) is heading to pick up',
        'time': '12:44 PM',
        'isDone': true,
        'icon': Icons.two_wheeler_rounded,
      },
      {
        'title': 'Out for Delivery',
        'subtitle': 'Your food is on the way to 76A Eighth Avenue',
        'time': '12:48 PM',
        'isDone': true,
        'isCurrent': true,
        'icon': Icons.navigation_rounded,
      },
      {
        'title': 'Delivered',
        'subtitle': 'Estimated arrival at your doorstep',
        'time': '01:05 PM',
        'isDone': false,
        'icon': Icons.home_rounded,
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Order Status Timeline'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  children: List.generate(steps.length, (index) {
                    final s = steps[index];
                    final isDone = s['isDone'] as bool;
                    final isCurrent = s['isCurrent'] as bool? ?? false;
                    final isLast = index == steps.length - 1;

                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Indicator Column
                          Column(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: isDone
                                      ? AppColors.primary
                                      : (isDark ? Colors.white12 : AppColors.inputLight),
                                  shape: BoxShape.circle,
                                  border: isCurrent
                                      ? Border.all(color: AppColors.accentYellow, width: 3)
                                      : null,
                                ),
                                child: Icon(
                                  s['icon'] as IconData,
                                  size: 18,
                                  color: isDone
                                      ? Colors.white
                                      : (isDark ? Colors.white38 : Colors.black38),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    color: isDone
                                        ? AppColors.primary
                                        : (isDark ? Colors.white12 : AppColors.inputLight),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          // Step Info
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        s['title'] as String,
                                        style: AppTextStyles.subtitle1(
                                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                        ),
                                      ),
                                      Text(
                                        s['time'] as String,
                                        style: AppTextStyles.caption(
                                          color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    s['subtitle'] as String,
                                    style: AppTextStyles.bodySmall(
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
