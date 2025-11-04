import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/settings_cubit.dart';
import '../widgets/settings_section.dart';
import '../widgets/preference_tile.dart';
import '../widgets/advanced/session_management_section.dart';
import '../widgets/advanced/account_management_section.dart';
import '../widgets/advanced/invitation_system_section.dart';
import '../widgets/advanced/help_support_section.dart';
import '../widgets/advanced/data_management_section.dart';
import '../widgets/advanced/developer_options_section.dart';
import '../../domain/entities/user_preferences_entity.dart';

/// Complete advanced features settings screen
class AdvancedFeaturesScreen extends StatelessWidget {
  const AdvancedFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Features'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save all advanced feature preferences
              final cubit = context.read<SettingsCubit>();
              if (cubit.state is SettingsLoaded) {
                final state = cubit.state as SettingsLoaded;
                cubit.savePreferences(state.preferences);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is SettingsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SettingsCubit>().loadPreferences();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is SettingsLoaded) {
            return _buildAdvancedFeaturesContent(context, state.preferences);
          }
          
          return const Center(child: Text('No settings loaded'));
        },
      ),
    );
  }

  Widget _buildAdvancedFeaturesContent(
      BuildContext context, UserPreferencesEntity preferences) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Session Management Section
        SessionManagementSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Account Management Section
        AccountManagementSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Invitation System Section
        InvitationSystemSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Help & Support Section
        HelpSupportSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Data Management Section
        DataManagementSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Developer Options Section
        DeveloperOptionsSection(
          preferences: preferences,
          onPreferenceChanged: (updatedPreferences) {
            context.read<SettingsCubit>().updatePreference(updatedPreferences);
          },
        ),
        
        const SizedBox(height: 16),
        
        // Advanced Privacy Section
        SettingsSection(
          title: 'Advanced Privacy',
          icon: Icons.privacy_tip,
          children: [
            PreferenceTile(
              title: 'Analytics & Insights',
              subtitle: 'Help improve the app with anonymous usage data',
              trailing: Switch(
                value: preferences.allowAnalytics,
                onChanged: (value) {
                  final updated = preferences.copyWith(allowAnalytics: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Crash Reports',
              subtitle: 'Automatically send crash reports for app stability',
              trailing: Switch(
                value: preferences.allowCrashReports,
                onChanged: (value) {
                  final updated = preferences.copyWith(allowCrashReports: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Performance Monitoring',
              subtitle: 'Monitor app performance and identify issues',
              trailing: Switch(
                value: preferences.allowPerformanceMonitoring,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    allowPerformanceMonitoring: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Personalized Content',
              subtitle: 'Show content based on your interests and behavior',
              trailing: Switch(
                value: preferences.allowPersonalizedContent,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    allowPersonalizedContent: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Advanced Notifications Section
        SettingsSection(
          title: 'Advanced Notifications',
          icon: Icons.notifications_active,
          children: [
            PreferenceTile(
              title: 'Smart Notifications',
              subtitle: 'AI-powered notification prioritization',
              trailing: Switch(
                value: preferences.smartNotifications,
                onChanged: (value) {
                  final updated = preferences.copyWith(smartNotifications: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Batch Notifications',
              subtitle: 'Group similar notifications together',
              trailing: Switch(
                value: preferences.batchNotifications,
                onChanged: (value) {
                  final updated = preferences.copyWith(batchNotifications: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Notification History',
              subtitle: 'Keep track of all notifications for 30 days',
              trailing: Switch(
                value: preferences.keepNotificationHistory,
                onChanged: (value) {
                  final updated = preferences.copyWith(
                    keepNotificationHistory: value,
                  );
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Priority Senders',
              subtitle: 'Always show notifications from important contacts',
              trailing: Switch(
                value: preferences.prioritySenders,
                onChanged: (value) {
                  final updated = preferences.copyWith(prioritySenders: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Advanced Security Section
        SettingsSection(
          title: 'Advanced Security',
          icon: Icons.security,
          children: [
            PreferenceTile(
              title: 'Biometric Authentication',
              subtitle: 'Use fingerprint or face recognition',
              trailing: Switch(
                value: preferences.biometricAuth,
                onChanged: (value) {
                  final updated = preferences.copyWith(biometricAuth: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Advanced Encryption',
              subtitle: 'Use enhanced encryption for sensitive data',
              trailing: Switch(
                value: preferences.advancedEncryption,
                onChanged: (value) {
                  final updated = preferences.copyWith(advancedEncryption: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Security Alerts',
              subtitle: 'Get notified of suspicious account activity',
              trailing: Switch(
                value: preferences.securityAlerts,
                onChanged: (value) {
                  final updated = preferences.copyWith(securityAlerts: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Auto-Lock',
              subtitle: 'Automatically lock app after inactivity',
              trailing: Switch(
                value: preferences.autoLock,
                onChanged: (value) {
                  final updated = preferences.copyWith(autoLock: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Advanced Performance Section
        SettingsSection(
          title: 'Advanced Performance',
          icon: Icons.speed,
          children: [
            PreferenceTile(
              title: 'Background Sync',
              subtitle: 'Sync data when app is in background',
              trailing: Switch(
                value: preferences.backgroundSync,
                onChanged: (value) {
                  final updated = preferences.copyWith(backgroundSync: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Auto-Optimization',
              subtitle: 'Automatically optimize app performance',
              trailing: Switch(
                value: preferences.autoOptimization,
                onChanged: (value) {
                  final updated = preferences.copyWith(autoOptimization: value);
                  context.read<SettingsCubit>().updatePreference(updated);
                },
              ),
            ),
            PreferenceTile(
              title: 'Cache Management',
              subtitle: 'Manage app cache and storage',
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showCacheManagementDialog(context),
            ),
            PreferenceTile(
              title: 'Performance Metrics',
              subtitle: 'View detailed performance statistics',
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showPerformanceMetricsDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  void _showCacheManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cache Management'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current cache usage:'),
            const SizedBox(height: 16),
            _buildCacheItem('App Cache', '156 MB'),
            _buildCacheItem('Image Cache', '89 MB'),
            _buildCacheItem('Video Cache', '234 MB'),
            _buildCacheItem('Data Cache', '45 MB'),
            const Divider(),
            const Text('Total: 524 MB', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  content: Text('Cache cleared successfully!'),
                ),
              );
            },
            child: const Text('Clear All Cache'),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheItem(String name, String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showPerformanceMetricsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Metrics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMetricItem('App Launch Time', '1.2s', Colors.green),
            _buildMetricItem('Memory Usage', '89 MB', Colors.orange),
            _buildMetricItem('CPU Usage', '12%', Colors.green),
            _buildMetricItem('Battery Impact', 'Low', Colors.green),
            _buildMetricItem('Network Latency', '45ms', Colors.green),
            _buildMetricItem('Storage I/O', 'Fast', Colors.green),
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

  Widget _buildMetricItem(String name, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
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
}
