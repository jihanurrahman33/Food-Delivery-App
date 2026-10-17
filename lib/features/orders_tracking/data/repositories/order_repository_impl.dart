import '../../../../core/services/mock_data_service.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final List<OrderEntity> _orders = [MockDataService.activeOrder];
  final List<ChatMessageEntity> _chatMessages = List.from(MockDataService.initialChatMessages);

  @override
  Future<List<OrderEntity>> getActiveOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders
        .where((o) =>
            o.status != OrderStatus.delivered && o.status != OrderStatus.cancelled)
        .toList();
  }

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final history = _orders
        .where((o) =>
            o.status == OrderStatus.delivered || o.status == OrderStatus.cancelled)
        .toList();

    // Add a completed mock order if empty
    if (history.isEmpty) {
      history.add(
        MockDataService.activeOrder.copyWith(
          id: 'FD-77210',
          status: OrderStatus.delivered,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      );
    }
    return history;
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return _orders.isNotEmpty ? _orders.first : MockDataService.activeOrder;
    }
  }

  @override
  Future<OrderEntity> placeOrder(OrderEntity order) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _orders.insert(0, order);
    return order;
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: OrderStatus.cancelled);
    }
  }

  @override
  Future<List<ChatMessageEntity>> getChatMessages(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_chatMessages);
  }

  @override
  Future<void> sendChatMessage(String orderId, String message) async {
    final newMsg = ChatMessageEntity(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: message,
      isSender: true,
      timestamp: DateTime.now(),
      isRead: true,
    );
    _chatMessages.add(newMsg);

    // Auto simulated response from driver after 1.5s
    Future.delayed(const Duration(milliseconds: 1500), () {
      _chatMessages.add(
        ChatMessageEntity(
          id: 'msg_reply_${DateTime.now().millisecondsSinceEpoch}',
          text: 'Got it, thanks for the update! See you shortly.',
          isSender: false,
          timestamp: DateTime.now(),
          isRead: true,
        ),
      );
    });
  }

  @override
  Future<void> submitOrderReview(
      String orderId, double restaurantRating, double riderRating, String review) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
