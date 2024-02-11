import 'package:quantum_muscle/library.dart';

class AddExerciseScreen extends ConsumerStatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  ConsumerState<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends ConsumerState<AddExerciseScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final networkExercises = ref.watch(publicExercisesProvider);
    final tabController = TabController(
      length: networkExercises.maybeWhen(
        data: (networkExercises) => networkExercises.length,
        orElse: () => 0,
      ),
      vsync: this,
    );
    return Scaffold(
      appBar: AppBar(
        bottom: QmCustomTabBar(
          tabs: networkExercises.maybeWhen(
            data: (networkExercises) {
              return networkExercises.map(
                (e) {
                  final element = e.$1 as String;
                  return element;
                },
              ).toList();
            },
            orElse: () => const <String>[],
          ),
          onTabSelected: tabController.animateTo,
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: networkExercises.when(
        data: (networkExercises) {
          return TabBarView(
            controller: tabController,
            children: networkExercises.map(
              (e) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: e.$2.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .15,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref.read(workoutNetworkImageProvider.notifier).state =
                            e.$2[index];
                        context.pop();
                      },
                      child: GridTile(
                        child: QmImageNetwork(
                          source: e.$2[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        },
        loading: () => const Center(child: QmCircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }
}
