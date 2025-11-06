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
    try {
      // Handle different response structures
      // Case 1: {success: true, data: {...}}
      if (json.containsKey('data') && json['data'] is Map) {
        return MemberProfileModel(
          success: json['success'] ?? false,
          data: MemberDataModel.fromJson(json['data'] as Map<String, dynamic>),
        );
      }
      
      // Case 2: Direct user object (WoWonder style)
      // {user_id: "123", name: "John", email: "john@example.com", ...}
      else if (json.containsKey('user_id') || json.containsKey('id')) {
        return MemberProfileModel(
          success: true,
          data: MemberDataModel.fromJson(json),
        );
      }
      
      // Case 3: Wrapped in 'user' key
      // {success: true, user: {...}}
      else if (json.containsKey('user') && json['user'] is Map) {
        return MemberProfileModel(
          success: json['success'] ?? true,
          data: MemberDataModel.fromJson(json['user'] as Map<String, dynamic>),
        );
      }
      
      // Default: treat entire response as data
      else {
        return MemberProfileModel(
          success: true,
          data: MemberDataModel.fromJson(json),
        );
      }
    } catch (e) {
      print('❌ Error parsing MemberProfileModel: $e');
      print('📄 JSON was: $json');
      rethrow;
    }
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
  final String? userId;
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
  final String? phoneNumber;
  final String? username;

  MemberDataModel({
    this.userId,
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
    this.phoneNumber,
    this.username,
  });

  factory MemberDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return MemberDataModel(
        userId: json['user_id']?.toString() ?? json['id']?.toString(),
        name: json['name'] ?? json['full_name'] ?? json['username'] ?? '',
        email: json['email'] ?? '',
        emailVerified: json['email_verified'] ?? 
                       json['email_verified_at'] != null ?? 
                       json['verified'] == 1 ?? 
                       false,
        registrationDate: json['registration_date'] ?? 
                          json['registered'] ?? 
                          json['created_at'],
        avatar: json['avatar'] ?? 
                json['profile_picture'] ?? 
                json['image'] ?? 
                '',
        age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
        weight: json['weight']?.toDouble(),
        height: json['height']?.toDouble(),
        primaryPosition: json['primary_position'] ?? json['position'],
        preferredFoot: json['preferred_foot'] ?? json['foot'],
        profileComplete: json['profile_complete'] ?? 
                         json['is_pro'] ?? 
                         json['verified'] == 1 ?? 
                         false,
        phoneNumber: json['phone_number'] ?? json['phone'],
        username: json['username'] ?? json['user_name'],
      );
    } catch (e) {
      print('❌ Error parsing MemberDataModel: $e');
      print('📄 JSON was: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
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
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (username != null) 'username': username,
    };
  }

  @override
  MemberDataEntity toEntity() {
    return MemberDataEntity(
      userId: userId,
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
      phoneNumber: phoneNumber,
      username: username,
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

