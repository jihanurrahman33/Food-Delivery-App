import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../routes/app_routes.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartController extends GetxController {
  final RxList<CartItemEntity> items = <CartItemEntity>[].obs;
  final RxString appliedPromoCode = ''.obs;
  final RxDouble promoDiscountRate = 0.0.obs;
  final RxString currentRestaurantId = ''.obs;
  final RxString currentRestaurantName = ''.obs;

  final promoTextController = TextEditingController();

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee {
    if (items.isEmpty) return 0.0;
    if (subtotal >= AppConstants.freeDeliveryThreshold) return 0.0;
    return AppConstants.defaultDeliveryFee;
  }

  double get tax => subtotal * AppConstants.defaultTaxRate;

  double get discountAmount => subtotal * promoDiscountRate.value;

  double get total =>
      items.isEmpty ? 0.0 : (subtotal + deliveryFee + tax - discountAmount);

  bool get isEmpty => items.isEmpty;

  void addItem({
    required FoodItemEntity foodItem,
    int quantity = 1,
    List<FoodAddon> selectedAddons = const [],
    String? specialInstructions,
  }) {
    // If cart has items from different restaurant, prompt or reset
    if (items.isNotEmpty && currentRestaurantId.value != foodItem.restaurantId) {
      Get.defaultDialog(
        title: 'Start New Order?',
        middleText:
            'Your cart contains items from ${currentRestaurantName.value}. Would you like to clear your cart and add this item?',
        textConfirm: 'Yes, Start New',
        textCancel: 'Cancel',
        confirmTextColor: Colors.white,
        onConfirm: () {
          clearCart();
          _addNewItem(foodItem, quantity, selectedAddons, specialInstructions);
          Get.back();
        },
      );
      return;
    }

    _addNewItem(foodItem, quantity, selectedAddons, specialInstructions);
  }

  void _addNewItem(
    FoodItemEntity foodItem,
    int quantity,
    List<FoodAddon> selectedAddons,
    String? specialInstructions,
  ) {
    currentRestaurantId.value = foodItem.restaurantId;
    currentRestaurantName.value = foodItem.restaurantName;

    final existingIndex = items.indexWhere((item) =>
        item.foodItem.id == foodItem.id &&
        _areAddonsEqual(item.selectedAddons, selectedAddons));

    if (existingIndex != -1) {
      final old = items[existingIndex];
      items[existingIndex] = old.copyWith(quantity: old.quantity + quantity);
    } else {
      items.add(
        CartItemEntity(
          id: const Uuid().v4(),
          foodItem: foodItem,
          quantity: quantity,
          selectedAddons: selectedAddons,
          specialInstructions: specialInstructions,
        ),
      );
    }

    AppSnackbar.cartAdded(
      itemName: foodItem.name,
      price: foodItem.price,
      onCheckout: () => Get.toNamed(AppRoutes.cart),
    );
  }

  bool _areAddonsEqual(List<FoodAddon> a, List<FoodAddon> b) {
    if (a.length != b.length) return false;
    final setA = a.map((e) => e.id).toSet();
    final setB = b.map((e) => e.id).toSet();
    return setA.containsAll(setB);
  }

  void incrementQuantity(String cartItemId) {
    final index = items.indexWhere((e) => e.id == cartItemId);
    if (index != -1) {
      items[index] =
          items[index].copyWith(quantity: items[index].quantity + 1);
    }
  }

  void decrementQuantity(String cartItemId) {
    final index = items.indexWhere((e) => e.id == cartItemId);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index] =
            items[index].copyWith(quantity: items[index].quantity - 1);
      } else {
        items.removeAt(index);
        if (items.isEmpty) {
          currentRestaurantId.value = '';
          currentRestaurantName.value = '';
        }
      }
    }
  }

  void removeItem(String cartItemId) {
    items.removeWhere((e) => e.id == cartItemId);
    if (items.isEmpty) {
      currentRestaurantId.value = '';
      currentRestaurantName.value = '';
    }
  }

  void applyPromo(String code) {
    final clean = code.trim().toUpperCase();
    if (clean == 'SAVE20' || clean == 'DISCOUNT20') {
      appliedPromoCode.value = clean;
      promoDiscountRate.value = 0.20;
      AppSnackbar.success('Promo Applied', '20% discount has been applied!');
    } else if (clean == 'WELCOME50') {
      appliedPromoCode.value = clean;
      promoDiscountRate.value = 0.50;
      AppSnackbar.success('Promo Applied', '50% discount has been applied!');
    } else {
      AppSnackbar.error('Invalid Coupon', 'Code "$code" is not valid or expired.');
    }
  }

  void removePromo() {
    appliedPromoCode.value = '';
    promoDiscountRate.value = 0.0;
  }

  void clearCart() {
    items.clear();
    appliedPromoCode.value = '';
    promoDiscountRate.value = 0.0;
    currentRestaurantId.value = '';
    currentRestaurantName.value = '';
  }
}
