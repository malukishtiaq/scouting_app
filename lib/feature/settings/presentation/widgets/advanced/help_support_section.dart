import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Help & support section widget
class HelpSupportSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const HelpSupportSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Help & Support',
      icon: Icons.help,
      children: [
        PreferenceTile(
          title: 'Help Center',
          subtitle: 'Browse help articles and tutorials',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showHelpCenterDialog(context),
        ),
        PreferenceTile(
          title: 'Contact Support',
          subtitle: 'Get help from our support team',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showContactSupportDialog(context),
        ),
        PreferenceTile(
          title: 'Report a Problem',
          subtitle: 'Report bugs or technical issues',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showReportProblemDialog(context),
        ),
        PreferenceTile(
          title: 'Feature Requests',
          subtitle: 'Suggest new features or improvements',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showFeatureRequestDialog(context),
        ),
        PreferenceTile(
          title: 'Community Forum',
          subtitle: 'Connect with other users',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showCommunityForumDialog(context),
        ),
        PreferenceTile(
          title: 'Live Chat',
          subtitle: 'Chat with support in real-time',
          trailing: Switch(
            value: preferences.enableLiveChat,
            onChanged: (value) {
              final updated = preferences.copyWith(enableLiveChat: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }

  void _showHelpCenterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help Center'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Browse help articles and tutorials:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.article, color: Colors.blue),
              title: const Text('Getting Started'),
              subtitle: const Text('Learn the basics of using the app'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Getting Started guide opened')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.security, color: Colors.green),
              title: const Text('Privacy & Security'),
              subtitle: const Text('Understand your privacy settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy guide opened')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text('Settings & Preferences'),
              subtitle: const Text('Customize your app experience'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings guide opened')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.troubleshoot, color: Colors.red),
              title: const Text('Troubleshooting'),
              subtitle: const Text('Common issues and solutions'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Troubleshooting guide opened')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactSupportDialog(BuildContext context) {
    final supportOptions = [
      {
        'method': 'Email Support',
        'description': 'Get a response within 24 hours',
        'icon': Icons.email,
        'color': Colors.blue,
      },
      {
        'method': 'Phone Support',
        'description': 'Speak with a support agent',
        'icon': Icons.phone,
        'color': Colors.green,
      },
      {
        'method': 'In-App Chat',
        'description': 'Chat with support team',
        'icon': Icons.chat,
        'color': Colors.orange,
      },
      {
        'method': 'Video Call',
        'description': 'Screen share for complex issues',
        'icon': Icons.video_call,
        'color': Colors.purple,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose how you want to contact support:'),
            const SizedBox(height: 16),
            ...supportOptions.map((option) => ListTile(
                  leading: Icon(
                    option['icon'] as IconData,
                    color: option['color'] as Color,
                  ),
                  title: Text(option['method'] as String),
                  subtitle: Text(option['description'] as String),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${option['method']} support opened'),
                      ),
                    );
                  },
                )),
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

  void _showReportProblemDialog(BuildContext context) {
    final problemCategories = [
      'App Crashes',
      'Login Issues',
      'Performance Problems',
      'Feature Not Working',
      'UI/UX Issues',
      'Data Sync Problems',
      'Other',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report a Problem'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Help us fix the issue by providing details:'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Problem Category',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {
                // TODO: Show category picker
              },
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe the problem in detail...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Steps to Reproduce',
                hintText: '1. Open the app\n2. Go to settings\n3. ...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Include Screenshots:'),
                const SizedBox(width: 16),
                Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Handle screenshot toggle
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Problem report submitted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }

  void _showFeatureRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Suggest new features or improvements:'),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Feature Title',
                hintText: 'e.g., Dark Mode for Settings',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe the feature and how it would help...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Use Case',
                hintText: 'When would you use this feature?',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Priority:'),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: 3,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: 'High',
                    onChanged: (value) {
                      // TODO: Handle priority change
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feature request submitted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Submit Request'),
          ),
        ],
      ),
    );
  }

  void _showCommunityForumDialog(BuildContext context) {
    final forumCategories = [
      {
        'name': 'General Discussion',
        'topics': 1250,
        'posts': 5670,
        'icon': Icons.forum,
        'color': Colors.blue,
      },
      {
        'name': 'Feature Requests',
        'topics': 340,
        'posts': 890,
        'icon': Icons.lightbulb,
        'color': Colors.orange,
      },
      {
        'name': 'Bug Reports',
        'topics': 210,
        'posts': 450,
        'icon': Icons.bug_report,
        'color': Colors.red,
      },
      {
        'name': 'Tips & Tricks',
        'topics': 180,
        'posts': 320,
        'icon': Icons.tips_and_updates,
        'color': Colors.green,
      },
      {
        'name': 'Showcase',
        'topics': 95,
        'posts': 180,
        'icon': Icons.show_chart,
        'color': Colors.purple,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Community Forum'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Connect with other users:'),
            const SizedBox(height: 16),
            ...forumCategories.map((category) => ListTile(
                  leading: Icon(
                    category['icon'] as IconData,
                    color: category['color'] as Color,
                  ),
                  title: Text(category['name'] as String),
                  subtitle: Text(
                    '${category['topics']} topics • ${category['posts']} posts',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${category['name']} forum opened'),
                      ),
                    );
                  },
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Community forum opened')),
              );
            },
            child: const Text('Join Discussion'),
          ),
        ],
      ),
    );
  }
}
