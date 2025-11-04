import 'package:flutter/material.dart';
import '../preference_tile.dart';

/// Privacy selector item widget
class PrivacySelectorItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> options;
  final String currentValue;
  final Function(String) onChanged;

  const PrivacySelectorItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceTile(
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showPrivacySelector(context),
    );
  }

  void _showPrivacySelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: currentValue,
                    onChanged: (value) {
                      if (value != null) {
                        onChanged(value);
                        Navigator.pop(context);
                      }
                    },
                  ))
              .toList(),
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
