import 'package:flutter/material.dart';
import '../settings_section.dart';
import '../preference_tile.dart';
import '../../../domain/entities/user_preferences_entity.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../core/services/navigation_style_manager.dart';

/// Navigation style selector section widget
class NavigationStyleSelectorSection extends StatefulWidget {
  final UserPreferencesEntity preferences;
  final Function(UserPreferencesEntity) onPreferenceChanged;

  const NavigationStyleSelectorSection({
    super.key,
    required this.preferences,
    required this.onPreferenceChanged,
  });

  @override
  State<NavigationStyleSelectorSection> createState() =>
      _NavigationStyleSelectorSectionState();
}

class _NavigationStyleSelectorSectionState
    extends State<NavigationStyleSelectorSection> {
  final NavigationStyleManager _styleManager = NavigationStyleManager.instance;
  String _currentNavigationStyle = 'simple';

  @override
  void initState() {
    super.initState();
    _loadNavigationStyle();
  }

  Future<void> _loadNavigationStyle() async {
    final style = await _styleManager.getNavigationStyle();
    if (mounted) {
      setState(() {
        _currentNavigationStyle = style;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Navigation Style',
      icon: Icons.navigation_outlined,
      children: [
        PreferenceTile(
          title: 'Bottom Navigation Style',
          subtitle: _getNavigationStyleDisplayText(_currentNavigationStyle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _showNavigationStyleSelector(context),
        ),
        PreferenceTile(
          title: 'Enable Navigation Animations',
          subtitle: 'Smooth transitions between tabs',
          trailing: Switch(
            value: widget.preferences.enableAnimations,
            onChanged: (value) {
              final updated = widget.preferences.copyWith(
                enableAnimations: value,
              );
              widget.onPreferenceChanged(updated);
            },
          ),
        ),
      ],
    );
  }

  String _getNavigationStyleDisplayText(String style) {
    switch (style) {
      case 'simple':
        return 'Simple - Clean and minimal design';
      case 'animated':
        return 'Animated - Smooth transitions and effects';
      case 'modern':
        return 'Modern - Floating design with glassmorphism';
      case 'glassmorphism':
        return 'Glassmorphism - Blur effects and transparency';
      default:
        return 'Simple - Clean and minimal design';
    }
  }

  void _showNavigationStyleSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMedium * 2),
        ),
      ),
      builder: (context) => NavigationStyleSelector(
        currentStyle: _currentNavigationStyle,
        onStyleSelected: (style) async {
          final success = await _styleManager.setNavigationStyle(style);
          if (success && mounted) {
            setState(() {
              _currentNavigationStyle = style;
            });
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

/// Navigation style selector bottom sheet
class NavigationStyleSelector extends StatelessWidget {
  final String currentStyle;
  final Function(String) onStyleSelected;

  const NavigationStyleSelector({
    super.key,
    required this.currentStyle,
    required this.onStyleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.navigation_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              SizedBox(width: AppDimensions.spacing16),
              Text(
                'Choose Navigation Style',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacing24),

          // Style options
          ...NavigationStyleManager.availableStyles.map((style) {
            final isSelected = style == currentStyle;

            return Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.spacing16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onStyleSelected(style),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimensions.spacing16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.surfaceVariant,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Style preview
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getStylePreviewColor(style),
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium),
                            border: Border.all(
                              color: AppColors.borderLight,
                              width: 1,
                            ),
                          ),
                          child: _buildStylePreview(style),
                        ),

                        const SizedBox(width: AppDimensions.spacing16),

                        // Style info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getStyleTitle(style),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getStyleDescription(style),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Selection indicator
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: AppColors.textOnPrimary,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: AppDimensions.spacing24),
        ],
      ),
    );
  }

  Color _getStylePreviewColor(String style) {
    switch (style) {
      case 'simple':
        return AppColors.surface;
      case 'animated':
        return AppColors.primaryContainer;
      case 'modern':
        return AppColors.surface.withOpacity(0.9);
      case 'glassmorphism':
        return AppColors.surface.withOpacity(0.1);
      default:
        return AppColors.surface;
    }
  }

  Widget _buildStylePreview(String style) {
    switch (style) {
      case 'simple':
        return _buildSimplePreview();
      case 'animated':
        return _buildAnimatedPreview();
      case 'modern':
        return _buildModernPreview();
      case 'glassmorphism':
        return _buildGlassmorphismPreview();
      default:
        return _buildSimplePreview();
    }
  }

  Widget _buildSimplePreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPreviewDot(AppColors.textSecondary),
        _buildPreviewDot(AppColors.primary),
        _buildPreviewDot(AppColors.textSecondary),
        _buildPreviewDot(AppColors.textSecondary),
      ],
    );
  }

  Widget _buildAnimatedPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPreviewDot(AppColors.textSecondary),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        _buildPreviewDot(AppColors.textSecondary),
        _buildPreviewDot(AppColors.textSecondary),
      ],
    );
  }

  Widget _buildModernPreview() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPreviewDot(AppColors.textSecondary),
          _buildPreviewDot(AppColors.primary),
          _buildPreviewDot(AppColors.textSecondary),
          _buildPreviewDot(AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildGlassmorphismPreview() {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPreviewDot(AppColors.textSecondary),
          _buildPreviewDot(AppColors.primary),
          _buildPreviewDot(AppColors.textSecondary),
          _buildPreviewDot(AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildPreviewDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  String _getStyleTitle(String style) {
    switch (style) {
      case 'simple':
        return 'Simple';
      case 'animated':
        return 'Animated';
      case 'modern':
        return 'Modern';
      case 'glassmorphism':
        return 'Glassmorphism';
      default:
        return 'Simple';
    }
  }

  String _getStyleDescription(String style) {
    switch (style) {
      case 'simple':
        return 'Clean and minimal design';
      case 'animated':
        return 'Smooth transitions and effects';
      case 'modern':
        return 'Floating design with glassmorphism';
      case 'glassmorphism':
        return 'Blur effects and transparency';
      default:
        return 'Clean and minimal design';
    }
  }
}
