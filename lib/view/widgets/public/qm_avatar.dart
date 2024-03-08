import 'package:quantum_muscle/library.dart';

/// A widget that displays an avatar image.
class QmAvatar extends StatelessWidget {
  /// Creates a [QmAvatar] widget.
  ///
  /// The [imageUrl] parameter specifies the URL of the image to be displayed.
  /// The [onTap] parameter specifies the callback function to be called when the avatar is tapped.
  /// The [radius] parameter specifies the radius of the avatar.
  /// The [isNetworkImage] parameter specifies whether the image is a network image or a base64 encoded image.
  const QmAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.radius = 25.0,
    this.isNetworkImage = true,
  });

  /// The URL of the image to be displayed.
  final String? imageUrl;

  /// The callback function to be called when the avatar is tapped.
  final void Function()? onTap;

  /// The radius of the avatar.
  final double radius;

  /// Specifies whether the image is a network image or a base64 encoded image.
  final bool isNetworkImage;

  /// Returns the URL of the image.
  String? get imageURL => imageUrl;

  /// Returns the image provider based on the [isNetworkImage] parameter.
  ImageProvider get imageProvider => isNetworkImage
      ? CachedNetworkImageProvider(imageURL!)
      : MemoryImage(base64Decode(imageURL!)) as ImageProvider<Object>;

  /// Indicates whether an error occurred while loading the image.
  static bool hasError = false;

  @override
  Widget build(BuildContext context) {
    const borderWidth = 5;
    if (imageUrl == SimpleConstants.emptyString ||
        hasError ||
        imageUrl == null) {
      return CircleAvatar(
        radius: radius - borderWidth,
        backgroundColor: ColorConstants.primaryColor,
        child: const Icon(
          EvaIcons.person,
          color: ColorConstants.iconColor,
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius - borderWidth,
        backgroundColor: ColorConstants.primaryColor,
        backgroundImage: imageProvider,
        onBackgroundImageError: (exception, stackTrace) => hasError = true,
      ),
    );
  }
}
