import '../../../../../core/params/base_params.dart';
import '../../../../../mainapis.dart';

class UpdateAvatarParam extends BaseParams {
  final String? avatarPath; // Optional file path for avatar

  UpdateAvatarParam({
    this.avatarPath,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      // Don't include file path in toMap() - it's handled separately
    };
  }

  // ✅ MANDATORY: Mark this as a mutation for cache invalidation
  @override
  bool get isMutation => true;

  // ✅ MANDATORY: List ALL features whose cache should be invalidated
  @override
  List<String> get invalidateCaches => [
        'users', // User profile data changed
        'profile', // Profile data changed
        'newsfeed', // User posts might show new avatar
      ];
}
