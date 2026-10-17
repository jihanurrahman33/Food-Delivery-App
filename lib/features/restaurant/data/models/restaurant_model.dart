import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.logoUrl,
    required super.rating,
    required super.ratingCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.distanceKm,
    required super.address,
    required super.tags,
    super.isOpen = true,
    super.isFeatured = false,
    super.isFavorite = false,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 100,
      deliveryTime: json['deliveryTime'] as String? ?? '20-25 min',
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 2.99,
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 2.5,
      address: json['address'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isOpen: json['isOpen'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'rating': rating,
      'ratingCount': ratingCount,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'distanceKm': distanceKm,
      'address': address,
      'tags': tags,
      'isOpen': isOpen,
      'isFeatured': isFeatured,
      'isFavorite': isFavorite,
    };
  }
}

class FoodItemModel extends FoodItemEntity {
  const FoodItemModel({
    required super.id,
    required super.restaurantId,
    required super.restaurantName,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.rating,
    required super.ratingCount,
    required super.categoryId,
    super.calories = 450,
    super.prepTimeMinutes = 15,
    super.isPopular = false,
    super.isSpicy = false,
    super.isVegetarian = false,
    super.availableAddons = const [],
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'] as String? ?? '',
      restaurantId: json['restaurantId'] as String? ?? '',
      restaurantName: json['restaurantName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 50,
      categoryId: json['categoryId'] as String? ?? '',
      calories: (json['calories'] as num?)?.toInt() ?? 450,
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 15,
      isPopular: json['isPopular'] as bool? ?? false,
      isSpicy: json['isSpicy'] as bool? ?? false,
      isVegetarian: json['isVegetarian'] as bool? ?? false,
      availableAddons: (json['availableAddons'] as List<dynamic>?)
              ?.map((e) => FoodAddon(
                    id: e['id'] as String? ?? '',
                    name: e['name'] as String? ?? '',
                    price: (e['price'] as num?)?.toDouble() ?? 0.0,
                    isSelected: e['isSelected'] as bool? ?? false,
                  ))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'ratingCount': ratingCount,
      'categoryId': categoryId,
      'calories': calories,
      'prepTimeMinutes': prepTimeMinutes,
      'isPopular': isPopular,
      'isSpicy': isSpicy,
      'isVegetarian': isVegetarian,
      'availableAddons': availableAddons
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'price': e.price,
                'isSelected': e.isSelected,
              })
          .toList(),
    };
  }
}
