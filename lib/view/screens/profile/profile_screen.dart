import '/library.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                ref.watch(localeProvider);
                final userWatcher = ref.watch(userProvider(Utils().userUid!));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  data: (user) => Row(
                    children: [
                      QmAvatar(
                        imageUrl: user.profileImageURL,
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
                              text: user.name,
                            ),
                            Row(
                              children: [
                                QmText(
                                  text: "#${user.id.substring(0, 8)}...",
                                  isSeccoundary: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                QmIconButton(
                                  onPressed: () => Utils().copyToClipboard(
                                    text: user.id,
                                  ),
                                  icon: EvaIcons.copyOutline,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Consumer(
                        builder: (_, WidgetRef ref, __) {
                          final userWatcher =
                              ref.watch(userProvider(Utils().userUid!));
                          return userWatcher.when(
                            error: (error, stackTrace) => Center(
                              child: QmText(text: S.current.DefaultError),
                            ),
                            loading: () => const Center(
                              child: QmCircularProgressIndicator(),
                            ),
                            data: (user) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                QmIconButton(
                                  onPressed: () => context.push(
                                    Routes.profileEditR,
                                    extra: {UserModel.modelKey: user},
                                  ),
                                  icon: EvaIcons.editOutline,
                                ),
                                QmIconButton(
                                  onPressed: () => openAddImage(
                                    context: context,
                                    ref: ref,
                                    indexToInsert: user.content.length,
                                  ),
                                  icon: EvaIcons.image,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: height * .01,
            ),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final userWatcher = ref.watch(userProvider(Utils().userUid!));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  data: (user) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QmText(
                        text: user.followers.length.toString(),
                      ),
                      SizedBox(
                        width: width * .005,
                      ),
                      QmText(
                        text: S.current.Followers,
                        isSeccoundary: true,
                      ),
                      SizedBox(
                        width: width * .005,
                      ),
                      QmText(
                        text: user.following.length.toString(),
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
                );
              },
            ),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final userWatcher = ref.watch(userProvider(Utils().userUid!));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  data: (user) => QmText(
                    text: user.bio == SimpleConstants.emptyString
                        ? S.current.LetPeopleKnow
                        : user.bio,
                  ),
                );
              },
            ),
            const Divider(
              thickness: .5,
            ),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final contentWatcher =
                    ref.watch(contentProvider(Utils().userUid!));
                return contentWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  data: (contents) {
                    if (contents.isEmpty) {
                      return const Center(
                        child: QmText(text: "No Content Found"),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: height * .01,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contents.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.0, // .5 for vertical
                          ),
                          itemBuilder: (_, index) {
                            final content = contents[index];
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                Routes.contentRootR,
                                extra: {
                                  ContentModel.modelKey: contents,
                                  "indexKey": index,
                                  UserModel.idKey: Utils().userUid!,
                                },
                              ),
                              child: QmBlock(
                                width: 100,
                                height: 100,
                                child: Hero(
                                  tag: content.id,
                                  child: ClipRRect(
                                    borderRadius: SimpleConstants.borderRadius,
                                    child: QmImageNetwork(
                                      source: content.contentURL,
                                      fallbackIcon:
                                          EvaIcons.alertTriangleOutline,
                                      fit: BoxFit.cover,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
