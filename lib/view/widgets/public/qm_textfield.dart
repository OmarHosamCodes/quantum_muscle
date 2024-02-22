import 'dart:ui' as ui show BoxHeightStyle;
import 'package:quantum_muscle/library.dart';

class QmTextField extends StatelessWidget {
  const QmTextField({
    required this.controller,
    required this.hintText,
    required this.textInputAction,
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.isExpanded = false,
    this.initialValue,
    this.maxLength,
    this.borderRadius,
    this.margin,
    this.fontSize = 16.0,
    this.fieldColor = ColorConstants.primaryColor,
    this.onChanged,
    this.onEditingComplete,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isExpanded;
  final String? initialValue;
  final int? maxLength;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final double? fontSize;
  final Color fieldColor;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputAction textInputAction;
  BorderRadius get borderRadiusValue {
    if (borderRadius != null) {
      return borderRadius!;
    }
    return BorderRadius.circular(10);
  }

  OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderRadius: borderRadiusValue,
        borderSide: const BorderSide(
          color: ColorConstants.accentColor,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      strutStyle: const StrutStyle(height: 1),
      maxLength: maxLength,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      expands: isExpanded,
      keyboardType: keyboardType,
      style: TextStyle(
        color: ColorConstants.textColor,
        fontSize: fontSize,
      ),
      selectionHeightStyle: ui.BoxHeightStyle.strut,
      textAlignVertical: TextAlignVertical.top,
      maxLines: isExpanded ? null : 1,
      cursorColor: ColorConstants.textSeccondaryColor,
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        isCollapsed: false,
        errorStyle: const TextStyle(
          color: ColorConstants.errorColor,
          fontSize: 14,
        ),
        counterText: SimpleConstants.emptyString,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        filled: true,
        fillColor: fieldColor.withOpacity(.2),
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorConstants.textSeccondaryColor),
        contentPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
      ),
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
