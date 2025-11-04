import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/ui/screens/base_screen.dart';
import '../../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../state_m/account/account_cubit.dart';
import 'register_screen_content.dart';
import '../../../../home/presentation/screen/home_tabbed_screen.dart';

class RegisterScreenParam {
  final String? referralCode;

  const RegisterScreenParam({this.referralCode});
}

class RegisterScreen extends BaseScreen<RegisterScreenParam> {
  static const routeName = "/RegisterScreen";

  const RegisterScreen({required super.param, super.key});

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.primaryGradient,
        child: BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(),
          child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {
              state.whenOrNull(
                accountError: (error, callback) async {
                  // Handle error with snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error: $error',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.error,
                    ),
                  );
                },
              );
            },
            builder: (context, AccountState state) {
              if (state is AccountLoading) {
                return const Center(
                  child: AppLoader(
                    isLoading: true,
                    child: RegisterScreenContent(),
                  ),
                );
              }
              if (state is RegisterError) {
                return const Center(
                  child: AppLoader(
                    isLoading: false,
                    child: RegisterScreenContent(),
                  ),
                );
              }
              if (state is UserRegisteredSuccessState) {
                if (state.accountEntity.userId != null) {
                  // Schedule navigation for next frame to avoid navigator lock
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    if (mounted) {
                      // Navigate directly to home
                      Nav.off(
                        HomeTabbedScreen.routeName,
                        arguments: HomeTabbedScreenParam(),
                      );
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Could not register user',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
                return const SizedBox.shrink();
              }
              return const Center(
                child: AppLoader(
                  isLoading: false,
                  child: RegisterScreenContent(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
