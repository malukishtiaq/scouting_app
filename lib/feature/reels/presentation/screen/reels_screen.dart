import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reels_cubit.dart';
import '../cubit/reels_state.dart';
import '../widget/reel_player_widget.dart';
import '../../../../core/video/video_cache_manager.dart';

class ReelsScreen extends StatefulWidget {
  static const String routeName = '/reels';

  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with WidgetsBindingObserver {
  late PageController _pageController;
  int _currentIndex = 0;

  // Gesture tracking for quick flicks
  double _dragStartY = 0;
  double _currentDragY = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    // Configure PageController for smooth scrolling
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
      keepPage: true,
    );
    // Load initial reels
    context.read<ReelsCubit>().loadReels();

    // Listen to app lifecycle events
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Clear cache when app goes to background to free memory
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      print('📱 APP PAUSED: Clearing video cache to free memory');
      VideoCacheManager().forceCleanup(clearAll: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<ReelsCubit, ReelsState>(
        listener: (context, state) {
          if (state is ReelsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message ?? 'Unknown error'),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: state.retry,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReelsInitial || state is ReelsLoading) {
            return Stack(
              children: [
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                _buildBackOverlay(context),
              ],
            );
          } else if (state is ReelsLoaded) {
            final reels = state.reels;
            if (reels.isEmpty) {
              return Stack(
                children: [
                  const Center(
                    child: Text(
                      'No reels available',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  _buildBackOverlay(context),
                ],
              );
            }

            // Prepare initial window once first frame is built
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ReelsCubit>().preloadUpcomingVideos(_currentIndex);
            });
            return Stack(
              children: [
                GestureDetector(
                  onVerticalDragStart: (details) {
                    _isDragging = true;
                    _dragStartY = details.globalPosition.dy;
                    _currentDragY = details.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (details) {
                    if (_isDragging) {
                      _currentDragY = details.globalPosition.dy;
                    }
                  },
                  onVerticalDragEnd: (details) {
                    if (!_isDragging) return;
                    _isDragging = false;

                    final dragDistance = _dragStartY - _currentDragY;
                    final screenHeight = MediaQuery.of(context).size.height;
                    final dragPercent = (dragDistance.abs() / screenHeight);
                    final velocity = details.primaryVelocity ?? 0;

                    // Quick flick: velocity > 300 OR drag > 15% of screen
                    final isQuickFlick = velocity.abs() > 300;
                    final isSignificantDrag = dragPercent > 0.15;

                    if (isQuickFlick || isSignificantDrag) {
                      if (dragDistance > 0) {
                        // Swiped up - next video
                        if (_currentIndex < reels.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      } else {
                        // Swiped down - previous video
                        if (_currentIndex > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      }
                    }

                    // Reset tracking
                    _dragStartY = 0;
                    _currentDragY = 0;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable built-in scrolling
                    pageSnapping: true,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });

                      // Trigger intelligent preloading based on current position
                      context.read<ReelsCubit>().preloadUpcomingVideos(index);

                      // Load more reels when approaching the end
                      if (index >= reels.length - 2) {
                        context.read<ReelsCubit>().loadMoreReels();
                      }
                    },
                    itemCount: reels.length,
                    itemBuilder: (context, index) {
                      final reel = reels[index];
                      return ReelPlayerWidget(
                        reel: reel,
                        isActive: index == _currentIndex,
                      );
                    },
                    // Performance optimizations
                    allowImplicitScrolling: false,
                    padEnds: false,
                  ),
                ),
                _buildBackOverlay(context),
              ],
            );
          } else if (state is ReelsError) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load reels',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.error.message ?? 'Unknown error',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: state.retry,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                _buildBackOverlay(context),
              ],
            );
          }

          return Stack(
            children: [
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              _buildBackOverlay(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackOverlay(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              tooltip: 'Back',
            ),
          ),
        ),
      ),
    );
  }
}
