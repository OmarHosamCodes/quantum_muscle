import '../../library.dart';

final isImageErrorStateProvider = StateProvider<bool>((ref) => false);

class QmAvatar extends ConsumerWidget {
  const QmAvatar({super.key, this.userImage, this.onTap});
  final String? userImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageError = ref.watch(isImageErrorStateProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.precise,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 25,
          backgroundImage: MemoryImage(base64Decode(userImage!)),
          onBackgroundImageError: (exception, stackTrace) {
            ref.read(isImageErrorStateProvider.notifier).state = true;
          },
          child: isImageError ? const Icon(EvaIcons.person) : null,
        ),
      ),
    );
  }
}
