import '/library.dart';

class RoutingDrawer extends ConsumerWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void changeIndex(int index) {
      ref.read(indexStateProvider.notifier).state = index;
      pageController.jumpToPage(
        index,
      );
      context.pop(context);
    }

    return Drawer(
        backgroundColor: ColorConstants.primaryColorDark,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(
                EvaIcons.homeOutline,
                color: ColorConstants.secondaryColor,
              ),
              title: QmText(
                text: S.of(context).Home,
              ),
              onTap: () {
                changeIndex(0);
              },
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.messageSquareOutline,
                color: ColorConstants.secondaryColor,
              ),
              title: QmText(
                text: S.of(context).Chat,
              ),
              onTap: () => changeIndex(1),
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.personOutline,
                color: ColorConstants.secondaryColor,
              ),
              title: QmText(
                text: S.of(context).Profile,
              ),
              onTap: () => changeIndex(2),
            ),
            Consumer(
              builder: (context, ref, child) {
                final locale = ref.watch(localStateProvider);
                return ListTile(
                  leading: const Icon(
                    EvaIcons.globe,
                    color: ColorConstants.secondaryColor,
                  ),
                  title: QmText(
                    text: S.of(context).Language,
                  ),
                  onTap: () => locale == const Locale('en')
                      ? ref.read(localStateProvider.notifier).state =
                          const Locale('ar')
                      : ref.read(localStateProvider.notifier).state =
                          const Locale('en'),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.logOutOutline,
                color: ColorConstants.secondaryColor,
              ),
              title: QmText(
                text: S.of(context).Logout,
              ),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ));
  }
}
