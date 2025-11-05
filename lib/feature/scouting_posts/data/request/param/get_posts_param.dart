import '../../../../../core/params/base_params.dart';

/// Parameter for getting list of posts with pagination
class GetPostsParam extends BaseParams {
  final int page;

  GetPostsParam({
    this.page = 1,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': page,
    };
  }

  @override
  bool get isMutation => false; // Getting posts is not a mutation

  @override
  String? get featureName => 'posts'; // Use posts cache feature
}

