import '/library.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userFuture = ref.watch(userFutureProvider(Utils().userUid!));
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
      final String userName = userData[UserModel.nameKey];
      final String userRatID = userData[UserModel.ratIDKey];
      final String userProfileImage = userData[UserModel.imageKey] ?? '';
      final String? userBio = userData[UserModel.bioKey];
      final List userFollowers = userData[UserModel.followersKey] ?? [];
      final List userFollowing = userData[UserModel.followingKey] ?? [];
      final List userImages = userData[UserModel.imagesKey] ?? [];

      return Scaffold(
        appBar: AppBar(
          actions: [
            QmIconButton(
              onPressed: () => context.push(
                Routes.profileEditR,
                extra: {
                  'userProfileImage': userProfileImage,
                  'userName': userName,
                  'userBio': userBio ?? '',
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
              icon: EvaIcons.image,
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
                    imageUrl: userProfileImage,
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
                          text: userName,
                        ),
                        QmText(
                          text: userRatID,
                          isSeccoundary: true,
                        ),
                      ],
                    ),
                  ),
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
                        text: userFollowers.length.toString(),
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
                        text: userFollowing.length.toString(),
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
                text: userBio ?? S.of(context).LetPeopleKnow,
              ),
              const Divider(
                thickness: .5,
              ),
            ],
          ),
        ),
      );
    }
  }
}
