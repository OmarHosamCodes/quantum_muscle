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
        state.uri.toString() == Routes.searchR) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider);
    final routingController = RoutingController.instants;
    return user.when(
      data: (data) {
        if (data == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.mounted ? routingController.changeRoute(4) : null;
          });
        }

        return context.mounted
            ? Scaffold(
                appBar: getDrawerExist ? AppBar() : null,
                extendBody: true,
                drawer: getDrawerExist ? const RoutingDrawer() : null,
                body: child,
              )
            : const QmCircularProgressIndicator();
      },
      loading: () => const Center(child: QmCircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: QmText(text: S.current.DefaultError)),
    );
  }
}
