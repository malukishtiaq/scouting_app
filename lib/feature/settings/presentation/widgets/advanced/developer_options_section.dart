import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Developer options section widget
class DeveloperOptionsSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const DeveloperOptionsSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Developer Options',
      icon: Icons.developer_mode,
      children: [
        PreferenceTile(
          title: 'Debug Mode',
          subtitle: 'Enable advanced debugging features',
          trailing: Switch(
            value: preferences.debugMode,
            onChanged: (value) {
              final updated = preferences.copyWith(debugMode: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Performance Monitoring',
          subtitle: 'Monitor app performance metrics',
          trailing: Switch(
            value: preferences.allowPerformanceMonitoring,
            onChanged: (value) {
              final updated =
                  preferences.copyWith(allowPerformanceMonitoring: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Crash Reports',
          subtitle: 'Send crash reports for debugging',
          trailing: Switch(
            value: preferences.allowCrashReports,
            onChanged: (value) {
              final updated = preferences.copyWith(allowCrashReports: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Analytics',
          subtitle: 'Help improve the app with usage data',
          trailing: Switch(
            value: preferences.allowAnalytics,
            onChanged: (value) {
              final updated = preferences.copyWith(allowAnalytics: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Logs & Diagnostics',
          subtitle: 'View app logs and diagnostic information',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showLogsDialog(context),
        ),
        PreferenceTile(
          title: 'API Endpoints',
          subtitle: 'Configure API endpoints for development',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showApiEndpointsDialog(context),
        ),
        PreferenceTile(
          title: 'Feature Flags',
          subtitle: 'Enable/disable experimental features',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showFeatureFlagsDialog(context),
        ),
        PreferenceTile(
          title: 'Reset All Settings',
          subtitle: 'Reset all preferences to default values',
          trailing: const Icon(Icons.restore, color: Colors.orange),
          onTap: () => _showResetDialog(context),
        ),
      ],
    );
  }

  void _showLogsDialog(BuildContext context) {
    final logs = [
      {
        'level': 'INFO',
        'time': '12:34:56',
        'message': 'App initialized successfully'
      },
      {
        'level': 'DEBUG',
        'time': '12:34:57',
        'message': 'Settings loaded from storage'
      },
      {
        'level': 'WARN',
        'time': '12:35:00',
        'message': 'Cache size exceeds threshold'
      },
      {
        'level': 'ERROR',
        'time': '12:35:05',
        'message': 'Failed to sync preferences'
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logs & Diagnostics'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Logs:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logs exported')),
                      );
                    },
                    child: const Text('Export'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getLogColor(log['level'] as String),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                log['level'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                log['time'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            log['message'] as String,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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

  Color _getLogColor(String level) {
    switch (level) {
      case 'ERROR':
        return Colors.red;
      case 'WARN':
        return Colors.orange;
      case 'INFO':
        return Colors.blue;
      case 'DEBUG':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showApiEndpointsDialog(BuildContext context) {
    final endpoints = [
      {
        'name': 'Production',
        'url': 'https://api.wowonder.com',
        'status': 'Active'
      },
      {
        'name': 'Staging',
        'url': 'https://staging-api.wowonder.com',
        'status': 'Active'
      },
      {
        'name': 'Development',
        'url': 'https://dev-api.wowonder.com',
        'status': 'Inactive'
      },
      {'name': 'Local', 'url': 'http://localhost:3000', 'status': 'Inactive'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('API Endpoints'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Configure API endpoints for different environments:'),
            const SizedBox(height: 16),
            ...endpoints.map((endpoint) => ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: endpoint['status'] == 'Active'
                        ? Colors.green
                        : Colors.grey,
                    size: 12,
                  ),
                  title: Text(endpoint['name'] as String),
                  subtitle: Text(endpoint['url'] as String),
                  trailing: Switch(
                    value: endpoint['status'] == 'Active',
                    onChanged: (value) {
                      // TODO: Implement endpoint switching
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${endpoint['name']} endpoint ${value ? 'activated' : 'deactivated'}'),
                        ),
                      );
                    },
                  ),
                )),
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

  void _showFeatureFlagsDialog(BuildContext context) {
    final features = [
      {
        'name': 'Dark Mode',
        'enabled': true,
        'description': 'Enable dark theme'
      },
      {
        'name': 'Push Notifications',
        'enabled': true,
        'description': 'Enable push notifications'
      },
      {
        'name': 'Live Chat',
        'enabled': false,
        'description': 'Enable live chat support'
      },
      {
        'name': 'Advanced Encryption',
        'enabled': false,
        'description': 'Use enhanced encryption'
      },
      {
        'name': 'Performance Monitoring',
        'enabled': true,
        'description': 'Monitor app performance'
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature Flags'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enable/disable experimental features:'),
            const SizedBox(height: 16),
            ...features.map((feature) => ListTile(
                  leading: Icon(
                    feature['enabled'] as bool
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color:
                        feature['enabled'] as bool ? Colors.green : Colors.grey,
                  ),
                  title: Text(feature['name'] as String),
                  subtitle: Text(feature['description'] as String),
                  trailing: Switch(
                    value: feature['enabled'] as bool,
                    onChanged: (value) {
                      // TODO: Implement feature flag toggling
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${feature['name']} ${value ? 'enabled' : 'disabled'}'),
                        ),
                      );
                    },
                  ),
                )),
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

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Settings'),
        content: const Text(
          'This will reset all your preferences to their default values. '
          'This action cannot be undone. Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement reset functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All settings have been reset to defaults'),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
