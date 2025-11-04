import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';

/// Data management section widget
class DataManagementSection extends StatelessWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const DataManagementSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Data Management',
      icon: Icons.storage,
      children: [
        PreferenceTile(
          title: 'Data Usage',
          subtitle: 'View and manage your data consumption',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showDataUsageDialog(context),
        ),
        PreferenceTile(
          title: 'Storage Management',
          subtitle: 'Manage app storage and cache',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showStorageManagementDialog(context),
        ),
        PreferenceTile(
          title: 'Data Export',
          subtitle: 'Export your data in various formats',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showDataExportDialog(context),
        ),
        PreferenceTile(
          title: 'Data Import',
          subtitle: 'Import data from other sources',
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showDataImportDialog(context),
        ),
        PreferenceTile(
          title: 'Data Backup',
          subtitle: 'Backup your data automatically',
          trailing: Switch(
            value: preferences.autoDataBackup,
            onChanged: (value) {
              final updated = preferences.copyWith(autoDataBackup: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
        PreferenceTile(
          title: 'Data Sync',
          subtitle: 'Sync data across devices',
          trailing: Switch(
            value: preferences.dataSyncEnabled,
            onChanged: (value) {
              final updated = preferences.copyWith(dataSyncEnabled: value);
              onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }

  void _showDataUsageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Usage'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDataItem('App Data', '156 MB', 'Core app functionality'),
            _buildDataItem('User Content', '89 MB', 'Posts, photos, videos'),
            _buildDataItem('Cache', '234 MB', 'Temporary files'),
            _buildDataItem('Downloads', '45 MB', 'Saved content'),
            const Divider(),
            _buildDataItem('Total', '524 MB', 'Current usage'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Text(
                'Data usage is optimized for performance and storage efficiency.',
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

  Widget _buildDataItem(String label, String size, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(
            size,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void _showStorageManagementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage Management'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text('Clear Cache'),
              subtitle: const Text('Free up 234 MB of space'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache cleared successfully'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Manage Photos'),
              subtitle: const Text('Optimize photo storage'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Photo management opened'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Manage Videos'),
              subtitle: const Text('Optimize video storage'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video management opened'),
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

  void _showDataExportDialog(BuildContext context) {
    final exportFormats = [
      {
        'format': 'JSON',
        'size': '2.3 MB',
        'description': 'Structured data format'
      },
      {
        'format': 'CSV',
        'size': '1.8 MB',
        'description': 'Spreadsheet compatible'
      },
      {
        'format': 'XML',
        'size': '3.1 MB',
        'description': 'Extensible markup format'
      },
      {'format': 'PDF', 'size': '4.2 MB', 'description': 'Printable document'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Export'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose export format:'),
            const SizedBox(height: 16),
            ...exportFormats.map((format) => ListTile(
                  leading: const Icon(Icons.file_download),
                  title: Text(format['format'] as String),
                  subtitle:
                      Text('${format['size']} • ${format['description']}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${format['format']} export started'),
                      ),
                    );
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

  void _showDataImportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Import'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Import data from external sources:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text('Upload File'),
              subtitle: const Text('Import from JSON, CSV, or XML file'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File upload dialog opened'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Import from URL'),
              subtitle: const Text('Import from web link'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('URL import dialog opened'),
                  ),
                );
              },
            ),
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
}
