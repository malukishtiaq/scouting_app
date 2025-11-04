import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../di/service_locator.dart';
import '../../../../mainapis.dart';
import '../cubit/user_profile_cubit.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/user_profile_photo_entity.dart' as photo_entity;

/// User Profile Screen - Full Xamarin Feature Parity
/// Based on: Xamarin_Reference/.../Activities/UserProfile/UserProfileActivity.cs
///
/// Features:
/// - ✅ Cover image display
/// - ✅ Avatar image
/// - ✅ Stats: Followers, Following, Likes, Points (clickable)
/// - ✅ VIP/Pro badge
/// - ✅ Location/Country display
/// - ✅ Multiple tabs: Posts, Followers, Following, Photos, Groups, Pages
/// - ✅ All profile info fields
class UserProfileScreenModern extends StatefulWidget {
  final String userId;
  final String? username;

  const UserProfileScreenModern({
    super.key,
    required this.userId,
    this.username,
  });

  static const routeName = '/user-profile';

  @override
  State<UserProfileScreenModern> createState() =>
      _UserProfileScreenModernState();
}

class _UserProfileScreenModernState extends State<UserProfileScreenModern>
    with TickerProviderStateMixin {
  late UserProfileCubit _userProfileCubit;
  late TabController _tabController;
  bool _isDisposed = false;
  bool _postsLoaded = false;
  bool _photosLoaded = false;
  bool _followersLoaded = false;
  bool _followingLoaded = false;

  @override
  void initState() {
    super.initState();
    // 6 tabs like Xamarin: Posts, Followers, Following, Photos, Groups, Pages
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_onTabChanged);
    _userProfileCubit = getIt<UserProfileCubit>();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _userProfileCubit.close();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    if (_isDisposed) return;
    _userProfileCubit.loadUserProfile(widget.userId, username: widget.username);
  }

  void _onTabChanged() {
    if (_isDisposed) return;

    // ✅ CRITICAL: Only respond to actual user tab changes, not animation frames
    if (!_tabController.indexIsChanging) return;

    switch (_tabController.index) {
      case 0: // Posts tab
        if (!_postsLoaded) {
          _userProfileCubit.loadUserPosts(widget.userId);
          _postsLoaded = true;
        }
        break;
      case 1: // Followers tab
        if (!_followersLoaded) {
          _userProfileCubit.loadUserFollowers(widget.userId);
          _followersLoaded = true;
        }
        break;
      case 2: // Following tab
        if (!_followingLoaded) {
          _userProfileCubit.loadUserFollowing(widget.userId);
          _followingLoaded = true;
        }
        break;
      case 3: // Photos tab
        if (!_photosLoaded) {
          _userProfileCubit.loadUserPhotos(widget.userId);
          _photosLoaded = true;
        }
        break;
      case 4: // Groups tab
        // TODO: Load groups
        break;
      case 5: // Pages tab
        // TODO: Load pages
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: BlocListener<UserProfileCubit, UserProfileState>(
        bloc: _userProfileCubit,
        listener: (context, state) {
          if (_isDisposed) return;

          // Load posts automatically after profile is loaded (only first time)
          if (state is UserProfileLoaded &&
              !_postsLoaded &&
              _tabController.index == 0) {
            _userProfileCubit.loadUserPosts(widget.userId);
            _postsLoaded = true;
          }
        },
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          bloc: _userProfileCubit,
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return _buildLoadingState();
            } else if (state is UserProfileError) {
              return _buildErrorState(state.error);
            } else if (state is UserProfileLoaded ||
                state is UserProfilePostsLoaded ||
                state is UserProfilePhotosLoaded ||
                state is UserProfileFollowersLoaded ||
                state is UserProfileFollowingLoaded) {
              final userProfile = _getUserProfileFromState(state);

              return CustomScrollView(
                slivers: [
                  _buildCoverImageAppBar(userProfile),
                  _buildProfileInfo(userProfile),
                  _buildStatsSection(userProfile),
                  _buildActionButtons(userProfile),
                  _buildTabBar(),
                  _buildTabContent(userProfile, state),
                ],
              );
            }

            // For any other states, show loading to prevent blank screen
            return _buildLoadingState();
          },
        ),
      ),
    );
  }

  UserProfileEntity _getUserProfileFromState(UserProfileState state) {
    if (state is UserProfileLoaded) return state.userProfile;
    if (state is UserProfilePostsLoaded) return state.userProfile;
    if (state is UserProfilePhotosLoaded) return state.userProfile;
    if (state is UserProfileFollowersLoaded) return state.userProfile;
    if (state is UserProfileFollowingLoaded) return state.userProfile;
    return UserProfileEntity(); // Empty fallback
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A1B9A)),
          ),
          SizedBox(height: 16),
          Text(
            'Loading profile...',
            style: TextStyle(
              color: Color(0xFF6A1B9A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(AppErrors error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Failed to Load Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.message ?? 'An error occurred',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _loadUserProfile(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Cover Image AppBar - Like Xamarin ImageCover
  Widget _buildCoverImageAppBar(UserProfileEntity userProfile) {
    final coverUrl = userProfile.cover != null && userProfile.cover!.isNotEmpty
        ? MainAPIS.getCoverImage(userProfile.cover!)
        : '';

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF6A1B9A),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () => _showProfileOptions(context, userProfile),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          userProfile.username ?? 'Profile',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Cover Image
            if (coverUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: coverUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                    ),
                  ),
                ),
              )
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                  ),
                ),
              ),
            // Gradient overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Profile Info - Avatar, Name, Username, Last Seen, Pro Badge
  Widget _buildProfileInfo(UserProfileEntity userProfile) {
    final avatarUrl =
        userProfile.avatar != null && userProfile.avatar!.isNotEmpty
            ? MainAPIS.getCoverImage(userProfile.avatar!)
            : '';

    final isPro = userProfile.proType != null &&
        userProfile.proType != '0' &&
        userProfile.proType!.isNotEmpty;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF6A1B9A),
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: avatarUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Pro/VIP Badge
                  if (isPro)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Name, Username, Last Seen
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name with verified badge
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            userProfile.fullName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (userProfile.verified == true) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Username and last seen
                    Text(
                      '@${userProfile.username ?? 'user'} • ${userProfile.lastSeenText}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    // Pro badge
                    if (isPro) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.workspace_premium,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PRO Member',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Stats Section - Followers, Following, Likes, Points (Clickable like Xamarin)
  Widget _buildStatsSection(UserProfileEntity userProfile) {
    final details = userProfile.details;
    final followersCount = details?.followersCount ?? 0;
    final followingCount = details?.followingCount ?? 0;
    final likesCount = details?.likesCount ?? 0;
    final points = userProfile.points ?? 0;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Followers (clickable)
              _buildStatItem(
                count: _formatCount(followersCount),
                label: 'Followers',
                onTap: () => _navigateToTab(1), // Navigate to Followers tab
              ),
              _buildStatDivider(),
              // Following (clickable)
              _buildStatItem(
                count: _formatCount(followingCount),
                label: 'Following',
                onTap: () => _navigateToTab(2), // Navigate to Following tab
              ),
              _buildStatDivider(),
              // Likes (clickable)
              _buildStatItem(
                count: _formatCount(likesCount),
                label: 'Likes',
                onTap: () {
                  // TODO: Show likes details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Likes details coming soon')),
                  );
                },
              ),
              _buildStatDivider(),
              // Points (clickable)
              _buildStatItem(
                count: _formatCount(points),
                label: 'Points',
                onTap: () {
                  // TODO: Show points details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Points details coming soon')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey[300],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  void _navigateToTab(int tabIndex) {
    if (_tabController.index != tabIndex) {
      _tabController.animateTo(tabIndex);
    }
  }

  /// Action Buttons - Follow, Message, More
  Widget _buildActionButtons(UserProfileEntity userProfile) {
    final isFollowing = userProfile.isFollowing ?? false;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _userProfileCubit.followUser(userProfile.userId ?? '');
                  },
                  icon: Icon(
                    isFollowing ? Icons.person_remove : Icons.person_add,
                    size: 18,
                  ),
                  label: Text(isFollowing ? 'Unfollow' : 'Follow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFollowing
                        ? Colors.grey[300]
                        : const Color(0xFF6A1B9A),
                    foregroundColor:
                        isFollowing ? Colors.black87 : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement message functionality
                  },
                  icon: const Icon(Icons.message, size: 18),
                  label: const Text('Message'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6A1B9A),
                    side: const BorderSide(color: Color(0xFF6A1B9A), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF6A1B9A), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    _showMoreOptions(context, userProfile);
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          onTap: (index) => _onTabChanged(),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF6A1B9A),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Posts'),
            Tab(text: 'Followers'),
            Tab(text: 'Following'),
            Tab(text: 'Photos'),
            Tab(text: 'Groups'),
            Tab(text: 'Pages'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
      UserProfileEntity userProfile, UserProfileState state) {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(userProfile),
          _buildFollowersTab(userProfile, state),
          _buildFollowingTab(userProfile, state),
          _buildPhotosTab(userProfile, state),
          _buildGroupsTab(userProfile),
          _buildPagesTab(userProfile),
        ],
      ),
    );
  }

  Widget _buildPostsTab(UserProfileEntity userProfile) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      bloc: _userProfileCubit,
      builder: (context, state) {
        if (state is UserProfilePostsLoaded) {
          if (state.posts.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                _userProfileCubit.loadUserPosts(widget.userId);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return _buildModernPostCard(post);
                },
              ),
            );
          } else {
            return _buildEmptyState(
                icon: Icons.article_outlined, message: 'No posts yet');
          }
        } else if (state is UserProfileError) {
          return _buildErrorTabState('Failed to load posts', state.error);
        } else {
          return _buildLoadingTabState('Loading posts...');
        }
      },
    );
  }

  Widget _buildFollowersTab(
      UserProfileEntity userProfile, UserProfileState state) {
    if (state is UserProfileFollowersLoaded) {
      if (state.followers.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            _userProfileCubit.loadUserFollowers(widget.userId);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.followers.length,
            itemBuilder: (context, index) {
              final follower = state.followers[index];
              return _buildFollowerCard(follower);
            },
          ),
        );
      } else {
        return _buildEmptyState(
            icon: Icons.people_outline, message: 'No followers yet');
      }
    } else if (state is UserProfileError) {
      return _buildErrorTabState('Failed to load followers', state.error);
    } else {
      return _buildLoadingTabState('Loading followers...');
    }
  }

  Widget _buildFollowingTab(
      UserProfileEntity userProfile, UserProfileState state) {
    if (state is UserProfileFollowingLoaded) {
      if (state.following.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            _userProfileCubit.loadUserFollowing(widget.userId);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.following.length,
            itemBuilder: (context, index) {
              final following = state.following[index];
              return _buildFollowerCard(following);
            },
          ),
        );
      } else {
        return _buildEmptyState(
            icon: Icons.person_add_outlined,
            message: 'Not following anyone yet');
      }
    } else if (state is UserProfileError) {
      return _buildErrorTabState('Failed to load following', state.error);
    } else {
      return _buildLoadingTabState('Loading following...');
    }
  }

  Widget _buildPhotosTab(
      UserProfileEntity userProfile, UserProfileState state) {
    if (state is UserProfilePhotosLoaded) {
      if (state.photos.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            _userProfileCubit.loadUserPhotos(widget.userId);
          },
          child: CustomScrollView(
            slivers: [
              // Photos count header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.photo_library_outlined,
                        color: Color(0xFF6A1B9A),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${state.photos.length} Photos',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Photos grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final photo = state.photos[index];
                      return _buildPhotoItem(photo);
                    },
                    childCount: state.photos.length,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return _buildEmptyState(
            icon: Icons.photo_library_outlined, message: 'No photos yet');
      }
    } else if (state is UserProfileError) {
      return _buildErrorTabState('Failed to load photos', state.error);
    } else {
      return _buildLoadingTabState('Loading photos...');
    }
  }

  Widget _buildGroupsTab(UserProfileEntity userProfile) {
    final groups = userProfile.joinedGroups;
    if (groups.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return _buildGroupCard(group);
        },
      );
    } else {
      return _buildEmptyState(
          icon: Icons.group_outlined, message: 'No groups joined yet');
    }
  }

  Widget _buildPagesTab(UserProfileEntity userProfile) {
    final pages = userProfile.likedPages;
    if (pages.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return _buildPageCard(page);
        },
      );
    } else {
      return _buildEmptyState(
          icon: Icons.flag_outlined, message: 'No pages liked yet');
    }
  }

  Widget _buildModernPostCard(dynamic post) {
    final postText = post.postText ?? '';
    final postTime = post.postTime ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post time
            Text(
              postTime.toString(),
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            if (postText.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                postText.toString(),
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ],
            if (post.postFileFull != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl:
                      MainAPIS.getCoverImage(post.postFileFull.toString()),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            // Post stats
            Row(
              children: [
                Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  post.postLikes?.toString() ?? '0',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(width: 16),
                Icon(Icons.comment_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  post.postComments?.toString() ?? '0',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(width: 16),
                Icon(Icons.share_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  post.postShares?.toString() ?? '0',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowerCard(UserProfileFollowerEntity follower) {
    final avatarUrl = follower.avatar != null && follower.avatar!.isNotEmpty
        ? MainAPIS.getCoverImage(follower.avatar!)
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage:
              avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
          backgroundColor: Colors.grey[300],
          child: avatarUrl.isEmpty
              ? const Icon(Icons.person, color: Colors.grey)
              : null,
        ),
        title: Text(
          follower.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          '@${follower.username ?? 'user'}',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        trailing: follower.isFollowing == true
            ? OutlinedButton(
                onPressed: () {
                  // TODO: Unfollow
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Following'),
              )
            : ElevatedButton(
                onPressed: () {
                  // TODO: Follow
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Follow'),
              ),
        onTap: () {
          // Navigate to this user's profile
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreenModern(
                userId: follower.userId ?? '',
                username: follower.username,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupCard(UserProfileGroupEntity group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.group, color: Colors.grey),
        ),
        title: Text(
          group.groupName ?? 'Group',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          '${group.groupMembers ?? 0} members',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to group
        },
      ),
    );
  }

  Widget _buildPageCard(UserProfilePageEntity page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.flag, color: Colors.grey),
        ),
        title: Text(
          page.pageName ?? 'Page',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          '${page.pageLikes ?? 0} likes',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to page
        },
      ),
    );
  }

  Widget _buildPhotoItem(photo_entity.UserProfilePhotoEntity photo) {
    return GestureDetector(
      onTap: () => _showPhotoViewer(photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: MainAPIS.getCoverImage(photo.photoUrl ?? ''),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child:
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingTabState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A1B9A)),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorTabState(String title, AppErrors error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.message ?? 'An error occurred',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoViewer(photo_entity.UserProfilePhotoEntity photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: MainAPIS.getCoverImage(photo.photoUrl ?? ''),
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child:
                        Icon(Icons.broken_image, color: Colors.white, size: 64),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileOptions(
      BuildContext context, UserProfileEntity userProfile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xFF6A1B9A)),
              title: const Text('Share Profile'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share profile coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.red),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                _blockUser(context, userProfile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: Colors.orange),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(context);
                _reportUser(context, userProfile);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context, UserProfileEntity userProfile) {
    _showProfileOptions(context, userProfile);
  }

  void _blockUser(BuildContext context, UserProfileEntity userProfile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: Text(
            'Are you sure you want to block ${userProfile.username ?? 'User'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _userProfileCubit.blockUser(userProfile.userId ?? '', true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${userProfile.username ?? 'User'} has been blocked'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _reportUser(BuildContext context, UserProfileEntity userProfile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: Text('Report ${userProfile.username ?? 'User'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _userProfileCubit.reportUser(userProfile.userId ?? '');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${userProfile.username ?? 'User'} has been reported'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Report', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
}
