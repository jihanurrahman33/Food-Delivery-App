import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/text_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int? count;
  final double iconSize;
  final double fontSize;

  const RatingBadge({
    super.key,
    required this.rating,
    this.count,
    this.iconSize = 16,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          size: iconSize,
          color: AppColors.accentYellow,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.subtitle2().copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 3),
          Text(
            '($count+)',
            style: AppTextStyles.caption().copyWith(fontSize: fontSize - 2),
          ),
        ],
      ],
    );
  }
}
