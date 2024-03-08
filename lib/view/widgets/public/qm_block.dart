import 'package:quantum_muscle/library.dart';

/// A customizable block widget that can be used to display content.
class QmBlock extends StatelessWidget {
  /// Creates a [QmBlock] widget.
  const QmBlock({
    super.key,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.isAnimated = false,
    this.color = ColorConstants.primaryColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
  });

  /// The width of the block.
  final double? width;

  /// The height of the block.
  final double? height;

  /// The child widget to be displayed inside the block.
  final Widget? child;

  /// The padding around the block.
  final EdgeInsets? padding;

  /// The margin around the block.
  final EdgeInsets? margin;

  /// The callback function to be called when the block is tapped.
  final void Function()? onTap;

  /// The maximum height that the block can have.
  final double maxHeight;

  /// The maximum width that the block can have.
  final double maxWidth;

  /// Whether the block should be animated.
  final bool isAnimated;

  /// The background color of the block.
  final Color color;

  /// The border radius of the block.
  final BorderRadius? borderRadius;

  /// The border of the block.
  final Border? border;

  /// The box shadow of the block.
  final List<BoxShadow>? boxShadow;

  /// The border radius of the block. If not provided, it uses the
  /// default border radius.
  BorderRadius get containerBorderRadius =>
      borderRadius ?? SimpleConstants.borderRadius;

  /// The duration of the animation. If the block is not animated, it
  /// returns a zero duration.
  Duration get duration =>
      isAnimated ? SimpleConstants.fastAnimationDuration : Duration.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            maxWidth: maxWidth,
          ),
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: containerBorderRadius,
            border: border,
            boxShadow: boxShadow,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
