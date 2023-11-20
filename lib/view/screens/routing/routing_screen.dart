import '../../../library.dart';

final indexStateProvider = StateProvider<int>((ref) => 0);
final pageController = PageController();

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
    return Scaffold(
      extendBody: true,

      //todo streambuilder for change of user
      body: Row(
        children: [
          if (isDrawerExist())
            SizedBox(
              width: width * .2,
              child: const RoutingDrawer(),
            ),
          SizedBox(
            width: isDrawerExist() ? width * .8 : width,
            height: height,
            child: Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    SafeArea(child: routes[pageIndex]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
