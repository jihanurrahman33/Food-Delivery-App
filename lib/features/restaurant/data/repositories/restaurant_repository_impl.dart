import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../models/restaurant_model.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final ApiClient apiClient;

  RestaurantRepositoryImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? Get.find<ApiClient>();

  @override
  Future<List<RestaurantEntity>> getRestaurants(
      {String? categoryId, String? searchQuery}) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null && categoryId.isNotEmpty && categoryId != 'cat_all') {
      queryParams['categoryId'] = categoryId;
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['search'] = searchQuery;
    }

    final response = await apiClient.get('/restaurants', queryParams: queryParams);
    if (response is List) {
      return response
          .map((r) => RestaurantModel.fromJson(r as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<RestaurantEntity?> getRestaurantById(String id) async {
    final response = await apiClient.get('/restaurants/$id');
    if (response is Map<String, dynamic>) {
      return RestaurantModel.fromJson(response);
    }
    return null;
  }

  @override
  Future<List<FoodItemEntity>> getFoodItemsByRestaurant(String restaurantId) async {
    final response = await apiClient.get('/restaurants/$restaurantId/foods');
    if (response is List) {
      return response
          .map((f) => FoodItemModel.fromJson(f as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<List<FoodItemEntity>> searchFoods(String query) async {
    final response =
        await apiClient.get('/foods/search', queryParams: {'query': query});
    if (response is List) {
      return response
          .map((f) => FoodItemModel.fromJson(f as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> toggleFavoriteRestaurant(String restaurantId) async {
    await apiClient.post(
      '/favorites/toggle',
      body: {'restaurantId': restaurantId},
    );
  }

  @override
  Future<List<RestaurantEntity>> getFavoriteRestaurants() async {
    final response = await apiClient.get('/favorites');
    if (response is List) {
      return response
          .map((r) => RestaurantModel.fromJson(r as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
