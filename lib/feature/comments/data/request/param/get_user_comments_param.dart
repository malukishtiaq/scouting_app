import '../../../../../core/params/base_params.dart';

/// Parameter for getting current user's comments
class GetUserCommentsParam extends BaseParams {
  GetUserCommentsParam({
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting comments is not a mutation
}

