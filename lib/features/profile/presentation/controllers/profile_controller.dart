import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository;
  final StorageService storageService;

  ProfileController({
    required this.authRepository,
    required this.storageService,
  });

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final RxString activeRole = 'customer'.obs; // customer, chef, rider

  // Edit Profile Form
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Notifications
  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[
    {
      'id': 'notif_1',
      'title': 'Your order has been picked up!',
      'description': 'Robert Fox is on the way with your delicious meal from Rose Garden Bakehouse.',
      'time': '10 min ago',
      'icon': Icons.delivery_dining_rounded,
      'isRead': false,
    },
    {
      'id': 'notif_2',
      'title': 'Flash Deal: 40% OFF Gourmet Burgers',
      'description': 'Use promo code SAVE20 on your next order. Valid until midnight!',
      'time': '2 hours ago',
      'icon': Icons.local_offer_rounded,
      'isRead': true,
    },
    {
      'id': 'notif_3',
      'title': 'Payment Confirmed',
      'description': 'Payment of \$33.12 via Visa •••• 4242 was successful.',
      'time': 'Yesterday',
      'icon': Icons.check_circle_rounded,
      'isRead': true,
    },
  ].obs;

  ApiClient get apiClient => Get.find<ApiClient>();

  @override
  void onInit() {
    super.onInit();
    activeRole.value = storageService.userRole;
    loadUserData();
    loadNotifications();
  }

  Future<void> loadUserData() async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      currentUser.value = user;
      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;
    }
  }

  Future<void> loadNotifications() async {
    try {
      final res = await apiClient.get('/notifications');
      if (res is List) {
        final mapped = res.map((n) {
          final map = n as Map<String, dynamic>;
          IconData icon = Icons.notifications_rounded;
          final iconName = map['iconName'] as String?;
          if (iconName == 'delivery_dining') {
            icon = Icons.delivery_dining_rounded;
          } else if (iconName == 'local_offer') {
            icon = Icons.local_offer_rounded;
          } else if (iconName == 'check_circle') {
            icon = Icons.check_circle_rounded;
          }
          return {
            'id': map['id'],
            'title': map['title'],
            'description': map['description'],
            'time': map['time'] ?? 'Just now',
            'icon': icon,
            'isRead': map['isRead'] ?? false,
          };
        }).toList();
        notifications.assignAll(mapped);
      }
    } catch (_) {}
  }

  void switchRole(String role) {
    activeRole.value = role;
    storageService.userRole = role;
    AppSnackbar.info(
      'Role Switched',
      'Switched view to ${role.capitalizeFirst} Mode',
    );
  }

  Future<void> saveProfile() async {
    if (currentUser.value != null) {
      final updated = UserEntity(
        id: currentUser.value!.id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        avatarUrl: currentUser.value!.avatarUrl,
        role: currentUser.value!.role,
        address: currentUser.value!.address,
      );
      await authRepository.updateUserProfile(updated);
      currentUser.value = updated;
      Get.back();
      AppSnackbar.success('Profile Updated', 'Your profile details have been saved.');
    }
  }

  Future<void> markAllNotificationsRead() async {
    try {
      await apiClient.put('/notifications/mark-read');
    } catch (_) {}
    for (var n in notifications) {
      n['isRead'] = true;
    }
    notifications.refresh();
  }
}

class SettingsController extends GetxController {
  final StorageService storageService;

  SettingsController({required this.storageService});

  final RxBool isDarkMode = false.obs;
  final RxBool pushNotifications = true.obs;
  final RxBool promoNotifications = true.obs;
  final RxBool biometricLogin = false.obs;
  final RxString selectedLanguage = 'English (US)'.obs;
  final RxString selectedCurrency = 'USD (\$)'.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = storageService.isDarkMode;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    storageService.isDarkMode = value;
    Get.changeTheme(value ? AppTheme.darkTheme : AppTheme.lightTheme);
  }

  void togglePush(bool value) => pushNotifications.value = value;
  void togglePromo(bool value) => promoNotifications.value = value;
  void toggleBiometric(bool value) => biometricLogin.value = value;
}
