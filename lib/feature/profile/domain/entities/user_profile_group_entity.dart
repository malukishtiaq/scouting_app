import '../../../../core/entities/base_entity.dart';

class UserProfileGroupEntity extends BaseEntity {
  final String? id;
  final String? name;
  final String? avatar;
  final String? category;
  final String? members;

  UserProfileGroupEntity({
    this.id,
    this.name,
    this.avatar,
    this.category,
    this.members,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        category,
        members,
      ];
}
