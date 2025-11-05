import '../../../../../core/params/base_params.dart';

/// Parameter for getting a specific member's profile
class ShowMemberParam extends BaseParams {
  final int userId;

  ShowMemberParam({
    required this.userId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting member is not a mutation

  @override
  String? get featureName => 'members'; // Use members cache feature
}

