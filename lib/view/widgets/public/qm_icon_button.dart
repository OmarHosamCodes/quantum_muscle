import '/library.dart';

class QmIconButton extends StatelessWidget {
  const QmIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 20,
    this.iconColor = ColorConstants.iconColor,
  });
  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;
  final Color iconColor;
  void Function()? get onPressedFunction => onPressed ?? () {};
  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      onPressed: onPressedFunction,
      iconSize: iconSize,
      icon: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
