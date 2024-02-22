import 'package:quantum_muscle/library.dart';

class QmImage {
// Nameless method
  static Widget smart({
    required String source,
    double? width,
    double? height,
    IconData? fallbackIcon,
    BoxFit? fit,
  }) {
    if (source.startsWith('http')) {
      return network(
        source: source,
        width: width,
        height: height,
        fallbackIcon: fallbackIcon,
        fit: fit,
      );
    } else {
      return memory(
        source: source,
        width: width,
        height: height,
        fallbackIcon: fallbackIcon,
        fit: fit,
      );
    }
  }

  static Widget network({
    required String source,
    double? width,
    double? height,
    IconData? fallbackIcon,
    BoxFit? fit,
  }) {
    return CachedNetworkImage(
      imageUrl: source,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: QmLoader.indicator(
            value: progress.progress,
          ),
        );
      },
      errorWidget: (context, url, error) {
        print(error);
        return Icon(
          fallbackIcon,
          color: ColorConstants.iconColor,
        );
      },
      fadeInDuration: SimpleConstants.slowAnimationDuration,
      fadeOutDuration: SimpleConstants.slowAnimationDuration,
      filterQuality: FilterQuality.medium,
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget memory({
    required String source,
    double? width,
    double? height,
    IconData? fallbackIcon,
    BoxFit? fit,
  }) {
    return Image(
      image: MemoryImage(base64Decode(source)),
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => Icon(
        fallbackIcon,
        color: ColorConstants.iconColor,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: QmLoader.indicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      filterQuality: FilterQuality.medium,
      fit: fit,
    );
  }
}
