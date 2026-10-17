import 'package:get/get.dart';
import '../../../orders_tracking/data/repositories/order_repository_impl.dart';
import '../../../orders_tracking/domain/repositories/order_repository.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(
        orderRepository: Get.find<OrderRepository>(),
        cartController: Get.find<CartController>(),
      ),
    );
  }
}
