import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantController extends GetxController {
  final RestaurantRepository restaurantRepository;

  RestaurantController({required this.restaurantRepository});

  final Rx<RestaurantEntity?> currentRestaurant = Rx<RestaurantEntity?>(null);
  final RxList<FoodItemEntity> menuItems = <FoodItemEntity>[].obs;
  final RxBool isLoading = false.obs;

  // Selected food item for customization
  final Rx<FoodItemEntity?> selectedFood = Rx<FoodItemEntity?>(null);
  final RxInt customizationQuantity = 1.obs;
  final RxList<FoodAddon> selectedAddons = <FoodAddon>[].obs;
  final specialInstructionsController = TextEditingController();

  // Active menu category tab
  final RxString selectedCategoryTab = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is RestaurantEntity) {
      loadRestaurantDetails(args);
    } else if (args is String) {
      loadRestaurantById(args);
    }
  }

  Future<void> loadRestaurantDetails(RestaurantEntity restaurant) async {
    currentRestaurant.value = restaurant;
    try {
      isLoading.value = true;
      final items = await restaurantRepository.getFoodItemsByRestaurant(restaurant.id);
      menuItems.assignAll(items);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      isLoading.value = true;
      final r = await restaurantRepository.getRestaurantById(id);
      if (r != null) {
        currentRestaurant.value = r;
        final items = await restaurantRepository.getFoodItemsByRestaurant(id);
        menuItems.assignAll(items);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void openCustomization(FoodItemEntity food) {
    selectedFood.value = food;
    customizationQuantity.value = 1;
    selectedAddons.clear();
    specialInstructionsController.clear();
  }

  void toggleAddon(FoodAddon addon) {
    final existing = selectedAddons.indexWhere((a) => a.id == addon.id);
    if (existing != -1) {
      selectedAddons.removeAt(existing);
    } else {
      selectedAddons.add(addon);
    }
  }

  bool isAddonSelected(FoodAddon addon) {
    return selectedAddons.any((a) => a.id == addon.id);
  }

  double get customizedPrice {
    if (selectedFood.value == null) return 0.0;
    double base = selectedFood.value!.price;
    for (final addon in selectedAddons) {
      base += addon.price;
    }
    return base * customizationQuantity.value;
  }

  void incrementCustomizationQuantity() {
    customizationQuantity.value++;
  }

  void decrementCustomizationQuantity() {
    if (customizationQuantity.value > 1) {
      customizationQuantity.value--;
    }
  }

  Future<void> toggleFavorite() async {
    if (currentRestaurant.value != null) {
      await restaurantRepository.toggleFavoriteRestaurant(currentRestaurant.value!.id);
      final updated = currentRestaurant.value!.isFavorite;
      // reload
      final r = await restaurantRepository.getRestaurantById(currentRestaurant.value!.id);
      if (r != null) {
        currentRestaurant.value = r;
      }
      if (updated) {
        AppSnackbar.info('Removed', 'Removed from favorites');
      } else {
        AppSnackbar.success('Saved', 'Saved to favorite restaurants');
      }
    }
  }
}
