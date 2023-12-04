import '/library.dart';

final pageViewController = PageController();
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
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

    // List<Widget> pages = [
    //   const HomeScreen(),
    //   const ChatScreen(),
    //   const ProfileScreen(),
    // ];

    final user = ref.watch(authStateChangesProvider);

    return Scaffold(
      extendBody: true,
      drawer: isDrawerExist() ? const RoutingDrawer() : null,
      body: user.when(
        data: (data) {
          if (data == null) context.go(Routes.authR);

          return Row(
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
          );
        },
        loading: () => const Center(child: QmCircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(child: QmText(text: S.of(context).DefaultError));
        },
      ),
    );
  }
}
