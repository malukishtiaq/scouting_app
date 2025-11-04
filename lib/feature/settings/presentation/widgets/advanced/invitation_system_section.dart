import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Invitation system section widget
class InvitationSystemSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const InvitationSystemSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Invitation System',
      icon: Icons.share,
      children: [
        PreferenceTile(
          title: 'Invite Friends & Family',
          subtitle: 'Share the app with people you know',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showInviteFriendsDialog(context),
        ),
        PreferenceTile(
          title: 'Invitation History',
          subtitle: 'View all your sent invitations',
          trailing: const Icon(Icons.history),
          onTap: () => _showInvitationHistoryDialog(context),
        ),
        PreferenceTile(
          title: 'Referral Rewards',
          subtitle: 'Earn rewards for successful referrals',
          trailing: const Icon(Icons.card_giftcard),
          onTap: () => _showReferralRewardsDialog(context),
        ),
        PreferenceTile(
          title: 'Auto-Invite Contacts',
          subtitle: 'Automatically invite contacts from your phone',
          trailing: Switch(
            value: preferences.autoInviteContacts,
            onChanged: (value) {
              final updated = preferences.copyWith(autoInviteContacts: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Invitation Limits',
          subtitle: 'Manage how many invitations you can send',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showInvitationLimitsDialog(context),
        ),
        PreferenceTile(
          title: 'Invitation Templates',
          subtitle: 'Customize your invitation messages',
          trailing: const Icon(Icons.edit),
          onTap: () => _showInvitationTemplatesDialog(context),
        ),
      ],
    );
  }

  void _showInviteFriendsDialog(BuildContext context) {
    final inviteMethods = [
      {
        'method': 'Share Link',
        'description': 'Share your unique invitation link',
        'icon': Icons.link,
        'color': Colors.blue,
      },
      {
        'method': 'Email Invitation',
        'description': 'Send personalized email invitations',
        'icon': Icons.email,
        'color': Colors.green,
      },
      {
        'method': 'SMS Invitation',
        'description': 'Send invitations via text message',
        'icon': Icons.sms,
        'color': Colors.orange,
      },
      {
        'method': 'Social Media',
        'description': 'Share on your social media accounts',
        'icon': Icons.share,
        'color': Colors.purple,
      },
      {
        'method': 'QR Code',
        'description': 'Generate QR code for easy sharing',
        'icon': Icons.qr_code,
        'color': Colors.orange,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Friends & Family'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose how you want to invite people:'),
            const SizedBox(height: 16),
            ...inviteMethods.map((method) => ListTile(
                  leading: Icon(
                    method['icon'] as IconData,
                    color: method['color'] as Color,
                  ),
                  title: Text(method['method'] as String),
                  subtitle: Text(method['description'] as String),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    _showInvitationMethodDialog(context, method);
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

  void _showInvitationMethodDialog(
      BuildContext context, Map<String, dynamic> method) {
    final methodName = method['method'] as String;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invite via $methodName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (methodName == 'Share Link') ...[
              const Text('Your unique invitation link:'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Text(
                  'https://app.com/invite/ABC123XYZ',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Share this link with friends and family.'),
            ] else if (methodName == 'Email Invitation') ...[
              const Text('Send invitations to multiple email addresses:'),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Addresses',
                  hintText: 'friend1@email.com, friend2@email.com',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text('Separate multiple emails with commas.'),
            ] else if (methodName == 'SMS Invitation') ...[
              const Text('Send invitations via text message:'),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Numbers',
                  hintText: '+1-555-0123, +1-555-0456',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text('Separate multiple numbers with commas.'),
            ] else if (methodName == 'Social Media') ...[
              const Text('Share on your social media accounts:'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Facebook sharing opened')),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.pink),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Instagram sharing opened')),
                      );
                    },
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.flutter_dash, color: Colors.lightBlue),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Twitter sharing opened')),
                      );
                    },
                  ),
                ],
              ),
            ] else if (methodName == 'QR Code') ...[
              const Text('Generate a QR code for easy sharing:'),
              const SizedBox(height: 16),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, size: 150, color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Friends can scan this QR code to join.'),
            ],
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
                SnackBar(
                  content: Text('$methodName invitation sent'),
                ),
              );
            },
            child: const Text('Send Invitation'),
          ),
        ],
      ),
    );
  }

  void _showInvitationHistoryDialog(BuildContext context) {
    final invitations = [
      {
        'name': 'John Doe',
        'email': 'john@email.com',
        'status': 'Accepted',
        'date': '2024-01-15',
        'method': 'Email',
      },
      {
        'name': 'Jane Smith',
        'email': 'jane@email.com',
        'status': 'Pending',
        'date': '2024-01-14',
        'method': 'SMS',
      },
      {
        'name': 'Mike Johnson',
        'email': 'mike@email.com',
        'status': 'Expired',
        'date': '2024-01-10',
        'method': 'Link',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invitation History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Track all your sent invitations:'),
            const SizedBox(height: 16),
            ...invitations.map((invitation) => ListTile(
                  leading: Icon(
                    _getStatusIcon(invitation['status'] as String),
                    color: _getStatusColor(invitation['status'] as String),
                  ),
                  title: Text(invitation['name'] as String),
                  subtitle: Text(
                    '${invitation['email']}\n${invitation['date']} • ${invitation['method']}',
                  ),
                  trailing: Text(
                    invitation['status'] as String,
                    style: TextStyle(
                      color: _getStatusColor(invitation['status'] as String),
                      fontWeight: FontWeight.bold,
                    ),
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Accepted':
        return Icons.check_circle;
      case 'Pending':
        return Icons.schedule;
      case 'Expired':
        return Icons.timer_off;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showReferralRewardsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Referral Rewards'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Earn rewards for successful referrals:'),
            const SizedBox(height: 16),
            _buildRewardItem(
                '5 Referrals', '1 Month Premium', Icons.star, Colors.amber),
            _buildRewardItem(
                '10 Referrals', '3 Months Premium', Icons.star, Colors.orange),
            _buildRewardItem(
                '25 Referrals', '1 Year Premium', Icons.star, Colors.red),
            _buildRewardItem(
                '50 Referrals', 'Lifetime Premium', Icons.star, Colors.purple),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Text(
                'Current Progress: 3/5 referrals completed',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
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

  Widget _buildRewardItem(
      String requirement, String reward, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(requirement),
      subtitle: Text(reward),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  void _showInvitationLimitsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invitation Limits'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Manage your invitation sending limits:'),
            const SizedBox(height: 16),
            _buildLimitItem('Daily Limit', '10 invitations', '8 remaining'),
            _buildLimitItem('Weekly Limit', '50 invitations', '35 remaining'),
            _buildLimitItem(
                'Monthly Limit', '200 invitations', '150 remaining'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Text(
                'Premium users get 2x invitation limits',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              ),
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

  Widget _buildLimitItem(String label, String limit, String remaining) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(limit, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(remaining,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  void _showInvitationTemplatesDialog(BuildContext context) {
    final templates = [
      {
        'name': 'Casual Friend',
        'message':
            'Hey! I found this awesome app and thought you might like it too. Check it out!',
        'category': 'Friends',
      },
      {
        'name': 'Professional',
        'message':
            'I\'d like to invite you to join our professional network on this platform.',
        'category': 'Work',
      },
      {
        'name': 'Family',
        'message':
            'Hi family! I\'d love for you to join me on this app so we can stay connected.',
        'category': 'Family',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invitation Templates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Customize your invitation messages:'),
            const SizedBox(height: 16),
            ...templates.map((template) => ListTile(
                  leading: const Icon(Icons.edit),
                  title: Text(template['name'] as String),
                  subtitle: Text(
                    '${template['category']}\n${template['message']}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Editing ${template['name']} template'),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${template['name']} template copied'),
                            ),
                          );
                        },
                      ),
                    ],
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New template dialog opened')),
              );
            },
            child: const Text('Create New'),
          ),
        ],
      ),
    );
  }
}
