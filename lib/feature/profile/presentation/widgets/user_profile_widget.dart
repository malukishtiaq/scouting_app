import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_profile_cubit.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../../../di/service_locator.dart';
import '../../../../core/navigation/nav.dart';
import '../screen/user_profile_screen.dart';

class UserProfileWidget extends StatefulWidget {
  final String userId;
  final String? username;
  final bool showVerifiedBadge;
  final bool showLocation;
  final double? avatarRadius;
  final TextStyle? nameStyle;
  final TextStyle? usernameStyle;
  final GestureTapCallback? onTap;
  final bool enableNavigation;

  const UserProfileWidget({
    super.key,
    required this.userId,
    this.username,
    this.showVerifiedBadge = false,
    this.showLocation = false,
    this.avatarRadius = 20.0,
    this.nameStyle,
    this.usernameStyle,
    this.onTap,
    this.enableNavigation = true,
  });

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  late UserProfileCubit _userProfileCubit;
  UserProfileEntity? _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfileCubit = getIt<UserProfileCubit>();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _userProfileCubit.close();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    _userProfileCubit.loadUserProfile(widget.userId, username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      bloc: _userProfileCubit,
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          _userProfile = state.userProfile;
        }

        return GestureDetector(
          onTap: widget.enableNavigation
              ? () => _handleTap(context)
              : widget.onTap,
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNameRow(),
                    if (widget.showLocation && _userProfile?.about != null) ...[
                      const SizedBox(height: 2),
                      _buildLocationRow(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: widget.avatarRadius,
      backgroundColor: Colors.grey[300],
      backgroundImage: _userProfile?.avatar != null
          ? NetworkImage(_userProfile!.avatar!)
          : null,
      child: _userProfile?.avatar == null
          ? Icon(
              Icons.person,
              size: widget.avatarRadius! * 0.8,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildNameRow() {
    final displayName =
        _userProfile?.firstName != null && _userProfile?.lastName != null
            ? '${_userProfile!.firstName} ${_userProfile!.lastName}'
            : _userProfile?.username ?? widget.username ?? 'Unknown User';

    return Row(
      children: [
        Text(
          displayName,
          style: widget.nameStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
        ),
        if (widget.showVerifiedBadge && _userProfile?.verified == true) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.verified,
            size: 16,
            color: Colors.blue,
          ),
        ],
      ],
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 12,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          _userProfile?.about ?? '',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _handleTap(BuildContext context) {
    if (widget.enableNavigation) {
      Nav.to(
        UserProfileScreenModern.routeName,
        arguments: {
          'userId': widget.userId,
          'username': widget.username,
        },
        context: context,
      );
    }
  }
}

/// Compact user profile widget for comments and small spaces
class CompactUserProfileWidget extends StatefulWidget {
  final String userId;
  final String? username;
  final bool showVerifiedBadge;
  final double? avatarRadius;
  final GestureTapCallback? onTap;
  final bool enableNavigation;

  const CompactUserProfileWidget({
    super.key,
    required this.userId,
    this.username,
    this.showVerifiedBadge = false,
    this.avatarRadius = 16.0,
    this.onTap,
    this.enableNavigation = true,
  });

  @override
  State<CompactUserProfileWidget> createState() =>
      _CompactUserProfileWidgetState();
}

class _CompactUserProfileWidgetState extends State<CompactUserProfileWidget> {
  late UserProfileCubit _userProfileCubit;
  UserProfileEntity? _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfileCubit = getIt<UserProfileCubit>();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _userProfileCubit.close();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    _userProfileCubit.loadUserProfile(widget.userId, username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      bloc: _userProfileCubit,
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          _userProfile = state.userProfile;
        }

        return GestureDetector(
          onTap: widget.enableNavigation
              ? () => _handleTap(context)
              : widget.onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: widget.avatarRadius,
                backgroundColor: Colors.grey[300],
                backgroundImage: _userProfile?.avatar != null
                    ? NetworkImage(_userProfile!.avatar!)
                    : null,
                child: _userProfile?.avatar == null
                    ? Icon(
                        Icons.person,
                        size: widget.avatarRadius! * 0.8,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                _userProfile?.firstName != null &&
                        _userProfile?.lastName != null
                    ? '${_userProfile!.firstName} ${_userProfile!.lastName}'
                    : _userProfile?.username ??
                        widget.username ??
                        'Unknown User',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              if (widget.showVerifiedBadge &&
                  _userProfile?.verified == true) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified,
                  size: 14,
                  color: Colors.blue,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    if (widget.enableNavigation) {
      Nav.to(
        UserProfileScreenModern.routeName,
        arguments: {
          'userId': widget.userId,
          'username': widget.username,
        },
        context: context,
      );
    }
  }
}

/// User profile widget for post headers
class PostUserProfileWidget extends StatefulWidget {
  final String userId;
  final String? username;
  final String? timeAgo;
  final bool showVerifiedBadge;
  final bool showLocation;
  final GestureTapCallback? onTap;
  final bool enableNavigation;

  const PostUserProfileWidget({
    super.key,
    required this.userId,
    this.username,
    this.timeAgo,
    this.showVerifiedBadge = false,
    this.showLocation = false,
    this.onTap,
    this.enableNavigation = true,
  });

  @override
  State<PostUserProfileWidget> createState() => _PostUserProfileWidgetState();
}

class _PostUserProfileWidgetState extends State<PostUserProfileWidget> {
  late UserProfileCubit _userProfileCubit;
  UserProfileEntity? _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfileCubit = getIt<UserProfileCubit>();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _userProfileCubit.close();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    _userProfileCubit.loadUserProfile(widget.userId, username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      bloc: _userProfileCubit,
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          _userProfile = state.userProfile;
        }

        return GestureDetector(
          onTap: widget.enableNavigation
              ? () => _handleTap(context)
              : widget.onTap,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                backgroundImage: _userProfile?.avatar != null
                    ? NetworkImage(_userProfile!.avatar!)
                    : null,
                child: _userProfile?.avatar == null
                    ? const Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _userProfile?.firstName != null &&
                                  _userProfile?.lastName != null
                              ? '${_userProfile!.firstName} ${_userProfile!.lastName}'
                              : _userProfile?.username ??
                                  widget.username ??
                                  'Unknown User',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (widget.showVerifiedBadge &&
                            _userProfile?.verified == true) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            size: 16,
                            color: Colors.blue,
                          ),
                        ],
                      ],
                    ),
                    if (widget.timeAgo != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            widget.timeAgo!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (widget.showLocation &&
                              _userProfile?.about != null) ...[
                            Text(
                              ' • ${_userProfile!.about}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    if (widget.enableNavigation) {
      Nav.to(
        UserProfileScreenModern.routeName,
        arguments: {
          'userId': widget.userId,
          'username': widget.username,
        },
        context: context,
      );
    }
  }
}
