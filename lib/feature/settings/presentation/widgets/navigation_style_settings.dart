import 'package:flutter/material.dart';
import '../../../../core/services/navigation_style_manager.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_dimensions.dart';

/// Simple navigation style settings widget
class NavigationStyleSettings extends StatefulWidget {
  const NavigationStyleSettings({super.key});

  @override
  State<NavigationStyleSettings> createState() =>
      _NavigationStyleSettingsState();
}

class _NavigationStyleSettingsState extends State<NavigationStyleSettings> {
  final NavigationStyleManager _styleManager = NavigationStyleManager.instance;
  String _currentStyle = 'simple';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentStyle();
  }

  Future<void> _loadCurrentStyle() async {
    final style = await _styleManager.getNavigationStyle();
    if (mounted) {
      setState(() {
        _currentStyle = style;
        _isLoading = false;
      });
    }
  }

  Future<void> _changeStyle(String style) async {
    setState(() {
      _isLoading = true;
    });

    final success = await _styleManager.setNavigationStyle(style);
    if (success && mounted) {
      setState(() {
        _currentStyle = style;
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Navigation style changed to ${_styleManager.getStyleDisplayName(style)}'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to change navigation style'),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Style'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacing24),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              border: Border.all(
                color: AppColors.borderLight,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.navigation_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: AppDimensions.spacing16),
                    Text(
                      'Choose Your Navigation Style',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  'Select how you want your bottom navigation to look and behave.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacing24),

          // Style options
          ...NavigationStyleManager.availableStyles.map((style) {
            final isSelected = style == _currentStyle;

            return Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.spacing16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isLoading ? null : () => _changeStyle(style),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimensions.spacing16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
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
                                _styleManager.getStyleDisplayName(style),
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
                                _styleManager.getStyleDescription(style),
                                style: TextStyle(
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
                            padding: const EdgeInsets.all(6),
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

          // Info card
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              border: Border.all(
                color: AppColors.info,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                  size: 20,
                ),
                const SizedBox(width: AppDimensions.spacing16),
                Expanded(
                  child: Text(
                    'Changes will be applied immediately. You can switch between styles anytime.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
}
