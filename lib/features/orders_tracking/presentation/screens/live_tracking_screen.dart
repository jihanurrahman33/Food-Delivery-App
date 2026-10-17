import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/order_controller.dart';

class LiveTrackingScreen extends GetView<OrderTrackingController> {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      body: Stack(
        children: [
          // Simulated Interactive Map Canvas with Route & Moving Rider
          Positioned.fill(
            child: Obx(
              () => CustomPaint(
                painter: MapRoutePainter(
                  progress: controller.riderProgress.value,
                  isDark: isDark,
                ),
              ),
            ),
          ),

          // Top Header Bar
          Positioned(
            top: 48,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        size: 18),
                    onPressed: () => Get.back(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: AppColors.primary, size: 18),
                      const SizedBox(width: 6),
                      Obx(
                        () => Text(
                          '${controller.remainingMinutes.value} MINS AWAY',
                          style: AppTextStyles.caption().copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.format_list_bulleted_rounded,
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        size: 20),
                    onPressed: () => Get.toNamed(AppRoutes.orderTimeline),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Order Status Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Stepper Preview
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(isDark ? 0.2 : 0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.delivery_dining_rounded,
                              color: AppColors.primary, size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Food is on the way',
                                style: AppTextStyles.subtitle1(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Order #FD-98421 • Delivering to Home',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.rateOrder),
                          child: Text(
                            'Rate Order',
                            style: AppTextStyles.subtitle2(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 28),

                    // Courier Rider Card
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Robert Fox',
                                style: AppTextStyles.subtitle1(
                                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const RatingBadge(rating: 4.9),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Vespa • NYC-5491',
                                    style: AppTextStyles.caption(
                                      color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Call action
                        GestureDetector(
                          onTap: () {
                            controller.startVoiceCall();
                            Get.toNamed(AppRoutes.voiceCall);
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.accentGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.phone, color: Colors.white, size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Chat action
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.driverChat),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapRoutePainter extends CustomPainter {
  final double progress;
  final bool isDark;

  MapRoutePainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Map background
    final bgPaint = Paint()..color = isDark ? const Color(0xFF161A29) : const Color(0xFFE8EEF4);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Draw Simulated Roads / Street Grid
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF22283C) : Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final gridPath = Path();
    for (double y = 80; y < size.height; y += 90) {
      gridPath.moveTo(0, y);
      gridPath.lineTo(size.width, y);
    }
    for (double x = 40; x < size.width; x += 80) {
      gridPath.moveTo(x, 0);
      gridPath.lineTo(x, size.height);
    }
    canvas.drawPath(gridPath, roadPaint);

    // 3. Define Delivery Route Path
    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePath = Path();
    final start = Offset(size.width * 0.25, size.height * 0.22);
    final mid1 = Offset(size.width * 0.25, size.height * 0.38);
    final mid2 = Offset(size.width * 0.70, size.height * 0.38);
    final mid3 = Offset(size.width * 0.70, size.height * 0.58);
    final end = Offset(size.width * 0.45, size.height * 0.58);

    routePath.moveTo(start.dx, start.dy);
    routePath.lineTo(mid1.dx, mid1.dy);
    routePath.lineTo(mid2.dx, mid2.dy);
    routePath.lineTo(mid3.dx, mid3.dy);
    routePath.lineTo(end.dx, end.dy);

    canvas.drawPath(routePath, routePaint);

    // 4. Restaurant Marker at Start
    final restPinPaint = Paint()..color = const Color(0xFF181C2E);
    canvas.drawCircle(start, 18, restPinPaint);
    final restInner = Paint()..color = Colors.white;
    canvas.drawCircle(start, 8, restInner);

    // 5. Customer House Marker at End
    final destPinPaint = Paint()..color = AppColors.accentGreen;
    canvas.drawCircle(end, 20, destPinPaint);
    final destInner = Paint()..color = Colors.white;
    canvas.drawCircle(end, 8, destInner);

    // 6. Animated Rider Marker along the route
    final currentPos = _calculateCurrentPosition(progress, start, mid1, mid2, mid3, end);
    final riderBg = Paint()..color = AppColors.primary;
    canvas.drawCircle(currentPos, 22, riderBg);
    final riderRing = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(currentPos, 22, riderRing);

    // Icon in rider marker
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '🛵',
        style: TextStyle(fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, currentPos - const Offset(8, 10));
  }

  Offset _calculateCurrentPosition(
      double p, Offset start, Offset mid1, Offset mid2, Offset mid3, Offset end) {
    if (p <= 0.25) {
      double sub = p / 0.25;
      return Offset.lerp(start, mid1, sub)!;
    } else if (p <= 0.50) {
      double sub = (p - 0.25) / 0.25;
      return Offset.lerp(mid1, mid2, sub)!;
    } else if (p <= 0.75) {
      double sub = (p - 0.50) / 0.25;
      return Offset.lerp(mid2, mid3, sub)!;
    } else {
      double sub = (p - 0.75) / 0.25;
      return Offset.lerp(mid3, end, sub)!;
    }
  }

  @override
  bool shouldRepaint(covariant MapRoutePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}
