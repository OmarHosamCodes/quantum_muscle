import 'package:quantum_muscle/library.dart';

/// A customizable button widget that can be used to trigger actions.
class QmButton extends StatelessWidget {
  /// Creates a [QmButton] widget.
  const QmButton.icon({
    required this.icon,
    super.key,
    this.iconSize,
    this.iconColor,
    this.tooltip,
    this.onPressed,
  })  : text = null,
        variant = QmButtonVariant.icon;

  /// Text Button's Properties
  const QmButton.text({
    required this.text,
    super.key,
    this.onPressed,
  })  : icon = null,
        iconSize = null,
        iconColor = null,
        tooltip = null,
        variant = QmButtonVariant.text;

  /// Icon Button's Properties
  final IconData? icon;

  ///
  final double? iconSize;

  ///
  final Color? iconColor;

  ///
  final String? tooltip;

  /// Text Button's Properties
  final String? text;

  /// Common
  final void Function()? onPressed;

  /// Variant
  final QmButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      QmButtonVariant.icon => _buildIcon(),
      QmButtonVariant.text => _buildText(),
    };
  }

  Widget _buildIcon() {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }

  Widget _buildText() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.accentColor,
        foregroundColor: ColorConstants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: FittedBox(
        child: QmText.simple(
          text: text!,
          // isHeadline: true,
        ),
      ),
    );
  }
}

/// The variant of the button.
enum QmButtonVariant {
  /// The button is an icon button.
  icon,

  /// The button is a text button.
  text,
}
