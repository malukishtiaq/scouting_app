import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Session management section widget
class SessionManagementSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const SessionManagementSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Session Management',
      icon: Icons.devices,
      children: [
        PreferenceTile(
          title: 'Active Sessions',
          subtitle:
              '${preferences.activeSessionsCount} devices currently signed in',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showActiveSessionsDialog(context),
        ),
        PreferenceTile(
          title: 'Session Timeout',
          subtitle:
              '${preferences.sessionTimeoutMinutes} minutes of inactivity',
          trailing: const Icon(Icons.timer),
          onTap: () => _showSessionTimeoutDialog(context),
        ),
        PreferenceTile(
          title: 'Auto-Logout on Inactivity',
          subtitle: 'Automatically sign out after period of inactivity',
          trailing: Switch(
            value: preferences.autoLogoutOnInactivity,
            onChanged: (value) {
              final updated = preferences.copyWith(
                autoLogoutOnInactivity: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Remember This Device',
          subtitle: 'Keep me signed in on this device',
          trailing: Switch(
            value: preferences.rememberThisDevice,
            onChanged: (value) {
              final updated = preferences.copyWith(rememberThisDevice: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Trusted Devices',
          subtitle: 'Manage devices that don\'t require re-authentication',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showTrustedDevicesDialog(context),
        ),
        PreferenceTile(
          title: 'Force Logout All Devices',
          subtitle: 'Sign out from all devices immediately',
          trailing: const Icon(Icons.logout, color: Colors.red),
          onTap: () => _showForceLogoutDialog(context),
        ),
      ],
    );
  }

  void _showActiveSessionsDialog(BuildContext context) {
    final sessions = [
      {
        'device': 'iPhone 15 Pro (Current)',
        'location': 'New York, NY',
        'lastActive': 'Now',
        'ip': '192.168.1.100',
        'isCurrent': true,
      },
      {
        'device': 'MacBook Pro',
        'location': 'New York, NY',
        'lastActive': '2 hours ago',
        'ip': '192.168.1.101',
        'isCurrent': false,
      },
      {
        'device': 'iPad Air',
        'location': 'Boston, MA',
        'lastActive': '1 day ago',
        'ip': '198.51.100.50',
        'isCurrent': false,
      },
      {
        'device': 'Samsung Galaxy',
        'location': 'Los Angeles, CA',
        'lastActive': '3 days ago',
        'ip': '203.0.113.25',
        'isCurrent': false,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Active Sessions'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                leading: Icon(
                  session['isCurrent'] as bool
                      ? Icons.phone_android
                      : Icons.devices,
                  color:
                      session['isCurrent'] as bool ? Colors.blue : Colors.grey,
                ),
                title: Text(session['device'] as String),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${session['location']} • ${session['ip']}'),
                    Text('Last active: ${session['lastActive']}'),
                  ],
                ),
                trailing: session['isCurrent'] as bool
                    ? const Chip(
                        label: Text('Current'),
                        backgroundColor: Colors.blue,
                      )
                    : PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'end',
                            child: Text('End Session'),
                          ),
                          const PopupMenuItem(
                            value: 'trust',
                            child: Text('Trust Device'),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'end') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Session ended for ${session['device']}'),
                              ),
                            );
                          } else if (value == 'trust') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('${session['device']} is now trusted'),
                              ),
                            );
                          }
                        },
                      ),
                isThreeLine: true,
              );
            },
          ),
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
                const SnackBar(
                  content: Text('All other sessions ended'),
                ),
              );
            },
            child: const Text('End All Other Sessions'),
          ),
        ],
      ),
    );
  }

  void _showSessionTimeoutDialog(BuildContext context) {
    final timeouts = [5, 10, 15, 30, 60, 120, 240];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session Timeout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: timeouts
              .map((timeout) => RadioListTile<int>(
                    title: Text('$timeout minutes'),
                    subtitle: Text(_getTimeoutDescription(timeout)),
                    value: timeout,
                    groupValue: preferences.sessionTimeoutMinutes,
                    onChanged: (value) {
                      if (value != null) {
                        final updated =
                            preferences.copyWith(sessionTimeoutMinutes: value);
                        onPreferenceChanged(updated);
                        Navigator.pop(context);
                      }
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  String _getTimeoutDescription(int minutes) {
    if (minutes <= 15) return 'Very short - for high security';
    if (minutes <= 60) return 'Short - for regular use';
    if (minutes <= 120) return 'Medium - for convenience';
    return 'Long - for extended sessions';
  }

  void _showTrustedDevicesDialog(BuildContext context) {
    final trustedDevices = [
      {
        'name': 'MacBook Pro',
        'added': '2 weeks ago',
        'lastUsed': '1 day ago',
        'location': 'New York, NY',
      },
      {
        'name': 'iPad Air',
        'added': '1 month ago',
        'lastUsed': '3 days ago',
        'location': 'Boston, MA',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trusted Devices'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Trusted devices don\'t require re-authentication for 30 days.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...trustedDevices.map((device) => ListTile(
                  leading: const Icon(Icons.devices),
                  title: Text(device['name'] as String),
                  subtitle: Text(
                    'Added: ${device['added']}\nLast used: ${device['lastUsed']}\n${device['location']}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${device['name']} removed from trusted devices'),
                        ),
                      );
                    },
                  ),
                  isThreeLine: true,
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

  void _showForceLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Force Logout All Devices'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This will immediately sign you out from all devices, including this one.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
                'You will need to sign in again on any device you want to use.'),
            SizedBox(height: 16),
            Text(
              'This action is useful if you suspect unauthorized access to your account.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
                  content: Text('All devices signed out successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Force Logout All'),
          ),
        ],
      ),
    );
  }
}
