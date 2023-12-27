import '/library.dart';

class SearchedProfile extends ConsumerWidget {
  const SearchedProfile({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final String userURI =
        GoRouterState.of(context).uri.toString().split('/profile/')[1];
    return Scaffold(
      extendBody: true,
      body: FutureBuilder(
        future: ref.watch(userFutureProvider(userId).future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: QmCircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: QmText(text: S.current.DefaultError),
            );
          }
          final data = snapshot.data!;
          final userData = data.data() as Map<String, dynamic>;
          final String userName = userData[UserModel.nameKey];
          final String userRatID = userData[UserModel.ratIDKey];
          final String userProfileImage = userData[UserModel.profileImageKey] ??
              SimpleConstants.emptyString;
          final String userBio = userData[UserModel.bioKey] ?? S.current.NoBio;
          final List userFollowers = userData[UserModel.followersKey];
          final List userFollowing = userData[UserModel.followingKey];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                      Visibility(
                        visible: userURI !=
                            (Utils().userUid ?? SimpleConstants.emptyString),
                        child: FollowAndMessageButton(
                          userId: userURI,
                          height: height,
                          width: width,
                          isFollowing: userFollowers.any((element) =>
                              element ==
                              (Utils().userUid ?? SimpleConstants.emptyString)),
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
                            text: userFollowing.length.toString(),
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
                    text: userBio,
                  ),
                  const Divider(
                    thickness: 1,
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
