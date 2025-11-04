import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/ui/error_ui/error_viewer/error_viewer.dart';
import '../../../../../core/ui/screens/base_screen.dart';
import '../../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../state_m/account/account_cubit.dart';
import '../login/login_screen.dart';
import 'forgot_password_screen_content.dart';

class ForgotPasswordParam {
  const ForgotPasswordParam();
}

class ForgotPasswordScreen extends BaseScreen<ForgotPasswordParam> {
  static const String routeName = "/ForgotPassword";

  const ForgotPasswordScreen({
    super.key,
    required super.param,
  });

  @override
  State createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AccountCubit>(
        create: (context) => AccountCubit(),
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            state.whenOrNull(
              accountError: (error, callback) async {
                ErrorViewer.showError(
                  context: context,
                  error: error,
                  callback: callback,
                );
              },
              // Keep user on the same page; content will react via its own BlocListener
              resetPasswordSuccess: (email) {},
              replacePasswordSuccess: (message) {
                // After successful reset, pop back to Login
                Nav.off(
                  LoginScreen.routeName,
                  arguments: const LoginScreenParam(),
                );
              },
            );
          },
          builder: (context, state) {
            return state.mapOrNull(
                  accountLoading: (_) {
                    return const Center(
                      child: AppLoader(
                        isLoading: true,
                        child: ForgotPasswordScreenContent(),
                      ),
                    );
                  },
                ) ??
                const ForgotPasswordScreenContent();
          },
        ),
      ),
    );
  }
}
