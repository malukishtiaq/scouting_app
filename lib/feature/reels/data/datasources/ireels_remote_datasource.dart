import 'package:dartz/dartz.dart';
import '../../../../../core/datasources/remote_data_source.dart';
import '../../../../../core/errors/app_errors.dart';
import '../request/model/reels_response_model.dart';
import '../request/param/get_reels_param.dart';

abstract class IReelsRemoteSource extends RemoteDataSource {
  /// Get reels videos from remote source
  Future<Either<AppErrors, ReelsResponseModel>> getReels(GetReelsParam param);

  /// Get more reels videos for pagination
  Future<Either<AppErrors, ReelsResponseModel>> getMoreReels(
      GetReelsParam param);
}
