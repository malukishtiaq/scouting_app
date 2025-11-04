import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../localization/app_localization.dart';
import '../../../../../core/ui/widgets/flutter_target/app_messages.dart';
import '../../state_m/account/account_cubit.dart';

class ForgotPasswordScreenContent extends StatefulWidget {
  const ForgotPasswordScreenContent({super.key});

  @override
  State<ForgotPasswordScreenContent> createState() =>
      _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState
    extends State<ForgotPasswordScreenContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _sentEmail = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        state.whenOrNull(
          resetPasswordSuccess: (email) {
            setState(() => _sentEmail = true);
            AppMessages.show(
              context: context,
              message: '${'verification_code_sent'.tr} $email',
              isError: false,
            );
          },
          replacePasswordSuccess: (message) {
            AppMessages.show(
              context: context,
              message: message,
              isError: false,
            );
          },
        );
      },
      child: Container(
        decoration: AppDecorations.primaryGradient,
        child: SafeArea(
          child: Column(
            children: [
              // Logo Section
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimensions.spacing40,
                  bottom: AppDimensions.spacing32,
                ),
                child: Image.asset(
                  'assets/images/icons/logo.webp',
                  height: AppDimensions.iconXXLarge,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),

              // Main Card
              Expanded(
                child: Container(
                  decoration: AppDecorations.card,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Center(
                          child: Text(
                            'forgot_password_title'.tr,
                            style: AppTextStyles.h2,
                          ),
                        ),

                        // Description
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing16),
                            child: Text(
                              'forgot_password_description'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),

                        // Email Label
                        Container(
                          margin: const EdgeInsets.only(
                              top: AppDimensions.spacing24),
                          child: Text(
                            'email_label'.tr,
                            style: AppTextStyles.labelLarge,
                          ),
                        ),

                        // Email Field
                        Container(
                          margin: const EdgeInsets.only(
                              top: AppDimensions.spacing8),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: AppTextStyles.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'email_hint'.tr,
                              hintStyle: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textTertiary,
                              ),
                              filled: true,
                              fillColor: AppColors.surface,
                              isDense: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium),
                                borderSide: const BorderSide(
                                  color: AppColors.borderLight,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium),
                                borderSide: const BorderSide(
                                  color: AppColors.borderLight,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium),
                                borderSide: const BorderSide(
                                  color: AppColors.borderFocus,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.spacing16,
                                vertical: AppDimensions.spacing16,
                              ),
                            ),
                          ),
                        ),

                        // Step 1: Send email button
                        if (!_sentEmail)
                          Container(
                            margin:
                                const EdgeInsets.all(AppDimensions.spacing16),
                            height: AppDimensions.buttonHeightLarge,
                            child: ElevatedButton(
                              onPressed: () => _handleSendPress(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textOnPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusMedium),
                                ),
                              ),
                              child: Text(
                                'send_reset_link'.tr,
                                style: AppTextStyles.buttonLarge,
                              ),
                            ),
                          ),

                        // Step 2: OTP + New Password fields
                        if (_sentEmail) ...[
                          // Code label
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing24),
                            child: Text(
                              'verification_code'.tr,
                              style: AppTextStyles.labelLarge,
                            ),
                          ),
                          // Code field
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing8),
                            child: TextField(
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.bodyMedium,
                              decoration:
                                  _inputDecoration('verification_code_hint'.tr),
                            ),
                          ),

                          // New Password label
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing24),
                            child: Text(
                              'new_password'.tr,
                              style: AppTextStyles.labelLarge,
                            ),
                          ),
                          // New Password field
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing8),
                            child: TextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              style: AppTextStyles.bodyMedium,
                              decoration:
                                  _inputDecoration('new_password_hint'.tr),
                            ),
                          ),

                          // Confirm Password label
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing24),
                            child: Text(
                              'confirm_password'.tr,
                              style: AppTextStyles.labelLarge,
                            ),
                          ),
                          // Confirm Password field
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppDimensions.spacing8),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              style: AppTextStyles.bodyMedium,
                              decoration: _inputDecoration(
                                  'forgot_confirm_password_hint'.tr),
                            ),
                          ),

                          // Confirm button
                          Container(
                            margin:
                                const EdgeInsets.all(AppDimensions.spacing16),
                            height: AppDimensions.buttonHeightLarge,
                            child: ElevatedButton(
                              onPressed: () => _handleConfirmPress(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textOnPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusMedium),
                                ),
                              ),
                              child: Text(
                                'confirm_reset'.tr,
                                style: AppTextStyles.buttonLarge,
                              ),
                            ),
                          ),
                        ],

                        // Bottom Spacer
                        const SizedBox(height: AppDimensions.spacing32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSendPress(BuildContext context) {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppMessages.show(
        context: context,
        message: 'forgot_please_enter_email'.tr,
        isError: true,
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      AppMessages.show(
        context: context,
        message: 'forgot_please_enter_valid_email'.tr,
        isError: true,
      );
      return;
    }

    final cubit = BlocProvider.of<AccountCubit>(context);
    cubit.resetPassword(email);
  }

  void _handleConfirmPress(BuildContext context) {
    final email = _emailController.text.trim();
    final code = _codeController.text.trim();
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (code.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      AppMessages.show(
        context: context,
        message: 'please_fill_all_fields'.tr,
        isError: true,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      AppMessages.show(
        context: context,
        message: 'forgot_passwords_do_not_match'.tr,
        isError: true,
      );
      return;
    }

    final cubit = BlocProvider.of<AccountCubit>(context);
    cubit.confirmResetPassword(email, code, newPassword);
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.borderFocus,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing16,
        ),
      );
}
