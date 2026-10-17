import 'package:equatable/equatable.dart';
import '../../../cart_checkout/domain/entities/cart_item_entity.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing Food';
      case OrderStatus.onTheWay:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.confirmed:
        return 1;
      case OrderStatus.preparing:
        return 2;
      case OrderStatus.onTheWay:
        return 3;
      case OrderStatus.delivered:
        return 4;
      case OrderStatus.cancelled:
        return -1;
    }
  }
}

class DeliveryRiderEntity extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String avatarUrl;
  final double rating;
  final String vehicleType; // "Motorcycle", "Bicycle"
  final String licensePlate;

  const DeliveryRiderEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatarUrl,
    required this.rating,
    required this.vehicleType,
    required this.licensePlate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        avatarUrl,
        rating,
        vehicleType,
        licensePlate,
      ];
}

class OrderEntity extends Equatable {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String restaurantImageUrl;
  final List<CartItemEntity> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final String deliveryAddress;
  final String paymentMethod;
  final DeliveryRiderEntity? rider;
  final int estimatedDeliveryMinutes;

  const OrderEntity({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImageUrl,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.rider,
    this.estimatedDeliveryMinutes = 25,
  });

  OrderEntity copyWith({
    String? id,
    String? restaurantId,
    String? restaurantName,
    String? restaurantImageUrl,
    List<CartItemEntity>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? discount,
    double? total,
    OrderStatus? status,
    DateTime? createdAt,
    String? deliveryAddress,
    String? paymentMethod,
    DeliveryRiderEntity? rider,
    int? estimatedDeliveryMinutes,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImageUrl: restaurantImageUrl ?? this.restaurantImageUrl,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      rider: rider ?? this.rider,
      estimatedDeliveryMinutes:
          estimatedDeliveryMinutes ?? this.estimatedDeliveryMinutes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        restaurantName,
        restaurantImageUrl,
        items,
        subtotal,
        deliveryFee,
        tax,
        discount,
        total,
        status,
        createdAt,
        deliveryAddress,
        paymentMethod,
        rider,
        estimatedDeliveryMinutes,
      ];
}

class ChatMessageEntity extends Equatable {
  final String id;
  final String text;
  final bool isSender;
  final DateTime timestamp;
  final bool isRead;

  const ChatMessageEntity({
    required this.id,
    required this.text,
    required this.isSender,
    required this.timestamp,
    this.isRead = true,
  });

  @override
  List<Object?> get props => [id, text, isSender, timestamp, isRead];
}
