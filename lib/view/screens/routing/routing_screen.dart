import '/library.dart';

class RoutingScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
