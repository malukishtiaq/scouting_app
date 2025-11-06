import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../core/services/social_login_service.dart';
import '../../state_m/account/account_cubit.dart';
import '../register/register_screen.dart';

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isConnected = true;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
    // Hardcoded login credentials for testing
    _emailController.text = 'gbailey2@example.net2';
    _passwordController.text = '+-0pBNvYgxwmi/#iw';
  }

  @override
  void dispose() {
    try {
      _connectivitySubscription.cancel();
    } catch (e) {
      // Ignore if subscription was never initialized
    }
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _setupFocusListeners() {
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  void _handleLogin(context) async {
    if (!_isConnected) {
      _showErrorSnackBar('no_internet_connection'.tr);
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar('please_fill_all_fields'.tr);
      return;
    }

    // Call the actual login API through AccountCubit
    BlocProvider.of<AccountCubit>(context).login(email, password);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password functionality
    // Nav.to(ForgotPasswordScreen.routeName, arguments: const ForgotPasswordParam());
  }

  void _handleCreateAccount() {
    Nav.to(
      RegisterScreen.routeName,
      arguments: const RegisterScreenParam(),
    );
  }

  Future<void> _handleSocialLogin(String provider) async {
    try {
      SocialLoginResult result;

      switch (provider) {
        case 'google':
          result = await SocialLoginService.signInWithGoogle();
          break;
        case 'facebook':
          result = await SocialLoginService.signInWithFacebook();
          break;
        default:
          _showErrorSnackBar('Unsupported social login provider');
          return;
      }

      if (result.isSuccess) {
        // TODO: Implement social login with Scouting API
        _showErrorSnackBar('Social login not yet implemented');
      } else {
        _showErrorSnackBar(
            result.error?.userFriendlyMessage ?? 'Social login failed');
      }
    } catch (e) {
      _showErrorSnackBar('Social login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimensions.spacing40),

            // Welcome Back Title
            Text(
              'welcome_back'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.h1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppDimensions.spacing8),

            // Subtitle
            Text(
              'login_subtitle'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppDimensions.spacing32),

            // Social Login Buttons
            Column(
              children: [
                // Google Button - Bright Blue (from Figma)
                ElevatedButton(
                  onPressed: () => _handleSocialLogin('google'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      AppDimensions.buttonHeightLarge,
                    ),
                    backgroundColor: AppColors.primary, // Bright blue
                    foregroundColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.g_mobiledata,
                        color: AppColors.textOnPrimary,
                        size: AppDimensions.iconMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacing12),
                      Text(
                        'continue_with_google'.tr,
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spacing16),

                // Facebook Button - Dark Gray (from Figma)
                ElevatedButton(
                  onPressed: () => _handleSocialLogin('facebook'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      AppDimensions.buttonHeightLarge,
                    ),
                    backgroundColor: AppColors.surface, // Dark gray
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.facebook,
                        color: AppColors.facebook,
                        size: AppDimensions.iconMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacing12),
                      Text(
                        'continue_with_facebook'.tr,
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // OR Divider
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spacing20,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: AppColors.borderLight,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing16,
                    ),
                    child: Text(
                      'or'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: AppColors.borderLight,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),

            // Email Input
            TextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'email'.tr,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(AppDimensions.spacing16),
              ),
            ),

            const SizedBox(height: AppDimensions.spacing16),

            // Password Input
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !_isPasswordVisible,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'password'.tr,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(AppDimensions.spacing16),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.textTertiary,
                    size: AppDimensions.iconSmall,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacing8),

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _handleForgotPassword,
                child: Text(
                  'forgot_password'.tr,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacing24),

            // Login Button
            ElevatedButton(
              onPressed: _isLoading ? null : () => _handleLogin(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  AppDimensions.buttonHeightLarge,
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: AppDimensions.iconMedium,
                      height: AppDimensions.iconMedium,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textOnPrimary,
                        ),
                      ),
                    )
                  : Text(
                      'login_button'.tr,
                      style: AppTextStyles.buttonLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),

            const SizedBox(height: AppDimensions.spacing24),

            // Footer - Don't have an account
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dont_have_account'.tr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing4),
                  GestureDetector(
                    onTap: _handleCreateAccount,
                    child: Text(
                      'sign_up'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
