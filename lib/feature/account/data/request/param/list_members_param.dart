import '../../../../../core/params/base_params.dart';

/// Parameter for listing all members
/// GET /api/members?page={page}
class ListMembersParam extends BaseParams {
  final int? page; // Page number for pagination (optional)

  ListMembersParam({
    this.page,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (page != null) 'page': page,
    };
  }

  @override
  bool get isMutation => false; // Getting members is not a mutation

  @override
  String? get featureName => 'members'; // Use members cache feature
}

