import '/library.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class RoutingScreen extends ConsumerWidget {
  const RoutingScreen({
    super.key,
    required this.child,
    required this.state,
  });
  final Widget child;
  final GoRouterState state;
  bool get getDrawerExist {
    if (state.uri.toString() == Routes.homeR ||
        state.uri.toString() == Routes.chatsR ||
        state.uri.toString() == Routes.myProfileR ||
        state.uri.toString() == Routes.searchR ||
        state.uri.toString() == Routes.programsR) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //todo add loading screen
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case User():
            return Scaffold(
              backgroundColor: ColorConstants.backgroundColor,
              appBar: getDrawerExist ? AppBar() : null,
              extendBodyBehindAppBar: true,
              extendBody: true,
              drawer: getDrawerExist ? const RoutingDrawer() : null,
              body: QmNiceTouch(child: SafeArea(child: child)),
            );

          case null:
            return const AuthScreen();
        }
      },
    );
  }
}

// class SideDrawer extends StatelessWidget {
//   const SideDrawer({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.child,
//   });
//   final double width;
//   final double height;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     final routingController = RoutingController();
//     final locale = Intl.getCurrentLocale();
//     SizedBox smallSpace() => const SizedBox(height: 10);

//     return Container(
//       width: width,
//       height: height,
//       color: ColorConstants.disabledColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 QmIconButton(
//                   icon: EvaIcons.homeOutline,
//                   onPressed: () => routingController.changeRoute(0),
//                 ),
//                 smallSpace(),
//                 QmIconButton(
//                   icon: EvaIcons.messageSquareOutline,
//                   onPressed: () => routingController.changeRoute(1),
//                 ),
//                 smallSpace(),
//                 QmIconButton(
//                   icon: EvaIcons.personOutline,
//                   onPressed: () => routingController.changeRoute(2),
//                 ),
//                 smallSpace(),
//                 QmIconButton(
//                   icon: EvaIcons.searchOutline,
//                   onPressed: () => routingController.changeRoute(3),
//                 ),
//                 smallSpace(),
//                 QmIconButton(
//                   icon: EvaIcons.archive,
//                   onPressed: () => routingController.changeRoute(4),
//                 ),
//                 smallSpace(),
//                 const Spacer(),
//                 Consumer(
//                   builder: (context, ref, child) {
//                     return QmIconButton(
//                       icon: EvaIcons.globe,
//                       onPressed: () {
//                         locale == SimpleConstants.englishLocale
//                             ? ref.read(localeProvider).value =
//                                 const Locale(SimpleConstants.arabicLocale)
//                             : ref.read(localeProvider) =
//                                 const Locale(SimpleConstants.englishLocale);
//                       },
//                     );
//                   },
//                 ),
//                 QmIconButton(
//                   icon: EvaIcons.logOutOutline,
//                   iconColor: ColorConstants.logoutColor,
//                   onPressed: () {
//                     LogoutUtil().logout(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 bottom: 10,
//                 left: locale == SimpleConstants.englishLocale ? 0 : 10,
//                 right: locale == SimpleConstants.englishLocale ? 10 : 0,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: child,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
