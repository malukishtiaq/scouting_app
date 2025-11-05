import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../data/request/param/upload_media_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Upload Media Use Case
class UploadMediaUsecase {
  final IPlayerRepository repository;

  const UploadMediaUsecase({required this.repository});

  Future<Either<AppErrors, MediaEntity>> call(UploadMediaParam param) async {
    return await repository.uploadMedia(param);
  }
}

