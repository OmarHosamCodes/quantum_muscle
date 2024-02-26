import 'package:quantum_muscle/library.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                ref.watch(localeProvider);
                final userWatcher = ref.watch(userProvider(utils.userUid!));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => Row(
                    children: [
                      QmShimmer.round(size: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QmShimmer.rectangle(
                              height: 30,
                              width: 100,
                            ),
                            const SizedBox(
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
                          final userWatcher =
                              ref.watch(userProvider(utils.userUid!));
                          return userWatcher.when(
                            error: (error, stackTrace) => Center(
                              child: QmText(text: S.current.DefaultError),
                            ),
                            loading: () => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QmShimmer.rectangle(
                                  width: 150,
                                  height: 300,
                                ),
                                QmShimmer.rectangle(
                                  width: 150,
                                  height: 300,
                                ),
                              ],
                            ),
                            data: (user) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Hero(
                                  tag: 'addImageHero',
                                  child: QmButton.icon(
                                    onPressed: () => context.push(
                                      Routes.profileEditR,
                                      extra: {UserModel.modelKey: user},
                                    ),
                                    icon: EvaIcons.editOutline,
                                  ),
                                ),
                                QmButton.icon(
                                  onPressed: () => context.pushNamed(
                                    Routes.addContentRootR,
                                    extra: {
                                      'indexToInsert': user.content.length,
                                    },
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
            const SizedBox(height: 5),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final userWatcher = ref.watch(userProvider(utils.userUid!));
                return userWatcher.when(
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.DefaultError),
                  ),
                  loading: () => Row(
                    children: [
                      QmShimmer.rectangle(width: 25, height: 30),
                      const SizedBox(
                        width: 5,
                      ),
                      QmShimmer.rectangle(width: 40, height: 30),
                      const SizedBox(
                        width: 5,
                      ),
                      QmShimmer.rectangle(width: 25, height: 30),
                      const SizedBox(
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
                final userWatcher = ref.watch(userProvider(utils.userUid!));
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
                final contentWatcher =
                    ref.watch(contentProvider(utils.userUid!));
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
                      return QmShimmer.rectangle(
                        width: 100,
                        height: 100,
                      );
                    },
                  ),
                  data: (contents) {
                    if (contents.isEmpty) {
                      return const Center(
                        child: QmText(text: 'No Content Found'),
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
                          ),
                          itemBuilder: (_, index) {
                            final content = contents[index];
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                Routes.contentRootR,
                                extra: {
                                  ContentModel.modelKey: contents,
                                  'indexKey': index,
                                  UserModel.idKey: utils.userUid!,
                                },
                              ),
                              child: QmBlock(
                                width: 100,
                                height: 100,
                                child: Hero(
                                  tag: content.id,
                                  child: ClipRRect(
                                    borderRadius: SimpleConstants.borderRadius,
                                    child: QmImage.network(
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
