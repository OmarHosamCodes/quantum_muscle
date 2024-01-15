import '/library.dart';

class QmAvatar extends StatelessWidget {
  const QmAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.radius = 25.0,
    this.isNetworkImage = true,
  });
  final String? imageUrl;
  final void Function()? onTap;
  final double radius;
  final bool isNetworkImage;

  String? get imageURL => imageUrl;
  ImageProvider get imageProvider => isNetworkImage
      ? CachedNetworkImageProvider(imageURL!)
      : MemoryImage(base64Decode(imageURL!)) as ImageProvider<Object>;

  bool get hasError => false;
  set hasError(bool value) {
    hasError = value;
  }

  @override
  Widget build(BuildContext context) {
    const borderWidth = 5;
    if (imageUrl == SimpleConstants.emptyString || hasError) {
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
