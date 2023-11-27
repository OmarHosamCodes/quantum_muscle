import '../../library.dart';

class QmBlock extends StatelessWidget {
  const QmBlock({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.isAnimated = false,
    this.color = ColorConstants.primaryColor,
  }) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
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
            gradient: onTap != null && color == ColorConstants.primaryColor
                ? LinearGradient(
                    colors: [
                      ColorConstants.primaryColor,
                      ColorConstants.primaryColor.withOpacity(.5),
                    ],
                  )
                : null,
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
