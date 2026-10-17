import '../entities/banner_entity.dart';
import '../entities/category_entity.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';

abstract class HomeRepository {
  Future<List<BannerEntity>> getBanners();
  Future<List<CategoryEntity>> getCategories();
  Future<List<RestaurantEntity>> getFeaturedRestaurants();
  Future<List<FoodItemEntity>> getPopularFoods();
}
