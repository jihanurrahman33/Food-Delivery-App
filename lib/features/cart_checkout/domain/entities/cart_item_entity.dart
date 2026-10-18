import 'package:equatable/equatable.dart';
import '../../../restaurant/domain/entities/restaurant_entity.dart';

class CartItemEntity extends Equatable {
  final String id;
  final FoodItemEntity foodItem;
  final int quantity;
  final List<FoodAddon> selectedAddons;
  final String? specialInstructions;

  const CartItemEntity({
    required this.id,
    required this.foodItem,
    required this.quantity,
    this.selectedAddons = const [],
    this.specialInstructions,
  });

  double get unitPrice {
    double total = foodItem.price;
    for (final addon in selectedAddons) {
      total += addon.price;
    }
    return total;
  }

  double get totalPrice => unitPrice * quantity;

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      id: json['id'] as String? ?? '',
      foodItem: FoodItemEntity(
        id: json['foodItemId'] as String? ?? json['foodId'] as String? ?? json['id'] as String? ?? '',
        restaurantId: json['restaurantId'] as String? ?? '',
        restaurantName: json['restaurantName'] as String? ?? '',
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        imageUrl: json['imageUrl'] as String? ?? '',
        rating: 4.8,
        ratingCount: 50,
        categoryId: json['categoryId'] as String? ?? '',
      ),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      selectedAddons: (json['selectedAddons'] as List<dynamic>?)
              ?.map((a) => FoodAddon(
                    id: a['id'] as String? ?? '',
                    name: a['name'] as String? ?? '',
                    price: (a['price'] as num?)?.toDouble() ?? 0.0,
                  ))
              .toList() ??
          [],
      specialInstructions: json['specialInstructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodItemId': foodItem.id,
      'name': foodItem.name,
      'price': foodItem.price,
      'quantity': quantity,
      'selectedAddonIds': selectedAddons.map((a) => a.id).toList(),
      'specialInstructions': specialInstructions,
    };
  }

  CartItemEntity copyWith({
    String? id,
    FoodItemEntity? foodItem,
    int? quantity,
    List<FoodAddon>? selectedAddons,
    String? specialInstructions,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      selectedAddons: selectedAddons ?? this.selectedAddons,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        foodItem,
        quantity,
        selectedAddons,
        specialInstructions,
      ];
}

class AddressEntity extends Equatable {
  final String id;
  final String label; // "Home", "Work", "Other"
  final String fullAddress;
  final String street;
  final String? apartment;
  final String? deliveryNotes;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.street,
    this.apartment,
    this.deliveryNotes,
    this.isDefault = false,
  });

  AddressEntity copyWith({
    String? id,
    String? label,
    String? fullAddress,
    String? street,
    String? apartment,
    String? deliveryNotes,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? 'Home',
      fullAddress: json['fullAddress'] as String? ?? '',
      street: json['street'] as String? ?? '',
      apartment: json['apartment'] as String?,
      deliveryNotes: json['deliveryNotes'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'fullAddress': fullAddress,
      'street': street,
      'apartment': apartment,
      'deliveryNotes': deliveryNotes,
      'isDefault': isDefault,
    };
  }

  @override
  List<Object?> get props => [
        id,
        label,
        fullAddress,
        street,
        apartment,
        deliveryNotes,
        isDefault,
      ];
}

class PaymentCardEntity extends Equatable {
  final String id;
  final String cardHolderName;
  final String cardNumber; // e.g. "**** **** **** 4242"
  final String expiryDate; // "MM/YY"
  final String brand; // "Visa", "Mastercard"
  final bool isDefault;

  const PaymentCardEntity({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.brand,
    this.isDefault = false,
  });

  factory PaymentCardEntity.fromJson(Map<String, dynamic> json) {
    return PaymentCardEntity(
      id: json['id'] as String? ?? '',
      cardHolderName: json['cardHolderName'] as String? ?? '',
      cardNumber: json['cardNumber'] as String? ?? '•••• •••• •••• 4242',
      expiryDate: json['expiryDate'] as String? ?? '12/28',
      brand: json['brand'] as String? ?? 'Visa',
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'brand': brand,
      'isDefault': isDefault,
    };
  }

  PaymentCardEntity copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? brand,
    bool? isDefault,
  }) {
    return PaymentCardEntity(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      brand: brand ?? this.brand,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cardHolderName,
        cardNumber,
        expiryDate,
        brand,
        isDefault,
      ];
}
