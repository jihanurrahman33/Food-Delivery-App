import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/rider_controller.dart';

class RiderNavigationScreen extends StatefulWidget {
  const RiderNavigationScreen({super.key});

  @override
  State<RiderNavigationScreen> createState() => _RiderNavigationScreenState();
}

class _RiderNavigationScreenState extends State<RiderNavigationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final RiderController _riderController = Get.find<RiderController>();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Ensure there's an active delivery to navigate
    if (_riderController.activeDelivery.value == null) {
      if (_riderController.availableDeliveries.isNotEmpty) {
        _riderController.acceptDelivery(_riderController.availableDeliveries.first);
      } else {
        _riderController.activeDelivery.value = {
          'id': 'DEL-889',
          'restaurantName': 'Piazza Bella Napoli',
          'pickupAddress': '15 Little Italy Blvd, Downtown',
          'deliveryAddress': '220 Central Park South, Apt 8A',
          'distance': '1.8 km',
          'payout': 9.50,
          'itemsCount': 2,
        };
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        final delivery = _riderController.activeDelivery.value ?? {
          'id': 'DEL-889',
          'restaurantName': 'Piazza Bella Napoli',
          'pickupAddress': '15 Little Italy Blvd, Downtown',
          'deliveryAddress': '220 Central Park South, Apt 8A',
          'distance': '1.8 km',
          'payout': 9.50,
          'itemsCount': 2,
        };
        final step = _riderController.deliveryStep.value;
        final isHeadingToCustomer = step == 'Picked Up';

        return Stack(
          children: [
            // 1. Simulated Canvas Navigation Map
            Positioned.fill(
              child: CustomPaint(
                painter: _RiderNavMapPainter(
                  isDark: isDark,
                  pulseProgress: _pulseController.value,
                  isCustomerRoute: isHeadingToCustomer,
                ),
              ),
            ),

            // 2. Turn-by-Turn Instruction Banner
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: _buildTurnInstructionBanner(isDark, isHeadingToCustomer),
            ),

            // 3. Floating Quick Action Controls
            Positioned(
              right: 16,
              bottom: 270,
              child: Column(
                children: [
                  _buildFloatingActionBtn(
                    icon: Icons.my_location_rounded,
                    onTap: () {
                      AppSnackbar.info('Recenter GPS', 'Locked to current courier coordinates');
                    },
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildFloatingActionBtn(
                    icon: Icons.volume_up_rounded,
                    onTap: () {
                      AppSnackbar.info('Voice Guidance', 'Voice navigation active');
                    },
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildFloatingActionBtn(
                    icon: Icons.call_outlined,
                    onTap: () => Get.toNamed(AppRoutes.voiceCall),
                    isDark: isDark,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),

            // 4. Bottom Active Delivery Details Card
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomDeliveryCard(context, delivery, isDark, isHeadingToCustomer),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTurnInstructionBanner(bool isDark, bool isHeadingToCustomer) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.turn_right_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'In 250 meters',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isHeadingToCustomer
                      ? 'Turn right onto Central Park South'
                      : 'Turn right toward Grand Central Station',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Get.back(),
            tooltip: 'Exit Navigation',
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionBtn({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    Color? color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color ?? (isDark ? AppColors.darkSurface : Colors.white),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: color != null ? Colors.white : (isDark ? Colors.white : AppColors.darkSurface),
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomDeliveryCard(
      BuildContext context, Map<String, dynamic> delivery, bool isDark, bool isHeadingToCustomer) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Payout & ETA summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip Earnings',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${(delivery['payout'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      '8 min (1.4 km)',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),

          // Origin / Destination details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isHeadingToCustomer ? Colors.grey : AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 32,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isHeadingToCustomer ? AppColors.success : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      delivery['restaurantName'] ?? 'Restaurant',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isHeadingToCustomer
                            ? (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)
                            : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
                      ),
                    ),
                    Text(
                      delivery['pickupAddress'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Customer: Sophia Miller',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isHeadingToCustomer
                            ? (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)
                            : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                      ),
                    ),
                    Text(
                      delivery['deliveryAddress'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary),
                onPressed: () => Get.toNamed(AppRoutes.driverChat),
                tooltip: 'Chat with Customer',
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Primary Status Progression Button
          CustomButton(
            text: isHeadingToCustomer ? 'Swipe to Complete Delivery' : 'Confirm Order Picked Up',
            color: isHeadingToCustomer ? AppColors.success : AppColors.primary,
            onPressed: () {
              if (isHeadingToCustomer) {
                _riderController.completeDelivery();
                Get.offNamed(AppRoutes.riderOrders);
              } else {
                _riderController.confirmPickup();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _RiderNavMapPainter extends CustomPainter {
  final bool isDark;
  final double pulseProgress;
  final bool isCustomerRoute;

  _RiderNavMapPainter({
    required this.isDark,
    required this.pulseProgress,
    required this.isCustomerRoute,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = isDark ? const Color(0xFF1E2336) : const Color(0xFFE8ECEF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF2B3047) : Colors.white
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final roadBorderPaint = Paint()
      ..color = isDark ? const Color(0xFF383F5E) : const Color(0xFFD6DBDF)
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw grid/city roads
    final pathRoad1 = Path()
      ..moveTo(0, size.height * 0.45)
      ..lineTo(size.width, size.height * 0.45);
    final pathRoad2 = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.5, size.height);
    final pathRoad3 = Path()
      ..moveTo(0, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.2);

    for (var p in [pathRoad1, pathRoad2, pathRoad3]) {
      canvas.drawPath(p, roadBorderPaint);
      canvas.drawPath(p, roadPaint);
    }

    // Active Route Path
    final routePath = Path();
    final pStart = Offset(size.width * 0.25, size.height * 0.65);
    final pMid1 = Offset(size.width * 0.25, size.height * 0.45);
    final pMid2 = Offset(size.width * 0.5, size.height * 0.45);
    final pEnd = Offset(size.width * 0.5, size.height * 0.2);

    routePath.moveTo(pStart.dx, pStart.dy);
    routePath.lineTo(pMid1.dx, pMid1.dy);
    routePath.lineTo(pMid2.dx, pMid2.dy);
    routePath.lineTo(pEnd.dx, pEnd.dy);

    final routeBorderPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.35)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final routeMainPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(routePath, routeBorderPaint);
    canvas.drawPath(routePath, routeMainPaint);

    // Origin Pin
    final startPaint = Paint()..color = const Color(0xFF32343E);
    canvas.drawCircle(pStart, 12, startPaint);
    canvas.drawCircle(pStart, 5, Paint()..color = Colors.white);

    // Destination Pin
    final endPaint = Paint()..color = AppColors.secondary;
    canvas.drawCircle(pEnd, 14, endPaint);
    canvas.drawCircle(pEnd, 6, Paint()..color = Colors.white);

    // Rider Motorcycle Position (Current Location)
    final riderPos = isCustomerRoute ? pMid2 : Offset(size.width * 0.25, size.height * 0.55);

    // Pulse animation around rider
    final pulsePaint = Paint()
      ..color = AppColors.primary.withOpacity((1 - pulseProgress) * 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(riderPos, 16 + (pulseProgress * 20), pulsePaint);

    // Rider Marker
    final riderPaint = Paint()..color = AppColors.primary;
    canvas.drawCircle(riderPos, 14, riderPaint);
    canvas.drawCircle(riderPos, 10, Paint()..color = Colors.white);
    canvas.drawCircle(riderPos, 6, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant _RiderNavMapPainter oldDelegate) => true;
}
