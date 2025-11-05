import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/repositories/iplayer_repository.dart';
import '../datasources/iplayer_remote_datasource.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';

/// Player Repository Implementation
class PlayerRepository implements IPlayerRepository {
  final IPlayerRemoteDatasource remoteDatasource;

  const PlayerRepository({required this.remoteDatasource});

  @override
  Future<Either<AppErrors, PlayerEntity>> getPlayer(
      GetPlayerParam param) async {
    try {
      final result = await remoteDatasource.getPlayer(param);
      return Right(result.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error).appError);
    }
  }

  @override
  Future<Either<AppErrors, PlayerEntity>> updatePlayer(
      UpdatePlayerParam param) async {
    try {
      final result = await remoteDatasource.updatePlayer(param);
      return Right(result.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error).appError);
    }
  }

  @override
  Future<Either<AppErrors, MediaEntity>> uploadMedia(
      UploadMediaParam param) async {
    try {
      final result = await remoteDatasource.uploadMedia(param);
      return Right(result.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error).appError);
    }
  }

  @override
  Future<Either<AppErrors, List<GameEntity>>> getUpcomingGames(
      GetPlayerParam param) async {
    try {
      final result = await remoteDatasource.getUpcomingGames(param);
      return Right(result.map((game) => game.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error).appError);
    }
  }

  @override
  Future<Either<AppErrors, List<MediaEntity>>> getPlayerMedia(
      GetPlayerParam param) async {
    try {
      final result = await remoteDatasource.getPlayerMedia(param);
      return Right(result.map((media) => media.toEntity()).toList());
    } catch (error) {
      return Left(ErrorHandler.handle(error).appError);
    }
  }
}

