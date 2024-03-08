import 'package:quantum_muscle/library.dart';

/// A widget that displays an image from a network or memory source.
class QmImage extends StatelessWidget {
  /// Constructs a [QmImage] widget with smart image loading.
  const QmImage.smart({
    required this.source,
    super.key,
    this.width,
    this.height,
    this.fallbackIcon,
    this.fit,
  });

  /// The source of the image.
  final String source;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  /// The fallback icon to display if the image fails to load.
  final IconData? fallbackIcon;

  /// The fit of the image within its container.
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return buildSmartImage();
  }

  /// Builds a network image widget.
  Widget buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: source,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: QmLoader.indicator(
            value: progress.progress,
          ),
        );
      },
      errorWidget: (context, url, error) => Icon(
        fallbackIcon,
        color: ColorConstants.iconColor,
      ),
      fadeInDuration: SimpleConstants.slowAnimationDuration,
      fadeOutDuration: SimpleConstants.slowAnimationDuration,
      filterQuality: FilterQuality.medium,
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// Builds a memory image widget.
  Widget buildMemoryImage() {
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

  /// Builds a smart image widget based on the source.
  Widget buildSmartImage() {
    if (source.startsWith('http')) {
      return buildNetworkImage();
    } else {
      return buildMemoryImage();
    }
  }
}
