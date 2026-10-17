import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class AnimatedSuccessCheckmark extends StatefulWidget {
  final double size;
  final VoidCallback? onComplete;

  const AnimatedSuccessCheckmark({
    super.key,
    this.size = 110,
    this.onComplete,
  });

  @override
  State<AnimatedSuccessCheckmark> createState() => _AnimatedSuccessCheckmarkState();
}

class _AnimatedSuccessCheckmarkState extends State<AnimatedSuccessCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: AppCurves.iosSpring),
      ),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward().then((_) {
      if (widget.onComplete != null) widget.onComplete!();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CheckmarkPainter(
            scale: _scaleAnimation.value,
            checkProgress: _checkAnimation.value,
          ),
        );
      },
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  final double scale;
  final double checkProgress;

  _CheckmarkPainter({required this.scale, required this.checkProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * scale;

    if (radius <= 0) return;

    // Outer glow halo
    final glowPaint = Paint()
      ..color = AppColors.success.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 1.15, glowPaint);

    // Main Circle
    final circlePaint = Paint()
      ..color = AppColors.success
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    // Inner checkmark path
    if (checkProgress > 0) {
      final checkPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.075
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path = Path();
      final p1 = Offset(size.width * 0.30, size.height * 0.50);
      final p2 = Offset(size.width * 0.45, size.height * 0.65);
      final p3 = Offset(size.width * 0.70, size.height * 0.38);

      if (checkProgress <= 0.4) {
        final t = checkProgress / 0.4;
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(
          p1.dx + (p2.dx - p1.dx) * t,
          p1.dy + (p2.dy - p1.dy) * t,
        );
      } else {
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(p2.dx, p2.dy);
        final t = (checkProgress - 0.4) / 0.6;
        path.lineTo(
          p2.dx + (p3.dx - p2.dx) * t,
          p2.dy + (p3.dy - p2.dy) * t,
        );
      }

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) =>
      oldDelegate.scale != scale || oldDelegate.checkProgress != checkProgress;
}

class AnimatedDeliveryBike extends StatefulWidget {
  final double size;

  const AnimatedDeliveryBike({super.key, this.size = 140});

  @override
  State<AnimatedDeliveryBike> createState() => _AnimatedDeliveryBikeState();
}

class _AnimatedDeliveryBikeState extends State<AnimatedDeliveryBike>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final bounce = math.sin(_controller.value * math.pi * 4) * 3.5;
        final tilt = math.sin(_controller.value * math.pi * 2) * 0.04;

        return Transform.translate(
          offset: Offset(0, bounce),
          child: Transform.rotate(
            angle: tilt,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.two_wheeler_rounded,
                size: 72,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimatedCookingPot extends StatefulWidget {
  final double size;

  const AnimatedCookingPot({super.key, this.size = 120});

  @override
  State<AnimatedCookingPot> createState() => _AnimatedCookingPotState();
}

class _AnimatedCookingPotState extends State<AnimatedCookingPot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final steamOffset = (_controller.value * 8);

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: AppColors.accentYellow.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.soup_kitchen_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            Positioned(
              top: 14 - steamOffset,
              child: Opacity(
                opacity: 1.0 - _controller.value,
                child: const Icon(
                  Icons.air_rounded,
                  size: 26,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedEmptyBag extends StatefulWidget {
  final double size;

  const AnimatedEmptyBag({super.key, this.size = 130});

  @override
  State<AnimatedEmptyBag> createState() => _AnimatedEmptyBagState();
}

class _AnimatedEmptyBagState extends State<AnimatedEmptyBag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final floatY = math.sin(_controller.value * math.pi) * 8.0;

        return Transform.translate(
          offset: Offset(0, floatY),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
