import '../../library.dart';

final isImageErrorStateProvider = StateProvider<bool>((ref) => false);

class QmAvatar extends ConsumerWidget {
  const QmAvatar(this.userImage, {super.key});
  final String userImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageError = ref.watch(isImageErrorStateProvider);
    return CircleAvatar(
      radius: 25,
      backgroundImage: CachedNetworkImageProvider(userImage),
      onBackgroundImageError: (exception, stackTrace) {
        ref.read(isImageErrorStateProvider.notifier).state = true;
      },
      child: isImageError ? const Icon(EvaIcons.person) : null,
    );
  }
}
