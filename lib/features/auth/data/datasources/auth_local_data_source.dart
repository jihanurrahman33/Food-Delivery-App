import '../../../../core/services/storage_service.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storageService;

  AuthLocalDataSourceImpl({required this.storageService});

  @override
  Future<UserModel?> getUser() async {
    final data = storageService.userData;
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    storageService.userData = user.toJson();
    storageService.isLoggedIn = true;
    storageService.userToken = 'mock_jwt_token_${user.id}';
  }

  @override
  Future<void> clearUser() async {
    storageService.userData = null;
    storageService.isLoggedIn = false;
    storageService.userToken = null;
  }
}
