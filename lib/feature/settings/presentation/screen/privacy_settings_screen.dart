import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/settings_cubit.dart';
import '../widgets/settings_section.dart';
import '../widgets/preference_tile.dart';
import '../widgets/privacy/privacy_controls_section.dart';
import '../widgets/privacy/privacy_toggles_section.dart';

import '../../domain/entities/user_preferences_entity.dart';

/// Complete privacy settings screen
class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save all privacy preferences
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
            return _buildPrivacyContent(context, state.preferences);
          }

          return const Center(child: Text('No settings loaded'));
        },
      ),
    );
  }

  Widget _buildPrivacyContent(
      BuildContext context, UserPreferencesEntity preferences) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Privacy Controls Section
        PrivacyControlsSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Privacy Toggles Section
        PrivacyTogglesSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Blocked Users Section
        SettingsSection(
          title: 'Blocked Users',
          icon: Icons.block,
          children: [
            PreferenceTile(
              title: 'Add Blocked User',
              subtitle: 'Block specific users from contacting you',
              trailing: const Icon(Icons.add),
              onTap: () => _showAddBlockedUserDialog(context, preferences),
            ),
            if (preferences.blockedUsers.isNotEmpty) ...[
              ...preferences.blockedUsers.map((user) => PreferenceTile(
                    title: user,
                    subtitle: 'Blocked user',
                    trailing: IconButton(
                      icon: const Icon(Icons.block, color: Colors.green),
                      onPressed: () => _unblockUser(context, preferences, user),
                    ),
                  )),
            ],
          ],
        ),

        const SizedBox(height: 16),

        // Muted Users Section
        SettingsSection(
          title: 'Muted Users',
          icon: Icons.volume_off,
          children: [
            PreferenceTile(
              title: 'Add Muted User',
              subtitle: 'Mute notifications from specific users',
              trailing: const Icon(Icons.add),
              onTap: () => _showAddMutedUserDialog(context, preferences),
            ),
            if (preferences.mutedUsers.isNotEmpty) ...[
              ...preferences.mutedUsers.map((user) => PreferenceTile(
                    title: user,
                    subtitle: 'Muted user',
                    trailing: IconButton(
                      icon: const Icon(Icons.volume_up, color: Colors.blue),
                      onPressed: () => _unmuteUser(context, preferences, user),
                    ),
                  )),
            ],
          ],
        ),

        const SizedBox(height: 16),

        // Data Privacy Section
        SettingsSection(
          title: 'Data Privacy',
          icon: Icons.security,
          children: [
            PreferenceTile(
              title: 'Data Export',
              subtitle: 'Download your personal data',
              trailing: const Icon(Icons.download),
              onTap: () => _exportData(context, preferences),
            ),
            PreferenceTile(
              title: 'Data Deletion',
              subtitle: 'Request data deletion',
              trailing: const Icon(Icons.delete_forever),
              onTap: () => _showDataDeletionDialog(context),
            ),
            PreferenceTile(
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              trailing: const Icon(Icons.policy),
              onTap: () => _showPrivacyPolicy(context),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Location Privacy Section
        SettingsSection(
          title: 'Location Privacy',
          icon: Icons.location_on,
          children: [
            PreferenceTile(
              title: 'Show Location',
              subtitle: 'Display your location to others',
              trailing: Switch(
                value: preferences.showLocation,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    showLocation: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Location Accuracy',
              subtitle: 'Control location precision',
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showLocationAccuracyDialog(context, preferences),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Contact Privacy Section
        SettingsSection(
          title: 'Contact Privacy',
          icon: Icons.contact_phone,
          children: [
            PreferenceTile(
              title: 'Show Email',
              subtitle: 'Display your email address',
              trailing: Switch(
                value: preferences.showEmail,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    showEmail: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Show Phone Number',
              subtitle: 'Display your phone number',
              trailing: Switch(
                value: preferences.showPhoneNumber,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    showPhoneNumber: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Show Birthday',
              subtitle: 'Display your birthday',
              trailing: Switch(
                value: preferences.showBirthday,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    showBirthday: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddBlockedUserDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Blocked User'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Username or Email',
            hintText: 'Enter user to block',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final user = controller.text.trim();
              if (user.isNotEmpty) {
                final updatedUsers = List<String>.from(preferences.blockedUsers)
                  ..add(user);
                final updated =
                    preferences.copyWith(blockedUsers: updatedUsers);
                context.read<SettingsCubit>().updatePreference(updated);
                Navigator.pop(context);
              }
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _unblockUser(
      BuildContext context, UserPreferencesEntity preferences, String user) {
    final updatedUsers = List<String>.from(preferences.blockedUsers)
      ..remove(user);
    final updated = preferences.copyWith(blockedUsers: updatedUsers);
    context.read<SettingsCubit>().updatePreference(updated);
  }

  void _showAddMutedUserDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Muted User'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Username or Email',
            hintText: 'Enter user to mute',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final user = controller.text.trim();
              if (user.isNotEmpty) {
                final updatedUsers = List<String>.from(preferences.mutedUsers)
                  ..add(user);
                final updated = preferences.copyWith(mutedUsers: updatedUsers);
                context.read<SettingsCubit>().updatePreference(updated);
                Navigator.pop(context);
              }
            },
            child: const Text('Mute'),
          ),
        ],
      ),
    );
  }

  void _unmuteUser(
      BuildContext context, UserPreferencesEntity preferences, String user) {
    final updatedUsers = List<String>.from(preferences.mutedUsers)
      ..remove(user);
    final updated = preferences.copyWith(mutedUsers: updatedUsers);
    context.read<SettingsCubit>().updatePreference(updated);
  }

  void _exportData(BuildContext context, UserPreferencesEntity preferences) {
    // TODO: Implement data export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export feature coming soon!')),
    );
  }

  void _showDataDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Deletion'),
        content: const Text(
          'This will permanently delete your account and all associated data. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement data deletion
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    // TODO: Navigate to privacy policy screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy policy screen coming soon!')),
    );
  }

  void _showLocationAccuracyDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    final accuracies = ['High', 'Medium', 'Low', 'Off'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Accuracy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: accuracies
              .map((accuracy) => ListTile(
                    title: Text(accuracy),
                    trailing: const Icon(Icons.radio_button_unchecked),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Update location accuracy preference
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
