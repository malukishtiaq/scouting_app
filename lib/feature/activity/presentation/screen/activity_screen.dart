import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../../../localization/app_localization.dart';
import '../../../../core/navigation/nav.dart';
import '../state_m/activity/activity_cubit.dart';
import '../widgets/activity_item.dart';

class ActivityScreenParam {
  const ActivityScreenParam();
}

class ActivityScreen extends BaseScreen<ActivityScreenParam> {
  static const routeName = "/ActivityScreen";

  const ActivityScreen({required super.param, super.key});

  @override
  State createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'activity'.tr,
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: BlocProvider<ActivityCubit>(
        create: (context) => ActivityCubit()..loadActivities(),
        child: BlocConsumer<ActivityCubit, ActivityState>(
          listener: (context, state) {
            state.whenOrNull(
              activityError: (error, callback) async {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${'error_occurred'.tr}: $error',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              connectionResponded: (activity) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'connection_responded'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            if (state is ActivityLoading) {
              return const Center(
                child: AppLoader(
                  isLoading: true,
                  child: SizedBox(),
                ),
              );
            }

            if (state is ActivitiesLoadedState) {
              final activities = state.activityListEntity.activities;

              if (activities.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: AppDimensions.iconXXLarge,
                        color: AppColors.textTertiary,
                      ),
                      SizedBox(height: AppDimensions.spacing16),
                      Text(
                        'no_activities_found'.tr,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return ActivityItem(
                    activity: activity,
                    onAccept: activity.hasActions
                        ? () {
                            context.read<ActivityCubit>().respondToConnection(
                                  activityId: activity.id,
                                  accept: true,
                                );
                          }
                        : null,
                    onDecline: activity.hasActions
                        ? () {
                            context.read<ActivityCubit>().respondToConnection(
                                  activityId: activity.id,
                                  accept: false,
                                );
                          }
                        : null,
                  );
                },
              );
            }

            // Initial state - show loading
            return const Center(
              child: AppLoader(
                isLoading: true,
                child: SizedBox(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

