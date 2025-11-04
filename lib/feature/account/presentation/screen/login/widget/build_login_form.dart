import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/navigation/nav.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/app_dimensions.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../localization/app_localization.dart';
import '../../../../data/request/param/login_param.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../register/register_screen.dart';
import '../../../state_m/account/account_cubit.dart';

class BuildLoginForm extends StatelessWidget {
  BuildLoginForm({super.key});
  late final AccountCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<AccountCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUsernameInput(context),
        const SizedBox(height: AppDimensions.spacing24),
        _buildPasswordInput(context),
        const SizedBox(height: AppDimensions.spacing32),
        _buildLoginButton(context),
        const SizedBox(height: AppDimensions.spacing24),
        Center(
          child: Text(
            'or'.tr,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing24),
        _buildSignUpButton(context),
        Center(
          child: GestureDetector(
            onTap: () {
              Nav.to(
                ForgotPasswordScreen.routeName,
                arguments: const ForgotPasswordParam(),
              );
            },
            child: Text(
              'forgot_password'.tr,
              style: AppTextStyles.linkText,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing32),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      decoration: AppDecorations.primaryButton,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            TextInput.finishAutofillContext();
            cubit?.loginLoveLoop(
              LoginParam(
                username: cubit?.usernameController.text,
                password: cubit?.passwordController.text,
              ),
            );
          },
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: Center(
            child: Text(
              'login_button'.tr,
              style: AppTextStyles.buttonLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      decoration: AppDecorations.outlineButton,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Nav.to(
              RegisterScreen.routeName,
              arguments: RegisterScreenParam(),
            );
          },
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: Center(
            child: Text(
              'sign_up'.tr,
              style: AppTextStyles.buttonLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameInput(BuildContext context) {
    return TextFormField(
      controller: cubit?.usernameController,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: 'email'.tr,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing16,
        ),
        filled: true,
        fillColor: AppColors.surface,
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
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'email_validation_error'.tr;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'email_format_error'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Selector<AccountCubit, bool>(
      selector: (_, cubit) => cubit.isShowPassword,
      builder: (context, isShowPassword, _) {
        return TextFormField(
          controller: cubit?.passwordController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: isShowPassword,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: 'password'.tr,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing16,
            ),
            filled: true,
            fillColor: AppColors.surface,
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
            suffixIcon: InkWell(
              onTap: () {
                cubit?.isShowPassword = !isShowPassword;
              },
              child: Icon(
                isShowPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textTertiary,
                size: AppDimensions.iconMedium,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_validation_error'.tr;
            }
            if (value.length < 6) {
              return 'password_length_error'.tr;
            }
            return null;
          },
        );
      },
    );
  }
}
