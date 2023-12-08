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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDrawerExist() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP) ||
          state.uri.toString() == Routes.authR) return false;
      return true;
    }

    final user = ref.watch(authStateChangesProvider);

    return user.when(
      data: (data) {
        if (data == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.mounted ? RoutingController().changeRoute(3) : null;
          });
        }

        return Scaffold(
          extendBody: true,
          body: Row(
            children: [
              isDrawerExist()
                  ? SizedBox(
                      width: width * .2,
                      child: const RoutingDrawer(),
                    )
                  : const SizedBox(),
              SizedBox(
                width: isDrawerExist() ? width * .8 : width,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: QmCircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: QmText(text: S.of(context).DefaultError)),
    );
  }
}
