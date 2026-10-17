import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_animated_illustrations.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../routes/app_routes.dart';

class EmptyOrdersScreen extends StatelessWidget {
  const EmptyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'My Orders'),
      body: SafeArea(
        child: EmptyView(
          customIllustration: const AnimatedCookingPot(size: 130),
          icon: Icons.receipt_long_outlined,
          title: 'No Orders Yet',
          subtitle:
              'You have no ongoing or past food deliveries. Start discovering top restaurants near you!',
          buttonText: 'Order Food Now',
          onButtonPressed: () {
            Get.offAllNamed(AppRoutes.mainNav);
          },
        ),
      ),
    );
  }
}
