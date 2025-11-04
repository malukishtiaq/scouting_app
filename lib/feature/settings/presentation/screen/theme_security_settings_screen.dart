import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/settings_cubit.dart';
import '../widgets/settings_section.dart';
import '../widgets/preference_tile.dart';
import '../widgets/theme_security/theme_selector_section.dart';
import '../widgets/theme_security/language_selector_section.dart';
import '../widgets/theme_security/password_management_section.dart';
import '../widgets/theme_security/two_factor_auth_section.dart';
import '../widgets/theme_security/security_settings_section.dart';
import '../../domain/entities/user_preferences_entity.dart';

/// Complete theme & security settings screen
class ThemeSecuritySettingsScreen extends StatelessWidget {
  const ThemeSecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Security'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save all theme & security preferences
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
            return _buildThemeSecurityContent(context, state.preferences);
          }

          return const Center(child: Text('No settings loaded'));
        },
      ),
    );
  }

  Widget _buildThemeSecurityContent(
      BuildContext context, UserPreferencesEntity preferences) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Theme Selector Section
        ThemeSelectorSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Language Selector Section
        LanguageSelectorSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Password Management Section
        PasswordManagementSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Two-Factor Authentication Section
        TwoFactorAuthSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Security Settings Section
        SecuritySettingsSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),

        const SizedBox(height: 16),

        // Display Settings Section
        SettingsSection(
          title: 'Display Settings',
          icon: Icons.display_settings,
          children: [
            PreferenceTile(
              title: 'Font Size',
              subtitle: '${preferences.fontSize.toInt()}px',
              trailing: const Icon(Icons.text_fields),
              onTap: () => _showFontSizeDialog(context, preferences),
            ),
            PreferenceTile(
              title: 'Enable Animations',
              subtitle: 'Show smooth animations throughout the app',
              trailing: Switch(
                value: preferences.enableAnimations,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    enableAnimations: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Haptic Feedback',
              subtitle: 'Vibrate on button presses',
              trailing: Switch(
                value: preferences.enableHapticFeedback,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    enableHapticFeedback: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Compact Mode',
              subtitle: 'Show more content in less space',
              trailing: Switch(
                value: preferences.compactMode,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    compactMode: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Format Settings Section
        SettingsSection(
          title: 'Format Settings',
          icon: Icons.format_list_bulleted,
          children: [
            PreferenceTile(
              title: 'Time Format',
              subtitle: preferences.timeFormat == '24h' ? '24-hour' : '12-hour',
              trailing: const Icon(Icons.access_time),
              onTap: () => _showTimeFormatDialog(context, preferences),
            ),
            PreferenceTile(
              title: 'Date Format',
              subtitle: preferences.dateFormat,
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _showDateFormatDialog(context, preferences),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Color Settings Section
        SettingsSection(
          title: 'Color Settings',
          icon: Icons.palette,
          children: [
            PreferenceTile(
              title: 'Primary Color',
              subtitle: 'Main app color theme',
              trailing: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(int.parse(
                      preferences.primaryColor.replaceAll('#', '0xFF'))),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onTap: () => _showColorPicker(context, preferences, true),
            ),
            PreferenceTile(
              title: 'Accent Color',
              subtitle: 'Secondary highlight color',
              trailing: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(int.parse(
                      preferences.accentColor.replaceAll('#', '0xFF'))),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onTap: () => _showColorPicker(context, preferences, false),
            ),
          ],
        ),
      ],
    );
  }

  void _showFontSizeDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Font Size'),
        content: StatefulBuilder(
          builder: (context, setState) {
            double fontSize = preferences.fontSize;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sample Text',
                  style: TextStyle(fontSize: fontSize),
                ),
                const SizedBox(height: 16),
                Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  label: '${fontSize.toInt()}px',
                  onChanged: (value) {
                    setState(() {
                      fontSize = value;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated =
                  preferences.copyWith(fontSize: preferences.fontSize);
              context.read<SettingsCubit>().updatePreference(updated);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showTimeFormatDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time Format'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('12-hour (1:30 PM)'),
              value: '12h',
              groupValue: preferences.timeFormat,
              onChanged: (value) {
                if (value != null) {
                  final updated = preferences.copyWith(timeFormat: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('24-hour (13:30)'),
              value: '24h',
              groupValue: preferences.timeFormat,
              onChanged: (value) {
                if (value != null) {
                  final updated = preferences.copyWith(timeFormat: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDateFormatDialog(
      BuildContext context, UserPreferencesEntity preferences) {
    final formats = ['MM/dd/yyyy', 'dd/MM/yyyy', 'yyyy-MM-dd', 'MMM dd, yyyy'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Date Format'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: formats
              .map((format) => RadioListTile<String>(
                    title: Text(format),
                    value: format,
                    groupValue: preferences.dateFormat,
                    onChanged: (value) {
                      if (value != null) {
                        final updated = preferences.copyWith(dateFormat: value);
                        context.read<SettingsCubit>().updatePreference(updated);
                        Navigator.pop(context);
                      }
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showColorPicker(
      BuildContext context, UserPreferencesEntity preferences, bool isPrimary) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isPrimary ? 'Primary Color' : 'Accent Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors
              .map((color) => GestureDetector(
                    onTap: () {
                      final colorString =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                      final updated = isPrimary
                          ? preferences.copyWith(primaryColor: colorString)
                          : preferences.copyWith(accentColor: colorString);
                      context.read<SettingsCubit>().updatePreference(updated);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
