import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Avatar with edit badge
                      Center(
                        child: Stack(
                          children: [
                            const AppAvatar(
                              radius: 54,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt_rounded,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Full Name
                      CustomTextField(
                        label: 'FULL NAME',
                        hintText: 'John Doe',
                        controller: controller.nameController,
                        prefixIcon: const Icon(Icons.person_outline_rounded,
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 18),

                      // Email
                      CustomTextField(
                        label: 'EMAIL',
                        hintText: 'example@gmail.com',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 18),

                      // Phone
                      CustomTextField(
                        label: 'PHONE NUMBER',
                        hintText: '+1 234 567 8900',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_outlined,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),

              // Save button
              CustomButton(
                text: 'SAVE CHANGES',
                onPressed: controller.saveProfile,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
