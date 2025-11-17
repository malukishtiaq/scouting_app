import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../di/service_locator.dart';
import '../../../../localization/app_localization.dart';
import '../../../posts/domain/entity/posts_response_entity.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
import '../../../account/domain/usecase/update_profile_usecase.dart';
import '../../../account/data/request/param/update_profile_param.dart';
import 'qr_code_screen.dart';
import '../state_m/my_profile/my_profile_cubit.dart';
import '../state_m/my_profile/my_profile_state.dart';
import '../state_m/my_profile/my_profile_posts_cubit.dart';
import '../state_m/my_profile/my_profile_posts_state.dart';

class MyProfileScreenParam {
  const MyProfileScreenParam();
}

class MyProfileScreen extends BaseScreen<MyProfileScreenParam> {
  static const routeName = "/MyProfileScreen";

  const MyProfileScreen({required super.param, super.key});

  @override
  State createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  late final MyProfileCubit _cubit;
  late final MyProfilePostsCubit _postsCubit;
  late final TabController _tabController;

  // Edit mode state
  bool _isEditMode = false;
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  String? _selectedPosition;
  String? _selectedFoot;

  // Football positions
  final List<String> _footballPositions = [
    'Goalkeeper',
    'Centre Back',
    'Left Back',
    'Right Back',
    'Left Wing Back',
    'Right Wing Back',
    'Defensive Midfielder',
    'Central Midfielder',
    'Attacking Midfielder',
    'Left Midfielder',
    'Right Midfielder',
    'Left Winger',
    'Right Winger',
    'Centre Forward',
    'Striker',
    'Second Striker',
  ];

