import 'package:quantum_muscle/library.dart';

class QmTextField extends StatelessWidget {
  const QmTextField({
    required this.height,
    required this.width,
    required this.controller,
    required this.hintText,
    super.key,
    this.obscureText = false,
    this.hasNext = true,
    this.keyboardType,
    this.validator,
    this.isExpanded = false,
    this.initialValue,
    this.maxLength,
    this.borderRadius,
    this.margin,
    this.maxHeight = double.maxFinite,
    this.maxWidth = double.maxFinite,
    this.fontSize = 16.0,
    this.onChanged,
    this.fieldColor = ColorConstants.textFieldColor,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasNext;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isExpanded;
  final String? initialValue;
  final int? maxLength;
  final BorderRadius? borderRadius;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final double maxHeight;
  final double maxWidth;
  final double? fontSize;
  final void Function(String)? onChanged;
  final Color fieldColor;
  BorderRadius get borderRadiusValue {
    if (borderRadius != null) {
      return borderRadius!;
    }
    return BorderRadius.circular(10);
  }

  TextInputAction get finalInputAction {
    if (isExpanded) {
      return TextInputAction.newline;
    }
    if (hasNext) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        minWidth: width,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: borderRadiusValue,
      ),
      margin: margin,
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.left,
          strutStyle: const StrutStyle(height: 1),
          onChanged: onChanged,
          maxLength: maxLength,
          smartDashesType: SmartDashesType.enabled,
          smartQuotesType: SmartQuotesType.enabled,
          expands: isExpanded,
          keyboardType: keyboardType,
          style: TextStyle(
            color: ColorConstants.textColor,
            fontSize: fontSize,
          ),
          textAlignVertical: TextAlignVertical.top,
          maxLines: isExpanded ? null : 1,
          cursorColor: ColorConstants.textSeccondaryColor,
          controller: controller,
          obscureText: obscureText,
          textInputAction: finalInputAction,
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              color: ColorConstants.errorColor,
              fontSize: 14,
            ),
            counterText: SimpleConstants.emptyString,
            border: OutlineInputBorder(
              borderRadius: borderRadiusValue,
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: false,
            hintText: hintText,
            hintStyle:
                const TextStyle(color: ColorConstants.textSeccondaryColor),
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
          ),
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ),
    );
  }
}
