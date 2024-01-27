import '/library.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsSnapshot = ref.watch(workoutsProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScrollController scrollController = ScrollController();
    ref.watch(localeProvider);

    return Scaffold(
      body: workoutsSnapshot.when(
        data: (data) {
          if (data.isEmpty) {
            return BigAddWorkout(width: width, height: height);
          } else {
            return Scrollbar(
              controller: scrollController,
              child: ResponsiveGridView.builder(
                controller: scrollController,
                gridDelegate: const ResponsiveGridDelegate(
                  crossAxisSpacing: 10,
                  crossAxisExtent: 200,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  maxCrossAxisExtent: 200,
                  minCrossAxisExtent: 100,
                ),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: width * .05,
                ),
                itemCount: data.length + 1,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    return SmallAddWorkout(
                      width: width * .2,
                      height: height * .2,
                    );
                  } else {
                    final workout = data[index];

                    return QmBlock(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      width: width * .2,
                      height: height * .2,
                      isGradient: false,
                      onTap: () => context.pushNamed(
                        Routes.workoutRootR,
                        extra: {
                          WorkoutModel.modelKey: workout,
                          "index": index,
                          "showAddButton": true,
                        },
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: QmText(
                                  text: workout.name,
                                  maxWidth: double.maxFinite,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: QmText(
                                  text: Utils().timeAgo(workout.creationDate),
                                  isSeccoundary: true,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Draggable<WorkoutModel>(
                              data: workout,
                              feedback: QmBlock(
                                padding: const EdgeInsets.all(10),
                                color: ColorConstants.secondaryColor,
                                width: width * .2,
                                height: height * .2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Hero(
                                        tag: workout.id,
                                        child: QmImageNetwork(
                                          source: workout.imageURL,
                                          fallbackIcon: EvaIcons.plus,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: QmText(
                                        text: workout.name,
                                        maxWidth: double.maxFinite,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: Hero(
                                tag: workout.id,
                                child: QmImageNetwork(
                                  source: workout.imageURL,
                                  fallbackIcon: EvaIcons.plus,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          }
        },
        loading: () => const Center(child: QmCircularProgressIndicator()),
        error: (e, s) => BigAddWorkout(width: width, height: height),
      ),
    );
  }
}
