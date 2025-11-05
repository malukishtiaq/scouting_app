import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../core/services/social_login_service.dart';
import '../../state_m/account/account_cubit.dart';
import '../../../data/request/param/love_loop/register_param.dart';
import '../../../data/request/param/social_login_param.dart';

class RegisterScreenContent extends StatefulWidget {
  const RegisterScreenContent({super.key});

  @override
  State<RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<RegisterScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar('please_fill_all_fields'.tr);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the cubit to handle registration
      BlocProvider.of<AccountCubit>(context).register(email, password);
    } catch (e) {
      _showErrorSnackBar('${'registration_error'.tr}: $e');
      setState(() {
        _isLoading = false;
      });
    }
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleNavigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimensions.spacing40),

            // Welcome Title
            Text(
              'welcome_signup_title'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppDimensions.spacing32),

            // Social Login Buttons
            Column(
              children: [
                // Google Sign In Button - Bright Blue (from Figma)
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
                          fontWeight: FontWeight.bold,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spacing16),

                // Facebook Sign In Button - Dark Gray (from Figma)
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
                          fontWeight: FontWeight.bold,
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
                vertical: AppDimensions.spacing24,
              ),
              child: Text(
                'signup_subtitle'.tr,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
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
                    width: 1,
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
                    width: 1,
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

            const SizedBox(height: AppDimensions.spacing24),

            // Sign Up Button
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSignUp,
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
                      'sign_up'.tr,
                      style: AppTextStyles.buttonMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),

            const SizedBox(height: AppDimensions.spacing16),

            // Terms and Privacy
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  children: [
                    TextSpan(text: 'by_continuing_agree'.tr),
                    TextSpan(
                      text: ' ${'terms_of_service'.tr}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: ' ${'and'.tr} '),
                    TextSpan(
                      text: 'privacy_policy'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacing24),

            // Footer - Already have an account
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already_have_account'.tr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing4),
                  GestureDetector(
                    onTap: _handleNavigateToLogin,
                    child: Text(
                      'log_in'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
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
