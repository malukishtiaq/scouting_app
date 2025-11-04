import '../../../../core/entities/base_entity.dart';

class UserProfileFollowerEntity extends BaseEntity {
  final String? id;
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? followTime;

  UserProfileFollowerEntity({
    this.id,
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.followTime,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        firstName,
        lastName,
        avatar,
        followTime,
      ];
}
