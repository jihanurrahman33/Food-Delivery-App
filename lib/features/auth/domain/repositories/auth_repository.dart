import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signUp(String name, String email, String phone, String password);
  Future<void> sendOtp(String email);
  Future<bool> verifyOtp(String code);
  Future<void> resetPassword(String newPassword);
  Future<void> logout();
  Future<void> updateUserProfile(UserEntity user);
}
