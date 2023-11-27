import '../../../library.dart';

final indexStateProvider = StateProvider<int>((ref) => 0);
final pageController = PageController();
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class RoutingScreen extends ConsumerWidget {
  const RoutingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDrawerExist() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    const List<Widget> routes = [
      HomeScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];
    final pageIndex = ref.watch(indexStateProvider);
    final user = ref.watch(authStateChangesProvider);

    return Scaffold(
      extendBody: true,
      //todo streambuilder for change of user
      body: user.when(
        data: (data) {
          if (data == null) return const RegisterScreen();

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
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      SafeArea(child: routes[pageIndex]),
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
