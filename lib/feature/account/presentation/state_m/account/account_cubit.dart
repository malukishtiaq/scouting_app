import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/common/utils/utils.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/providers/session_data.dart';
import '../../../../../core/common/local_storage.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../di/service_locator.dart';
import '../../../../profile/domain/entities/user_profile_entity.dart';
import '../../../data/request/param/scouting_login_param.dart';
import '../../../data/request/param/scouting_register_param.dart';
import '../../../domain/entity/auth_response_entity.dart';
import '../../../domain/usecase/member_login_usecase.dart';
import '../../../domain/usecase/member_register_usecase.dart';
import '../../screen/login/login_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_cubit.freezed.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit([this.param = const LoginScreenParam()])
      : super(const AccountState.accountInit()) {
    usernameController.text = '';
    passwordController.text = '';

    isFaceIdEnabled = false;
    isNotificationEnabled = false;
  }

  // fields
  final LoginScreenParam param;

  ///form section
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordKey = GlobalKey<FormFieldState<String>>();
  final passwordFocusNode = FocusNode();

  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final usernameKey = GlobalKey<FormFieldState<String>>();

  bool _isShowPassword = true;
  bool get isShowPassword => _isShowPassword;
  set isShowPassword(bool value) {
    _isShowPassword = value;
    emit(AccountState.passwordVisibilityChanged(value));
  }

  bool _isShowConfirmPassword = false;
  bool get isShowConfirmPassword => _isShowConfirmPassword;
  set isShowConfirmPassword(bool value) {
    _isShowConfirmPassword = value;
    emit(AccountState.confirmPasswordVisibilityChanged(value));
  }

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;
  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    emit(AccountState.notificationToggelled(value));
  }

  bool _isFaceIdEnabled = false;
  bool get isFaceIdEnabled => _isFaceIdEnabled;
  set isFaceIdEnabled(bool value) {
    _isFaceIdEnabled = value;
    emit(AccountState.faceidToggelled(value));
  }

  String _profilePictureUrl = "";
  String get profilePictureUrl => _profilePictureUrl;
  set profilePictureUrl(String value) {
    _profilePictureUrl = value;
    emit(AccountState.profilePictureUrl(value));
  }

  XFile? _profilePicture;
  XFile? get profilePicture => _profilePicture;
  set profilePicture(XFile? value) {
    _profilePicture = value;
    emit(AccountState.newProfilePicture(value));
  }

  // ========== SCOUTING API METHODS ==========

  /// Login with Scouting API
  /// POST /api/members/login
  void login(String email, String password) async {
    emit(const AccountState.accountLoading());

    try {
      final loginParam = ScoutingLoginParam(
        email: email,
        password: password,
      );

      final result = await getIt<MemberLoginUsecase>()(loginParam);

      result.pick(
        onData: (data) async {
          // Setup session data and emit success
          _setupSessionData(data);
          emit(AccountState.loginSuccess(data));
        },
        onError: (error) {
          emit(AccountState.accountError(error, () => login(email, password)));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        const AppErrors.customError(message: 'Login failed. Please try again.'),
        () => login(email, password),
      ));
    }
  }

  /// Register with Scouting API
  /// POST /api/members/register
  void register(String email, String password) async {
    emit(const AccountState.accountLoading());

    try {
      final registerParam = ScoutingRegisterParam(
        email: email,
        password: password,
      );

      final result = await getIt<MemberRegisterUsecase>()(registerParam);

      result.pick(
        onData: (data) async {
          _setupSessionData(data);
          emit(AccountState.userRegisteredSuccess(data));
        },
        onError: (error) {
          emit(AccountState.registerError(
              error, () => register(email, password), registerParam));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        const AppErrors.customError(
            message: 'Registration failed. Please try again.'),
        () => register(email, password),
      ));
    }
  }

  void _setupSessionData(AuthResponseEntity data) async {
    try {
      final token = data.data.token;
      final user = data.data.user;
      
      // Parse userId from string to int (it's stored as String? in MemberDataEntity)
      int userId = 0;
      if (user.userId != null && user.userId!.isNotEmpty) {
        userId = int.tryParse(user.userId!) ?? 0;
      }

      if (token.isNotEmpty) {
        // Use AuthService for consistent session management
        final authService = getIt<AuthService>();
        await authService.setupSession(
          accessToken: token,
          userId: userId,
        );

        // Store user profile data in SessionData (workaround for /api/me bug)
        final sessionData = getIt<SessionData>();
        sessionData.token = token;
        sessionData.userId = userId;
        
        // Convert login response user to UserProfileEntity
        sessionData.userProfile = UserProfileEntity(
          userId: userId.toString(),
          username: user.name.isNotEmpty ? user.name : user.email.split('@').first,
          email: user.email,
          firstName: user.name.isNotEmpty ? user.name : user.email.split('@').first,
          lastName: '',
          avatar: user.avatar,
          cover: '',
          about: '',
          gender: '',
          birthday: '',
          countryId: '',
          website: '',
          facebook: '',
          google: '',
          twitter: '',
          instagram: '',
          youtube: '',
          vk: '',
          lastSeenUnixTime: 0,
          lastSeenStatus: '',
          isFollowing: false,
          canFollow: false,
          isFollowingMe: false,
          isBlocked: false,
          isReported: false,
          points: 0,
          proType: user.primaryPosition, // Map primary_position to proType
          verified: false,
          details: null,
          // Scouting-specific fields from login response
          age: user.age,
          weight: user.weight,
          height: user.height,
          primaryPosition: user.primaryPosition,
          preferredFoot: user.preferredFoot,
        );
        
        // Persist to storage
        LocalStorage.persistToken(token);
        LocalStorage.persistMemberId(userId);
        
        print('✅ Session data setup completed successfully');
        print('✅ User profile stored: ${user.email}');
      }
    } catch (e) {
      print('Error setting up session: $e');
      // Fallback to direct storage if AuthService fails
      getIt<SessionData>().token = data.data.token;
      if (data.data.token.isNotEmpty) {
        LocalStorage.persistToken(data.data.token);
      }
    }
  }

  void showDeleteAccount() {
    emit(const AccountState.showDeleteAccount());
  }

  void showDeleteData() {
    emit(const AccountState.showDeleteData());
  }

  void cancelDeleteData() {
    emit(const AccountState.accountInit());
  }

  void toggleShowPassword() {
    isShowPassword = !isShowPassword;
  }

  void toggleNotification() {
    isNotificationEnabled = !isNotificationEnabled;
  }

  void toggleFaceId() {
    isFaceIdEnabled = !isFaceIdEnabled;
  }

  void deleteNewProfilePicture() {
    profilePicture = null;
  }
}
