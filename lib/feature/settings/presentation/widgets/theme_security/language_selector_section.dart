import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Language selector section widget
class LanguageSelectorSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const LanguageSelectorSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Language & Region',
      icon: Icons.language,
      children: [
        PreferenceTile(
          title: 'Language',
          subtitle: _getLanguageDisplayText(preferences.language),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showLanguageSelector(context),
        ),
        PreferenceTile(
          title: 'Region',
          subtitle: _getRegionDisplayText(preferences.language),
          trailing: const Icon(Icons.public),
          onTap: () => _showRegionSelector(context),
        ),
      ],
    );
  }

  String _getLanguageDisplayText(String language) {
    final languageMap = {
      'en': 'English',
      'es': 'Español',
      'fr': 'Français',
      'de': 'Deutsch',
      'it': 'Italiano',
      'pt': 'Português',
      'ru': 'Русский',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'ar': 'العربية',
      'hi': 'हिन्दी',
    };
    return languageMap[language] ?? 'English';
  }

  String _getRegionDisplayText(String language) {
    final regionMap = {
      'en': 'United States',
      'es': 'España',
      'fr': 'France',
      'de': 'Deutschland',
      'it': 'Italia',
      'pt': 'Portugal',
      'ru': 'Россия',
      'zh': '中国',
      'ja': '日本',
      'ko': '대한민국',
      'ar': 'العربية',
      'hi': 'भारत',
    };
    return regionMap[language] ?? 'United States';
  }

  void _showLanguageSelector(BuildContext context) {
    final languages = [
      {'code': 'en', 'name': 'English', 'native': 'English'},
      {'code': 'es', 'name': 'Spanish', 'native': 'Español'},
      {'code': 'fr', 'name': 'French', 'native': 'Français'},
      {'code': 'de', 'name': 'German', 'native': 'Deutsch'},
      {'code': 'it', 'name': 'Italian', 'native': 'Italiano'},
      {'code': 'pt', 'name': 'Portuguese', 'native': 'Português'},
      {'code': 'ru', 'name': 'Russian', 'native': 'Русский'},
      {'code': 'zh', 'name': 'Chinese', 'native': '中文'},
      {'code': 'ja', 'name': 'Japanese', 'native': '日本語'},
      {'code': 'ko', 'name': 'Korean', 'native': '한국어'},
      {'code': 'ar', 'name': 'Arabic', 'native': 'العربية'},
      {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Language'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              final isSelected = preferences.language == language['code'];

              return ListTile(
                title: Text(
                  '${language['name']} (${language['native']})',
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Theme.of(context).primaryColor : null,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                onTap: () {
                  final updated =
                      preferences.copyWith(language: language['code']!);
                  onPreferenceChanged(updated);
                  Navigator.pop(context);
                },
              );
            },
          ),
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

  void _showRegionSelector(BuildContext context) {
    final regions = [
      {'code': 'US', 'name': 'United States'},
      {'code': 'CA', 'name': 'Canada'},
      {'code': 'GB', 'name': 'United Kingdom'},
      {'code': 'AU', 'name': 'Australia'},
      {'code': 'DE', 'name': 'Germany'},
      {'code': 'FR', 'name': 'France'},
      {'code': 'ES', 'name': 'Spain'},
      {'code': 'IT', 'name': 'Italy'},
      {'code': 'JP', 'name': 'Japan'},
      {'code': 'KR', 'name': 'South Korea'},
      {'code': 'CN', 'name': 'China'},
      {'code': 'IN', 'name': 'India'},
      {'code': 'BR', 'name': 'Brazil'},
      {'code': 'MX', 'name': 'Mexico'},
      {'code': 'RU', 'name': 'Russia'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Region'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: regions.length,
            itemBuilder: (context, index) {
              final region = regions[index];

              return ListTile(
                title: Text(region['name']!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // For demo purposes, we'll just close the dialog
                  // In a real app, you'd update region preferences
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Region set to ${region['name']}'),
                    ),
                  );
                },
              );
            },
          ),
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
}
