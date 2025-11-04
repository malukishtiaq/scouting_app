import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import '../../../../../core/params/base_params.dart';

class GetReelsParam extends BaseParams {
  final String? serverKey; // Server key for API authentication
  final String? type; // Type of posts to fetch (get_news_feed)
  final String? limit; // Number of videos to fetch
  final String? offset; // Offset for pagination (after_post_id)
  final String? adId; // Ad ID for tracking
  final String? postType; // Post type filter (video)

  GetReelsParam({
    this.serverKey,
    this.type,
    this.limit,
    this.offset,
    this.adId,
    this.postType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (serverKey.isNotEmptyNorNull) 'server_key': serverKey,
        if (type.isNotEmptyNorNull) 'type': type,
        if (limit.isNotEmptyNorNull) 'limit': limit,
        if (offset.isNotEmptyNorNull) 'after_post_id': offset,
        if (adId.isNotEmptyNorNull) 'ad_id': adId,
        if (postType.isNotEmptyNorNull) 'post_type': postType,
      };
}
