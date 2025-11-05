import '../../../../../core/params/base_params.dart';

/// Parameter for toggling like on a post (add/remove like)
class ToggleLikeParam extends BaseParams {
  final int postId;

  ToggleLikeParam({
    required this.postId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => true; // Toggling like is a mutation

  @override
  List<String>? get invalidateCaches => ['likes', 'newsfeed']; // Invalidate likes and posts cache
}

