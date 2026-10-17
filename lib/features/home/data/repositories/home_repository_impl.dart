import '../../../../core/services/mock_data_service.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<BannerEntity>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.banners;
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.categories;
  }

  @override
  Future<List<RestaurantEntity>> getFeaturedRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.restaurants;
  }

  @override
  Future<List<FoodItemEntity>> getPopularFoods() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.foods;
  }
}
