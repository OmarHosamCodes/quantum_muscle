import 'package:quantum_muscle/library.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    required this.height,
    required this.width,
    required this.controller,
    super.key,
    this.hintText,
    this.hasNext = true,
    this.validator,
    this.initialValue,
    this.maxLength,
    this.margin,
    this.maxHeight = double.maxFinite,
    this.maxWidth = double.maxFinite,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final int? maxLength;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final double maxHeight;
  final double maxWidth;
  final bool hasNext;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    TextInputAction finalInputAction() {
      if (hasNext) {
        return TextInputAction.next;
      } else {
        return TextInputAction.done;
      }
    }

    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        smartDashesType: SmartDashesType.enabled,
        smartQuotesType: SmartQuotesType.enabled,
        style: const TextStyle(
          color: ColorConstants.textColor,
          fontSize: 16,
        ),
        textAlignVertical: TextAlignVertical.top,
        cursorColor: ColorConstants.textSeccondaryColor,
        controller: controller,
        textInputAction: finalInputAction(),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.primaryColor,
            ),
          ),
          filled: false,
          hintText: hintText,
          hintStyle: const TextStyle(color: ColorConstants.textColor),
        ),
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
