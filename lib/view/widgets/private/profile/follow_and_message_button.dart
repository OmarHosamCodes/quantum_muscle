import 'package:quantum_muscle/library.dart';

/// A widget that displays follow and message buttons for a user's profile.
class FollowAndMessageButton extends ConsumerWidget {
  /// Constructs a [FollowAndMessageButton].
  ///
  /// The [userId] is the ID of the user.
  /// The [height] and [width] specify the dimensions of the button.
  /// The [isFollowing] indicates whether the user is currently being followed.
  const FollowAndMessageButton({
    required this.userId,
    required this.height,
    required this.isFollowing,
    required this.width,
    super.key,
  });

  /// The ID of the user.
  final String userId;

  /// The height of the button.
  final double height;

  /// The width of the button.
  final double width;

  /// Indicates whether the user is currently being followed.
  final bool isFollowing;

  /// Returns the bottom border radius of the container.
  ///
  /// If [isFollowing] is `true`, the radius is set to zero.
  /// Otherwise, it is set to a circular radius of 10.
  Radius get containerBottomBorderRadius =>
      isFollowing ? Radius.zero : const Radius.circular(10);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QmBlock(
          onTap: () => profileUtil.followOrUnFollow(
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
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: isFollowing,
          child: QmBlock(
            onTap: () => chatUtil.startChat(
              userId: userId,
              context: context,
              // ref: ref,
            ),
            color: ColorConstants.accentColor,
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
        ),
      ],
    );
  }
}
