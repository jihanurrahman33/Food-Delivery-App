import 'package:get/get.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../restaurant/data/repositories/restaurant_repository_impl.dart';
import '../../../restaurant/domain/repositories/restaurant_repository.dart';
import '../controllers/home_controller.dart';
import '../controllers/main_nav_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    Get.lazyPut<RestaurantRepository>(() => RestaurantRepositoryImpl());
    Get.lazyPut<MainNavController>(() => MainNavController());
    Get.lazyPut<HomeController>(
      () => HomeController(
        homeRepository: Get.find<HomeRepository>(),
        restaurantRepository: Get.find<RestaurantRepository>(),
      ),
    );
  }
}
