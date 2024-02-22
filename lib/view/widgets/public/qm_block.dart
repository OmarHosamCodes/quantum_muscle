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

  final bool isNormal;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  Duration get containerAnimationDuration =>
      isAnimated ? SimpleConstants.fastAnimationDuration : Duration.zero;

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
