import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/chef_controller.dart';

class ChefEarningsScreen extends GetView<ChefController> {
  const ChefEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final payouts = [
      {
        'date': 'Oct 15, 2026',
        'amount': 2450.00,
        'status': 'Completed',
        'account': 'Chase Bank •••• 6712',
      },
      {
        'date': 'Oct 08, 2026',
        'amount': 2120.50,
        'status': 'Completed',
        'account': 'Chase Bank •••• 6712',
      },
      {
        'date': 'Oct 01, 2026',
        'amount': 1890.00,
        'status': 'Completed',
        'account': 'Chase Bank •••• 6712',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Kitchen Earnings & Payouts'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E2337), Color(0xFF121223)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AVAILABLE BALANCE',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        CurrencyFormatter.format(controller.todaySales.value * 3.8),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.account_balance_rounded,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        const Text(
                          'Direct Deposit: Chase Bank •••• 6712',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Withdraw Action
              CustomButton(
                text: 'REQUEST WITHDRAWAL',
                icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 20),
                onPressed: () {
                  Get.snackbar(
                    'Withdrawal Requested',
                    'Your funds are being transferred to Chase Bank •••• 6712',
                    backgroundColor: AppColors.accentGreen,
                    colorText: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 32),

              // Payout History
              Text(
                'Recent Weekly Settlements',
                style: AppTextStyles.heading3(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 14),

              ...payouts.map((p) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isDark ? [] : AppColors.cardShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['account'] as String,
                            style: AppTextStyles.subtitle2(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            p['date'] as String,
                            style: AppTextStyles.caption(
                              color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            CurrencyFormatter.format(p['amount'] as double),
                            style: AppTextStyles.subtitle1(
                              color: isDark ? Colors.white : AppColors.textPrimaryLight,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            p['status'] as String,
                            style: AppTextStyles.caption(color: AppColors.accentGreen)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
}
