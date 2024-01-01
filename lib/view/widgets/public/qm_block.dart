import '/library.dart';

class QmBlock extends StatelessWidget {
  const QmBlock({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.maxHeight = double.maxFinite,
    this.maxWidth = double.maxFinite,
    this.isAnimated = false,
    this.color = ColorConstants.primaryColor,
    this.isGradient = false,
    this.isNormal = true,
    this.borderRadius,
  });
  final double width;
  final double height;
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

  Duration get containerAnimationDuration =>
      isAnimated ? SimpleConstants.fastAnimationDuration : Duration.zero;
  Gradient? get containerGradient => isGradient
      ? const LinearGradient(
          colors: [
            ColorConstants.primaryColor,
            ColorConstants.accentColor,
          ],
        )
      : null;
  BorderRadius? get containerBorderRadius =>
      borderRadius ?? BorderRadius.circular(10);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.cell,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: containerAnimationDuration,
          constraints: BoxConstraints(
            minHeight: height,
            minWidth: width,
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
