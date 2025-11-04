import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Message notifications section widget
class MessageNotificationsSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const MessageNotificationsSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Message Notifications',
      icon: Icons.message,
      children: [
        PreferenceTile(
          title: 'Chat Heads',
          subtitle: 'Show chat bubbles on screen',
          trailing: Switch(
            value: preferences.enableInAppNotifications,
            onChanged: (value) {
              final updated = preferences.copyWith(
                enableInAppNotifications: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Notification Popup',
          subtitle: 'Show notification previews',
          trailing: Switch(
            value: preferences.enablePushNotifications,
            onChanged: (value) {
              final updated = preferences.copyWith(
                enablePushNotifications: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Conversation Tones',
          subtitle: 'Play sounds for messages',
          trailing: Switch(
            value: preferences.notifyOnNewMessages,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnNewMessages: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'New Messages',
          subtitle: 'Notify when receiving new messages',
          trailing: Switch(
            value: preferences.notifyOnNewMessages,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnNewMessages: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Group Messages',
          subtitle: 'Notify for group chat messages',
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
          title: 'Mentions',
          subtitle: 'Notify when someone mentions you',
          trailing: Switch(
            value: preferences.notifyOnMentions,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnMentions: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }
}
