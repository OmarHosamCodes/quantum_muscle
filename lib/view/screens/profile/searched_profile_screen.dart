import 'package:quantum_muscle/library.dart';

/// Screen to show the profile of a searched user.
class SearchedProfileScreen extends StatelessWidget {
  /// const constructor for the [SearchedProfileScreen]
  const SearchedProfileScreen({required this.userId, super.key});

  /// user id
  final String userId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            EvaIcons.arrowBack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                ref.watch(localeProvider);
                final userWatcher = ref.watch(userProvider(userId));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Row(
                    children: [
                      QmShimmer.round(size: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QmShimmer.rectangle(
                              height: 30,
                              width: 100,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            QmShimmer.rectangle(
                              height: 30,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QmText(
                              text: user.name,
                            ),
                            Row(
                              children: [
                                QmText(
                                  text: '#${user.id.substring(0, 8)}...',
                                  isSeccoundary: true,
                                ),
                                QmButton.icon(
                                  onPressed: () => utils.copyToClipboard(
                                    text: user.id,
                                  ),
                                  icon: EvaIcons.copyOutline,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Consumer(
                        builder: (_, WidgetRef ref, __) {
                          final userWatcher = ref.watch(userProvider(userId));
                          return userWatcher.when(
                            error: (error, stackTrace) => Center(
                              child: QmText(text: S.current.DefaultError),
                            ),
                            loading: () => const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QmShimmer.rectangle(
                                  width: 150,
                                  height: 50,
                                ),
                                QmShimmer.rectangle(
                                  width: 150,
                                  height: 50,
                                ),
                              ],
                            ),
                            data: (data) => Visibility(
                              visible: userId !=
                                  (utils.userUid ??
                                      SimpleConstants.emptyString),
                              child: FollowAndMessageButton(
                                userId: userId,
                                height: height,
                                width: width,
                                isFollowing: data.followers.any(
                                  (element) =>
                                      element ==
                                      (utils.userUid ??
                                          SimpleConstants.emptyString),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final userWatcher = ref.watch(userProvider(userId));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => const Row(
                    children: [
                      QmShimmer.rectangle(width: 25, height: 30),
                      SizedBox(
                        width: 5,
                      ),
                      QmShimmer.rectangle(width: 40, height: 30),
                      SizedBox(
                        width: 5,
                      ),
                      QmShimmer.rectangle(width: 25, height: 30),
                      SizedBox(
                        width: 5,
                      ),
                      QmShimmer.rectangle(width: 40, height: 30),
                    ],
                  ),
                  data: (user) => Row(
                    children: [
                      QmText(
                        text: user.followers.length.toString(),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      QmText(
                        text: S.current.Followers,
                        isSeccoundary: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      QmText(
                        text: user.following.length.toString(),
                      ),
                      const SizedBox(
                        width: 5,
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
            const SizedBox(height: 5),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final userWatcher = ref.watch(userProvider(userId));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => QmShimmer.rectangle(
                    width: width * .5,
                    height: 50,
                  ),
                  data: (user) => QmText(
                    text: user.bio == SimpleConstants.emptyString
                        ? S.current.LetPeopleKnow
                        : user.bio,
                  ),
                );
              },
            ),
            const QmDivider(),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final contentWatcher = ref.watch(contentProvider(userId));
                return contentWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      return const QmShimmer.rectangle(
                        width: 100,
                        height: 100,
                      );
                    },
                  ),
                  data: (contents) {
                    if (contents.isEmpty) {
                      return const Center();
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
                          ),
                          itemBuilder: (_, index) {
                            final content = contents[index];
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                Routes.contentRootR,
                                extra: {
                                  ContentModel.modelKey: contents,
                                  'indexKey': index,
                                  UserModel.idKey: userId,
                                },
                              ),
                              child: QmBlock(
                                width: 100,
                                height: 100,
                                child: Hero(
                                  tag: content.id,
                                  child: ClipRRect(
                                    borderRadius: SimpleConstants.borderRadius,
                                    child: QmImage.smart(
                                      source: content.contentURL,
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
