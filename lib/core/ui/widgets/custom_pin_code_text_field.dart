import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../export_files.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/colors.dart';

// ignore_for_file: must_be_immutable
class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField(
      {Key? key,
      required this.context,
      required this.onChanged,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator,
      this.length = true})
      : super(
          key: key,
        );

  final bool length;

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget)
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: length ? 4 : 6,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? AppTextStyles.h2,
        hintStyle: hintStyle ?? AppTextStyles.h2,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 44.h,
          fieldWidth: 44.h,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5.h),
          inactiveColor: AppColors.borderMedium,
          activeColor: AppColors.primary,
          inactiveFillColor: Colors.transparent,
          activeFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          selectedColor: AppColors.primary,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
