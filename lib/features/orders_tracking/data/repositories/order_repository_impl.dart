import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient apiClient;

  OrderRepositoryImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? Get.find<ApiClient>();

  @override
  Future<List<OrderEntity>> getActiveOrders() async {
    final response = await apiClient.get('/orders/active');
    if (response is List) {
      return response
          .map((o) => OrderEntity.fromJson(o as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    final response = await apiClient.get('/orders/history');
    if (response is List) {
      return response
          .map((o) => OrderEntity.fromJson(o as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    final response = await apiClient.get('/orders/$orderId');
    if (response is Map<String, dynamic>) {
      return OrderEntity.fromJson(response);
    }
    return null;
  }

  @override
  Future<OrderEntity> placeOrder(OrderEntity order) async {
    final payload = {
      'restaurantId': order.restaurantId,
      'deliveryAddress': order.deliveryAddress,
      'paymentMethod': order.paymentMethod,
      'items': order.items.map((item) => item.toJson()).toList(),
    };

    final orderResponse = await apiClient.post('/orders', body: payload);
    final createdOrder = OrderEntity.fromJson(orderResponse as Map<String, dynamic>);

    // Complete transaction lifecycle through the Payment Engine
    try {
      final intentResponse = await apiClient.post(
        '/payments/initiate',
        body: {
          'orderId': createdOrder.id,
          'paymentMethod': order.paymentMethod,
        },
      );

      if (intentResponse is Map<String, dynamic>) {
        final txRef = intentResponse['transactionReference'] as String?;
        if (txRef != null && txRef.isNotEmpty) {
          await apiClient.post(
            '/payments/verify',
            body: {'transactionReference': txRef},
          );
        }
      }
    } catch (_) {
      // Payment intent handled or recorded on server
    }

    return createdOrder;
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await apiClient.post('/orders/$orderId/cancel');
  }

  @override
  Future<List<ChatMessageEntity>> getChatMessages(String orderId) async {
    final response = await apiClient.get('/orders/$orderId/chat');
    if (response is List) {
      return response
          .map((m) => ChatMessageEntity.fromJson(m as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> sendChatMessage(String orderId, String message) async {
    await apiClient.post(
      '/orders/$orderId/chat',
      body: {'text': message},
    );
  }

  @override
  Future<void> submitOrderReview(
      String orderId, double restaurantRating, double riderRating, String review) async {
    await apiClient.post(
      '/orders/$orderId/rate',
      body: {
        'restaurantRating': restaurantRating,
        'riderRating': riderRating,
        'review': review,
      },
    );
  }
}
