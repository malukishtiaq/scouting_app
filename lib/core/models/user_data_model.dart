import 'base_model.dart';
import '../entities/user_data_entity.dart';
import '../common/type_validators.dart';

/// Unified User Data Model for all features
/// Based on Xamarin: UserDataObject (simplified for common usage)
class UserDataModel extends BaseModel<UserDataEntity> {
  final String? userId;
  final String? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? cover;
  final String? name;
  final String? url;
  final String? about;
  final String? verified;
  final String? birthday;
  final String? age;
  final String? isOnline;
  final String? lastSeen;
  final String? lastSeenStatus;

  UserDataModel({
    this.userId,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.cover,
    this.name,
    this.url,
    this.about,
    this.verified,
    this.birthday,
    this.age,
    this.isOnline,
    this.lastSeen,
    this.lastSeenStatus,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    try {
      // Handle both 'user_id' and 'id' fields
      final userId = stringV(json['user_id']).isEmpty
          ? stringV(json['id'])
          : stringV(json['user_id']);
      final id = stringV(json['id']);
      final username = stringV(json['username']);
      final email = stringV(json['email']);
      final firstName = stringV(json['first_name']);
      final lastName = stringV(json['last_name']);
      final avatar = stringV(json['avatar']);
      final cover = stringV(json['cover']);

      // Handle name field - could be 'name' or constructed from 'first_name' + 'last_name'
      String name = stringV(json['name']);
      if (name.isEmpty) {
        if (firstName.isNotEmpty || lastName.isNotEmpty) {
          name =
              '${firstName.isNotEmpty ? firstName : ''} ${lastName.isNotEmpty ? lastName : ''}'
                  .trim();
        }
      }

      final url = stringV(json['url']);
      final about = stringV(json['about']);
      final verified = stringV(json['verified']);
      final birthday = stringV(json['birthday']);
      final age = stringV(json['age']);
      final isOnline = stringV(json['is_online']);
      final lastSeen = stringV(json['lastseen']);
      final lastSeenStatus = stringV(json['lastseen_status']);

      return UserDataModel(
        userId: userId,
        id: id,
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
        cover: cover,
        name: name,
        url: url,
        about: about,
        verified: verified,
        birthday: birthday,
        age: age,
        isOnline: isOnline,
        lastSeen: lastSeen,
        lastSeenStatus: lastSeenStatus,
      );
    } catch (e) {
      print('❌ UserDataModel.fromJson error: $e');
      print('❌ Problematic JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'cover': cover,
      'name': name,
      'url': url,
      'about': about,
      'verified': verified,
      'birthday': birthday,
      'age': age,
      'is_online': isOnline,
      'lastseen': lastSeen,
      'lastseen_status': lastSeenStatus,
    };
  }

  @override
  UserDataEntity toEntity() {
    return UserDataEntity.fromModel(this);
  }
}
