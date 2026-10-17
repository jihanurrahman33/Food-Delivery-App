import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  final Rx<UserEntity?> _currentUser = Rx<UserEntity?>(null);
  UserEntity? get currentUser => _currentUser.value;

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool rememberMe = true.obs;
  final RxString selectedAddress = '76A Eighth Avenue, New York, NY'.obs;

  // Controllers for text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Verification / OTP state
  final RxList<String> otpDigits = <String>['', '', '', ''].obs;
  final RxInt otpCountdown = 59.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    _currentUser.value = await authRepository.getCurrentUser();
    if (_currentUser.value != null && _currentUser.value!.address != null) {
      selectedAddress.value = _currentUser.value!.address!;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void updateOtpDigit(int index, String value) {
    if (index >= 0 && index < otpDigits.length) {
      otpDigits[index] = value;
    }
  }

  String get otpCode => otpDigits.join('');

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      AppSnackbar.warning('Required Fields', 'Please enter your email and password.');
      return;
    }

    try {
      isLoading.value = true;
      final user = await authRepository.login(email, password);
      _currentUser.value = user;
      Get.offAllNamed(AppRoutes.mainNav);
    } catch (e) {
      AppSnackbar.error('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPass = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppSnackbar.warning('Required Fields', 'Please complete all required fields.');
      return;
    }

    if (password != confirmPass) {
      AppSnackbar.warning('Password Mismatch', 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;
      final user = await authRepository.signUp(name, email, phone, password);
      _currentUser.value = user;
      Get.toNamed(AppRoutes.verification, arguments: email);
    } catch (e) {
      AppSnackbar.error('Signup Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpCode.length < 4) {
      AppSnackbar.warning('Invalid Code', 'Please enter the complete 4-digit code.');
      return;
    }

    try {
      isLoading.value = true;
      final success = await authRepository.verifyOtp(otpCode);
      if (success) {
        Get.offAllNamed(AppRoutes.locationAccess);
      } else {
        AppSnackbar.error('Invalid Code', 'The code entered is incorrect.');
      }
    } catch (e) {
      AppSnackbar.error('Verification Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendForgotPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.warning('Email Required', 'Please enter your registered email address.');
      return;
    }

    try {
      isLoading.value = true;
      await authRepository.sendOtp(email);
      Get.toNamed(AppRoutes.resetPassword);
    } catch (e) {
      AppSnackbar.error('Request Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (password.length < 6) {
      AppSnackbar.warning('Weak Password', 'Password must be at least 6 characters.');
      return;
    }

    if (password != confirm) {
      AppSnackbar.warning('Mismatch', 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;
      await authRepository.resetPassword(password);
      AppSnackbar.success('Success', 'Password has been successfully updated.');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppSnackbar.error('Reset Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  void setAddress(String address) {
    selectedAddress.value = address;
  }
}
