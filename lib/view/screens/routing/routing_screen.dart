import 'package:quantum_muscle/library.dart';

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({
    required this.child,
    required this.state,
    super.key,
  });
  final Widget child;
  final GoRouterState state;

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  bool get getDrawerExist {
    if (widget.state.uri.toString() == Routes.homeR ||
        widget.state.uri.toString() == Routes.chatsR ||
        widget.state.uri.toString() == Routes.myProfileR ||
        widget.state.uri.toString() == Routes.searchR ||
        widget.state.uri.toString() == Routes.programsR) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              body: SafeArea(
                minimum: const EdgeInsets.all(20),
                child: widget.child,
              ),
            );

          case null:
            return const AuthScreen();
        }
      },
    );
  }
}
