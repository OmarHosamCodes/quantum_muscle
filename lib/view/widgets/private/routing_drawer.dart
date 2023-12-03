import '/library.dart';

class RoutingDrawer extends ConsumerWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void changeRoute(int index) {
      switch (index) {
        case 0:
          pageViewController.jumpToPage(0);
          break;
        case 1:
          pageViewController.jumpToPage(1);
          break;
        case 2:
          pageViewController.jumpToPage(2);
          break;
      }
    }

    return Drawer(
      backgroundColor: ColorConstants.primaryColorDark,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              EvaIcons.homeOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QmText(
              text: S.of(context).Home,
            ),
            onTap: () => changeRoute(0),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.messageSquareOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QmText(
              text: S.of(context).Chat,
            ),
            onTap: () => changeRoute(1),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.personOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QmText(
              text: S.of(context).Profile,
            ),
            onTap: () => changeRoute(2),
          ),
          const Spacer(),
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
      ),
    );
  }
}
