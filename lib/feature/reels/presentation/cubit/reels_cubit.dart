import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../mainapis.dart';
import '../../../../core/video/video_cache_manager.dart';
import '../../data/request/param/get_reels_param.dart';
import '../../domain/entity/reels_response_entity.dart';
import '../../domain/usecase/get_reels_usecase.dart';
import '../../domain/usecase/get_more_reels_usecase.dart';
import 'reels_state.dart';

@injectable
class ReelsCubit extends Cubit<ReelsState> {
  final GetReelsUsecase getReelsUsecase;
  final GetMoreReelsUsecase getMoreReelsUsecase;

  ReelsCubit({
    required this.getReelsUsecase,
    required this.getMoreReelsUsecase,
  }) : super(const ReelsInitial());

  List<PostDataEntity> _reels = [];
  String? _lastPostId;
  bool _isLoading = false;

  /// Load initial reels
  void loadReels() async {
    if (_isLoading) return;

    emit(const ReelsLoading());
    _isLoading = true;

    try {
      final param = GetReelsParam(
        serverKey: MainAPIS.serverKey,
        type: 'get_news_feed',
        limit: '10',
        offset: '0',
        postType: 'video',
      );

      final result = await getReelsUsecase(param);

      result.pick(
        onData: (data) {
          final allReels = data.data ?? [];

          // Filter out invalid/deleted/unavailable posts
          _reels = _filterValidReels(allReels);
          _lastPostId = _reels.isNotEmpty ? _reels.last.id : null;

          // Preload videos for better performance
          _preloadVideos();

          emit(ReelsLoaded(_reels));

          // ✅ AGGRESSIVE PRELOAD: Immediately preload first 2 videos after load
          if (_reels.isNotEmpty) {
            Future.microtask(() => preloadUpcomingVideos(0));
          }
        },
        onError: (error) {
          emit(ReelsError(error, () => loadReels()));
        },
      );
    } catch (e) {
      emit(ReelsError(
        const AppErrors.customError(message: 'Failed to load reels'),
        () => loadReels(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  /// Load more reels for pagination
  void loadMoreReels() async {
    if (_isLoading || _lastPostId == null) return;

    _isLoading = true;

    try {
      final param = GetReelsParam(
        serverKey: MainAPIS.serverKey,
        type: 'get_news_feed',
        limit: '10',
        offset: _lastPostId!,
        postType: 'video',
      );

      final result = await getMoreReelsUsecase(param);

      result.pick(
        onData: (data) {
          final allNewReels = data.data ?? [];

          // Filter out invalid/deleted/unavailable posts
          final validNewReels = _filterValidReels(allNewReels);
          _reels.addAll(validNewReels);

          // Use last ID from ALL reels (even if some were filtered out)
          _lastPostId = allNewReels.isNotEmpty ? allNewReels.last.id : null;

          // Preload new videos
          _preloadVideos();

          emit(ReelsLoaded(_reels));

          // ✅ AGGRESSIVE PRELOAD: Preload upcoming videos after loading more
          final currentReelIndex = _reels.length - validNewReels.length;
          if (currentReelIndex >= 0) {
            Future.microtask(() => preloadUpcomingVideos(currentReelIndex));
          }
        },
        onError: (error) {
          emit(ReelsError(error, () => loadMoreReels()));
        },
      );
    } catch (e) {
      emit(ReelsError(
        const AppErrors.customError(message: 'Failed to load more reels'),
        () => loadMoreReels(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  /// Refresh reels
  void refreshReels() {
    _reels.clear();
    _lastPostId = null;
    loadReels();
  }

  /// Get current reels list
  List<PostDataEntity> get currentReels => _reels;

  /// Check if loading
  bool get isLoading => _isLoading;

  /// Check if has more reels to load
  bool get hasMoreReels => _lastPostId != null;

  /// Preload videos for better performance - DISABLED for memory
  void _preloadVideos() {
    // DISABLED: Preloading all videos causes NO_MEMORY errors
    // Only intelligent preloading (next 2-3 videos) is used via preloadUpcomingVideos()
    // This reduces memory usage from 50+ controllers to 3-5 controllers
    return;
  }

  /// Intelligent preloading - Preload 2 videos ahead
  void preloadUpcomingVideos(int currentIndex) {
    if (_reels.isEmpty) return;

    // Get all video URLs
    final allVideoUrls = <String>[];
    for (final reel in _reels) {
      if (reel.video.isNotEmpty) {
        final videoUrl = MainAPIS.getCoverImage(reel.video);
        allVideoUrls.add(videoUrl);
      }
    }

    if (allVideoUrls.isNotEmpty) {
      // Preload next 2 videos for smoother experience
      VideoCacheManager().preloadUpcomingVideos(
        allVideoUrls: allVideoUrls,
        currentIndex: currentIndex,
        preloadCount: 2, // ✅ Preload 2 videos ahead (current + 2 = 3 total)
      );
    }
  }

  /// Get preload status for current videos
  Map<String, bool> getPreloadStatus() {
    if (_reels.isEmpty) return {};

    final videoUrls = <String>[];
    for (final reel in _reels) {
      if (reel.video.isNotEmpty) {
        final videoUrl = MainAPIS.getCoverImage(reel.video);
        videoUrls.add(videoUrl);
      }
    }

    return VideoCacheManager().getPreloadStatus(videoUrls);
  }

  /// Check if specific video is preloaded
  bool isVideoPreloaded(int index) {
    if (index >= _reels.length) return false;

    final reel = _reels[index];
    if (reel.video.isEmpty) return false;

    final videoUrl = MainAPIS.getCoverImage(reel.video);
    return VideoCacheManager().isVideoPreloaded(videoUrl);
  }

  /// Filter out invalid reels
  List<PostDataEntity> _filterValidReels(List<PostDataEntity> reels) {
    int noId = 0, noVideo = 0;

    final filtered = reels.where((reel) {
      // 1. Check if post has valid ID
      if (reel.id.isEmpty) {
        noId++;
        return false;
      }

      // 2. Check if post has valid video URL
      if (reel.video.isEmpty) {
        noVideo++;
        return false;
      }

      // Post is valid
      return true;
    }).toList();

    // Only log if posts were filtered out
    final removedCount = reels.length - filtered.length;
    if (removedCount > 0) {
      print(
          '⚠️ FILTERED REELS: $removedCount removed (${filtered.length} valid) | Reasons: NoID=$noId, NoVideo=$noVideo');
    }

    return filtered;
  }
}
