import '/library.dart';

class QmIconButton extends StatelessWidget {
  const QmIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 20,
  });
  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;

  void Function()? get onPressedFunction => onPressed ?? () {};
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressedFunction,
      iconSize: iconSize,
      icon: Icon(
        icon,
        color: ColorConstants.iconColor,
      ),
    );
  }
}
