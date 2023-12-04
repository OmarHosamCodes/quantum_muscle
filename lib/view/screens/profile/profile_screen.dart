// ignore_for_file: must_be_immutable

import '../../../library.dart';

final userImagesFutureProvider = FutureProvider<QuerySnapshot<UserImageModel>>(
  (ref) async => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DBPathsConstants.usersUserImgs)
      .withConverter(
        fromFirestore: UserImageModel.fromMap,
        toFirestore: (userImages, _) => userImages.toMap(),
      )
      .get(),
);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    return Scaffold(
      extendBody: true,
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final userFuture = ref.watch(userFutureProvider);
                final userQuery = userFuture.whenOrNull(
                  data: (data) {
                    if (data.exists) {
                      return FutureStatus.data;
                    } else {
                      return FutureStatus.error;
                    }
                  },
                  loading: () => FutureStatus.loading,
                  error: (e, s) => FutureStatus.error,
                );
                if (userQuery == FutureStatus.data) {
                  final data = userFuture.value as DocumentSnapshot;
                  final userData = data.data() as Map<String, dynamic>;
                  final userProfileImage = userData['image'] ?? '';
                  final userName = userData['name'];
                  final userBio =
                      userData['bio'] ?? S.of(context).LetPeopleKnow;
                  final userFollowers = userData['followers'] ?? "0";
                  final userFollowing = userData['following'] ?? "0";
                  final userLikes = userData['likes'] ?? "0";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          QmAvatar(
                            userImage: userProfileImage,
                          ),
                          Column(
                            children: [
                              QmText(text: userFollowers),
                              QmText(
                                text: S.of(context).Followers,
                                isSeccoundary: true,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QmText(text: userFollowing),
                              QmText(
                                text: S.of(context).Following,
                                isSeccoundary: true,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              QmText(text: userLikes),
                              QmText(
                                text: S.of(context).Likes,
                                isSeccoundary: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .05,
                        ),
                        child: QmText(
                          text: userName,
                          isSeccoundary: true,
                        ),
                      ),
                      SizedBox(height: height * .01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .05,
                        ),
                        child: SizedBox(
                          height: height * .3,
                          width: width * .8,
                          child: QmText(text: userBio),
                        ),
                      ),
                    ],
                  );
                } else if (userQuery == FutureStatus.error) {
                  return Center(
                    child: QmText(text: S.of(context).DefaultError),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final userImagesFuture = ref.watch(userImagesFutureProvider);
                final userImagesQuery = userImagesFuture.whenOrNull(
                  data: (data) {
                    if (data.docs.isEmpty) {
                      return data;
                    } else {
                      return FutureStatus.none;
                    }
                  },
                  loading: () => FutureStatus.loading,
                  error: (e, s) => FutureStatus.error,
                );
                if (userImagesQuery == FutureStatus.error ||
                    userImagesQuery == FutureStatus.none) {
                  return Center(
                    child: QmText(
                      text: S.of(context).DefaultError,
                      maxWidth: width * .7,
                    ),
                  );
                } else if (userImagesQuery == FutureStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data =
                      userImagesFuture.value as QuerySnapshot<UserImageModel>;

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .05,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop() ? 4 : 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1,
                    ),
                    itemCount: data.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final imageEncoded = data.docs[index].data().imageEncoded;
                      final image = base64Decode(imageEncoded);
                      final title = data.docs[index].data().title;
                      final description = data.docs[index].data().description;
                      final createdAt = data.docs[index].data().createdAt;
                      return Container(
                        color: ColorConstants.primaryColor,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image(
                                image: MemoryImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: height * .01),
                            QmText(text: title),
                            SizedBox(height: height * .01),
                            QmText(text: description),
                            SizedBox(height: height * .01),
                            QmText(text: createdAt),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
