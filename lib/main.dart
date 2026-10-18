import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/network/api_client.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/cart_checkout/presentation/controllers/cart_controller.dart';
import 'features/orders_tracking/data/repositories/order_repository_impl.dart';
import 'features/orders_tracking/domain/repositories/order_repository.dart';
import 'features/orders_tracking/presentation/controllers/order_controller.dart';
import 'features/profile/presentation/controllers/profile_controller.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce preferred orientations and status bar style
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Initialize persistent Local Storage Service
  final storageService = await Get.putAsync<StorageService>(
    () => StorageService().init(),
    permanent: true,
  );

  // Initialize Core ApiClient
  Get.put<ApiClient>(ApiClient(), permanent: true);

  // Global Core & Auth Services
  final authLocalDataSource = Get.put<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(storageService: storageService),
    permanent: true,
  );
  final authRepository = Get.put<AuthRepository>(
    AuthRepositoryImpl(localDataSource: authLocalDataSource),
    permanent: true,
  );
  Get.put<AuthController>(
    AuthController(authRepository: authRepository),
    permanent: true,
  );

  // Globally shared Cart Controller
  Get.put<CartController>(CartController(), permanent: true);

  // Globally shared Orders Controller
  final orderRepository = Get.put<OrderRepository>(
    OrderRepositoryImpl(),
    permanent: true,
  );
  Get.put<OrderController>(
    OrderController(orderRepository: orderRepository),
    permanent: true,
  );

  // Globally shared Profile & Settings Controllers
  Get.put<ProfileController>(
    ProfileController(
      authRepository: authRepository,
      storageService: storageService,
    ),
    permanent: true,
  );
  Get.put<SettingsController>(
    SettingsController(storageService: storageService),
    permanent: true,
  );

  runApp(FoodDeliveryApp(storageService: storageService));
}

class FoodDeliveryApp extends StatelessWidget {
  final StorageService storageService;

  const FoodDeliveryApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: storageService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}
