import 'package:flutter/material.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../localization/app_localization.dart';
import '../../../account/presentation/screen/login/login_screen.dart';
import '../../../account/presentation/screen/register/register_screen.dart';
import '../../../home/presentation/screen/home_tabbed_screen.dart';
import '../../../../di/service_locator.dart';
import '../../../../core/services/auth_service.dart';

class SplashScreenParam {}

class SplashScreen extends BaseScreen<SplashScreenParam> {
  static const routeName = "/SplashScreen";

  const SplashScreen({required super.param, super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check for existing session and navigate accordingly
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show splash for at least 1 second for better UX
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    try {
      final authService = getIt<AuthService>();
      final isLoggedIn = await authService.tryAutoLogin();

      if (!mounted) return;

      if (isLoggedIn) {
        // User has valid session, navigate to home
        print('✅ Auto-login successful, navigating to home');
        _navigateToHome();
      } else {
        // No valid session, navigate to login
        print('ℹ️ No valid session, navigating to login');
        _navigateToLogin();
      }
    } catch (e) {
      print('❌ Error checking auth status: $e');
      // On error, navigate to login
      if (mounted) {
        _navigateToLogin();
      }
    }
  }

  void _navigateToLogin() {
    Nav.off(
      LoginScreen.routeName,
      arguments: const LoginScreenParam(),
    );
  }

  void _navigateToHome() {
    Nav.off(
      HomeTabbedScreen.routeName,
      arguments: HomeTabbedScreenParam(),
    );
  }

  void _navigateToRegister() {
    Nav.to(
      RegisterScreen.routeName,
      arguments: const RegisterScreenParam(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Spacer
            const Spacer(),

            // Logo Section
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusXLarge),
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      size: AppDimensions.iconXXLarge * 1.5,
                      color: AppColors.textOnPrimary,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacing24),

                  // App Name
                  Text(
                    'app_name'.tr,
                    style: AppTextStyles.h1.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacing8),

                  // Tagline
                  Text(
                    'app_tagline'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Get Started Button
                  ElevatedButton(
                    onPressed: _navigateToRegister,
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
                      elevation: 0,
                    ),
                    child: Text(
                      'get_started'.tr,
                      style: AppTextStyles.buttonLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacing16),

                  // Already have account
                  Row(
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
                        onTap: _navigateToLogin,
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

                  const SizedBox(height: AppDimensions.spacing24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
