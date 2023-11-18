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
  }) : super(key: key);
  final double width;
  final double height;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final void Function()? onTap;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          gradient: LinearGradient(colors: [
            ColorConstants.primaryColor,
            ColorConstants.primaryColor.withOpacity(.5),
          ]),
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: child),
      ),
    );
  }
}
