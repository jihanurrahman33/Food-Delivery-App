import 'package:get/get.dart';
import '../../data/repositories/restaurant_repository_impl.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../controllers/restaurant_controller.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantRepository>(() => RestaurantRepositoryImpl());
    Get.lazyPut<RestaurantController>(
      () => RestaurantController(restaurantRepository: Get.find<RestaurantRepository>()),
    );
  }
}
