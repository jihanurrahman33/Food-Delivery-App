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

  factory DeliveryRiderEntity.fromJson(Map<String, dynamic> json) {
    return DeliveryRiderEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Rider',
      phone: json['phone'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ??
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      vehicleType: json['vehicleType'] as String? ?? 'Motorcycle',
      licensePlate: json['licensePlate'] as String? ?? 'NYC-5491',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'rating': rating,
      'vehicleType': vehicleType,
      'licensePlate': licensePlate,
    };
  }

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

  static OrderStatus _parseStatus(String? val) {
    switch (val?.toLowerCase()) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'ontheway':
      case 'on_the_way':
        return OrderStatus.onTheWay;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  static String _statusToString(OrderStatus s) {
    switch (s) {
      case OrderStatus.confirmed:
        return 'confirmed';
      case OrderStatus.preparing:
        return 'preparing';
      case OrderStatus.onTheWay:
        return 'onTheWay';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
      case OrderStatus.pending:
        return 'pending';
    }
  }

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return OrderEntity(
      id: json['id'] as String? ?? '',
      restaurantId: json['restaurantId'] as String? ?? '',
      restaurantName: json['restaurantName'] as String? ?? '',
      restaurantImageUrl: json['restaurantImageUrl'] as String? ??
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
      items: rawItems
          .map((i) => CartItemEntity.fromJson(i as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: _parseStatus(json['status'] as String?),
      createdAt: json['createdAt'] != null
          ? (DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now())
          : DateTime.now(),
      deliveryAddress: json['deliveryAddress'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? 'card',
      rider: json['rider'] != null && json['rider'] is Map<String, dynamic>
          ? DeliveryRiderEntity.fromJson(json['rider'] as Map<String, dynamic>)
          : null,
      estimatedDeliveryMinutes:
          (json['estimatedDeliveryMinutes'] as num?)?.toInt() ?? 25,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantImageUrl': restaurantImageUrl,
      'items': items.map((i) => i.toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'discount': discount,
      'total': total,
      'status': _statusToString(status),
      'createdAt': createdAt.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'rider': rider?.toJson(),
      'estimatedDeliveryMinutes': estimatedDeliveryMinutes,
    };
  }

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

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json, {String currentUserId = ''}) {
    final senderId = json['senderId'] as String? ?? '';
    final senderRole = json['senderRole'] as String? ?? '';
    final isSender = json['isSender'] as bool? ??
        (currentUserId.isNotEmpty ? senderId == currentUserId : senderRole == 'customer');
    return ChatMessageEntity(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      isSender: isSender,
      timestamp: json['timestamp'] != null
          ? (DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now())
          : DateTime.now(),
      isRead: json['isRead'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isSender': isSender,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  @override
  List<Object?> get props => [id, text, isSender, timestamp, isRead];
}
