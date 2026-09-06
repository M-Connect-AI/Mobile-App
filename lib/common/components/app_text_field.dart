import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../extensions/responsive_extension.dart';
import '../themes/theme_extensions/app_color_scheme.dart';
import 'app_text_style.dart';

class IrhTextField extends StatelessWidget {
  const IrhTextField(
    this.context, {
    super.key,
    required this.name,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onSubmitted,
  });

  final BuildContext context;
  final String name;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      validator: validator,
      onSubmitted: onSubmitted,
      style: AppTextStyle.r16.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: AppTextStyle.r16.copyWith(color: colors.textSecondary),
        hintStyle: AppTextStyle.r16.copyWith(color: colors.textTertiary),
        filled: true,
        fillColor: colors.surfaceSecondary,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 16.height,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.borderSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.borderSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.iconBrand),
        ),
      ),
    );
  }
}

class AppTextField extends IrhTextField {
  const AppTextField(
    super.context, {
    super.key,
    required super.name,
    super.initialValue,
    super.labelText,
    super.hintText,
    super.prefixIcon,
    super.suffixIcon,
    super.obscureText,
    super.keyboardType,
    super.textInputAction,
    super.autofillHints,
    super.validator,
    super.onSubmitted,
  });
}
