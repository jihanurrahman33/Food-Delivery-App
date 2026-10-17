import '../../../../core/services/mock_data_service.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final List<String> _favoriteIds = ['rest_1', 'rest_3'];

  @override
  Future<List<RestaurantEntity>> getRestaurants({String? categoryId, String? searchQuery}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var list = MockDataService.restaurants.map((r) {
      return RestaurantEntity(
        id: r.id,
        name: r.name,
        imageUrl: r.imageUrl,
        logoUrl: r.logoUrl,
        rating: r.rating,
        ratingCount: r.ratingCount,
        deliveryTime: r.deliveryTime,
        deliveryFee: r.deliveryFee,
        distanceKm: r.distanceKm,
        address: r.address,
        tags: r.tags,
        isOpen: r.isOpen,
        isFeatured: r.isFeatured,
        isFavorite: _favoriteIds.contains(r.id),
      );
    }).toList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list.where((r) => r.name.toLowerCase().contains(q) || r.tags.any((t) => t.toLowerCase().contains(q))).toList();
    }

    return list;
  }

  @override
  Future<RestaurantEntity?> getRestaurantById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final r = MockDataService.restaurants.firstWhere(
      (element) => element.id == id,
      orElse: () => MockDataService.restaurants.first,
    );
    return RestaurantEntity(
      id: r.id,
      name: r.name,
      imageUrl: r.imageUrl,
      logoUrl: r.logoUrl,
      rating: r.rating,
      ratingCount: r.ratingCount,
      deliveryTime: r.deliveryTime,
      deliveryFee: r.deliveryFee,
      distanceKm: r.distanceKm,
      address: r.address,
      tags: r.tags,
      isOpen: r.isOpen,
      isFeatured: r.isFeatured,
      isFavorite: _favoriteIds.contains(r.id),
    );
  }

  @override
  Future<List<FoodItemEntity>> getFoodItemsByRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final items = MockDataService.foods.where((f) => f.restaurantId == restaurantId).toList();
    if (items.isEmpty) {
      return MockDataService.foods;
    }
    return items;
  }

  @override
  Future<List<FoodItemEntity>> searchFoods(String query) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final q = query.toLowerCase();
    return MockDataService.foods.where((f) => f.name.toLowerCase().contains(q) || f.description.toLowerCase().contains(q)).toList();
  }

  @override
  Future<void> toggleFavoriteRestaurant(String restaurantId) async {
    if (_favoriteIds.contains(restaurantId)) {
      _favoriteIds.remove(restaurantId);
    } else {
      _favoriteIds.add(restaurantId);
    }
  }

  @override
  Future<List<RestaurantEntity>> getFavoriteRestaurants() async {
    final all = await getRestaurants();
    return all.where((r) => _favoriteIds.contains(r.id)).toList();
  }
}
