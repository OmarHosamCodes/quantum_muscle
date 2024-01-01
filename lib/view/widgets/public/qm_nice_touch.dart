import '/library.dart';

class QmNiceTouch extends StatelessWidget {
  const QmNiceTouch(
      {super.key,
      required this.child,
      this.alignment = Alignment.center,
      this.blurStrength = 25,
      this.blurRadius = 200,
      this.width = 100,
      this.height = 100,
      this.color = ColorConstants.primaryColor});
  final Widget child;
  final Alignment alignment;
  final double blurStrength;
  final double blurRadius;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: alignment,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurStrength,
              sigmaY: blurStrength,
            ),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color,
                    blurRadius: blurRadius,
                  ),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
