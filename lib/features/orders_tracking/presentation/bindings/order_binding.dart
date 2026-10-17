import 'package:get/get.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl());
    Get.lazyPut<OrderController>(
      () => OrderController(orderRepository: Get.find<OrderRepository>()),
    );
    Get.lazyPut<OrderTrackingController>(
      () => OrderTrackingController(orderRepository: Get.find<OrderRepository>()),
    );
  }
}
