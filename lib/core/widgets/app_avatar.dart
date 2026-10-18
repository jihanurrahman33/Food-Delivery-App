import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final IconData placeholderIcon;

  const AppAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 24,
    this.placeholderIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fallbackBg = isDark ? AppColors.surfaceDark : Colors.grey.shade200;
    final fallbackIconColor = isDark ? Colors.white70 : Colors.grey.shade600;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fallbackBg,
          shape: BoxShape.circle,
        ),
        child: Icon(placeholderIcon, size: radius, color: fallbackIconColor),
      );
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: fallbackBg,
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          color: fallbackBg,
          child: Icon(placeholderIcon, size: radius, color: fallbackIconColor),
        ),
      ),
    );
  }
}
