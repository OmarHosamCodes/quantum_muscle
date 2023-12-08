import '/library.dart';

final isImageErrorStateProvider = Provider<bool>((ref) => false);

class QmAvatar extends ConsumerWidget {
  const QmAvatar({
    super.key,
    this.userImage,
    this.onTap,
    this.radius = 25.0,
  });
  final String? userImage;
  final void Function()? onTap;
  final double? radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageError = ref.watch(isImageErrorStateProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.precise,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: radius,
          backgroundImage: MemoryImage(base64Decode(userImage!)),
          onBackgroundImageError: (exception, stackTrace) {
            var _ = ref.read(isImageErrorStateProvider);
            _ = false;
          },
          child: isImageError ? const Icon(EvaIcons.person) : null,
        ),
      ),
    );
  }
}
