import 'package:quantum_muscle/library.dart';

class QmShimmerRound extends StatelessWidget {
  const QmShimmerRound({
    required this.size, super.key,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return FadeShimmer.round(
      size: size,
      baseColor: ColorConstants.primaryColor,
      highlightColor: ColorConstants.secondaryColor,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: SimpleConstants.fastAnimationDuration.inMilliseconds,
    );
  }
}

class QmShimmer extends StatelessWidget {
  const QmShimmer({
    required this.width, required this.height, super.key,
    this.radius = 0,
  });
  final double width;
  final double height;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: width,
      height: height,
      radius: radius,
      baseColor: ColorConstants.primaryColor,
      highlightColor: ColorConstants.secondaryColor,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: SimpleConstants.fastAnimationDuration.inMilliseconds,
    );
  }
}
