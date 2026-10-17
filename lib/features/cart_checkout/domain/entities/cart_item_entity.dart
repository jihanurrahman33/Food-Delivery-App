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
