import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../mainapis.dart';
import '../request/model/player_model.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';

part 'player_remote_datasource.dart';

/// Player Remote Datasource Interface
abstract class IPlayerRemoteDatasource extends RemoteDataSource {
  /// Get player data from remote source
  Future<Either<AppErrors, PlayerModel>> getPlayer(GetPlayerParam param);

  /// Update player profile data
  Future<Either<AppErrors, PlayerModel>> updatePlayer(UpdatePlayerParam param);
}
