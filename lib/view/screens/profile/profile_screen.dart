import '/library.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userFuture = ref.watch(userFutureProvider);
    final userQuery = userFuture.whenOrNull(
      data: (data) {
        if (data.data() != null) {
          return data;
        } else {
          return ProviderStatus.none;
        }
      },
      loading: () => ProviderStatus.loading,
      error: (e, s) => ProviderStatus.error,
    );
    if (userQuery == ProviderStatus.loading) {
      return const Center(
        child: QmCircularProgressIndicator(),
      );
    } else if (userQuery == ProviderStatus.error) {
      return Center(
        child: QmText(text: S.of(context).DefaultError),
      );
    } else {
      var data = userFuture.value as DocumentSnapshot;
      var userData = data.data() as Map<String, dynamic>;
      var userProfileImage = userData['image'] ?? '';
      var userName = userData['name'];
      var userBio = userData['bio'] ?? S.of(context).LetPeopleKnow;
      var userFollowers = userData['followers'] ?? "0";
      var userFollowing = userData['following'] ?? "0";
      var userRatID = userData['ratID'];
      var userImages = userData['images'] ?? [];

      return Scaffold(
        floatingActionButton: _CustomFloatingActionButton(
          userProfileImage: userProfileImage,
          userName: userName,
          userBio: userBio,
          userImages: userImages,
          ref: ref,
        ),
        appBar: AppBar(
          actions: [
            QmIconButton(
              onPressed: () => context.push(
                Routes.profileEditR,
                extra: {
                  'userProfileImage': userProfileImage,
                  'userName': userName,
                  'userBio': userBio,
                },
              ),
              icon: EvaIcons.editOutline,
            ),
            QmIconButton(
              onPressed: () => lunchAddImageWidget(
                context: context,
                ref: ref,
                indexToInsert: userImages.length,
              ),
              icon: EvaIcons.moreVerticalOutline,
            )
          ],
        ),
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  QmAvatar(
                    userImage: userProfileImage,
                    radius: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QmText(
                          text: userName!,
                        ),
                        QmText(
                          text: userRatID,
                          isSeccoundary: true,
                        ),
                      ],
                    ),
                  ),
                  // Visibility(
                  //   visible: id != Utils().userRatID,
                  //   child: Expanded(
                  //     child: QmBlock(
                  //       onTap: () {},
                  //       width: double.maxFinite,
                  //       height: height * .07,
                  //       child: QmText(
                  //         text: S.of(context).Follow,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QmText(
                        text: userFollowers,
                      ),
                      SizedBox(
                        width: width * .005,
                      ),
                      QmText(
                        text: S.of(context).Followers,
                        isSeccoundary: true,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .005,
                      ),
                      QmText(
                        text: userFollowing,
                      ),
                      SizedBox(
                        width: width * .005,
                      ),
                      QmText(
                        text: S.of(context).Following,
                        isSeccoundary: true,
                      ),
                    ],
                  ),
                ],
              ),
              QmText(
                text: userBio,
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _CustomFloatingActionButton extends StatefulWidget {
  const _CustomFloatingActionButton({
    required this.userProfileImage,
    required this.userName,
    required this.userBio,
    required this.userImages,
    required this.ref,
  });
  final String userProfileImage;
  final String userName;
  final String userBio;
  final List userImages;
  final WidgetRef ref;
  @override
  State<_CustomFloatingActionButton> createState() =>
      __CustomFloatingActionButtonState();
}

class __CustomFloatingActionButtonState
    extends State<_CustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),
      iconColor: ColorConstants.secondaryColor,
      backGroundColor: ColorConstants.primaryColorDark,
      animation: _animation,
      animatedIconData: AnimatedIcons.menu_close,
      items: [
        Bubble(
          title: S.of(context).EditProfile,
          iconColor: ColorConstants.secondaryColor,
          bubbleColor: ColorConstants.primaryColor,
          icon: EvaIcons.edit,
          titleStyle: const TextStyle(
            fontSize: 16,
            color: ColorConstants.secondaryColor,
          ),
          onPress: () {
            context.push(
              Routes.profileEditR,
              extra: {
                'userProfileImage': widget.userProfileImage,
                'userName': widget.userName,
                'userBio': widget.userBio,
              },
            );
          },
        ),
        Bubble(
          title: S.of(context).AddImage,
          icon: EvaIcons.image,
          iconColor: ColorConstants.secondaryColor,
          bubbleColor: ColorConstants.primaryColor,
          titleStyle: const TextStyle(
            fontSize: 16,
            color: ColorConstants.secondaryColor,
          ),
          onPress: () => lunchAddImageWidget(
            context: context,
            ref: widget.ref,
            indexToInsert: widget.userImages.length,
          ),
        ),
      ],
    );
  }
}
