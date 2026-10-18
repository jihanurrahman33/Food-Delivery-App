import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../controllers/order_controller.dart';

class VoiceCallScreen extends GetView<OrderTrackingController> {
  const VoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181C2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Pulsing Driver Avatar
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.15),
                      ),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.15, 1.15),
                          duration: 1200.ms,
                        ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    const AppAvatar(
                      radius: 54,
                      imageUrl:
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Courier Info
              Text(
                'Robert Fox',
                style: AppTextStyles.heading2(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final sec = controller.callSeconds.value;
                final minutes = (sec ~/ 60).toString().padLeft(2, '0');
                final seconds = (sec % 60).toString().padLeft(2, '0');
                return Text(
                  'Connected • $minutes:$seconds',
                  style: AppTextStyles.bodyMedium(color: AppColors.accentGreen),
                );
              }),
              const Spacer(),

              // Action Buttons Row (Mute, Speaker, End)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute
                  Obx(
                    () => _buildCircleAction(
                      icon: controller.isMuted.value
                          ? Icons.mic_off_rounded
                          : Icons.mic_rounded,
                      isActive: controller.isMuted.value,
                      onTap: controller.toggleMute,
                      label: 'Mute',
                    ),
                  ),

                  // End Call Button
                  GestureDetector(
                    onTap: controller.endVoiceCall,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.accentRed,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentRed.withOpacity(0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.call_end_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                  // Speaker
                  Obx(
                    () => _buildCircleAction(
                      icon: controller.isSpeakerOn.value
                          ? Icons.volume_up_rounded
                          : Icons.volume_down_rounded,
                      isActive: controller.isSpeakerOn.value,
                      onTap: controller.toggleSpeaker,
                      label: 'Speaker',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAction({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF181C2E) : Colors.white,
              size: 26,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
