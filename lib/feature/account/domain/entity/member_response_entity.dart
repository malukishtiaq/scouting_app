import '../../../../core/entities/base_entity.dart';

/// Member Profile Entity (for Me and Show Member endpoints)
class MemberProfileEntity extends BaseEntity {
  final bool success;
  final MemberDataEntity data;

  MemberProfileEntity({
    required this.success,
    required this.data,
  });

  @override
  List<Object?> get props => [success, data];
}

/// Member Data Entity
class MemberDataEntity extends BaseEntity {
  final String name;
  final String email;
  final bool emailVerified;
  final String? registrationDate;
  final String avatar;
  final int? age;
  final double? weight;
  final double? height;
  final String? primaryPosition;
  final String? preferredFoot;
  final bool profileComplete;

  MemberDataEntity({
    required this.name,
    required this.email,
    required this.emailVerified,
    this.registrationDate,
    required this.avatar,
    this.age,
    this.weight,
    this.height,
    this.primaryPosition,
    this.preferredFoot,
    required this.profileComplete,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        emailVerified,
        registrationDate,
        avatar,
        age,
        weight,
        height,
        primaryPosition,
        preferredFoot,
        profileComplete,
      ];
}

/// Members List Entity
class MembersListEntity extends BaseEntity {
  final bool success;
  final List<MemberDataEntity> data;

  MembersListEntity({
    required this.success,
    required this.data,
  });

  @override
  List<Object?> get props => [success, data];
}

/// Update Profile Response Entity
class UpdateProfileResponseEntity extends BaseEntity {
  final bool success;
  final String message;
  final MemberDataEntity? data;

  UpdateProfileResponseEntity({
    required this.success,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}

