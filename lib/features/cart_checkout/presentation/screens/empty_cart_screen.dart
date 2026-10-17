import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_animated_illustrations.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../routes/app_routes.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'My Cart'),
      body: SafeArea(
        child: EmptyView(
          customIllustration: const AnimatedEmptyBag(size: 130),
          icon: Icons.remove_shopping_cart_outlined,
          title: 'Your Cart is Empty',
          subtitle:
              'Looks like you haven\'t added any delicious meals to your cart yet. Explore restaurants and satisfy your cravings!',
          buttonText: 'Find Food Now',
          onButtonPressed: () {
            Get.offAllNamed(AppRoutes.mainNav);
          },
        ),
      ),
    );
  }
}
