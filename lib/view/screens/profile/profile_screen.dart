import 'package:quantum_muscle/models/user_image_model.dart';

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
      appBar: AppBar(
        title: QmText(text: S.of(context).Profile),
      ),
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
                  final userImage = userData['image'] ?? '';
                  final userName = userData['name'] ?? '';
                  final userBio = userData['bio'] ?? '';
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
                            userImage,
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
                    if (data.docs.isNotEmpty) {
                      return FutureStatus.data;
                    } else {
                      return FutureStatus.error;
                    }
                  },
                  loading: () => FutureStatus.loading,
                  error: (e, s) => FutureStatus.error,
                );
                if (userImagesQuery == FutureStatus.data) {
                  final data = userImagesFuture.value as QuerySnapshot;
                  final userImages =
                      data.docs.map((e) => e.data() as UserImageModel).toList();

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
                    itemCount: userImages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final image = userImages[index].image ?? '';
                      final title = userImages[index].title ?? 'title';
                      final description =
                          userImages[index].description ?? 'description';
                      final createdAt =
                          userImages[index].createdAt ?? '11/27/2023';
                      return Container(
                        color: ColorConstants.primaryColor,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                image,
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
                } else if (userImagesQuery == FutureStatus.error) {
                  return Center(
                    child: QmText(
                      text: S.of(context).DefaultError,
                      maxWidth: width * .7,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // GridView.builder(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: width * .05,
            //   ),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: isDesktop() ? 4 : 3,
            //     mainAxisSpacing: 0,
            //     crossAxisSpacing: 0,
            //     childAspectRatio: 1,
            //   ),
            //   itemCount: 100,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     return Container(
            //       color: ColorConstants.primaryColor,
            //       child: const Center(),
            //     ).animate().fade();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
