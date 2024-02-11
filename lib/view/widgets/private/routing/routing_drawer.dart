import 'package:quantum_muscle/library.dart';

class RoutingDrawer extends StatelessWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final routingController = RoutingController();
    final locale = Intl.getCurrentLocale();
    return Drawer(
      backgroundColor: ColorConstants.secondaryColor,
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
                    color: ColorConstants.iconColor,
                  ),
                  title: QmText(
                    text: S.current.Language,
                  ),
                  onTap: () {
                    context.pop();
                    locale == SimpleConstants.englishLocale
                        ? ref.read(localeProvider.notifier).state =
                            const Locale(SimpleConstants.arabicLocale)
                        : ref.read(localeProvider.notifier).state =
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
      ),
    );
  }
}