  @override
  void initState() {
    super.initState();
    _cubit = getIt<MyProfileCubit>()..loadMyProfile();
    _postsCubit = getIt<MyProfilePostsCubit>()..loadPosts();
    _tabController = TabController(length: 2, vsync: this);

    // Initialize controllers
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _cubit.close();
    _postsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _postsCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: BlocConsumer<MyProfileCubit, MyProfileState>(
          listener: _handleStateChanges,
          builder: (context, state) {
            return state.when(
              initial: _buildLoading,
              loading: _buildLoading,
              loaded: (profile, following, hasReachedMax) =>
                  _buildBody(profile, following),
              imageUpdating: (profile, imageType) =>
                  _buildBody(profile, profile.following),
              imageUpdated: (profile, imageType) =>
                  _buildBody(profile, profile.following),
              error: (message, profile) => _buildError(
                message: message,
                retry: () => _cubit.loadMyProfile(refresh: true),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showMediaUploadOptions,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          icon: const Icon(Icons.add),
          label: Text('upload_media'.tr, style: AppTextStyles.buttonMedium),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, MyProfileState state) {
    state.maybeWhen(
      imageUpdating: (profile, imageType) {
        final key = imageType == 'avatar'
            ? 'profile_updating_avatar'
            : 'profile_updating_cover';
        _showSnackBar(key.tr);
      },
      imageUpdated: (profile, imageType) {
        final key = imageType == 'avatar'
            ? 'profile_avatar_updated'
            : 'profile_cover_updated';
        _showSnackBar(key.tr);
      },
      error: (message, profile) {
        final content = message.isNotEmpty ? message : 'unknownError'.tr;
        _showSnackBar(content, isError: true);
      },
      orElse: () {},
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _buildError({
    required String message,
    VoidCallback? retry,
  }) {
    final resolved = message.isNotEmpty ? message : 'unknownError'.tr;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: AppDimensions.iconXXLarge,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              'profile_error_title'.tr,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.textOnPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              resolved,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (retry != null) ...[
              const SizedBox(height: AppDimensions.spacing24),
              GestureDetector(
                onTap: retry,
                child: Container(
                  decoration: AppDecorations.primaryButton,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacing12,
                  ),
                  alignment: Alignment.center,
                  child: Text('retry'.tr, style: AppTextStyles.buttonMedium),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    UserProfileEntity profile,
    List<UserProfileFollowerEntity> following,
  ) {
    return DefaultTabController(
      length: 2,
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          await Future.wait([
            _cubit.refreshProfile(),
            _postsCubit.refreshPosts(),
          ]);
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: _buildHeader(profile)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing24,
                  vertical: AppDimensions.spacing24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildActionButtons(profile),
                    const SizedBox(height: AppDimensions.spacing24),
                    _buildStatsRow(profile),
                    const SizedBox(height: AppDimensions.spacing24),
                    _buildOverviewCard(profile),
                    const SizedBox(height: AppDimensions.spacing24),
                    _buildUpcomingCard(profile),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primary,
                  labelStyle: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                  unselectedLabelStyle: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  tabs: [
                    Tab(text: 'videos'.tr),
                    Tab(text: 'images'.tr),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildVideosTab(),
              _buildImagesTab(following),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(UserProfileEntity profile) {
    const avatarSize = AppDimensions.avatarXXXLarge;
    const headerHeight =
        (AppDimensions.spacing64 * 3) + AppDimensions.spacing24;
    return SizedBox(
      height: headerHeight + 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildCover(profile),
          Container(decoration: AppDecorations.highlightGradientOverlay),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16,
                vertical: AppDimensions.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textOnPrimary,
                        ),
                        tooltip: 'go_back'.tr,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.textOnPrimary,
                        ),
                        onPressed: () => _showMoreActions(profile),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: Column(
                      children: [
                        _buildAvatar(profile, avatarSize),
                        const SizedBox(height: AppDimensions.spacing16),
                        Text(
                          profile.fullName,
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.spacing4),
                        Text(
                          '@${profile.username ?? ''}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(UserProfileEntity profile) {
    final cover = profile.cover;
    if (cover == null || cover.isEmpty) {
      return Container(decoration: AppDecorations.primaryGradient);
    }
    return CachedNetworkImage(
      imageUrl: cover,
      fit: BoxFit.cover,
      placeholder: (_, __) =>
          Container(decoration: AppDecorations.primaryGradient),
      errorWidget: (_, __, ___) =>
          Container(decoration: AppDecorations.primaryGradient),
    );
  }

  Widget _buildAvatar(UserProfileEntity profile, double size) {
    final avatarUrl = profile.avatar ?? '';
    return GestureDetector(
      onTap: _pickAvatar,
      child: Container(
        width: size,
        height: size,
        decoration: AppDecorations.avatarWithShadow,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          child: avatarUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: avatarUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _buildAvatarPlaceholder(),
                  errorWidget: (_, __, ___) => _buildAvatarPlaceholder(),
                )
              : _buildAvatarPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        color: AppColors.textSecondary,
        size: AppDimensions.iconXXLarge,
      ),
    );
  }

  Widget _buildActionButtons(UserProfileEntity profile) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_isEditMode) {
                _saveProfile(profile);
              } else {
                _enterEditMode(profile);
              }
            },
            child: Container(
              decoration: AppDecorations.primaryButton,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacing12,
              ),
              alignment: Alignment.center,
              child: Text(
                _isEditMode ? 'save_profile'.tr : 'edit_profile'.tr,
                style: AppTextStyles.buttonMedium,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_isEditMode) {
                _cancelEdit();
              } else {
                _showSnackBar('upload_coming_soon'.tr);
              }
            },
            child: Container(
              decoration: AppDecorations.secondaryButton,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacing12,
              ),
              alignment: Alignment.center,
              child: Text(
                _isEditMode ? 'cancel'.tr : 'upload_media'.tr,
                style: AppTextStyles.buttonMedium.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(UserProfileEntity profile) {
    final details = profile.details;
    final stats = [
      _ProfileStat(
        value: details?.followersCount ?? profile.followers.length,
        label: 'profile_connections'.tr,
      ),
      _ProfileStat(
        value: details?.postCount ?? 0,
        label: 'profile_recorded'.tr,
      ),
      _ProfileStat(
        value: details?.likesCount ?? 0,
        label: 'profile_completed'.tr,
      ),
    ];

    return Container(
      decoration: AppDecorations.card,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.spacing16,
        horizontal: AppDimensions.spacing16,
      ),
      child: Row(
        children: stats
            .map(
              (stat) => Expanded(
                child: Column(
                  children: [
                    Text(
                      _formatCount(stat.value),
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacing4),
                    Text(
                      stat.label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildOverviewCard(UserProfileEntity profile) {
    if (_isEditMode) {
      return Container(
        decoration: AppDecorations.card,
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'edit_profile_info'.tr,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.textOnPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            _buildEditField(
              label: 'name'.tr,
              controller: _nameController,
              hint: 'enter_name'.tr,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _buildEditField(
              label: 'age'.tr,
              controller: _ageController,
              hint: 'enter_age'.tr,
              isNumber: true,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _buildEditField(
              label: 'weight'.tr,
              controller: _weightController,
              hint: 'enter_weight'.tr,
              isNumber: true,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _buildEditField(
              label: 'height'.tr,
              controller: _heightController,
              hint: 'enter_height'.tr,
              isNumber: true,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _buildDropdownField(
              label: 'primary_position'.tr,
              value: _selectedPosition,
              items: _footballPositions,
              hint: 'select_position'.tr,
              onChanged: (value) {
                setState(() {
                  _selectedPosition = value;
                });
              },
            ),
            const SizedBox(height: AppDimensions.spacing12),
            _buildDropdownField(
              label: 'preferred_foot'.tr,
              value: _selectedFoot,
              items: ['Left', 'Right'],
              hint: 'select_foot'.tr,
              onChanged: (value) {
                setState(() {
                  _selectedFoot = value;
                });
              },
            ),
          ],
        ),
      );
    }

    final details = <_ProfileDetail>[
      _ProfileDetail(
        label: 'age'.tr,
        value: profile.age?.toString() ?? 'not_available'.tr,
      ),
      _ProfileDetail(
        label: 'height'.tr,
        value: profile.height != null
            ? '${profile.height} cm'
            : 'not_available'.tr,
      ),
      _ProfileDetail(
        label: 'weight'.tr,
        value: profile.weight != null
            ? '${profile.weight} kg'
            : 'not_available'.tr,
      ),
      _ProfileDetail(
        label: 'primary_position'.tr,
        value: profile.primaryPosition ?? 'not_available'.tr,
      ),
      _ProfileDetail(
        label: 'preferred_foot'.tr,
        value: profile.preferredFoot != null
            ? '${profile.preferredFoot![0].toUpperCase()}${profile.preferredFoot!.substring(1).toLowerCase()}'
            : 'not_available'.tr,
      ),
    ];

    return Container(
      decoration: AppDecorations.card,
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'profile_overview'.tr,
            style: AppTextStyles.h5.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing16),
          _buildOverviewDetailsGrid(details),
        ],
      ),
    );
  }

  Widget _buildOverviewDetailsGrid(List<_ProfileDetail> details) {
    final rows = <Widget>[];
    for (var index = 0; index < details.length; index += 2) {
      final first = details[index];
      final hasSecond = index + 1 < details.length;
      rows.add(
        Row(
          children: [
            Expanded(child: _buildOverviewDetailTile(first)),
            if (hasSecond) ...[
              const SizedBox(width: AppDimensions.spacing16),
              Expanded(child: _buildOverviewDetailTile(details[index + 1])),
            ],
          ],
        ),
      );
      if (index + 2 < details.length) {
        rows.add(const SizedBox(height: AppDimensions.spacing16));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }

  Widget _buildOverviewDetailTile(_ProfileDetail detail) {
    return Container(
      decoration: AppDecorations.secondaryButton,
      padding: const EdgeInsets.all(AppDimensions.spacing12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            detail.value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingCard(UserProfileEntity profile) {
    final upcoming = profile.details?.groupsCount ?? 0;
    return Container(
      decoration: AppDecorations.cardElevated,
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      child: Row(
        children: [
          Container(
            decoration: AppDecorations.primaryCircle,
            padding: const EdgeInsets.all(AppDimensions.spacing12),
            child: const Icon(
              Icons.event_available,
              color: AppColors.textOnPrimary,
              size: AppDimensions.iconLarge,
            ),
          ),
          const SizedBox(width: AppDimensions.spacing16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'upcoming_games'.tr,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                'profile_upcoming_summary'
                    .tr
                    .replaceFirst('{count}', upcoming.toString()),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideosTab() {
    return BlocBuilder<MyProfilePostsCubit, MyProfilePostsState>(
      builder: (context, state) {
        if (state is MyProfilePostsInitial || state is MyProfilePostsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (state is MyProfilePostsError) {
          return _buildMediaPlaceholder(
            icon: Icons.error_outline,
            title: 'profile_posts_error_title'.tr,
            subtitle: 'profile_posts_error_subtitle'.tr,
            action: () => context.read<MyProfilePostsCubit>().loadPosts(
                  refresh: true,
                ),
            actionLabel: 'retry'.tr,
          );
        }

        if (state is MyProfilePostsLoaded) {
          if (state.posts.isEmpty) {
            return _buildMediaPlaceholder(
              icon: Icons.videocam_outlined,
              title: 'profile_posts_empty_title'.tr,
              subtitle: 'profile_posts_empty_subtitle'.tr,
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent -
                      AppDimensions.spacing48) {
                context.read<MyProfilePostsCubit>().loadMorePosts();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16,
                vertical: AppDimensions.spacing16,
              ),
              itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(AppDimensions.spacing16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }
                final post = state.posts[index];
                return _buildPostCard(post);
              },
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppDimensions.spacing16),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildImagesTab(List<UserProfileFollowerEntity> following) {
    if (following.isEmpty) {
      return _buildMediaPlaceholder(
        icon: Icons.photo_outlined,
        title: 'profile_no_images'.tr,
        subtitle: 'profile_no_images_subtitle'.tr,
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimensions.spacing16,
        mainAxisSpacing: AppDimensions.spacing16,
        childAspectRatio: 0.75,
      ),
      itemCount: following.length,
      itemBuilder: (context, index) {
        final user = following[index];
        return Container(
          decoration: AppDecorations.card,
          padding: const EdgeInsets.all(AppDimensions.spacing12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppDimensions.avatarLarge,
                height: AppDimensions.avatarLarge,
                decoration: AppDecorations.avatarWithShadow,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.avatar ?? '',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _buildAvatarPlaceholder(),
                    errorWidget: (_, __, ___) => _buildAvatarPlaceholder(),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing8),
              Text(
                user.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostCard(PostEntity post) {
    final hasMedia = post.mediaUrl.isNotEmpty;
    final titleText = post.title.isNotEmpty ? post.title : post.description;
    final isVideo = post.mediaType == 'video';

    // Debug logging
    print('📹 POST DEBUG:');
    print('  ID: ${post.id}');
    print('  Title: ${post.title}');
    print('  MediaURL: "${post.mediaUrl}"');
    print('  MediaType: "${post.mediaType}"');
    print('  hasMedia: $hasMedia');
    print('  isVideo: $isVideo');

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to post detail or play video
        _showSnackBar('Opening ${isVideo ? 'video' : 'media'}: ${post.title}');
      },
      child: Container(
        decoration: AppDecorations.cardElevated,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video thumbnail area
            if (hasMedia) ...[
              Stack(
                children: [
                  // Video preview area with gradient background
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.8),
                          AppColors.accent.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppDimensions.radiusMedium),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'video'.tr.toUpperCase(),
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Video duration badge (placeholder)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '0:${(post.id * 13 % 60).toString().padLeft(2, '0')}', // Fake duration
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            // Content area
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (titleText.isNotEmpty)
                    Text(
                      titleText,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (post.description.isNotEmpty && post.title.isNotEmpty) ...[
                    const SizedBox(height: AppDimensions.spacing8),
                    Text(
                      post.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: AppDimensions.spacing12),
                  Row(
                    children: [
                      _buildPostStat(Icons.favorite_border, post.likes),
                      const SizedBox(width: AppDimensions.spacing16),
                      _buildPostStat(Icons.chat_bubble_outline, post.comments),
                      const SizedBox(width: AppDimensions.spacing16),
                      _buildPostStat(Icons.share_outlined, post.shares),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostStat(IconData icon, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppDimensions.iconSmall,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppDimensions.spacing4),
        Text(
          count.toString(),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMediaPlaceholder({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? action,
    String? actionLabel,
  }) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
              size: AppDimensions.iconXXLarge,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textOnPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null && actionLabel != null) ...[
              const SizedBox(height: AppDimensions.spacing24),
              GestureDetector(
                onTap: action,
                child: Container(
                  decoration: AppDecorations.primaryButton,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacing12,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    actionLabel,
                    style: AppTextStyles.buttonMedium,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMoreActions(UserProfileEntity profile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXLarge)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.dividerThicknessThick,
                decoration: AppDecorations.dividerThick,
              ),
              const SizedBox(height: AppDimensions.spacing16),
              _buildSheetHeader(profile),
              const SizedBox(height: AppDimensions.spacing16),
              _buildSheetItem(
                icon: Icons.photo_camera,
                title: 'profile_change_avatar'.tr,
                subtitle: 'profile_change_avatar_subtitle'.tr,
                onTap: () {
                  Navigator.pop(ctx);
                  _pickAvatar();
                },
              ),
              _buildSheetItem(
                icon: Icons.photo,
                title: 'profile_change_cover'.tr,
                subtitle: 'profile_change_cover_subtitle'.tr,
                onTap: () {
                  Navigator.pop(ctx);
                  _pickCover();
                },
              ),
              _buildSheetItem(
                icon: Icons.qr_code,
                title: 'profile_view_qr'.tr,
                subtitle: 'profile_view_qr_subtitle'.tr,
                onTap: () {
                  Navigator.pop(ctx);
                  Nav.to(QrCodeScreen.routeName,
                      arguments: QrCodeScreenParam(
                        userId: profile.userId,
                        username: profile.username,
                      ));
                },
              ),
              const SizedBox(height: AppDimensions.spacing16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader(UserProfileEntity profile) {
    return Row(
      children: [
        Container(
          width: AppDimensions.avatarLarge,
          height: AppDimensions.avatarLarge,
          decoration: AppDecorations.avatarWithShadow,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: profile.avatar ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => _buildAvatarPlaceholder(),
              errorWidget: (_, __, ___) => _buildAvatarPlaceholder(),
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.fullName,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                '@${profile.username ?? ''}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSheetItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: AppDecorations.secondaryButton,
        padding: const EdgeInsets.all(AppDimensions.spacing8),
        child: Icon(icon, color: AppColors.textOnPrimary),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textOnPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? AppColors.error : AppColors.surface,
        content: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }

  Future<void> _pickAvatar() async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
      if (file != null) {
        _cubit.updateAvatar(file.path);
      }
    } catch (e) {
      _showSnackBar(
        'profile_image_error'.tr.replaceFirst('{error}', e.toString()),
        isError: true,
      );
    }
  }

  Future<void> _pickCover() async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 90,
      );
      if (file != null) {
        _cubit.updateCover(file.path);
      }
    } catch (e) {
      _showSnackBar(
        'profile_image_error'.tr.replaceFirst('{error}', e.toString()),
        isError: true,
      );
    }
  }

  String _calculateAge(String? birthday) {
    if (birthday == null || birthday.isEmpty) {
      return 'not_available'.tr;
    }
    try {
      final birthDate = DateTime.parse(birthday);
      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age.toString();
    } catch (_) {
      return 'not_available'.tr;
    }
  }

  String _formatCount(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toString();
  }

  // ========== EDIT MODE METHODS ==========

  void _enterEditMode(UserProfileEntity profile) {
    setState(() {
      _isEditMode = true;
      // Pre-fill form fields with current profile data
      _nameController.text = profile.fullName;

      // Use age from profile
      if (profile.age != null) {
        _ageController.text = profile.age.toString();
      } else {
        _ageController.text = '';
      }

      // Use weight and height from profile
      _weightController.text = profile.weight?.toString() ?? '';
      _heightController.text = profile.height?.toString() ?? '';

      // Only set position if it exists in our list
      if (profile.primaryPosition != null &&
          _footballPositions.contains(profile.primaryPosition)) {
        _selectedPosition = profile.primaryPosition;
      } else {
        _selectedPosition = null;
      }

      // Set preferred foot
      if (profile.preferredFoot != null &&
          ['left', 'right'].contains(profile.preferredFoot!.toLowerCase())) {
        _selectedFoot = profile.preferredFoot!.substring(0, 1).toUpperCase() +
            profile.preferredFoot!.substring(1).toLowerCase();
      } else {
        _selectedFoot = null;
      }
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditMode = false;
      // Clear form fields
      _nameController.clear();
      _ageController.clear();
      _weightController.clear();
      _heightController.clear();
      _selectedPosition = null;
      _selectedFoot = null;
    });
  }

  Future<void> _saveProfile(UserProfileEntity profile) async {
    // Validate input
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('profile_name_required'.tr, isError: true);
      return;
    }

    // Parse numeric values
    int? age;
    int? weight; // Changed from double to int
    int? height; // Changed from double to int

    if (_ageController.text.isNotEmpty) {
      age = int.tryParse(_ageController.text);
      if (age == null) {
        _showSnackBar('profile_age_invalid'.tr, isError: true);
        return;
      }
    }

    if (_weightController.text.isNotEmpty) {
      weight = int.tryParse(_weightController.text); // Changed to int.tryParse
      if (weight == null) {
        _showSnackBar('profile_weight_invalid'.tr, isError: true);
        return;
      }
    }

    if (_heightController.text.isNotEmpty) {
      height = int.tryParse(_heightController.text); // Changed to int.tryParse
      if (height == null) {
        _showSnackBar('profile_height_invalid'.tr, isError: true);
        return;
      }
    }

    // Show loading indicator
    _showSnackBar('profile_updating'.tr);

    try {
      // Import the update profile usecase
      final updateProfileUsecase = getIt<UpdateProfileUsecase>();
      final param = UpdateProfileParam(
        name: _nameController.text.trim(),
        age: age,
        weight: weight, // Remove .toDouble()
        height: height, // Remove .toDouble()
        primaryPosition: _selectedPosition,
        preferredFoot: _selectedFoot?.toLowerCase(),
      );

      final result = await updateProfileUsecase(param);

      result.pick(
        onData: (response) {
          _showSnackBar('profile_updated_success'.tr);
          setState(() {
            _isEditMode = false;
          });
          // Refresh profile to show updated data
          _cubit.loadMyProfile(refresh: true);
        },
        onError: (error) {
          _showSnackBar(
            error.message ?? 'profile_update_failed'.tr,
            isError: true,
          );
        },
      );
    } catch (e) {
      _showSnackBar('profile_update_error'.tr, isError: true);
    }
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Container(
          decoration: AppDecorations.inputField,
          child: TextField(
            controller: controller,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(AppDimensions.spacing12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    // Ensure the value is either null or exists in the items list
    final safeValue = (value != null && items.contains(value)) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Container(
          decoration: AppDecorations.inputField,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing12,
            vertical: AppDimensions.spacing4,
          ),
          child: DropdownButton<String>(
            value: safeValue,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: Text(
              hint,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
            dropdownColor: AppColors.surface,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // Media Upload Methods
  void _showMediaUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacing24),
              Text(
                'upload_media'.tr,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacing24),
              _buildMediaOption(
                icon: Icons.videocam,
                title: 'upload_video'.tr,
                subtitle: 'record_or_select_video'.tr,
                onTap: () {
                  Navigator.pop(context);
                  _showVideoSourceOptions();
                },
              ),
              const SizedBox(height: AppDimensions.spacing16),
              _buildMediaOption(
                icon: Icons.photo_library,
                title: 'upload_image'.tr,
                subtitle: 'take_or_select_photo'.tr,
                onTap: () {
                  Navigator.pop(context);
                  _showImageSourceOptions();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.spacing12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppDimensions.iconMedium,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'select_video_source'.tr,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacing24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickVideo(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.videocam),
                label:
                    Text('record_video'.tr, style: AppTextStyles.buttonMedium),
              ),
              const SizedBox(height: AppDimensions.spacing12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickVideo(ImageSource.gallery);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary),
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.video_library),
                label: Text('select_from_gallery'.tr,
                    style: AppTextStyles.buttonMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'select_image_source'.tr,
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacing24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.camera_alt),
                label: Text('take_photo'.tr, style: AppTextStyles.buttonMedium),
              ),
              const SizedBox(height: AppDimensions.spacing12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary),
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                icon: const Icon(Icons.photo_library),
                label: Text('select_from_gallery'.tr,
                    style: AppTextStyles.buttonMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: source);

      if (video != null) {
        // For now, just show success message
        // TODO: Upload to server when API is available
        _showSnackBar('video_selected_upload_pending'.tr);
        print('📹 Video selected: ${video.path}');
        print('📹 Video size: ${await video.length()} bytes');

        // TODO: In the future, upload the video
        // await _uploadVideo(video);
      }
    } catch (e) {
      print('Error picking video: $e');
      _showSnackBar('error_picking_video'.tr, isError: true);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // For now, just show success message
        // TODO: Upload to server when API is available
        _showSnackBar('image_selected_upload_pending'.tr);
        print('📸 Image selected: ${image.path}');
        print('📸 Image size: ${await image.length()} bytes');

        // TODO: In the future, upload the image
        // await _uploadImage(image);
      }
    } catch (e) {
      print('Error picking image: $e');
      _showSnackBar('error_picking_image'.tr, isError: true);
    }
  }

  // TODO: Implement when upload API is available
  // Future<void> _uploadVideo(XFile video) async {
  //   // Upload video to server
  // }

  // TODO: Implement when upload API is available
  // Future<void> _uploadImage(XFile image) async {
  //   // Upload image to server
  // }
}

class _ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _ProfileTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundDark,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing24),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_ProfileTabBarDelegate oldDelegate) => false;
}

class _ProfileStat {
  final int value;
  final String label;

  const _ProfileStat({required this.value, required this.label});
}

class _ProfileDetail {
  final String label;
  final String value;

  const _ProfileDetail({required this.label, required this.value});
}
