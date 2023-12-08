// ignore_for_file: file_names

import '/library.dart';

class RoutingDrawer extends ConsumerWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onTap: () => RoutingController().changeRoute(0),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.messageSquareOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QmText(
              text: S.of(context).Chat,
            ),
            onTap: () => RoutingController().changeRoute(1),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.personOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QmText(
              text: S.of(context).Profile,
            ),
            onTap: () => RoutingController().changeRoute(2),
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
            onTap: () {
              LogoutUtil()
                  .logout(context)
                  .then((value) => RoutingController().changeRoute(3));
            },
          ),
        ],
      ),
    ).animate().slideX(
          begin: Utils().isEnglish ? -1 : 1,
          end: 0,
          duration: const Duration(milliseconds: 500),
        );
  }
}
