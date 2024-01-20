import '/library.dart';

class QmNiceTouch extends StatelessWidget {
  const QmNiceTouch({
    super.key,
    required this.child,
    this.color = ColorConstants.primaryColor,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final vWidth = MediaQuery.of(context).size.width;
    final vHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(vWidth, vHeight),
          foregroundPainter:
              DotPainter(dotColor: color, dotRadius: 0.35, spacing: 10.0),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      ],
    );
  }
}
