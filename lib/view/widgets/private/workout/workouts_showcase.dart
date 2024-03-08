import 'package:quantum_muscle/library.dart';

class WorkoutsShowcase extends ConsumerWidget {
  const WorkoutsShowcase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsSnapshot = ref.watch(workoutsProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scrollController = ScrollController();
    ref.watch(localeProvider);

    return workoutsSnapshot.when(
      data: (data) {
        if (data.isEmpty) {
          return AddWorkoutBlock.big(context);
        } else {
          return Scrollbar(
            controller: scrollController,
            child: ResponsiveGridView.builder(
              controller: scrollController,
              gridDelegate: const ResponsiveGridDelegate(
                crossAxisSpacing: 10,
                crossAxisExtent: 200,
                mainAxisSpacing: 10,
                maxCrossAxisExtent: 200,
                minCrossAxisExtent: 100,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return AddWorkoutBlock.small(context);
                } else {
                  final workout = data[index];

                  return WorkoutBlock(
                    width: width,
                    height: height,
                    workout: workout,
                  );
                }
              },
            ),
          );
        }
      },
      loading: () => ResponsiveGridView.builder(
        gridDelegate: const ResponsiveGridDelegate(
          crossAxisSpacing: 10,
          crossAxisExtent: 200,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: 200,
          minCrossAxisExtent: 100,
        ),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: width * .05,
        ),
        itemCount: 3,
        itemBuilder: (context, index) => const QmShimmer.rectangle(
          radius: 10,
          width: 100,
          height: 100,
        ),
      ),
      error: (e, s) => AddWorkoutBlock.small(context),
    );
  }
}
