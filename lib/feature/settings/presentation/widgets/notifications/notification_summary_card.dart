import 'package:flutter/material.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Notification summary card widget
class NotificationSummaryCard extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final VoidCallback? onViewAll;

  const NotificationSummaryCard({
    super.key,
    required this.preferences,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    child: const Text('View All'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Notification Types Summary
            _buildSummaryRow(
              context,
              'Push Notifications',
              preferences.enablePushNotifications,
              Icons.notifications,
              Colors.blue,
            ),
            _buildSummaryRow(
              context,
              'Email Notifications',
              preferences.enableEmailNotifications,
              Icons.email,
              Colors.green,
            ),
            _buildSummaryRow(
              context,
              'In-App Notifications',
              preferences.enableInAppNotifications,
              Icons.message,
              Colors.orange,
            ),
            
            const Divider(height: 24),
            
            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Active Types',
                    '${_getActiveNotificationTypes()}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Quiet Hours',
                    preferences.quietHoursEnabled ? 'Enabled' : 'Disabled',
                    Icons.bedtime,
                    preferences.quietHoursEnabled ? Colors.purple : Colors.grey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Muted Keywords',
                    '${preferences.mutedKeywords.length}',
                    Icons.block,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Sound & Vibration',
                    preferences.vibrationEnabled ? 'Enabled' : 'Disabled',
                    Icons.volume_up,
                    preferences.vibrationEnabled ? Colors.teal : Colors.grey,
                  ),
                ),
              ],
            ),
            
            if (preferences.quietHoursEnabled) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bedtime,
                      color: Colors.purple,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Quiet Hours: ${preferences.quietHoursStart} - ${preferences.quietHoursEnd}',
                        style: TextStyle(
                          color: Colors.purple[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    bool isEnabled,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isEnabled ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isEnabled ? 'ON' : 'OFF',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int _getActiveNotificationTypes() {
    int count = 0;
    if (preferences.enablePushNotifications) count++;
    if (preferences.enableEmailNotifications) count++;
    if (preferences.enableInAppNotifications) count++;
    return count;
  }
}
