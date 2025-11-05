import '../../../../../core/params/base_params.dart';

/// Parameter for getting current user profile (me endpoint)
class GetMeParam extends BaseParams {
  GetMeParam({
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting profile is not a mutation
  
  @override
  String? get featureName => 'profile'; // Use profile cache feature
}

