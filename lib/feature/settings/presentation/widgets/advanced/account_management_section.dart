import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Account management section widget
class AccountManagementSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const AccountManagementSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Account Management',
      icon: Icons.account_circle,
      children: [
        PreferenceTile(
          title: 'Account Status',
          subtitle: 'Active • Verified • Premium',
          trailing: const Icon(Icons.verified, color: Colors.green),
          onTap: () => _showAccountStatusDialog(context),
        ),
        PreferenceTile(
          title: 'Account Recovery',
          subtitle: 'Set up recovery options for your account',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showAccountRecoveryDialog(context),
        ),
        PreferenceTile(
          title: 'Linked Accounts',
          subtitle: 'Manage connected social media accounts',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showLinkedAccountsDialog(context),
        ),
        PreferenceTile(
          title: 'Data & Privacy',
          subtitle: 'Control your data and privacy settings',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showDataPrivacyDialog(context),
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

  void _showAccountStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusItem('Account Status', 'Active', Colors.green),
            _buildStatusItem('Email Verification', 'Verified', Colors.green),
            _buildStatusItem('Phone Verification', 'Verified', Colors.green),
            _buildStatusItem('Two-Factor Auth', 'Enabled', Colors.green),
            _buildStatusItem('Account Type', 'Premium', Colors.blue),
            _buildStatusItem('Member Since', 'January 2023', Colors.grey),
            _buildStatusItem('Last Login', '2 hours ago', Colors.grey),
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

  Widget _buildStatusItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showAccountRecoveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Recovery'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Set up multiple recovery options to protect your account:'),
            const SizedBox(height: 16),
            _buildRecoveryOption(
              'Email Recovery',
              'j***@gmail.com',
              Icons.email,
              Colors.blue,
              true,
            ),
            _buildRecoveryOption(
              'Phone Recovery',
              '+1 ***-***-1234',
              Icons.phone,
              Colors.green,
              true,
            ),
            _buildRecoveryOption(
              'Security Questions',
              '3 questions configured',
              Icons.security,
              Colors.orange,
              true,
            ),
            _buildRecoveryOption(
              'Backup Codes',
              '8 codes generated',
              Icons.backup,
              Colors.purple,
              true,
            ),
            _buildRecoveryOption(
              'Trusted Contacts',
              '2 contacts added',
              Icons.people,
              Colors.teal,
              false,
            ),
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
                const SnackBar(
                  content: Text('Recovery options updated'),
                ),
              );
            },
            child: const Text('Add Recovery Option'),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Recovery'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Set up multiple recovery options to protect your account:'),
            const SizedBox(height: 16),
            _buildRecoveryOption(
              'Email Recovery',
              'j***@gmail.com',
              Icons.email,
              Colors.blue,
              true,
            ),
            _buildRecoveryOption(
              'Phone Recovery',
              '+1 ***-***-1234',
              Icons.phone,
              Colors.green,
              true,
            ),
            _buildRecoveryOption(
              'Security Questions',
              '3 questions configured',
              Icons.security,
              Colors.orange,
              true,
            ),
            _buildRecoveryOption(
              'Backup Codes',
              '8 codes generated',
              Icons.backup,
              Colors.purple,
              true,
            ),
            _buildRecoveryOption(
              'Trusted Contacts',
              '2 contacts added',
              Icons.people,
              Colors.teal,
              false,
            ),
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
                const SnackBar(
                  content: Text('Recovery options updated'),
                ),
              );
            },
            child: const Text('Add Recovery Option'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryOption(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    bool isConfigured,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        isConfigured ? Icons.check_circle : Icons.add_circle_outline,
        color: isConfigured ? Colors.green : Colors.grey,
      ),
    );
  }

  void _showLinkedAccountsDialog(BuildContext context) {
    final linkedAccounts = [
      {
        'platform': 'Google',
        'email': 'user@gmail.com',
        'status': 'Connected',
        'icon': Icons.g_mobiledata,
        'color': Colors.red,
      },
      {
        'platform': 'Facebook',
        'email': 'user@facebook.com',
        'status': 'Connected',
        'icon': Icons.facebook,
        'color': Colors.blue,
      },
      {
        'platform': 'Apple',
        'email': 'user@icloud.com',
        'status': 'Connected',
        'icon': Icons.apple,
        'color': Colors.black,
      },
      {
        'platform': 'Twitter',
        'email': 'user@twitter.com',
        'status': 'Not Connected',
        'icon': Icons.flutter_dash,
        'color': Colors.blue,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Linked Accounts'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: linkedAccounts.length,
            itemBuilder: (context, index) {
              final account = linkedAccounts[index];
              final isConnected = account['status'] == 'Connected';

              return ListTile(
                leading: Icon(
                  account['icon'] as IconData,
                  color: account['color'] as Color,
                ),
                title: Text(account['platform'] as String),
                subtitle: Text(account['email'] as String),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      account['status'] as String,
                      style: TextStyle(
                        color: isConnected ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isConnected
                          ? Icons.check_circle
                          : Icons.add_circle_outline,
                      color: isConnected ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                onTap: () {
                  if (isConnected) {
                    _showUnlinkAccountDialog(context, account);
                  } else {
                    _showLinkAccountDialog(context, account);
                  }
                },
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

  void _showUnlinkAccountDialog(
      BuildContext context, Map<String, dynamic> account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Unlink ${account['platform']}'),
        content: Text(
          'Are you sure you want to unlink your ${account['platform']} account? '
          'You can always link it again later.',
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
                SnackBar(
                  content: Text('${account['platform']} account unlinked'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Unlink'),
          ),
        ],
      ),
    );
  }

  void _showLinkAccountDialog(
      BuildContext context, Map<String, dynamic> account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Link ${account['platform']}'),
        content: Text(
          'Link your ${account['platform']} account to enable seamless login '
          'and data synchronization.',
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
                SnackBar(
                  content: Text(
                      '${account['platform']} account linked successfully'),
                ),
              );
            },
            child: const Text('Link Account'),
          ),
        ],
      ),
    );
  }

  void _showDataPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data & Privacy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download Your Data'),
              subtitle: const Text('Get a copy of all your data'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data download request submitted'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text('Delete Specific Data'),
              subtitle: const Text('Remove specific types of data'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data deletion options opened'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Analytics & Insights'),
              subtitle: const Text('Control data collection for analytics'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Analytics settings opened'),
                  ),
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
            Text('• All data and preferences'),
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
              _showFinalDeletionConfirmation(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showFinalDeletionConfirmation(BuildContext context) {
    final confirmationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'To confirm account deletion, please type "DELETE MY ACCOUNT":',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmationController,
              decoration: const InputDecoration(
                labelText: 'Confirmation',
                hintText: 'DELETE MY ACCOUNT',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This action will be processed within 30 days. '
              'You can cancel the deletion during this period.',
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
              if (confirmationController.text == 'DELETE MY ACCOUNT') {
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
                    content: Text('Please type "DELETE MY ACCOUNT" to confirm'),
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
