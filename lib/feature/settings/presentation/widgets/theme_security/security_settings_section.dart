import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Security settings section widget
class SecuritySettingsSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const SecuritySettingsSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Security Settings',
      icon: Icons.shield,
      children: [
        PreferenceTile(
          title: 'Security Checkup',
          subtitle: 'Review your account security status',
          trailing: const Icon(Icons.security),
          onTap: () => _showSecurityCheckupDialog(context),
        ),
        PreferenceTile(
          title: 'Login Activity',
          subtitle: 'View recent login attempts and locations',
          trailing: const Icon(Icons.history),
          onTap: () => _showLoginActivityDialog(context),
        ),
        PreferenceTile(
          title: 'Active Sessions',
          subtitle: 'Manage active sessions across devices',
          trailing: const Icon(Icons.devices_other),
          onTap: () => _showActiveSessionsDialog(context),
        ),
        PreferenceTile(
          title: 'Data Download',
          subtitle: 'Download a copy of your data',
          trailing: const Icon(Icons.download),
          onTap: () => _showDataDownloadDialog(context),
        ),
        PreferenceTile(
          title: 'Account Deletion',
          subtitle: 'Permanently delete your account',
          trailing: const Icon(Icons.delete_forever, color: Colors.red),
          onTap: () => _showAccountDeletionDialog(context),
        ),
      ],
    );
  }

  void _showSecurityCheckupDialog(BuildContext context) {
    final securityScore = _calculateSecurityScore();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Checkup'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircularProgressIndicator(
                  value: securityScore / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    securityScore >= 80
                        ? Colors.green
                        : securityScore >= 60
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Score: ${securityScore.toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _getSecurityLevel(securityScore),
                        style: TextStyle(
                          color: securityScore >= 80
                              ? Colors.green
                              : securityScore >= 60
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Security Status:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildSecurityItem(
              'Two-Factor Authentication',
              preferences.twoFactorAuthEnabled,
              Icons.security,
            ),
            _buildSecurityItem(
              'Strong Password Required',
              preferences.requirePasswordForSensitiveActions,
              Icons.lock,
            ),
            _buildSecurityItem(
              'Device Notifications',
              preferences.notifyOnNewDeviceLogin,
              Icons.notifications,
            ),
            _buildSecurityItem(
              'Backup Codes Generated',
              preferences.backupCodesGenerated.isNotEmpty,
              Icons.backup,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (securityScore < 80)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSecurityRecommendationsDialog(context);
              },
              child: const Text('Improve Security'),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(String title, bool isEnabled, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isEnabled ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Icon(
            isEnabled ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isEnabled ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  double _calculateSecurityScore() {
    double score = 0;
    if (preferences.twoFactorAuthEnabled) score += 30;
    if (preferences.requirePasswordForSensitiveActions) score += 20;
    if (preferences.notifyOnNewDeviceLogin) score += 15;
    if (preferences.backupCodesGenerated.isNotEmpty) score += 15;
    if (preferences.logOutOnDeviceChange) score += 10;
    if (!preferences.allowRememberDevice) score += 10;
    return score;
  }

  String _getSecurityLevel(double score) {
    if (score >= 80) return 'Excellent Security';
    if (score >= 60) return 'Good Security';
    if (score >= 40) return 'Fair Security';
    return 'Poor Security';
  }

  void _showSecurityRecommendationsDialog(BuildContext context) {
    final recommendations = <String>[];

    if (!preferences.twoFactorAuthEnabled) {
      recommendations
          .add('Enable Two-Factor Authentication for better security');
    }
    if (!preferences.requirePasswordForSensitiveActions) {
      recommendations.add('Require password for sensitive actions');
    }
    if (!preferences.notifyOnNewDeviceLogin) {
      recommendations.add('Enable notifications for new device logins');
    }
    if (preferences.backupCodesGenerated.isEmpty) {
      recommendations.add('Generate backup codes for account recovery');
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Recommendations'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To improve your account security, consider:'),
            const SizedBox(height: 16),
            ...recommendations.map((rec) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_right, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(rec)),
                    ],
                  ),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Review Settings'),
          ),
        ],
      ),
    );
  }

  void _showLoginActivityDialog(BuildContext context) {
    final activities = [
      {
        'device': 'iPhone 15 Pro',
        'location': 'New York, NY',
        'time': '2 hours ago',
        'success': true,
      },
      {
        'device': 'MacBook Pro',
        'location': 'New York, NY',
        'time': '1 day ago',
        'success': true,
      },
      {
        'device': 'Unknown Device',
        'location': 'Los Angeles, CA',
        'time': '3 days ago',
        'success': false,
      },
      {
        'device': 'iPad Air',
        'location': 'Boston, MA',
        'time': '1 week ago',
        'success': true,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Activity'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                leading: Icon(
                  activity['success'] as bool
                      ? Icons.check_circle
                      : Icons.error,
                  color:
                      activity['success'] as bool ? Colors.green : Colors.red,
                ),
                title: Text(activity['device'] as String),
                subtitle: Text('${activity['location']}\n${activity['time']}'),
                trailing: activity['success'] as bool
                    ? null
                    : TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Suspicious activity reported'),
                            ),
                          );
                        },
                        child: const Text('Report'),
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

  void _showActiveSessionsDialog(BuildContext context) {
    final sessions = [
      {
        'device': 'iPhone 15 Pro (Current)',
        'location': 'New York, NY',
        'lastActive': 'Now',
        'isCurrent': true,
      },
      {
        'device': 'MacBook Pro',
        'location': 'New York, NY',
        'lastActive': '1 hour ago',
        'isCurrent': false,
      },
      {
        'device': 'iPad Air',
        'location': 'Boston, MA',
        'lastActive': '2 days ago',
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
                leading: const Icon(Icons.devices),
                title: Text(session['device'] as String),
                subtitle: Text(
                    '${session['location']}\nLast active: ${session['lastActive']}'),
                trailing: session['isCurrent'] as bool
                    ? const Chip(
                        label: Text('Current'),
                        backgroundColor: Colors.green,
                      )
                    : TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Session ended for ${session['device']}'),
                            ),
                          );
                        },
                        child: const Text('End Session'),
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

  void _showDataDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Your Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You can download a copy of your data including:'),
            SizedBox(height: 16),
            Text('• Profile information'),
            Text('• Posts and media'),
            Text('• Messages and conversations'),
            Text('• Settings and preferences'),
            Text('• Activity logs'),
            SizedBox(height: 16),
            Text(
              'Data will be prepared and sent to your email address. This may take up to 24 hours.',
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
                  content: Text('Data download request submitted'),
                ),
              );
            },
            child: const Text('Request Download'),
          ),
        ],
      ),
    );
  }

  void _showAccountDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WARNING: This action cannot be undone!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text('Deleting your account will permanently remove:'),
            SizedBox(height: 8),
            Text('• Your profile and all personal information'),
            Text('• All posts, comments, and media'),
            Text('• Message history and conversations'),
            Text('• Connections and followers'),
            SizedBox(height: 16),
            Text(
              'Consider downloading your data first if you want to keep a copy.',
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
              _showFinalConfirmationDialog(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showFinalConfirmationDialog(BuildContext context) {
    final confirmationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Type "DELETE" to confirm account deletion:'),
            const SizedBox(height: 16),
            TextField(
              controller: confirmationController,
              decoration: const InputDecoration(
                labelText: 'Confirmation',
                hintText: 'DELETE',
              ),
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
              if (confirmationController.text == 'DELETE') {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deletion request submitted'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please type "DELETE" to confirm'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
