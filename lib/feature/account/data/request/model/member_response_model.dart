import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/domain/entity/member_response_entity.dart';

/// Member Profile Model (for Me and Show Member endpoints)
class MemberProfileModel extends BaseModel<MemberProfileEntity> {
  final bool success;
  final MemberDataModel data;

  MemberProfileModel({
    required this.success,
    required this.data,
  });

  factory MemberProfileModel.fromJson(Map<String, dynamic> json) {
    return MemberProfileModel(
      success: json['success'] ?? false,
      data: MemberDataModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }

  @override
  MemberProfileEntity toEntity() {
    return MemberProfileEntity(
      success: success,
      data: data.toEntity(),
    );
  }
}

/// Member Data Model
class MemberDataModel extends BaseModel<MemberDataEntity> {
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

  MemberDataModel({
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

  factory MemberDataModel.fromJson(Map<String, dynamic> json) {
    return MemberDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerified: json['email_verified'] ?? false,
      registrationDate: json['registration_date'],
      avatar: json['avatar'] ?? '',
      age: json['age'],
      weight: json['weight']?.toDouble(),
      height: json['height']?.toDouble(),
      primaryPosition: json['primary_position'],
      preferredFoot: json['preferred_foot'],
      profileComplete: json['profile_complete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'email_verified': emailVerified,
      if (registrationDate != null) 'registration_date': registrationDate,
      'avatar': avatar,
      if (age != null) 'age': age,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (primaryPosition != null) 'primary_position': primaryPosition,
      if (preferredFoot != null) 'preferred_foot': preferredFoot,
      'profile_complete': profileComplete,
    };
  }

  @override
  MemberDataEntity toEntity() {
    return MemberDataEntity(
      name: name,
      email: email,
      emailVerified: emailVerified,
      registrationDate: registrationDate,
      avatar: avatar,
      age: age,
      weight: weight,
      height: height,
      primaryPosition: primaryPosition,
      preferredFoot: preferredFoot,
      profileComplete: profileComplete,
    );
  }
}

/// Members List Model
class MembersListModel extends BaseModel<MembersListEntity> {
  final bool success;
  final List<MemberDataModel> data;

  MembersListModel({
    required this.success,
    required this.data,
  });

  factory MembersListModel.fromJson(Map<String, dynamic> json) {
    return MembersListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => MemberDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  @override
  MembersListEntity toEntity() {
    return MembersListEntity(
      success: success,
      data: data.map((e) => e.toEntity()).toList(),
    );
  }
}

/// Update Profile Response Model
class UpdateProfileResponseModel
    extends BaseModel<UpdateProfileResponseEntity> {
  final bool success;
  final String message;
  final MemberDataModel? data;

  UpdateProfileResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? MemberDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }

  @override
  UpdateProfileResponseEntity toEntity() {
    return UpdateProfileResponseEntity(
      success: success,
      message: message,
      data: data?.toEntity(),
    );
  }
}

