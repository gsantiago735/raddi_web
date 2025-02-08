import 'package:flutter/material.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';

class GenericInput extends StatelessWidget {
  const GenericInput({
    super.key,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.obscureText = false,
    this.textController,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.maxHeight,
    this.colorLink,
    this.readOnly,
    this.prefixIconColor = ConstantColors.cffB0B7C3,
    this.labelText,
    this.suffixIcon,
  });

  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool obscureText;
  final double? maxHeight;
  final TextEditingController? textController;
  final void Function(String?)? onChanged;
  final Color? colorLink;
  final bool? readOnly;
  final Color? prefixIconColor;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      maxLines: 1,
      minLines: 1,
      validator: validator,
      obscureText: obscureText,
      keyboardType: textInputType,
      textInputAction: TextInputAction.done,
      textCapitalization: textCapitalization,
      controller: textController,
      onChanged: onChanged,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: colorLink != null ? colorLink! : ConstantColors.cff081131,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        //constraints:
        //    (maxHeight != null) ? BoxConstraints(maxHeight: maxHeight!) : null,
        filled: true,
        isDense: false,
        fillColor: Colors.transparent,
        prefixIcon: (prefixIcon != null) ? Icon(prefixIcon) : null,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
        suffixIconColor: prefixIconColor,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: ConstantColors.cffB0B7C3,
          fontSize: 14,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: ConstantColors.cffB0B7C3,
          fontSize: 14,
        ),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ConstantColors.cffF15B5B, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  final OutlineInputBorder _border = const OutlineInputBorder(
    borderSide: BorderSide(color: ConstantColors.cffDFE6EC, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
