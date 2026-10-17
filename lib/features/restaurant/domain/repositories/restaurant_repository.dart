import '../entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<List<RestaurantEntity>> getRestaurants({String? categoryId, String? searchQuery});
  Future<RestaurantEntity?> getRestaurantById(String id);
  Future<List<FoodItemEntity>> getFoodItemsByRestaurant(String restaurantId);
  Future<List<FoodItemEntity>> searchFoods(String query);
  Future<void> toggleFavoriteRestaurant(String restaurantId);
  Future<List<RestaurantEntity>> getFavoriteRestaurants();
}
