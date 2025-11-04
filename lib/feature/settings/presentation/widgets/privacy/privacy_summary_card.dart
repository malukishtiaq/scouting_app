import 'package:flutter/material.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Privacy summary card widget
class PrivacySummaryCard extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final VoidCallback? onViewAll;

  const PrivacySummaryCard({
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
                  'Privacy Summary',
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

            // Privacy Level
            _buildPrivacyLevelCard(context),

            const SizedBox(height: 16),

            // Profile Visibility Summary
            _buildSummaryRow(
              context,
              'Profile Visibility',
              _getProfileVisibilityText(preferences.profileVisibility),
              Icons.visibility,
              Colors.blue,
            ),
            _buildSummaryRow(
              context,
              'Online Status',
              preferences.showOnlineStatus ? 'Visible' : 'Hidden',
              Icons.circle,
              preferences.showOnlineStatus ? Colors.green : Colors.grey,
            ),
            _buildSummaryRow(
              context,
              'Messages from Strangers',
              preferences.allowMessagesFromStrangers ? 'Allowed' : 'Blocked',
              Icons.message,
              preferences.allowMessagesFromStrangers
                  ? Colors.orange
                  : Colors.red,
            ),

            const Divider(height: 24),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Blocked Users',
                    '${preferences.blockedUsers.length}',
                    Icons.block,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Muted Users',
                    '${preferences.mutedUsers.length}',
                    Icons.volume_off,
                    Colors.orange,
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
                    'Personal Info',
                    _getPersonalInfoVisibility(),
                    Icons.person,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Content Control',
                    _getContentControlStatus(),
                    Icons.security,
                    Colors.teal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Privacy Recommendations
            if (_shouldShowRecommendations()) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Colors.orange[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Consider reviewing your privacy settings for better control',
                        style: TextStyle(
                          color: Colors.orange[700],
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

  Widget _buildPrivacyLevelCard(BuildContext context) {
    final privacyLevel = _calculatePrivacyLevel();
    final color = _getPrivacyLevelColor(privacyLevel);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.shield,
            color: color,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Level',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  privacyLevel,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String value,
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
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
                  color: color.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getProfileVisibilityText(String visibility) {
    switch (visibility) {
      case 'public':
        return 'Public';
      case 'friends':
        return 'Friends';
      case 'private':
        return 'Private';
      default:
        return 'Friends';
    }
  }

  String _getPersonalInfoVisibility() {
    int visibleCount = 0;
    if (preferences.showBirthday) visibleCount++;
    if (preferences.showLocation) visibleCount++;
    if (preferences.showEmail) visibleCount++;
    if (preferences.showPhoneNumber) visibleCount++;

    if (visibleCount == 0) return 'Hidden';
    if (visibleCount <= 2) return 'Limited';
    return 'Visible';
  }

  String _getContentControlStatus() {
    if (!preferences.allowTagging && !preferences.allowSharing) {
      return 'Restricted';
    } else if (preferences.requireApprovalForTags) {
      return 'Controlled';
    }
    return 'Open';
  }

  String _calculatePrivacyLevel() {
    int privacyScore = 0;

    // Profile visibility
    if (preferences.profileVisibility == 'private')
      privacyScore += 3;
    else if (preferences.profileVisibility == 'friends')
      privacyScore += 2;
    else
      privacyScore += 1;

    // Online status
    if (!preferences.showOnlineStatus) privacyScore += 2;

    // Messages from strangers
    if (!preferences.allowMessagesFromStrangers) privacyScore += 2;

    // Personal information
    if (!preferences.showBirthday) privacyScore += 1;
    if (!preferences.showLocation) privacyScore += 2;
    if (!preferences.showEmail) privacyScore += 1;
    if (!preferences.showPhoneNumber) privacyScore += 1;

    // Content control
    if (!preferences.allowTagging) privacyScore += 1;
    if (preferences.requireApprovalForTags) privacyScore += 1;
    if (!preferences.allowSharing) privacyScore += 1;
    if (!preferences.allowDownloads) privacyScore += 1;

    // Lists visibility
    if (!preferences.showFriendsList) privacyScore += 1;
    if (!preferences.showFollowersList) privacyScore += 1;

    if (privacyScore >= 15) return 'Very High';
    if (privacyScore >= 10) return 'High';
    if (privacyScore >= 5) return 'Medium';
    return 'Low';
  }

  Color _getPrivacyLevelColor(String level) {
    switch (level) {
      case 'Very High':
        return Colors.green;
      case 'High':
        return Colors.blue;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  bool _shouldShowRecommendations() {
    final level = _calculatePrivacyLevel();
    return level == 'Low' || level == 'Medium';
  }
}
