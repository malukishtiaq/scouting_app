import 'package:injectable/injectable.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/repositories/repository.dart';
import '../../data/datasources/ireels_remote_datasource.dart';
import '../../data/request/param/get_reels_param.dart';
import '../entity/reels_response_entity.dart';
import 'ireels_repository.dart';

@Injectable(as: IReelsRepository)
class ReelsRepository extends Repository implements IReelsRepository {
  final IReelsRemoteSource _remoteSource;

  ReelsRepository(this._remoteSource);

  @override
  Future<Result<AppErrors, ReelsResponseEntity>> getReels(
      GetReelsParam param) async {
    try {
      final remoteResult = await _remoteSource.getReels(param);
      return execute(remoteResult: remoteResult);
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, ReelsResponseEntity>> getMoreReels(
      GetReelsParam param) async {
    try {
      final remoteResult = await _remoteSource.getMoreReels(param);
      return execute(remoteResult: remoteResult);
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }
}
