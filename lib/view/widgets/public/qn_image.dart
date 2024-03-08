import 'package:quantum_muscle/library.dart';

class QmImage extends StatelessWidget {
  const QmImage.smart({
    required this.source,
    super.key,
    this.width,
    this.height,
    this.fallbackIcon,
    this.fit,
  });

  final String source;
  final double? width;
  final double? height;
  final IconData? fallbackIcon;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return buildSmartImage();
  }

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

  Widget buildSmartImage() {
    if (source.startsWith('http')) {
      return buildNetworkImage();
    } else {
      return buildMemoryImage();
    }
  }
}
