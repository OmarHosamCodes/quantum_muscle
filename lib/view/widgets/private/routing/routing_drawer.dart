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
            _buildListTile(
              icon: EvaIcons.homeOutline,
              title: S.current.Home,
              onTap: () =>
                  routingController.changeDrawerRoute(Routes.homeR, context),
            ),
            _buildListTile(
              icon: EvaIcons.messageSquareOutline,
              title: S.current.Chat,
              onTap: () =>
                  routingController.changeDrawerRoute(Routes.chatR, context),
            ),
            _buildListTile(
              icon: EvaIcons.personOutline,
              title: S.current.Profile,
              onTap: () =>
                  routingController.changeDrawerRoute(Routes.profileR, context),
            ),
            _buildListTile(
              icon: EvaIcons.searchOutline,
              title: S.current.Search,
              onTap: () =>
                  routingController.changeDrawerRoute(Routes.searchR, context),
            ),
            _buildListTile(
              icon: EvaIcons.gridOutline,
              title: S.current.Programs,
              onTap: () => routingController.changeDrawerRoute(
                Routes.programsR,
                context,
              ),
            ),
            const Spacer(),
            Consumer(
              builder: (context, ref, child) {
                return _buildListTile(
                  icon: EvaIcons.globe,
                  title: S.current.Language,
                  onTap: () => ref.read(localeProvider.notifier).toggleLocale(),
                );
              },
            ),
            _buildListTile(
              icon: EvaIcons.logOutOutline,
              title: S.current.Logout,
              onTap: () => logoutUtil.logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: ColorConstants.iconColor,
      ),
      title: QmText(
        text: title,
      ),
      onTap: onTap,
    );
  }
}
