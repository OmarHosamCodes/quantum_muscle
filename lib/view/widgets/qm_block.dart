import '/library.dart';

class QmBlock extends StatelessWidget {
  const QmBlock({
    super.key,
    this.width = 0,
    this.height = 0,
    required this.child,
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
  final Widget child;
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.cell,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration:
              isAnimated ? const Duration(milliseconds: 250) : Duration.zero,
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
            gradient: isGradient
                ? const LinearGradient(
                    colors: [
                      ColorConstants.primaryColor,
                      ColorConstants.primaryColorDark,
                    ],
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: ColorConstants.primaryColorDark,
                blurRadius: 5,
              ),
            ],
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
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
