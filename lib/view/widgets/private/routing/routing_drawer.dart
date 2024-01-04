// ignore_for_file: file_names

import '/library.dart';

class RoutingDrawer extends ConsumerWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routingController = RoutingController.instants;
    return Drawer(
      backgroundColor: ColorConstants.disabledColor,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              EvaIcons.homeOutline,
              color: ColorConstants.iconColor,
            ),
            title: QmText(
              text: S.current.Home,
            ),
            onTap: () => routingController.changeDrawerRoute(0, context),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.messageSquareOutline,
              color: ColorConstants.iconColor,
            ),
            title: QmText(
              text: S.current.Chat,
            ),
            onTap: () => routingController.changeDrawerRoute(1, context),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.personOutline,
              color: ColorConstants.iconColor,
            ),
            title: QmText(
              text: S.current.Profile,
            ),
            onTap: () => routingController.changeDrawerRoute(2, context),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.searchOutline,
              color: ColorConstants.iconColor,
            ),
            title: QmText(
              text: S.current.Search,
            ),
            onTap: () => routingController.changeDrawerRoute(3, context),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.archive,
              color: ColorConstants.iconColor,
            ),
            title: QmText(
              text: S.current.Programs,
            ),
            onTap: () => routingController.changeDrawerRoute(4, context),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              return ListTile(
                leading: const Icon(
                  EvaIcons.globe,
                  color: ColorConstants.primaryColor,
                ),
                title: QmText(
                  text: S.current.Language,
                ),
                onTap: () {
                  context.pop();
                  Utils().isEnglish
                      ? ref.read(localeStateProvider.notifier).state =
                          const Locale(SimpleConstants.arabicLocale)
                      : ref.read(localeStateProvider.notifier).state =
                          const Locale(SimpleConstants.englishLocale);
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.logOutOutline,
              color: ColorConstants.logoutColor,
            ),
            title: QmText(
              text: S.current.Logout,
            ),
            onTap: () {
              LogoutUtil().logout(context);
            },
          ),
        ],
      ),
    );
  }
}
