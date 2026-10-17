import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.signup,
                style: AppTextStyles.heading1(
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create an account to start ordering your favorite foods',
                style: AppTextStyles.bodyMedium(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 28),

              // Name
              CustomTextField(
                label: 'FULL NAME',
                hintText: 'John Doe',
                controller: controller.nameController,
                validator: Validators.validateName,
                prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
              ),
              const SizedBox(height: 18),

              // Email
              CustomTextField(
                label: 'EMAIL',
                hintText: 'example@gmail.com',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
              ),
              const SizedBox(height: 18),

              // Phone
              CustomTextField(
                label: 'PHONE NUMBER',
                hintText: '+1 234 567 8900',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
              ),
              const SizedBox(height: 18),

              // Password
              Obx(
                () => CustomTextField(
                  label: 'PASSWORD',
                  hintText: '••••••••',
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  validator: Validators.validatePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiaryLight,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Confirm Password
              Obx(
                () => CustomTextField(
                  label: 'RE-TYPE PASSWORD',
                  hintText: '••••••••',
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  validator: Validators.validatePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: isDark
                          ? AppColors.textTertiaryDark
                          : AppColors.textTertiaryLight,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Sign Up button
              Obx(
                () => CustomButton(
                  text: 'SIGN UP',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.signUp,
                ),
              ),
              const SizedBox(height: 20),

              // Login redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTextStyles.bodyMedium(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.offNamed(AppRoutes.login),
                    child: Text(
                      'LOG IN',
                      style: AppTextStyles.subtitle2(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
