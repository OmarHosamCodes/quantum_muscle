import 'package:quantum_muscle/library.dart';

class QmBlock extends StatelessWidget {
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
    this.isGradient = false,
    this.isNormal = true,
    this.borderRadius,
    this.border,
    this.boxShadow,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final void Function()? onTap;
  final double maxHeight;
  final double maxWidth;
  final bool isAnimated;
  final Color color;
  final bool isGradient;
  final bool isNormal;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  Duration get containerAnimationDuration =>
      isAnimated ? SimpleConstants.fastAnimationDuration : Duration.zero;
  Gradient? get containerGradient => isGradient
      ? const LinearGradient(
          colors: [
            ColorConstants.primaryColor,
            ColorConstants.secondaryColor,
          ],
        )
      : null;
  BorderRadius? get containerBorderRadius =>
      borderRadius ?? SimpleConstants.borderRadius;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.cell,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: containerAnimationDuration,
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            maxWidth: maxWidth,
          ),
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: containerGradient,
            color: color,
            borderRadius: containerBorderRadius,
            border: border,
            boxShadow: boxShadow,
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.cell,
            child: GestureDetector(
              onTap: onTap,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
