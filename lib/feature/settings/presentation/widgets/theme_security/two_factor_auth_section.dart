import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Two-factor authentication section widget
class TwoFactorAuthSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const TwoFactorAuthSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Two-Factor Authentication',
      icon: Icons.security,
      children: [
        PreferenceTile(
          title: 'Enable Two-Factor Authentication',
          subtitle: preferences.twoFactorAuthEnabled
              ? 'Your account is protected with 2FA'
              : 'Add an extra layer of security',
          trailing: Switch(
            value: preferences.twoFactorAuthEnabled,
            onChanged: (value) {
              if (value) {
                _showSetupTwoFactorDialog(context);
              } else {
                _showDisableTwoFactorDialog(context);
              }
            },
          ),
        ),
        if (preferences.twoFactorAuthEnabled) ...[
          PreferenceTile(
            title: 'Authenticator App',
            subtitle: 'Use Google Authenticator or similar app',
            trailing: const Icon(Icons.smartphone),
            onTap: () => _showAuthenticatorSetupDialog(context),
          ),
          PreferenceTile(
            title: 'Backup Codes',
            subtitle: preferences.backupCodesGenerated.isNotEmpty
                ? 'Backup codes generated'
                : 'Generate backup codes for account recovery',
            trailing: Icon(
              preferences.backupCodesGenerated.isNotEmpty
                  ? Icons.check_circle
                  : Icons.warning,
              color: preferences.backupCodesGenerated.isNotEmpty
                  ? Colors.green
                  : Colors.orange,
            ),
            onTap: () => _showBackupCodesDialog(context),
          ),
          PreferenceTile(
            title: 'Recovery Methods',
            subtitle: 'Manage backup authentication methods',
            trailing: const Icon(Icons.restore),
            onTap: () => _showRecoveryMethodsDialog(context),
          ),
        ],
      ],
    );
  }

  void _showSetupTwoFactorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Setup Two-Factor Authentication'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Two-factor authentication adds an extra layer of security to your account.'),
            SizedBox(height: 16),
            Text('You will need:'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.smartphone, size: 20),
                SizedBox(width: 8),
                Expanded(child: Text('A smartphone with an authenticator app')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.qr_code, size: 20),
                SizedBox(width: 8),
                Expanded(child: Text('Ability to scan QR codes')),
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
              _showQRCodeSetupDialog(context);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showQRCodeSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Scan this QR code with your authenticator app:'),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code, size: 100, color: Colors.grey),
                    Text('QR Code', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Or enter this code manually:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'ABCD EFGH IJKL MNOP',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
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
              Navigator.pop(context);
              _showVerificationCodeDialog(context);
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void _showVerificationCodeDialog(BuildContext context) {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify Setup'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the 6-digit code from your authenticator app:'),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
                hintText: '123456',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
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
              final updated = preferences.copyWith(twoFactorAuthEnabled: true);
              onPreferenceChanged(updated);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Two-factor authentication enabled successfully!'),
                ),
              );
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }

  void _showDisableTwoFactorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable Two-Factor Authentication'),
        content: const Text(
          'Are you sure you want to disable two-factor authentication? '
          'This will make your account less secure.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = preferences.copyWith(
                twoFactorAuthEnabled: false,
                backupCodesGenerated: '',
              );
              onPreferenceChanged(updated);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Two-factor authentication disabled'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Disable'),
          ),
        ],
      ),
    );
  }

  void _showAuthenticatorSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Authenticator App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Currently configured authenticator apps:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.smartphone),
              title: Text('Google Authenticator'),
              subtitle: Text('Added 2 days ago'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
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
              _showQRCodeSetupDialog(context);
            },
            child: const Text('Add Another App'),
          ),
        ],
      ),
    );
  }

  void _showBackupCodesDialog(BuildContext context) {
    final backupCodes = [
      '1a2b-3c4d-5e6f',
      '7g8h-9i0j-1k2l',
      '3m4n-5o6p-7q8r',
      '9s0t-1u2v-3w4x',
      '5y6z-7a8b-9c0d',
      '1e2f-3g4h-5i6j',
      '7k8l-9m0n-1o2p',
      '3q4r-5s6t-7u8v',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup Codes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Save these backup codes in a secure location. Each code can only be used once.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: backupCodes
                    .map((code) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            code,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                        ))
                    .toList(),
              ),
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
              final updated = preferences.copyWith(
                  backupCodesGenerated: backupCodes.join(','));
              onPreferenceChanged(updated);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Backup codes generated and saved'),
                ),
              );
            },
            child: const Text('Generate New Codes'),
          ),
        ],
      ),
    );
  }

  void _showRecoveryMethodsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recovery Methods'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Recovery'),
              subtitle: Text('j***@gmail.com'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('SMS Recovery'),
              subtitle: Text('+1 ***-***-1234'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security Questions'),
              subtitle: Text('3 questions configured'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
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
}
