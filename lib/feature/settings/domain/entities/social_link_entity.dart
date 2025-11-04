import '../../../../core/entities/base_entity.dart';

/// Social link types enum
enum SocialLinkType {
  website,
  facebook,
  twitter,
  instagram,
  linkedin,
  youtube,
  tiktok,
  snapchat,
  discord,
  github,
}

/// Social Link Entity for managing user's social media links
class SocialLinkEntity extends BaseEntity {
  final String id;
  final SocialLinkType type;
  final String url;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SocialLinkEntity({
    required this.id,
    required this.type,
    required this.url,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        url,
        isActive,
        createdAt,
        updatedAt,
      ];

  SocialLinkEntity copyWith({
    String? id,
    SocialLinkType? type,
    String? url,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SocialLinkEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get display name for the social link type
  String get displayName {
    switch (type) {
      case SocialLinkType.website:
        return 'Website';
      case SocialLinkType.facebook:
        return 'Facebook';
      case SocialLinkType.twitter:
        return 'Twitter';
      case SocialLinkType.instagram:
        return 'Instagram';
      case SocialLinkType.linkedin:
        return 'LinkedIn';
      case SocialLinkType.youtube:
        return 'YouTube';
      case SocialLinkType.tiktok:
        return 'TikTok';
      case SocialLinkType.snapchat:
        return 'Snapchat';
      case SocialLinkType.discord:
        return 'Discord';
      case SocialLinkType.github:
        return 'GitHub';
    }
  }

  /// Get icon for the social link type
  String get iconName {
    switch (type) {
      case SocialLinkType.website:
        return 'language';
      case SocialLinkType.facebook:
        return 'facebook';
      case SocialLinkType.twitter:
        return 'alternate_email';
      case SocialLinkType.instagram:
        return 'camera_alt';
      case SocialLinkType.linkedin:
        return 'work';
      case SocialLinkType.youtube:
        return 'play_circle';
      case SocialLinkType.tiktok:
        return 'music_note';
      case SocialLinkType.snapchat:
        return 'camera_alt';
      case SocialLinkType.discord:
        return 'chat';
      case SocialLinkType.github:
        return 'code';
    }
  }

  /// Get color for the social link type
  String get colorHex {
    switch (type) {
      case SocialLinkType.website:
        return '#6200EE';
      case SocialLinkType.facebook:
        return '#1877F2';
      case SocialLinkType.twitter:
        return '#1DA1F2';
      case SocialLinkType.instagram:
        return '#E4405F';
      case SocialLinkType.linkedin:
        return '#0077B5';
      case SocialLinkType.youtube:
        return '#FF0000';
      case SocialLinkType.tiktok:
        return '#000000';
      case SocialLinkType.snapchat:
        return '#FFFC00';
      case SocialLinkType.discord:
        return '#5865F2';
      case SocialLinkType.github:
        return '#333333';
    }
  }

  /// Validate URL format
  bool get isValidUrl {
    try {
      final uri = Uri.parse(url);
      return uri.hasAbsolutePath;
    } catch (e) {
      return false;
    }
  }

  /// Get platform-specific URL hint
  String get urlHint {
    switch (type) {
      case SocialLinkType.website:
        return 'https://example.com';
      case SocialLinkType.facebook:
        return 'https://facebook.com/yourprofile';
      case SocialLinkType.twitter:
        return 'https://twitter.com/yourhandle';
      case SocialLinkType.instagram:
        return 'https://instagram.com/yourhandle';
      case SocialLinkType.linkedin:
        return 'https://linkedin.com/in/yourprofile';
      case SocialLinkType.youtube:
        return 'https://youtube.com/c/yourchannel';
      case SocialLinkType.tiktok:
        return 'https://tiktok.com/@yourhandle';
      case SocialLinkType.snapchat:
        return 'https://snapchat.com/add/yourhandle';
      case SocialLinkType.discord:
        return 'https://discord.gg/yourserver';
      case SocialLinkType.github:
        return 'https://github.com/yourusername';
    }
  }
}
