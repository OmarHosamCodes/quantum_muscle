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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                  ? ColorConstants.primaryColorDisabled
                  : ColorConstants.primaryColor,
              width: double.maxFinite,
              height: height * .075,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: isFollowing
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                bottomRight: isFollowing
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
              ),
              child: QmText(
                text:
                    isFollowing ? S.of(context).Unfollow : S.of(context).Follow,
              ),
            ).animate().fade(duration: const Duration(milliseconds: 350)),
            const SizedBox(height: 10),
            Visibility(
              visible: isFollowing,
              child: QmBlock(
                isAnimated: true,
                onTap: () => ChatUtil().startChat(
                  userId: userId,
                  context: context,
                ),
                color: ColorConstants.tertiaryColor,
                width: double.maxFinite,
                height: height * .075,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: QmText(
                  text: S.of(context).Message,
                ),
              ),
            ).animate().fade(duration: const Duration(milliseconds: 350)),
          ],
        ),
      ),
    );
  }
}
