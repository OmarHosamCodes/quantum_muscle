import '/library.dart';

class FollowAndMessageButton extends ConsumerWidget {
  const FollowAndMessageButton({
    super.key,
    required this.userId,
    required this.height,
    required this.isFollowing,
    required this.width,
  });

  final String userId;
  final double height;
  final double width;
  final bool isFollowing;
  Radius get containerBottomBorderRadius =>
      isFollowing ? const Radius.circular(0) : const Radius.circular(10);
  get followText => isFollowing ? S.current.Unfollow : S.current.Follow;
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
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: const Icon(
                EvaIcons.messageSquareOutline,
                color: ColorConstants.iconColor,
              )),
        ).animate().fade(duration: SimpleConstants.slowAnimationDuration),
      ],
    );
  }
}
