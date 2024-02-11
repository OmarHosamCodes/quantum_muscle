import 'package:quantum_muscle/library.dart';

class FollowAndMessageButton extends ConsumerWidget {
  const FollowAndMessageButton({
    required this.userId,
    required this.height,
    required this.isFollowing,
    required this.width,
    super.key,
  });

  final String userId;
  final double height;
  final double width;
  final bool isFollowing;
  Radius get containerBottomBorderRadius =>
      isFollowing ? Radius.zero : const Radius.circular(10);
  String get followText => isFollowing ? S.current.Unfollow : S.current.Follow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QmBlock(
          isAnimated: true,
          onTap: () => ProfileUtil().followOrUnFollow(
            userId: userId,
            context: context,
            ref: ref,
            isFollowing: isFollowing,
          ),
          color: isFollowing
              ? ColorConstants.disabledColor
              : ColorConstants.primaryColor,
          width: 40,
          height: 40,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
            bottomLeft: containerBottomBorderRadius,
            bottomRight: containerBottomBorderRadius,
          ),
          child: Icon(
            isFollowing
                ? EvaIcons.personDeleteOutline
                : EvaIcons.personAddOutline,
            color: ColorConstants.iconColor,
          ),
        ).animate().fade(duration: SimpleConstants.slowAnimationDuration),
        const SizedBox(height: 10),
        Visibility(
          visible: isFollowing,
          child: QmBlock(
            isAnimated: true,
            onTap: () => ChatUtil().startChat(
              userId: userId,
              context: context,
              ref: ref,
            ),
            color: ColorConstants.secondaryColor,
            width: 40,
            height: 40,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: const Icon(
              EvaIcons.messageSquareOutline,
              color: ColorConstants.iconColor,
            ),
          ),
        ).animate().fade(duration: SimpleConstants.slowAnimationDuration),
      ],
    );
  }
}
