import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../core/ui/screens/base_screen.dart';

class LiveVideosScreenParam {}

/// Live Videos screen - equivalent to LiveVideosActivity in Xamarin
class LiveVideosScreen extends BaseScreen<LiveVideosScreenParam> {
  static const routeName = "/LiveVideosScreen";

  const LiveVideosScreen({required super.param, super.key});

  @override
  State createState() => _LiveVideosScreenState();
}

class _LiveVideosScreenState extends State<LiveVideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: AppDimensions.iconLarge,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'live_videos_title'.tr,
          style: AppTextStyles.h5,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.primary,
              size: AppDimensions.iconLarge,
            ),
            onPressed: () {
              // TODO: Implement start live stream functionality
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Live Video Icon with Decoration
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing32),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusRound),
                  boxShadow: [
                    const BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: AppDimensions.shadowBlurLarge,
                      offset: Offset(0, AppDimensions.shadowOffset),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.videocam_outlined,
                  size: AppDimensions.iconXXLarge,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing24),

              // Title
              Text(
                'live_videos_feature_title'.tr,
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacing12),

              // Subtitle
              Text(
                'live_videos_subtitle'.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing32),

              // Features Card
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing24),
                decoration: AppDecorations.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'live_videos_features_title'.tr,
                      style: AppTextStyles.h6,
                    ),
                    const SizedBox(height: AppDimensions.spacing16),
                    _buildFeatureItem(
                      Icons.play_circle_outline,
                      'live_videos_feature_start_stream'.tr,
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    _buildFeatureItem(
                      Icons.visibility_outlined,
                      'live_videos_feature_watch_stream'.tr,
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    _buildFeatureItem(
                      Icons.chat_bubble_outline,
                      'live_videos_feature_live_chat'.tr,
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    _buildFeatureItem(
                      Icons.settings_outlined,
                      'live_videos_feature_stream_management'.tr,
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    _buildFeatureItem(
                      Icons.notifications_outlined,
                      'live_videos_feature_notifications'.tr,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spacing32),

              // Start Stream Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.buttonHeightLarge,
                  ),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                  elevation: AppDimensions.cardElevation,
                ),
                onPressed: () {
                  // TODO: Implement start live stream functionality
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.videocam,
                      size: AppDimensions.iconMedium,
                    ),
                    const SizedBox(width: AppDimensions.spacing8),
                    Text(
                      'live_videos_start_stream'.tr,
                      style: AppTextStyles.buttonMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppDimensions.iconMedium,
          color: AppColors.primary,
        ),
        const SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }
}
