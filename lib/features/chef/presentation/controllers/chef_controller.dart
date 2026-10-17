import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/mock_data_service.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';

class ChefController extends GetxController {
  final RxBool isKitchenOpen = true.obs;
  final RxDouble todaySales = 684.50.obs;
  final RxInt todayOrdersCount = 24.obs;
  final RxDouble chefRating = 4.9.obs;

  // Orders list for kitchen
  final RxList<Map<String, dynamic>> kitchenOrders = <Map<String, dynamic>>[
    {
      'id': 'KTC-104',
      'customerName': 'Sarah Connor',
      'time': '3 min ago',
      'items': ['2x Smash Cheeseburger (Extra Bacon)', '1x Truffle Fries'],
      'status': 'Pending',
      'total': 28.50,
      'notes': 'Allergies: No peanuts please.',
    },
    {
      'id': 'KTC-103',
      'customerName': 'Michael Scott',
      'time': '12 min ago',
      'items': ['1x Spicy Crispy Chicken Deluxe', '1x Coke Zero'],
      'status': 'Preparing',
      'total': 15.00,
      'notes': 'Extra crispy fries if possible!',
    },
    {
      'id': 'KTC-102',
      'customerName': 'David Miller',
      'time': '25 min ago',
      'items': ['1x Woodfired Margherita DOC'],
      'status': 'Ready for Pickup',
      'total': 16.75,
      'notes': 'Cut into 8 slices.',
    },
  ].obs;

  // Dishes managed by Chef
  final RxList<FoodItemEntity> chefDishes = <FoodItemEntity>[].obs;

  // Add dish form controllers
  final dishNameController = TextEditingController();
  final dishPriceController = TextEditingController();
  final dishPrepTimeController = TextEditingController(text: '15');
  final dishCaloriesController = TextEditingController(text: '500');
  final dishDescriptionController = TextEditingController();
  final RxString selectedDishCategory = 'cat_burger'.obs;

  @override
  void onInit() {
    super.onInit();
    chefDishes.assignAll(MockDataService.foods);
  }

  void toggleKitchenStatus(bool value) {
    isKitchenOpen.value = value;
    Get.snackbar(
      'Kitchen Status',
      value ? 'Your kitchen is now OPEN for orders' : 'Kitchen is closed',
      backgroundColor: value ? Colors.green : Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void acceptOrder(String orderId) {
    final idx = kitchenOrders.indexWhere((o) => o['id'] == orderId);
    if (idx != -1) {
      kitchenOrders[idx]['status'] = 'Preparing';
      kitchenOrders.refresh();
      Get.snackbar('Order Accepted', 'Order #$orderId moved to Preparing',
          backgroundColor: Colors.blueAccent, colorText: Colors.white);
    }
  }

  void markOrderReady(String orderId) {
    final idx = kitchenOrders.indexWhere((o) => o['id'] == orderId);
    if (idx != -1) {
      kitchenOrders[idx]['status'] = 'Ready for Pickup';
      kitchenOrders.refresh();
      Get.snackbar('Order Ready', 'Delivery rider notified for pickup!',
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  void rejectOrder(String orderId) {
    kitchenOrders.removeWhere((o) => o['id'] == orderId);
    Get.snackbar('Order Declined', 'Order #$orderId was declined',
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }

  void addNewDish() {
    final name = dishNameController.text.trim();
    final priceStr = dishPriceController.text.trim();
    if (name.isEmpty || priceStr.isEmpty) {
      Get.snackbar('Required', 'Please fill in dish name and price',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    final price = double.tryParse(priceStr) ?? 9.99;
    final prep = int.tryParse(dishPrepTimeController.text) ?? 15;
    final cal = int.tryParse(dishCaloriesController.text) ?? 500;

    final newDish = FoodItemEntity(
      id: const Uuid().v4(),
      restaurantId: 'rest_1',
      restaurantName: 'Rose Garden Bakehouse',
      name: name,
      description: dishDescriptionController.text.trim().isEmpty
          ? 'Fresh chef special made with artisan ingredients.'
          : dishDescriptionController.text.trim(),
      price: price,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80',
      rating: 5.0,
      ratingCount: 1,
      categoryId: selectedDishCategory.value,
      calories: cal,
      prepTimeMinutes: prep,
    );

    chefDishes.insert(0, newDish);

    // Reset form
    dishNameController.clear();
    dishPriceController.clear();
    dishDescriptionController.clear();

    Get.back();
    Get.snackbar('Dish Added', '$name has been added to your menu!',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
