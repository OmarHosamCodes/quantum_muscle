import 'package:quantum_muscle/library.dart';

class QmShimmer extends StatelessWidget {
  const QmShimmer.round({
    required this.size,
    super.key,
  })  : width = size,
        height = size,
        radius = size,
        isCircle = true;

  const QmShimmer.rectangle({
    required this.width,
    required this.height,
    this.radius = 0,
    super.key,
  })  : isCircle = false,
        size = 0;
  final double width;
  final double height;
  final double radius;
  final bool isCircle;
  final double size;

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? buildRound(
            size: size,
          )
        : buildRectangle(
            context,
          );
  }

  Widget buildRound({
    required double size,
  }) {
    return FadeShimmer.round(
      size: size,
      baseColor: ColorConstants.primaryColor,
      highlightColor: ColorConstants.accentColor,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: SimpleConstants.fastAnimationDuration.inMilliseconds,
    );
  }

  Widget buildRectangle(BuildContext context) {
    return FadeShimmer(
      width: width,
      height: height,
      radius: radius,
      baseColor: ColorConstants.primaryColor,
      highlightColor: ColorConstants.accentColor,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: SimpleConstants.fastAnimationDuration.inMilliseconds,
    );
  }
}
