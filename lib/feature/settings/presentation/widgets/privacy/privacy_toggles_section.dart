import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Privacy toggles section widget
class PrivacyTogglesSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const PrivacyTogglesSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Privacy Toggles',
      icon: Icons.toggle_on,
      children: [
        PreferenceTile(
          title: 'Confirm request when someone follows you',
          subtitle: 'Require approval for new followers',
          trailing: Switch(
            value: preferences.requireApprovalForTags,
            onChanged: (value) {
              final updated = preferences.copyWith(
                requireApprovalForTags: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Show my activities',
          subtitle: 'Display your recent activities to others',
          trailing: Switch(
            value: preferences.showOnlineStatus,
            onChanged: (value) {
              final updated = preferences.copyWith(
                showOnlineStatus: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Show online users',
          subtitle: 'Display who is currently online',
          trailing: Switch(
            value: preferences.showOnlineStatus,
            onChanged: (value) {
              final updated = preferences.copyWith(
                showOnlineStatus: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Share my location with public',
          subtitle: 'Allow public access to your location',
          trailing: Switch(
            value: preferences.showLocation,
            onChanged: (value) {
              final updated = preferences.copyWith(
                showLocation: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Allow tagging',
          subtitle: 'Let others tag you in posts and photos',
          trailing: Switch(
            value: preferences.allowTagging,
            onChanged: (value) {
              final updated = preferences.copyWith(
                allowTagging: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Require approval for tags',
          subtitle: 'Review tags before they appear on your profile',
          trailing: Switch(
            value: preferences.requireApprovalForTags,
            onChanged: (value) {
              final updated = preferences.copyWith(
                requireApprovalForTags: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Show friends list',
          subtitle: 'Display your friends list to others',
          trailing: Switch(
            value: preferences.showFriendsList,
            onChanged: (value) {
              final updated = preferences.copyWith(
                showFriendsList: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Show followers list',
          subtitle: 'Display your followers list to others',
          trailing: Switch(
            value: preferences.showFollowersList,
            onChanged: (value) {
              final updated = preferences.copyWith(
                showFollowersList: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Auto-accept friend requests',
          subtitle: 'Automatically accept friend requests',
          trailing: Switch(
            value: preferences.autoAcceptFriendRequests,
            onChanged: (value) {
              final updated = preferences.copyWith(
                autoAcceptFriendRequests: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Allow sharing',
          subtitle: 'Let others share your content',
          trailing: Switch(
            value: preferences.allowSharing,
            onChanged: (value) {
              final updated = preferences.copyWith(
                allowSharing: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Allow downloads',
          subtitle: 'Let others download your content',
          trailing: Switch(
            value: preferences.allowDownloads,
            onChanged: (value) {
              final updated = preferences.copyWith(
                allowDownloads: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }
}
