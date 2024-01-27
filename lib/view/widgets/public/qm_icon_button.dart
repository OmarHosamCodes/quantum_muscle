import '/library.dart';

class QmIconButton extends StatelessWidget {
  const QmIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 20,
    this.iconColor = ColorConstants.iconColor,
    this.tooltip,
  });
  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;
  final Color iconColor;
  final String? tooltip;
  void Function()? get onPressedFunction => onPressed ?? () {};
  @override
  Widget build(BuildContext context) {
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
}
