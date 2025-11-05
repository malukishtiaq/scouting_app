import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../di/service_locator.dart';
import '../../../../localization/app_localization.dart';
import '../cubit/explore_cubit.dart';
import 'explore_screen_content.dart';

class ExploreScreen extends StatelessWidget {
  static const String routeName = '/explore';

  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExploreCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundDark,
          elevation: 0,
          title: Text(
            'explore'.tr,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: const ExploreScreenContent(),
      ),
    );
  }
}

