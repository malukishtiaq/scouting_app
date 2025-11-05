import '../../../../../core/params/base_params.dart';

/// Parameter for getting a single post by ID
class GetPostByIdParam extends BaseParams {
  final int postId;

  GetPostByIdParam({
    required this.postId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting post is not a mutation

  @override
  String? get featureName => 'posts'; // Use posts cache feature
}

