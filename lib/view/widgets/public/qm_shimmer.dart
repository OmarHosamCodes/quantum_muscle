import 'package:quantum_muscle/library.dart';

/// A widget that displays a shimmer effect.
class QmShimmer extends StatelessWidget {
  /// Creates a circular shimmer effect with the given size.
  const QmShimmer.round({
    required this.size,
    super.key,
  })  : width = size,
        height = size,
        radius = size,
        type = ShimmerType.circular;

  /// Creates a rectangular shimmer effect with the given width and height.
  const QmShimmer.rectangle({
    required this.width,
    required this.height,
    this.radius = 0,
    super.key,
  })  : type = ShimmerType.rectangular,
        size = 0;

  /// The width of the rectangular shimmer effect.
  final double width;

  /// The height of the rectangular shimmer effect.
  final double height;

  /// The radius of the rectangular shimmer effect.
  final double radius;

  /// The size of the circular shimmer effect.
  final double size;

  /// The type of the shimmer effect.
  final ShimmerType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ShimmerType.circular => buildRound(),
      ShimmerType.rectangular => buildRectangle(),
    };
  }

  /// Builds the circular shimmer effect.
  Widget buildRound() {
    return FadeShimmer.round(
      size: size,
      baseColor: ColorConstants.primaryColor,
      highlightColor: ColorConstants.accentColor,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: SimpleConstants.fastAnimationDuration.inMilliseconds,
    );
  }

  /// Builds the rectangular shimmer effect.
  Widget buildRectangle() {
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

/// The type of the shimmer effect.
enum ShimmerType {
  /// The circular shimmer effect.
  circular,

  /// The rectangular shimmer effect.
  rectangular,
}
