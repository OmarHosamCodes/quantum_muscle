import 'package:quantum_muscle/library.dart';

class RoutingDrawer extends StatelessWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final routingController = RoutingController();
    return Drawer(
      backgroundColor: ColorConstants.backgroundColor,
      child: SafeArea(
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
              onTap: () => routingController.changeDrawerRoute(
                Routes.homeR,
                context,
              ),
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.messageSquareOutline,
                color: ColorConstants.iconColor,
              ),
              title: QmText(
                text: S.current.Chat,
              ),
              onTap: () => routingController.changeDrawerRoute(
                Routes.chatR,
                context,
              ),
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.personOutline,
                color: ColorConstants.iconColor,
              ),
              title: QmText(
                text: S.current.Profile,
              ),
              onTap: () => routingController.changeDrawerRoute(
                Routes.profileR,
                context,
              ),
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.searchOutline,
                color: ColorConstants.iconColor,
              ),
              title: QmText(
                text: S.current.Search,
              ),
              onTap: () => routingController.changeDrawerRoute(
                Routes.searchR,
                context,
              ),
            ),
            ListTile(
              leading: const Icon(
                EvaIcons.gridOutline,
                color: ColorConstants.iconColor,
              ),
              title: QmText(
                text: S.current.Programs,
              ),
              onTap: () => routingController.changeDrawerRoute(
                Routes.programsR,
                context,
              ),
            ),
            const Spacer(),
            Consumer(
              builder: (context, ref, child) {
                return ListTile(
                  leading: const Icon(
                    EvaIcons.globe,
                    color: ColorConstants.iconColor,
                  ),
                  title: QmText(
                    text: S.current.Language,
                  ),
                  onTap: () => ref.read(localeProvider.notifier).toggleLocale(),
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
                logoutUtil.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
