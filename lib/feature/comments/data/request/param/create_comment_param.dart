import '../../../../../core/params/base_params.dart';

/// Parameter for creating a comment on a post
class CreateCommentParam extends BaseParams {
  final int postId;
  final String comment;
  final int? commentId; // Optional: for replying to another comment

  CreateCommentParam({
    required this.postId,
    required this.comment,
    this.commentId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      if (commentId != null) 'comment_id': commentId,
    };
  }

  @override
  bool get isMutation => true; // Creating a comment is a mutation

  @override
  List<String>? get invalidateCaches => ['comments', 'newsfeed']; // Invalidate comments and posts cache
}

