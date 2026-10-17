import '../../../../core/services/mock_data_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity?> getCurrentUser() async {
    final cached = await localDataSource.getUser();
    if (cached != null) return cached;
    return MockDataService.defaultUser;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final user = MockDataService.defaultUser.copyWith(email: email);
    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<UserEntity> signUp(
      String name, String email, String phone, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final user = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      avatarUrl: MockDataService.defaultUser.avatarUrl,
      role: 'customer',
      address: MockDataService.defaultUser.address,
    );
    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<void> sendOtp(String email) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<bool> verifyOtp(String code) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return code.length == 4;
  }

  @override
  Future<void> resetPassword(String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }

  @override
  Future<void> updateUserProfile(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      avatarUrl: user.avatarUrl,
      role: user.role,
      address: user.address,
    );
    await localDataSource.saveUser(model);
  }
}
