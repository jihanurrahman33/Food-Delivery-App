import 'package:get/get.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(storageService: Get.find<StorageService>()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: Get.find<AuthLocalDataSource>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find<AuthRepository>()),
    );
  }
}
