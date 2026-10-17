import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // First time launch
  bool get isFirstTime => _box.read(AppConstants.keyIsFirstTime) ?? true;
  set isFirstTime(bool value) => _box.write(AppConstants.keyIsFirstTime, value);

  // Authentication
  bool get isLoggedIn => _box.read(AppConstants.keyIsLoggedIn) ?? false;
  set isLoggedIn(bool value) => _box.write(AppConstants.keyIsLoggedIn, value);

  String? get userToken => _box.read(AppConstants.keyUserToken);
  set userToken(String? value) => _box.write(AppConstants.keyUserToken, value);

  Map<String, dynamic>? get userData {
    final raw = _box.read(AppConstants.keyUserData);
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw);
  }

  set userData(Map<String, dynamic>? value) =>
      _box.write(AppConstants.keyUserData, value);

  // Dark Mode
  bool get isDarkMode => _box.read(AppConstants.keyIsDarkMode) ?? false;
  set isDarkMode(bool value) => _box.write(AppConstants.keyIsDarkMode, value);

  // User Role (customer, chef, rider)
  String get userRole => _box.read(AppConstants.keyUserRole) ?? 'customer';
  set userRole(String value) => _box.write(AppConstants.keyUserRole, value);

  // Generic read & write
  T? read<T>(String key) => _box.read<T>(key);
  Future<void> write(String key, dynamic value) => _box.write(key, value);
  Future<void> remove(String key) => _box.remove(key);
  Future<void> clearAll() => _box.erase();
}
