import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/app_config.dart';
import '../../../../../../core/constants/website_constants.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/theme/app_dimensions.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../localization/app_localization.dart';
import '../../../../data/request/param/love_loop/register_param.dart';
import '../../../state_m/account/account_cubit.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocSelector<AccountCubit, AccountState, RegisterError?>(
            selector: (state) {
              return state.whenOrNull(
                registerError: (error, callback, param) {
                  return RegisterError(error, callback, param);
                },
              );
            },
            builder: (context, registerError) {
              if (registerError != null) {
                // Handle error with snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'error_register'.tr.replaceAll(
                          '{error}', registerError.error.toString()),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    backgroundColor: AppColors.error,
                  ),
                );

                _fullNameController.text = registerError.param.firstName ?? '';
                _emailController.text = registerError.param.email ?? '';
                _passwordController.text = registerError.param.password ?? '';
              }
              return _buildPersonalInfoSection(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFullNameInput(context),
        SizedBox(height: AppDimensions.spacing16),
        _buildEmailInput(context),
        SizedBox(height: AppDimensions.spacing16),
        _buildPasswordInput(context),
        SizedBox(height: AppDimensions.spacing16),
        _buildConfirmPasswordInput(context),
        SizedBox(height: AppDimensions.spacing24),
        _buildNextButton(context),
      ],
    );
  }

  Widget _buildFullNameInput(BuildContext context) {
    return Container(
      decoration: AppDecorations.inputField,
      child: TextFormField(
        controller: _fullNameController,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: "hint_full_name".tr,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(AppDimensions.spacing16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your full name";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Container(
      decoration: AppDecorations.inputField,
      child: Stack(
        children: [
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: "hint_password".tr,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: AppDimensions.spacing16,
                right: AppDimensions.spacing56,
                top: AppDimensions.spacing16,
                bottom: AppDimensions.spacing16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
          ),
          Positioned(
            right: AppDimensions.spacing20,
            top: AppDimensions.spacing20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Container(
      decoration: AppDecorations.inputField,
      child: Stack(
        children: [
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: "hint_confirm_password".tr,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: AppDimensions.spacing16,
                right: AppDimensions.spacing56,
                top: AppDimensions.spacing16,
                bottom: AppDimensions.spacing16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          Positioned(
            right: AppDimensions.spacing20,
            top: AppDimensions.spacing20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              child: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Container(
      decoration: AppDecorations.inputField,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: "hint_email".tr,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(AppDimensions.spacing16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return "Please enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      child: ElevatedButton(
        onPressed: onTapRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
        ),
        child: Text(
          'sign_up'.tr,
          style: AppTextStyles.buttonLarge,
        ),
      ),
    );
  }

  void onTapRegister() {
    if (formKey.currentState?.validate() ?? false) {
      RegisterParam param = RegisterParam.fromFormData(
        serverKey: WebsiteConstants.serverKey, // Demo server key
        email: _emailController.text,
        username:
            _fullNameController.text, // Using full name as username for now
        firstName: _fullNameController.text,
        lastName: '', // Empty for now
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        gender: 'male', // Default gender
        phoneNum: '', // Empty for now
        ref: '', // Empty for now
        androidNDeviceId: AppConfig().deviceId ?? 'demo_device_token',
        androidMDeviceId: 'demo_message_token',
        deviceType: 'phone',
      );
      context.read<AccountCubit>().resgister(param);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
