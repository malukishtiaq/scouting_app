import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Password management section widget
class PasswordManagementSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const PasswordManagementSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Password & Security',
      icon: Icons.lock,
      children: [
        PreferenceTile(
          title: 'Change Password',
          subtitle: 'Update your account password',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showChangePasswordDialog(context),
        ),
        PreferenceTile(
          title: 'Require Password for Sensitive Actions',
          subtitle: 'Ask for password before sensitive operations',
          trailing: Switch(
            value: preferences.requirePasswordForSensitiveActions,
            onChanged: (value) {
              final updated = preferences.copyWith(
                requirePasswordForSensitiveActions: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Session Timeout',
          subtitle: '${preferences.sessionTimeoutMinutes} minutes',
          trailing: const Icon(Icons.timer),
          onTap: () => _showSessionTimeoutDialog(context),
        ),
        PreferenceTile(
          title: 'Log Out on Device Change',
          subtitle: 'Automatically sign out when switching devices',
          trailing: Switch(
            value: preferences.logOutOnDeviceChange,
            onChanged: (value) {
              final updated = preferences.copyWith(
                logOutOnDeviceChange: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Notify on New Device Login',
          subtitle: 'Get notified when signing in from new device',
          trailing: Switch(
            value: preferences.notifyOnNewDeviceLogin,
            onChanged: (value) {
              final updated = preferences.copyWith(
                notifyOnNewDeviceLogin: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Trusted Devices',
          subtitle: '${preferences.trustedDevices.length} devices',
          trailing: const Icon(Icons.devices),
          onTap: () => _showTrustedDevicesDialog(context),
        ),
        PreferenceTile(
          title: 'Allow Remember Device',
          subtitle: 'Remember this device for faster sign-in',
          trailing: Switch(
            value: preferences.allowRememberDevice,
            onChanged: (value) {
              final updated = preferences.copyWith(
                allowRememberDevice: value,
              );
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool obscureCurrentPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: obscureCurrentPassword,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureCurrentPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureCurrentPassword = !obscureCurrentPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPasswordController,
                  obscureText: obscureNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureNewPassword = !obscureNewPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password must be at least 8 characters long and contain uppercase, lowercase, number, and special character.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement password change logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                  ),
                );
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSessionTimeoutDialog(BuildContext context) {
    final timeouts = [5, 10, 15, 30, 60, 120];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session Timeout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: timeouts
              .map((timeout) => RadioListTile<int>(
                    title: Text('$timeout minutes'),
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

  void _showTrustedDevicesDialog(BuildContext context) {
    final devices = [
      {
        'name': 'iPhone 15 Pro',
        'lastUsed': '2 hours ago',
        'location': 'New York, NY'
      },
      {
        'name': 'MacBook Pro',
        'lastUsed': '1 day ago',
        'location': 'New York, NY'
      },
      {'name': 'iPad Air', 'lastUsed': '3 days ago', 'location': 'Boston, MA'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trusted Devices'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return ListTile(
                leading: const Icon(Icons.devices),
                title: Text(device['name']!),
                subtitle: Text(
                    'Last used: ${device['lastUsed']}\n${device['location']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // TODO: Implement device removal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${device['name']} removed from trusted devices'),
                      ),
                    );
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
        ],
      ),
    );
  }
}
