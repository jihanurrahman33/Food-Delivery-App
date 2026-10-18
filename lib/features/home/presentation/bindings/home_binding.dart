import 'package:get/get.dart';
import '../../../../core/services/storage_service.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../orders_tracking/data/repositories/order_repository_impl.dart';
import '../../../orders_tracking/domain/repositories/order_repository.dart';
import '../../../orders_tracking/presentation/controllers/order_controller.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../restaurant/data/repositories/restaurant_repository_impl.dart';
import '../../../restaurant/domain/repositories/restaurant_repository.dart';
import '../controllers/home_controller.dart';
import '../controllers/main_nav_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Auth dependencies
    if (!Get.isRegistered<AuthLocalDataSource>()) {
      Get.lazyPut<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(storageService: Get.find<StorageService>()),
      );
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(localDataSource: Get.find<AuthLocalDataSource>()),
      );
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(
        () => AuthController(authRepository: Get.find<AuthRepository>()),
      );
    }

    // Home & Discovery dependencies
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    Get.lazyPut<RestaurantRepository>(() => RestaurantRepositoryImpl());
    Get.lazyPut<MainNavController>(() => MainNavController());
    Get.lazyPut<HomeController>(
      () => HomeController(
        homeRepository: Get.find<HomeRepository>(),
        restaurantRepository: Get.find<RestaurantRepository>(),
      ),
    );

    // Orders dependencies (for Orders tab in MainNavScreen)
    if (!Get.isRegistered<OrderRepository>()) {
      Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl());
    }
    if (!Get.isRegistered<OrderController>()) {
      Get.lazyPut<OrderController>(
        () => OrderController(orderRepository: Get.find<OrderRepository>()),
      );
    }

    // Profile & Settings dependencies (for Profile tab in MainNavScreen)
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut<ProfileController>(
        () => ProfileController(
          authRepository: Get.find<AuthRepository>(),
          storageService: Get.find<StorageService>(),
        ),
      );
    }
    if (!Get.isRegistered<SettingsController>()) {
      Get.lazyPut<SettingsController>(
        () => SettingsController(storageService: Get.find<StorageService>()),
      );
    }
  }
}

