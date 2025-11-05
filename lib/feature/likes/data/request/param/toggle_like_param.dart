import '../../../../../core/params/base_params.dart';

/// Parameter for toggling like on a post (add/remove like)
/// POST /api/likes/{post_id}
class ToggleLikeParam extends BaseParams {
  final int postId;
  final bool like; // true to like, false to unlike

  ToggleLikeParam({
    required this.postId,
    required this.like,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'like': like,
    };
  }

  @override
  bool get isMutation => true; // Toggling like is a mutation

  @override
  List<String>? get invalidateCaches => ['likes', 'newsfeed']; // Invalidate likes and posts cache
}

