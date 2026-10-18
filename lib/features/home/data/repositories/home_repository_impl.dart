import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../restaurant/data/models/food_item_model.dart';
import '../../../restaurant/data/models/restaurant_model.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';
import '../../data/models/category_model.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? Get.find<ApiClient>();

  @override
  Future<List<BannerEntity>> getBanners() async {
    final response = await apiClient.get('/home/banners');
    if (response is List) {
      return response
          .map((b) => BannerModel.fromJson(b as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await apiClient.get('/home/categories');
    if (response is List) {
      return response
          .map((c) => CategoryModel.fromJson(c as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<List<RestaurantEntity>> getFeaturedRestaurants() async {
    final response = await apiClient.get('/restaurants');
    if (response is List) {
      final restaurants = response
          .map((r) => RestaurantModel.fromJson(r as Map<String, dynamic>))
          .toList();
      final featured = restaurants.where((r) => r.isFeatured).toList();
      return featured.isNotEmpty ? featured : restaurants;
    }
    return [];
  }

  @override
  Future<List<FoodItemEntity>> getPopularFoods() async {
    final response = await apiClient.get('/foods/search');
    if (response is List) {
      final foods = response
          .map((f) => FoodItemModel.fromJson(f as Map<String, dynamic>))
          .toList();
      final popular = foods.where((f) => f.isPopular).toList();
      return popular.isNotEmpty ? popular : foods;
    }
    return [];
  }
}
