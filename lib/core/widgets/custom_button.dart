import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../theme/text_styles.dart';
import 'bouncing_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? color; // Alias for backgroundColor
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final dynamic icon; // Can be Widget or IconData

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.color,
    this.textColor,
    this.width,
    this.height = AppDimens.buttonHeight,
    this.borderRadius = AppDimens.radius14,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBg = color ?? backgroundColor ?? AppColors.primary;
    final effectiveBgColor = isOutlined ? Colors.transparent : effectiveBg;
    final effectiveTextColor = isOutlined
        ? (textColor ?? AppColors.primary)
        : (textColor ?? Colors.white);

    return BouncingButton(
      onTap: isLoading ? null : onPressed,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: isOutlined
            ? OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: effectiveBg,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: _buildChild(effectiveTextColor),
              )
            : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: effectiveBgColor,
                  foregroundColor: effectiveTextColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.space20),
                ),
                child: _buildChild(effectiveTextColor),
              ),
      ),
    );
  }

  Widget _buildChild(Color textColorVal) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(textColorVal),
        ),
      );
    }

    if (icon != null) {
      final iconWidget = icon is IconData
          ? Icon(icon as IconData, size: 20, color: textColorVal)
          : icon as Widget;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const SizedBox(width: AppDimens.space10),
          Text(text, style: AppTextStyles.button(color: textColorVal)),
        ],
      );
    }

    return Text(text, style: AppTextStyles.button(color: textColorVal));
  }
}
