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
    final user = ref.watch(authStateChangesProvider);

    return user.when(
      data: (data) {
        if (data == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.mounted
                ? RoutingController().changeRoute(4, context)
                : null;
          });
        }

        return Scaffold(
          appBar: AppBar(),
          extendBody: true,
          drawer: const RoutingDrawer(),
          body: Row(
            children: [
              SizedBox(
                width: width,
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
          Center(child: QmText(text: S.current.DefaultError)),
    );
  }
}
