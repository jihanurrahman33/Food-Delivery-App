import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../routes/app_routes.dart';

class SystemStatesScreen extends StatefulWidget {
  const SystemStatesScreen({super.key});

  @override
  State<SystemStatesScreen> createState() => _SystemStatesScreenState();
}

class _SystemStatesScreenState extends State<SystemStatesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: 'System States',
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
            tabs: const [
              Tab(text: 'Offline / No Network'),
              Tab(text: 'Under Maintenance'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // State 1: Offline
            EmptyView(
              icon: Icons.wifi_off_rounded,
              title: 'No Internet Connection',
              subtitle:
                  'Please check your Wi-Fi or mobile data connection and try refreshing.',
              buttonText: 'Try Again',
              onButtonPressed: () {
                AppSnackbar.success('Network', 'Reconnected successfully!');
                Get.offAllNamed(AppRoutes.mainNav);
              },
            ),

            // State 2: Maintenance
            EmptyView(
              icon: Icons.build_circle_outlined,
              title: 'We’ll Be Back Soon!',
              subtitle:
                  'Our servers are currently undergoing routine maintenance to bring you faster speeds and new features.',
              buttonText: 'Check Service Status',
              onButtonPressed: () {
                AppSnackbar.info('Status', 'All systems operational!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
