import '../../../../../core/params/base_params.dart';

/// Parameter for fetching posts from API
class GetPostsParam extends BaseParams {
  final int page;

  GetPostsParam({
    this.page = 1,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': page.toString(),
    };
  }
}

/// Parameter for fetching a single post by ID
class GetPostByIdParam extends BaseParams {
  final int postId;

  GetPostByIdParam({
    required this.postId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'post_id': postId.toString(),
    };
  }
}
