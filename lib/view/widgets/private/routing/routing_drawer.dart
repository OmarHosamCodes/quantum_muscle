// ignore_for_file: file_names

import '/library.dart';

class RoutingDrawer extends ConsumerWidget {
  const RoutingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: ColorConstants.disabledColor,
      child: Column(
        children: [
          ListTile(
            leading: const QmIconButton(
              icon: EvaIcons.homeOutline,
            ),
            title: QmText(
              text: S.current.Home,
            ),
            onTap: () => RoutingController().changeRoute(0, context),
          ),
          ListTile(
            leading: const QmIconButton(
              icon: EvaIcons.messageSquareOutline,
            ),
            title: QmText(
              text: S.current.Chat,
            ),
            onTap: () => RoutingController().changeRoute(1, context),
          ),
          ListTile(
            leading: const QmIconButton(
              icon: EvaIcons.personOutline,
            ),
            title: QmText(
              text: S.current.Profile,
            ),
            onTap: () => RoutingController().changeRoute(2, context),
          ),
          ListTile(
            leading: const QmIconButton(
              icon: EvaIcons.searchOutline,
            ),
            title: QmText(
              text: S.current.Search,
            ),
            onTap: () => RoutingController().changeRoute(3, context),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              final locale = ref.watch(localeStateProvider);
              return ListTile(
                leading: const QmIconButton(
                  icon: EvaIcons.globe,
                ),
                title: QmText(
                  text: S.current.Language,
                ),
                onTap: () {
                  context.pop();
                  locale == const Locale(SimpleConstants.englishLocale)
                      ? ref.read(localeStateProvider.notifier).state =
                          const Locale(SimpleConstants.arabicLocale)
                      : ref.read(localeStateProvider.notifier).state =
                          const Locale(SimpleConstants.englishLocale);
                },
              );
            },
          ),
          ListTile(
            leading: const QmIconButton(
              icon: EvaIcons.logOutOutline,
            ),
            title: QmText(
              text: S.current.Logout,
            ),
            onTap: () {
              LogoutUtil()
                  .logout(context)
                  .then((_) => RoutingController().changeRoute(4, context));
            },
          ),
        ],
      ),
    );
  }
}
