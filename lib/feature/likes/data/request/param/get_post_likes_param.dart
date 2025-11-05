import '../../../../../core/params/base_params.dart';

/// Parameter for getting likes for a specific post
class GetPostLikesParam extends BaseParams {
  final int postId;

  GetPostLikesParam({
    required this.postId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting likes is not a mutation
}

