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
    final width = MediaQuery.of(context).size.width;
    final networkWorkouts = ref.watch(publicWorkoutsProvider);
    final tabController = TabController(
      length: networkWorkouts.maybeWhen(
        data: (networkWorkouts) => networkWorkouts.length,
        orElse: () => 0,
      ),
      vsync: this,
    );

    return Scaffold(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .15,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        ref
                            .read(addWorkoutNotifierProvider.notifier)
                            .setContent(
                              e.$2[index],
                            );
                        context.pop();
                      },
                      child: GridTile(
                        child: QmImage.network(
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
        loading: () => Center(child: QmLoader.indicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }
}
