import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';

class ChefOrderDetailScreen extends StatelessWidget {
  const ChefOrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Map<String, dynamic>? ?? {
      'id': 'KTC-104',
      'customerName': 'Sarah Connor',
      'time': '3 min ago',
      'items': ['2x Smash Cheeseburger (Extra Bacon)', '1x Truffle Fries'],
      'status': 'Pending',
      'total': 28.50,
      'notes': 'Allergies: No peanuts please.',
    };
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(title: 'Kitchen Ticket #${order['id']}'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : AppColors.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'KITCHEN EXPEDITE TICKET',
                        style: AppTextStyles.subtitle2(color: AppColors.primary).copyWith(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(height: 28),
                    _buildTicketRow('Customer:', order['customerName'] as String, isDark),
                    const SizedBox(height: 8),
                    _buildTicketRow('Placed Time:', order['time'] as String, isDark),
                    const SizedBox(height: 8),
                    _buildTicketRow('Current Status:', order['status'] as String, isDark),
                    const Divider(height: 28),
                    Text(
                      'PREPARATION ITEMS',
                      style: AppTextStyles.caption().copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...(order['items'] as List<dynamic>).map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, size: 8, color: AppColors.primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.toString(),
                                style: AppTextStyles.subtitle2(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (order['notes'] != null) ...[
                      const Divider(height: 28),
                      Text(
                        'CUSTOMER SPECIAL INSTRUCTIONS:',
                        style: AppTextStyles.caption().copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentRed,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        order['notes'] as String,
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'PRINT EXPEDITE TICKET',
                icon: const Icon(Icons.print_outlined, color: Colors.white, size: 20),
                onPressed: () {
                  AppSnackbar.info('Print', 'Ticket sent to thermal kitchen printer');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.caption(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.subtitle2(
            color: isDark ? Colors.white : AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }
}
