import '../../../../core/params/base_params.dart';

/// Search Players Param
/// Parameters for searching players by query
class SearchPlayersParam extends BaseParams {
  final String? query;
  final int? page;
  final int? limit;
  final String? position; // Filter by position (optional)
  final String? location; // Filter by location (optional)

  SearchPlayersParam({
    this.query,
    this.page = 1,
    this.limit = 20,
    this.position,
    this.location,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (query != null && query!.isNotEmpty) map['query'] = query;
    if (position != null && position!.isNotEmpty) map['position'] = position;
    if (location != null && location!.isNotEmpty) map['location'] = location;

    return map;
  }
}

