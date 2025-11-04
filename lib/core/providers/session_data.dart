import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../feature/profile/domain/entities/user_profile_entity.dart';

@singleton
class SessionData extends ChangeNotifier {
  String? _token;
  int? _userId;
  UserProfileEntity? _userProfile;

  int? get userId => _userId;
  set userId(int? value) {
    _userId = value;
    notifyListeners();
  }

  String? get token => _token;
  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  UserProfileEntity? get userProfile => _userProfile;
  set userProfile(UserProfileEntity? value) {
    _userProfile = value;
    notifyListeners();
  }

  void clear() {
    _token = null;
    _userId = null;
    _userProfile = null;
    notifyListeners();
  }
}
