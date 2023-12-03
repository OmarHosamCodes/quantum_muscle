import '/library.dart';

final pageViewController = PageController();
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class RoutingScreen extends ConsumerWidget {
  const RoutingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDrawerExist() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    List<Widget> pages = [
      const HomeScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];

    final user = ref.watch(authStateChangesProvider);

    return Scaffold(
      extendBody: true,
      //todo streambuilder for change of user
      body: user.when(
        data: (data) {
          if (data == null) return const AuthScreen();

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
                child: PageView(
                  controller: pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages.map((page) => SafeArea(child: page)).toList(),
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
