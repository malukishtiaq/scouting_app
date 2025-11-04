import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// General notifications section widget
class GeneralNotificationsSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const GeneralNotificationsSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'General Notifications',
      icon: Icons.notifications_active,
      children: [
        PreferenceTile(
          title: 'Someone Liked My Posts',
          subtitle: 'Notify when someone likes your content',
          trailing: Switch(
            value: preferences.notifyOnLikes,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnLikes: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Someone Commented My Posts',
          subtitle: 'Notify when someone comments on your content',
          trailing: Switch(
            value: preferences.notifyOnComments,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnComments: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Someone Shared My Posts',
          subtitle: 'Notify when someone shares your content',
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
          title: 'Someone Followed Me',
          subtitle: 'Notify when someone follows you',
          trailing: Switch(
            value: preferences.notifyOnFollows,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnFollows: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Someone Liked My Pages',
          subtitle: 'Notify when someone likes your pages',
          trailing: Switch(
            value: preferences.notifyOnLikes,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnLikes: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Someone Visited My Profile',
          subtitle: 'Notify when someone visits your profile',
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
          title: 'Someone Joined My Groups',
          subtitle: 'Notify when someone joins your groups',
          trailing: Switch(
            value: preferences.notifyOnGroupPosts,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnGroupPosts: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Friend Requests',
          subtitle: 'Notify when someone sends a friend request',
          trailing: Switch(
            value: preferences.notifyOnFriendRequests,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnFriendRequests: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Events',
          subtitle: 'Notify about upcoming events',
          trailing: Switch(
            value: preferences.notifyOnEvents,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnEvents: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Birthdays',
          subtitle: 'Notify about friends\' birthdays',
          trailing: Switch(
            value: preferences.notifyOnBirthdays,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnBirthdays: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Email Notifications',
          subtitle: 'Receive notifications via email',
          trailing: Switch(
            value: preferences.enableEmailNotifications,
            onChanged: (value) {
              final updated = preferences.copyWith(
                enableEmailNotifications: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }
}
