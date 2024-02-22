import 'package:quantum_muscle/library.dart';

class QmShimmer {
  static Widget round({
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

  static Widget rectangle({
    required double width,
    required double height,
    double radius = 0,
  }) {
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
