import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String role; // 'customer', 'chef', 'rider'
  final String? address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.role = 'customer',
    this.address,
  });

  @override
  List<Object?> get props => [id, name, email, phone, avatarUrl, role, address];
}
