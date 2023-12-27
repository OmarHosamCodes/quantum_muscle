import '/library.dart';

final borderWidthStateProvider = StateProvider<double>((ref) => 2);

class QmAvatar extends ConsumerWidget {
  const QmAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.radius = 25.0,
    this.isNetworkImage = true,
  });
  final String? imageUrl;
  final void Function()? onTap;
  final double? radius;
  final bool isNetworkImage;

  String get imageURL => imageUrl ?? SimpleConstants.emptyString;
  ImageProvider get imageProvider => isNetworkImage
      ? CachedNetworkImageProvider(imageURL)
      : MemoryImage(base64Decode(imageURL)) as ImageProvider<Object>;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderWidth = ref.watch(borderWidthStateProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => ref.read(borderWidthStateProvider.notifier).state = 20,
      onExit: (_) => ref.read(borderWidthStateProvider.notifier).state = 2,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: SimpleConstants.fastAnimationDuration,
          height: radius! * 2,
          width: radius! * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConstants.primaryColor,
              width: borderWidth,
            ),
          ),
          child: ClipRect(
            clipper: const CustomRectClipper(),
            child: Image(
              image: isNetworkImage
                  ? CachedNetworkImageProvider(imageURL)
                  : MemoryImage(base64Decode(imageURL))
                      as ImageProvider<Object>,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const QmIconButton(
                  icon: EvaIcons.person,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: QmCircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRectClipper extends CustomClipper<Rect> {
  const CustomRectClipper();
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomRectClipper oldClipper) => false;
}
