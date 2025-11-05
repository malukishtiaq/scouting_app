import '../../../../../core/params/base_params.dart';

/// Parameter for getting comments for a specific post
class GetPostCommentsParam extends BaseParams {
  final int postId;

  GetPostCommentsParam({
    required this.postId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting comments is not a mutation
}

