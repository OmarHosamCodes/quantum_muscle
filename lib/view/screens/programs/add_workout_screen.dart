import 'package:quantum_muscle/library.dart';

class AddWorkoutScreen extends ConsumerStatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  ConsumerState<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends ConsumerState<AddWorkoutScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final networkWorkouts = ref.watch(publicWorkoutsProvider);
    final tabController = TabController(
      length: networkWorkouts.maybeWhen(
        data: (networkWorkouts) => networkWorkouts.length,
        orElse: () => 0,
      ),
      vsync: this,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: QmCustomTabBar(
          tabs: networkWorkouts.maybeWhen(
            data: (networkWorkouts) {
              return networkWorkouts
                  .map(
                    (e) => e.$1 as String,
                  )
                  .toList();
            },
            orElse: () => const <String>[],
          ),
          onTabSelected: tabController.animateTo,
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: networkWorkouts.when(
        data: (networkWorkouts) {
          return TabBarView(
            controller: tabController,
            children: networkWorkouts
                .map(
                  (e) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: e.$2.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        ref.read(chooseProvider.notifier).setWorkoutContent(
                              e.$2[index],
                            );
                        context.pop();
                      },
                      child: GridTile(
                        child: QmImage.smart(
                          source: e.$2[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
        loading: () => const Center(child: QmLoader.indicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }
}
