import 'package:quantum_muscle/library.dart';

class QmButton {
  static Widget icon({
    required IconData icon,
    void Function()? onPressed,
    double iconSize = 20,
    Color iconColor = ColorConstants.iconColor,
    String? tooltip,
  }) {
    final onPressedFunction = onPressed ?? () {};
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressedFunction,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }

  static Widget text({
    required String text,
    void Function()? onPressed,
  }) {
    final onPressedFunction = onPressed ?? () {};
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.accentColor,
        foregroundColor: ColorConstants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressedFunction,
      child: FittedBox(
        child: QmSimpleText(
          text: text,
          // isHeadline: true,
        ),
      ),
    );
  }
}
