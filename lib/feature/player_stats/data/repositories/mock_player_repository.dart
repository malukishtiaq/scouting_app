import '../domain/entities/player_entity.dart';
import '../domain/repositories/iplayer_repository.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';
import '../../../../core/errors/app_errors.dart';
import 'package:dartz/dartz.dart';

/// Mock Player Repository for testing
/// This provides sample data without needing a backend
class MockPlayerRepository implements IPlayerRepository {
  @override
  Future<Either<AppErrors, PlayerEntity>> getPlayer(
      GetPlayerParam param) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock player data matching Figma design
    return Right(
      PlayerEntity(
        playerId: param.playerId,
        fullName: 'Ethan Carter',
        avatar: 'https://i.pravatar.cc/150?img=12',
        coverImage: 'https://picsum.photos/800/400',
        username: 'ethancarter',
        email: 'ethan.carter@example.com',
        phoneNumber: '+1 234 567 8900',
        team: 'Lakers',
        position: 'Forward',
        height: '6\'2"',
        weight: '180',
        age: '21',
        graduationClass: '2025',
        school: 'Springfield High',
        averageLocation: 'Los Angeles, CA',
        bio: 'Professional football player with 5 years of experience.',
        verified: true,
        isPro: true,
        stats: const PlayerStatsEntity(
          gamesPlayed: 120,
          goals: 15,
          assists: 20,
          yellowCards: 3,
          redCards: 0,
          minutesPlayed: 8500,
          averageRating: 8.5,
          cleanSheets: 0,
          saves: 0,
        ),
      ),
    );
  }

  @override
  Future<Either<AppErrors, PlayerEntity>> updatePlayer(
      UpdatePlayerParam param) async {
    await Future.delayed(const Duration(seconds: 1));

    return Right(
      PlayerEntity(
        playerId: param.playerId,
        fullName: param.fullName ?? 'Ethan Carter',
        team: param.team,
        position: param.position,
        height: param.height,
        weight: param.weight,
      ),
    );
  }

  @override
  Future<Either<AppErrors, MediaEntity>> uploadMedia(
      UploadMediaParam param) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      MediaEntity(
        mediaId: 'media_${DateTime.now().millisecondsSinceEpoch}',
        mediaUrl: 'https://picsum.photos/400/300',
        thumbnailUrl: 'https://picsum.photos/200/150',
        mediaType: param.mediaType,
        title: param.title ?? 'New Media',
        description: param.description,
        uploadDate: DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  Future<Either<AppErrors, List<GameEntity>>> getUpcomingGames(
      GetPlayerParam param) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return Right([
      const GameEntity(
        gameId: '1',
        opponent: 'Warriors',
        date: 'Nov 10, 2025',
        time: '7:00 PM',
        location: 'Staples Center',
        homeAway: 'Home',
        competition: 'NBA Regular Season',
      ),
      const GameEntity(
        gameId: '2',
        opponent: 'Bulls',
        date: 'Nov 12, 2025',
        time: '8:30 PM',
        location: 'United Center',
        homeAway: 'Away',
        competition: 'NBA Regular Season',
      ),
      const GameEntity(
        gameId: '3',
        opponent: 'Celtics',
        date: 'Nov 15, 2025',
        time: '6:00 PM',
        location: 'Staples Center',
        homeAway: 'Home',
        competition: 'NBA Regular Season',
      ),
      const GameEntity(
        gameId: '4',
        opponent: 'Heat',
        date: 'Nov 18, 2025',
        time: '7:30 PM',
        location: 'FTX Arena',
        homeAway: 'Away',
        competition: 'NBA Regular Season',
      ),
      const GameEntity(
        gameId: '5',
        opponent: 'Nets',
        date: 'Nov 20, 2025',
        time: '5:00 PM',
        location: 'Staples Center',
        homeAway: 'Home',
        competition: 'NBA Regular Season',
      ),
    ]);
  }

  @override
  Future<Either<AppErrors, List<MediaEntity>>> getPlayerMedia(
      GetPlayerParam param) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return Right([
      const MediaEntity(
        mediaId: '1',
        mediaUrl: 'https://picsum.photos/400/400?random=1',
        thumbnailUrl: 'https://picsum.photos/200/200?random=1',
        mediaType: 'photo',
        title: 'Game Highlight 1',
        description: 'Amazing shot from the game',
        uploadDate: '2025-11-01',
      ),
      const MediaEntity(
        mediaId: '2',
        mediaUrl: 'https://picsum.photos/400/400?random=2',
        thumbnailUrl: 'https://picsum.photos/200/200?random=2',
        mediaType: 'video',
        title: 'Training Session',
        description: 'Training highlights',
        uploadDate: '2025-11-02',
        duration: 120,
      ),
      const MediaEntity(
        mediaId: '3',
        mediaUrl: 'https://picsum.photos/400/400?random=3',
        thumbnailUrl: 'https://picsum.photos/200/200?random=3',
        mediaType: 'photo',
        title: 'Team Photo',
        description: 'Team celebration',
        uploadDate: '2025-11-03',
      ),
      const MediaEntity(
        mediaId: '4',
        mediaUrl: 'https://picsum.photos/400/400?random=4',
        thumbnailUrl: 'https://picsum.photos/200/200?random=4',
        mediaType: 'video',
        title: 'Best Goals',
        description: 'Season best goals compilation',
        uploadDate: '2025-11-04',
        duration: 180,
      ),
      const MediaEntity(
        mediaId: '5',
        mediaUrl: 'https://picsum.photos/400/400?random=5',
        thumbnailUrl: 'https://picsum.photos/200/200?random=5',
        mediaType: 'photo',
        title: 'Action Shot',
        description: 'In-game action',
        uploadDate: '2025-11-05',
      ),
      const MediaEntity(
        mediaId: '6',
        mediaUrl: 'https://picsum.photos/400/400?random=6',
        thumbnailUrl: 'https://picsum.photos/200/200?random=6',
        mediaType: 'photo',
        title: 'Victory Moment',
        description: 'Championship celebration',
        uploadDate: '2025-11-06',
      ),
    ]);
  }
}

