import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getActiveOrders();
  Future<List<OrderEntity>> getOrderHistory();
  Future<OrderEntity?> getOrderById(String orderId);
  Future<OrderEntity> placeOrder(OrderEntity order);
  Future<void> cancelOrder(String orderId);
  Future<List<ChatMessageEntity>> getChatMessages(String orderId);
  Future<void> sendChatMessage(String orderId, String message);
  Future<void> submitOrderReview(String orderId, double restaurantRating, double riderRating, String review);
}
