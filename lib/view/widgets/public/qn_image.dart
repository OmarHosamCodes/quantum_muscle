import '/library.dart';

class QmImageMemory extends StatelessWidget {
  const QmImageMemory({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fallbackIcon = EvaIcons.alertTriangleOutline,
    this.fit,
  });
  final String? source;
  final double? width;
  final double? height;
  final IconData? fallbackIcon;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Image(
      image: MemoryImage(base64Decode(source!)),
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => Icon(
        fallbackIcon,
        color: ColorConstants.iconColor,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: QmCircularProgressIndicator(
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

class QmImageNetwork extends StatelessWidget {
  const QmImageNetwork({
    super.key,
    this.source,
    this.width,
    this.height,
    this.fallbackIcon = EvaIcons.alertTriangleOutline,
    this.fit,
  });
  final String? source;
  final double? width;
  final double? height;
  final IconData? fallbackIcon;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: source!,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: QmCircularProgressIndicator(
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
}
