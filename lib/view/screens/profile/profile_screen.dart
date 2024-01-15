import '/library.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userFuture = ref.watch(userProvider(Utils().userUid!));
    return Scaffold(
      body: userFuture.when(
        error: (error, stackTrace) => Center(
          child: QmText(text: error.toString()),
        ),
        loading: () => const Center(
          child: QmCircularProgressIndicator(),
        ),
        data: (data) {
          return Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      QmAvatar(
                        imageUrl: data.profileImage,
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
                              text: data.name,
                            ),
                            Row(
                              children: [
                                QmText(
                                  text: "#${data.id}",
                                  isSeccoundary: true,
                                ),
                                QmIconButton(
                                  onPressed: () => Utils().copyToClipboard(
                                    text: data.id,
                                  ),
                                  icon: EvaIcons.copyOutline,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          QmIconButton(
                            onPressed: () => context.push(
                              Routes.profileEditR,
                              extra: {UserModel.modelKey: data},
                            ),
                            icon: EvaIcons.editOutline,
                          ),
                          QmIconButton(
                            onPressed: () => lunchAddImageWidget(
                              context: context,
                              ref: ref,
                              indexToInsert: data.images.length,
                            ),
                            icon: EvaIcons.image,
                          ),
                        ],
                      )
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
                            text: data.followers.length.toString(),
                          ),
                          SizedBox(
                            width: width * .005,
                          ),
                          QmText(
                            text: S.current.Followers,
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
                            text: data.following.length.toString(),
                          ),
                          SizedBox(
                            width: width * .005,
                          ),
                          QmText(
                            text: S.current.Following,
                            isSeccoundary: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  QmText(
                    text: data.bio == SimpleConstants.emptyString
                        ? S.current.LetPeopleKnow
                        : data.bio,
                  ),
                  const Divider(
                    thickness: .5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
