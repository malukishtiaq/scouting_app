import '../../../../core/entities/base_entity.dart';

class UserProfilePageEntity extends BaseEntity {
  final String? id;
  final String? name;
  final String? avatar;
  final String? category;
  final String? likes;

  UserProfilePageEntity({
    this.id,
    this.name,
    this.avatar,
    this.category,
    this.likes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        category,
        likes,
      ];
}
