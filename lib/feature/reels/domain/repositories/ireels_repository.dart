import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/results/result.dart';
import '../../data/request/param/get_reels_param.dart';
import '../entity/reels_response_entity.dart';

abstract class IReelsRepository {
  /// Get reels videos from remote source
  Future<Result<AppErrors, ReelsResponseEntity>> getReels(GetReelsParam param);

  /// Get more reels videos for pagination
  Future<Result<AppErrors, ReelsResponseEntity>> getMoreReels(
      GetReelsParam param);
}
