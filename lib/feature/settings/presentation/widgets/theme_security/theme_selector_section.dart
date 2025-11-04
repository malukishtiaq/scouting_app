import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Theme selector section widget
class ThemeSelectorSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const ThemeSelectorSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Theme Settings',
      icon: Icons.palette_outlined,
      children: [
        PreferenceTile(
          title: 'App Theme',
          subtitle: _getThemeDisplayText(preferences.theme),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showThemeSelector(context),
        ),
        if (preferences.theme == 'dark' || preferences.theme == 'light') ...[
          PreferenceTile(
            title: 'Auto Dark Mode',
            subtitle: 'Follow system theme automatically',
            trailing: Switch(
              value: preferences.theme == 'system',
              onChanged: (value) {
                final updated = preferences.copyWith(
                  theme: value ? 'system' : preferences.theme,
                );
                onPreferenceChanged(updated);
              },
            ),
          ),
        ],
      ],
    );
  }

  String _getThemeDisplayText(String theme) {
    switch (theme) {
      case 'light':
        return 'Light theme - bright and clean';
      case 'dark':
        return 'Dark theme - easy on the eyes';
      case 'system':
        return 'System theme - follows device setting';
      default:
        return 'System theme - follows device setting';
    }
  }

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              'Light',
              'light',
              Icons.light_mode,
              'Bright and clean interface',
            ),
            _buildThemeOption(
              context,
              'Dark',
              'dark',
              Icons.dark_mode,
              'Easy on the eyes in low light',
            ),
            _buildThemeOption(
              context,
              'System',
              'system',
              Icons.settings_brightness,
              'Follows your device settings',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String description,
  ) {
    final isSelected = preferences.theme == value;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
      ),
      subtitle: Text(description),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: () {
        final updated = preferences.copyWith(theme: value);
        onPreferenceChanged(updated);
        Navigator.pop(context);
      },
    );
  }
}
