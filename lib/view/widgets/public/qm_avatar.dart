import '/library.dart';

final isImageErrorStateProvider = Provider<bool>((ref) => false);

class QmAvatar extends ConsumerWidget {
  const QmAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.radius = 25.0,
  });
  final String? imageUrl;
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
          backgroundImage: MemoryImage(base64Decode(imageUrl!)),
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
