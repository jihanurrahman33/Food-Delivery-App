import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';
import '../../../restaurant/domain/repositories/restaurant_repository.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;
  final RestaurantRepository restaurantRepository;

  HomeController({
    required this.homeRepository,
    required this.restaurantRepository,
  });

  final RxBool isLoading = false.obs;
  final RxList<BannerEntity> banners = <BannerEntity>[].obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final Rx<CategoryEntity?> selectedCategory = Rx<CategoryEntity?>(null);

  final RxList<RestaurantEntity> featuredRestaurants = <RestaurantEntity>[].obs;
  final RxList<FoodItemEntity> popularFoods = <FoodItemEntity>[].obs;

  // Search state
  final searchTextController = TextEditingController();
  final RxString currentSearchQuery = ''.obs;
  final RxList<RestaurantEntity> searchRestaurantResults = <RestaurantEntity>[].obs;
  final RxList<FoodItemEntity> searchFoodResults = <FoodItemEntity>[].obs;
  final RxList<String> recentSearches = <String>[
    'Cheeseburger',
    'Margherita Pizza',
    'Ramen',
    'Mexican Tacos',
  ].obs;

  // Filter state
  final RxDouble minRating = 4.0.obs;
  final RxDouble maxDeliveryFee = 5.0.obs;
  final RxDouble maxDeliveryMinutes = 45.0.obs;
  final RxString selectedDietary = 'All'.obs; // All, Veg, Spicy
  final RxString sortBy = 'Recommended'.obs; // Recommended, Fast Delivery, Top Rated

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        homeRepository.getBanners(),
        homeRepository.getCategories(),
        homeRepository.getFeaturedRestaurants(),
        homeRepository.getPopularFoods(),
      ]);

      banners.assignAll(results[0] as List<BannerEntity>);
      categories.assignAll(results[1] as List<CategoryEntity>);
      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first;
      }
      featuredRestaurants.assignAll(results[2] as List<RestaurantEntity>);
      popularFoods.assignAll(results[3] as List<FoodItemEntity>);
    } catch (e) {
      AppSnackbar.error('Data Loading Error', 'Unable to retrieve menu: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(CategoryEntity category) {
    selectedCategory.value = category;
  }

  Future<void> search(String query) async {
    currentSearchQuery.value = query;
    if (query.trim().isEmpty) {
      searchRestaurantResults.clear();
      searchFoodResults.clear();
      return;
    }

    if (!recentSearches.contains(query.trim())) {
      recentSearches.insert(0, query.trim());
      if (recentSearches.length > 8) recentSearches.removeLast();
    }

    final rests = await restaurantRepository.getRestaurants(searchQuery: query);
    final foods = await restaurantRepository.searchFoods(query);

    searchRestaurantResults.assignAll(rests);
    searchFoodResults.assignAll(foods);
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  void applyFilters() {
    // Re-filter restaurants
    var list = featuredRestaurants.where((r) {
      if (r.rating < minRating.value) return false;
      if (r.deliveryFee > maxDeliveryFee.value) return false;
      return true;
    }).toList();

    if (sortBy.value == 'Top Rated') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (sortBy.value == 'Fast Delivery') {
      list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    }

    featuredRestaurants.assignAll(list);
    Get.back();
  }

  void resetFilters() {
    minRating.value = 4.0;
    maxDeliveryFee.value = 5.0;
    maxDeliveryMinutes.value = 45.0;
    selectedDietary.value = 'All';
    sortBy.value = 'Recommended';
    loadHomeData();
    Get.back();
  }
}
