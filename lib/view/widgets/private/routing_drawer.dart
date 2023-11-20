import 'package:flutter_animate/flutter_animate.dart';

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
      context.pop();
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
            title: QMText(
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
            title: QMText(
              text: S.of(context).Chat,
            ),
            onTap: () => changeIndex(1),
          ),
          ListTile(
            leading: const Icon(
              EvaIcons.personOutline,
              color: ColorConstants.secondaryColor,
            ),
            title: QMText(
              text: S.of(context).Profile,
            ),
            onTap: () => changeIndex(2),
          ),
        ],
      ).animate().fadeIn(
            duration: const Duration(
              milliseconds: 300,
            ),
          ),
    );
  }
}
