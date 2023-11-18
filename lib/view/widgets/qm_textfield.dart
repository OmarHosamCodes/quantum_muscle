import '../../../library.dart';

class QMTextField extends StatelessWidget {
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
  const QMTextField({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hasNext = true,
    this.keyboardType,
    this.validator,
    this.isExpanded = false,
    this.initialValue,
    this.maxLength,
    this.borderRadius,
    this.margin,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputAction finalInputAction() {
      if (isExpanded) {
        return TextInputAction.newline;
      }
      if (hasNext) {
        return TextInputAction.next;
      } else {
        return TextInputAction.done;
      }
    }

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
        color: ColorConstants.secondaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
      ),
      margin: margin,
      child: Center(
        child: TextFormField(
          maxLength: maxLength,
          smartDashesType: SmartDashesType.enabled,
          smartQuotesType: SmartQuotesType.enabled,
          expands: isExpanded,
          keyboardType: keyboardType,
          style: const TextStyle(color: ColorConstants.textFieldColor),
          textAlignVertical: TextAlignVertical.top,
          maxLines: isExpanded ? null : 1,
          cursorColor: ColorConstants.tertiaryColor,
          controller: controller,
          obscureText: obscureText,
          textInputAction: finalInputAction(),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: false,
            hintText: hintText,
            hintStyle: const TextStyle(color: ColorConstants.hintColor),
          ),
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ),
    );
  }
}
