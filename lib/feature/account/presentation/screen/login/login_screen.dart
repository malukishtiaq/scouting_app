import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/ui/screens/base_screen.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../../../../core/ui/widgets/flutter_target/app_messages.dart';
import '../../../../../localization/app_localization.dart';
import '../../state_m/account/account_cubit.dart';
import 'login_screen_content.dart';
// Onboarding flow intentionally not used in login for now

enum LoginFrom {
  onBoarding,
  mainScreen,
}

class LoginScreenParam {
  final LoginFrom from;

  const LoginScreenParam({this.from = LoginFrom.mainScreen});
}

class LoginScreen extends BaseScreen<LoginScreenParam> {
  static const routeName = "/LoginScreen";

  const LoginScreen({required super.param, super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AccountCubit>(
        create: (context) => AccountCubit(),
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            state.whenOrNull(accountError: (error, callback) async {
              // Handle error with snackbar
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
            });
          },
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(
                child: AppLoader(
                  isLoading: true,
                  child: LoginScreenContent(),
                ),
              );
            }
            if (state is LoginSuccessState) {
              if (state.accountEntity.data.token.isNotEmpty) {
                // if (kDebugMode) {
                //   dev.debugger();
                // }
                // Schedule navigation for next frame to avoid navigator lock
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (mounted) {
                    // Check if there's pending shared content to resume sharing flow
                    if (mounted) {
                      // Navigate directly to home
                      // Nav.to(
                      //   HomeTabbedScreen.routeName,
                      //   arguments: HomeTabbedScreenParam(),
                      // );
                    }
                  }
                });
              } else {
                // Schedule error message for next frame
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    AppMessages.show(
                      context: context,
                      message: 'error_occurred'.tr,
                      isError: true,
                    );
                  }
                });
              }
              return const LoginScreenContent();
            }
            return const LoginScreenContent();
          },
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}
