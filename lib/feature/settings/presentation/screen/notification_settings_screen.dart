import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/settings_cubit.dart';
import '../widgets/settings_section.dart';
import '../widgets/preference_tile.dart';
import '../widgets/notifications/message_notifications_section.dart';
import '../widgets/notifications/general_notifications_section.dart';
import '../../domain/entities/user_preferences_entity.dart';

/// Complete notification settings screen
class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save all notification preferences
              final cubit = context.read<SettingsCubit>();
              if (cubit.state is SettingsLoaded) {
                final state = cubit.state as SettingsLoaded;
                cubit.savePreferences(state.preferences);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is SettingsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SettingsCubit>().loadPreferences();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is SettingsLoaded) {
            return _buildNotificationContent(context, state.preferences);
          }
          
          return const Center(child: Text('No settings loaded'));
        },
      ),
    );
  }

  Widget _buildNotificationContent(BuildContext context, UserPreferencesEntity preferences) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Message Notifications Section
        MessageNotificationsSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // General Notifications Section
        GeneralNotificationsSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Quiet Hours Section
        SettingsSection(
          title: 'Quiet Hours',
          icon: Icons.bedtime,
          children: [
            PreferenceTile(
              title: 'Enable Quiet Hours',
              subtitle: 'Mute notifications during specific hours',
              trailing: Switch(
                value: preferences.quietHoursEnabled,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    quietHoursEnabled: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            if (preferences.quietHoursEnabled) ...[
              PreferenceTile(
                title: 'Start Time',
                subtitle: preferences.quietHoursStart,
                trailing: const Icon(Icons.access_time),
                onTap: () => _showTimePicker(context, preferences, true),
              ),
              PreferenceTile(
                title: 'End Time',
                subtitle: preferences.quietHoursEnd,
                trailing: const Icon(Icons.access_time),
                onTap: () => _showTimePicker(context, preferences, false),
              ),
            ],
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Notification Sounds Section
        SettingsSection(
          title: 'Notification Sounds',
          icon: Icons.volume_up,
          children: [
            PreferenceTile(
              title: 'Notification Sound',
              subtitle: preferences.notificationSound,
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showSoundSelector(context, preferences),
            ),
            PreferenceTile(
              title: 'Vibration',
              subtitle: 'Vibrate on notifications',
              trailing: Switch(
                value: preferences.vibrationEnabled,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    vibrationEnabled: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'LED Light',
              subtitle: 'Show LED indicator',
              trailing: Switch(
                value: preferences.ledColorEnabled,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    ledColorEnabled: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Custom Ringtone',
              subtitle: preferences.customRingtone,
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showRingtoneSelector(context, preferences),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Muted Keywords Section
        SettingsSection(
          title: 'Muted Keywords',
          icon: Icons.block,
          children: [
            PreferenceTile(
              title: 'Add Muted Keyword',
              subtitle: 'Block notifications containing specific words',
              trailing: const Icon(Icons.add),
              onTap: () => _showAddKeywordDialog(context, preferences),
            ),
            if (preferences.mutedKeywords.isNotEmpty) ...[
              ...preferences.mutedKeywords.map((keyword) => PreferenceTile(
                title: keyword,
                subtitle: 'Muted keyword',
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeKeyword(context, preferences, keyword),
                ),
              )),
            ],
          ],
        ),
      ],
    );
  }

  void _showTimePicker(BuildContext context, UserPreferencesEntity preferences, bool isStartTime) {
    final currentTime = isStartTime 
        ? _parseTime(preferences.quietHoursStart)
        : _parseTime(preferences.quietHoursEnd);
    
    showTimePicker(
      context: context,
      initialTime: currentTime,
    ).then((time) {
      if (time != null) {
        final timeString = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        final updated = isStartTime
            ? preferences.copyWith(quietHoursStart: timeString)
            : preferences.copyWith(quietHoursEnd: timeString);
        context.read<SettingsCubit>().updatePreference(updated);
      }
    });
  }

  void _showSoundSelector(BuildContext context, UserPreferencesEntity preferences) {
    final sounds = ['default', 'chime', 'bell', 'ding', 'pop', 'custom'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Notification Sound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: sounds.map((sound) => ListTile(
            title: Text(sound),
            trailing: preferences.notificationSound == sound 
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              final updated = preferences.copyWith(notificationSound: sound);
              context.read<SettingsCubit>().updatePreference(updated);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showRingtoneSelector(BuildContext context, UserPreferencesEntity preferences) {
    final ringtones = ['default', 'classic', 'modern', 'nature', 'custom'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Ringtone'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ringtones.map((ringtone) => ListTile(
            title: Text(ringtone),
            trailing: preferences.customRingtone == ringtone 
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              final updated = preferences.copyWith(customRingtone: ringtone);
              context.read<SettingsCubit>().updatePreference(updated);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showAddKeywordDialog(BuildContext context, UserPreferencesEntity preferences) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Muted Keyword'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Keyword',
            hintText: 'Enter word to mute',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final keyword = controller.text.trim();
              if (keyword.isNotEmpty) {
                final updatedKeywords = List<String>.from(preferences.mutedKeywords)
                  ..add(keyword);
                final updated = preferences.copyWith(mutedKeywords: updatedKeywords);
                context.read<SettingsCubit>().updatePreference(updated);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeKeyword(BuildContext context, UserPreferencesEntity preferences, String keyword) {
    final updatedKeywords = List<String>.from(preferences.mutedKeywords)
      ..remove(keyword);
    final updated = preferences.copyWith(mutedKeywords: updatedKeywords);
    context.read<SettingsCubit>().updatePreference(updated);
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
