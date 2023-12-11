import '/library.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({
    super.key,
    required this.userId,
    required this.height,
    required this.isFollowing,
  });

  final String userId;
  final double height;
  final bool isFollowing;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowingTemp;
  @override
  void initState() {
    super.initState();
    isFollowingTemp = !widget.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QmBlock(
        isAnimated: true,
        onTap: () {
          setState(() {
            isFollowingTemp = !isFollowingTemp;
          });
        },
        color: isFollowingTemp
            ? ColorConstants.primaryColor
            : ColorConstants.primaryColorDisabled,
        width: double.maxFinite,
        height: widget.height * .07,
        child: QmText(
          text: isFollowingTemp ? S.of(context).Follow : S.of(context).Unfollow,
        ),
      ),
    );
  }
}
