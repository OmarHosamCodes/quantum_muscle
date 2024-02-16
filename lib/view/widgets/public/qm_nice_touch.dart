import 'package:quantum_muscle/library.dart';

class QmNiceTouch extends StatelessWidget {
  const QmNiceTouch({
    required this.child,
    super.key,
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
              DotPainter(dotColor: color, dotRadius: 0.35, spacing: 10),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      ],
    );
  }
}
