import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String logoUrl;
  final double rating;
  final int ratingCount;
  final String deliveryTime; // e.g. "20-25 min"
  final double deliveryFee;
  final double distanceKm;
  final String address;
  final List<String> tags; // e.g. ["Burger", "Fast Food", "American"]
  final bool isOpen;
  final bool isFeatured;
  final bool isFavorite;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.logoUrl,
    required this.rating,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distanceKm,
    required this.address,
    required this.tags,
    this.isOpen = true,
    this.isFeatured = false,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        logoUrl,
        rating,
        ratingCount,
        deliveryTime,
        deliveryFee,
        distanceKm,
        address,
        tags,
        isOpen,
        isFeatured,
        isFavorite,
      ];
}

class FoodItemEntity extends Equatable {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final String categoryId;
  final int calories;
  final int prepTimeMinutes;
  final bool isPopular;
  final bool isSpicy;
  final bool isVegetarian;
  final List<FoodAddon> availableAddons;

  const FoodItemEntity({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.categoryId,
    this.calories = 450,
    this.prepTimeMinutes = 15,
    this.isPopular = false,
    this.isSpicy = false,
    this.isVegetarian = false,
    this.availableAddons = const [],
  });

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        restaurantName,
        name,
        description,
        price,
        imageUrl,
        rating,
        ratingCount,
        categoryId,
        calories,
        prepTimeMinutes,
        isPopular,
        isSpicy,
        isVegetarian,
        availableAddons,
      ];
}

class FoodAddon extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isSelected;

  const FoodAddon({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });

  FoodAddon copyWith({bool? isSelected}) {
    return FoodAddon(
      id: id,
      name: name,
      price: price,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, price, isSelected];
}
