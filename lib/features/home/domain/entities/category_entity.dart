import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, icon, imageUrl];
}

class BannerEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String discountText;
  final String imageUrl;
  final String? actionRoute;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discountText,
    required this.imageUrl,
    this.actionRoute,
  });

  @override
  List<Object?> get props => [id, title, subtitle, discountText, imageUrl, actionRoute];
}
