import 'package:flutter/material.dart';
import '../settings_section.dart';

import '../../../domain/entities/user_preferences_entity.dart';
import 'privacy_selector_item.dart';

/// Privacy controls section widget
class PrivacyControlsSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const PrivacyControlsSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Privacy Controls',
      icon: Icons.privacy_tip,
      children: [
        PrivacySelectorItem(
          title: 'Who can follow me?',
          subtitle: _getFollowVisibilityText(preferences.profileVisibility),
          options: ['Everyone', 'Followers', 'None'],
          currentValue: preferences.profileVisibility,
          onChanged: (value) {
            final updated = preferences.copyWith(profileVisibility: value);
            onPreferenceChanged(updated);
          },
        ),
        PrivacySelectorItem(
          title: 'Who can message me?',
          subtitle:
              _getMessageVisibilityText(preferences.allowMessagesFromStrangers),
          options: ['Everyone', 'Followers', 'None'],
          currentValue:
              preferences.allowMessagesFromStrangers ? 'Everyone' : 'Followers',
          onChanged: (value) {
            final updated = preferences.copyWith(
              allowMessagesFromStrangers: value == 'Everyone',
            );
            onPreferenceChanged(updated);
          },
        ),
        PrivacySelectorItem(
          title: 'Who can see my friends?',
          subtitle: _getFriendsVisibilityText(preferences.showFriendsList),
          options: ['Everyone', 'Followers', 'None'],
          currentValue: preferences.showFriendsList ? 'Everyone' : 'Followers',
          onChanged: (value) {
            final updated = preferences.copyWith(
              showFriendsList: value != 'None',
            );
            onPreferenceChanged(updated);
          },
        ),
        PrivacySelectorItem(
          title: 'Who can post on my timeline?',
          subtitle: _getTimelineVisibilityText(preferences.allowTagging),
          options: ['Everyone', 'Followers', 'None'],
          currentValue: preferences.allowTagging ? 'Everyone' : 'Followers',
          onChanged: (value) {
            final updated = preferences.copyWith(
              allowTagging: value != 'None',
            );
            onPreferenceChanged(updated);
          },
        ),
        PrivacySelectorItem(
          title: 'Who can see my birthday?',
          subtitle: _getBirthdayVisibilityText(preferences.showBirthday),
          options: ['Everyone', 'Followers', 'None'],
          currentValue: preferences.showBirthday ? 'Everyone' : 'Followers',
          onChanged: (value) {
            final updated = preferences.copyWith(
              showBirthday: value != 'None',
            );
            onPreferenceChanged(updated);
          },
        ),
        PrivacySelectorItem(
          title: 'Who can see my followers?',
          subtitle: _getFollowersVisibilityText(preferences.showFollowersList),
          options: ['Everyone', 'Followers', 'None'],
          currentValue:
              preferences.showFollowersList ? 'Everyone' : 'Followers',
          onChanged: (value) {
            final updated = preferences.copyWith(
              showFollowersList: value != 'None',
            );
            onPreferenceChanged(updated);
          },
        ),
      ],
    );
  }

  String _getFollowVisibilityText(String visibility) {
    switch (visibility) {
      case 'public':
        return 'Everyone can follow you';
      case 'friends':
        return 'Only friends can follow you';
      case 'private':
        return 'No one can follow you';
      default:
        return 'Friends can follow you';
    }
  }

  String _getMessageVisibilityText(bool allowStrangers) {
    return allowStrangers
        ? 'Everyone can send you messages'
        : 'Only friends can send you messages';
  }

  String _getFriendsVisibilityText(bool showFriends) {
    return showFriends
        ? 'Everyone can see your friends list'
        : 'Only friends can see your friends list';
  }

  String _getTimelineVisibilityText(bool allowTagging) {
    return allowTagging
        ? 'Everyone can post on your timeline'
        : 'Only friends can post on your timeline';
  }

  String _getBirthdayVisibilityText(bool showBirthday) {
    return showBirthday
        ? 'Everyone can see your birthday'
        : 'Only friends can see your birthday';
  }

  String _getFollowersVisibilityText(bool showFollowers) {
    return showFollowers
        ? 'Everyone can see your followers'
        : 'Only friends can see your followers';
  }
}
