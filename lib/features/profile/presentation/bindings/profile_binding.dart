import 'package:get/get.dart';
import '../../../../core/services/storage_service.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
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
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        authRepository: Get.find<AuthRepository>(),
        storageService: Get.find<StorageService>(),
      ),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(storageService: Get.find<StorageService>()),
    );
  }
}
