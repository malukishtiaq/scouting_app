import 'base_entity.dart';

/// Unified User Data Entity for all features
/// Based on Xamarin: UserDataObject (simplified for common usage)
class UserDataEntity extends BaseEntity {
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

  UserDataEntity({
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

  factory UserDataEntity.fromModel(dynamic model) {
    return UserDataEntity(
      userId: model.userId,
      id: model.id,
      username: model.username,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      avatar: model.avatar,
      cover: model.cover,
      name: model.name,
      url: model.url,
      about: model.about,
      verified: model.verified,
      birthday: model.birthday,
      age: model.age,
      isOnline: model.isOnline,
      lastSeen: model.lastSeen,
      lastSeenStatus: model.lastSeenStatus,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        username,
        email,
        firstName,
        lastName,
        avatar,
        cover,
        name,
        url,
        about,
        verified,
        birthday,
        age,
        isOnline,
        lastSeen,
        lastSeenStatus,
      ];
}
