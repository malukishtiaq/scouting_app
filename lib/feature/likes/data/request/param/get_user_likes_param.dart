import '../../../../../core/params/base_params.dart';

/// Parameter for getting current user's likes
class GetUserLikesParam extends BaseParams {
  GetUserLikesParam({
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting likes is not a mutation
}

