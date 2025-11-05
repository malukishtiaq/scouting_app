import '../../../../../core/params/base_params.dart';

/// Parameter for listing all members
class ListMembersParam extends BaseParams {
  ListMembersParam({
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  bool get isMutation => false; // Getting members is not a mutation

  @override
  String? get featureName => 'members'; // Use members cache feature
}

