import 'package:quantum_muscle/library.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({
    required this.arguments,
    super.key,
  });

  final Map<String, dynamic> arguments;
  @override
  Widget build(BuildContext context) {
    final workout = arguments[WorkoutModel.modelKey] as WorkoutModel;
    final showAddButton = arguments['showAddButton'] as bool;
    final programId = arguments['programId'] as String?;
    final programName = arguments['programName'] as String?;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final workoutCollectionName = '${workout.name}-${workout.id}';

    bool isDesktop() => !ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);

    bool isTablet() => !ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QmIconButton(
                  icon: EvaIcons.arrowBack,
                  onPressed: () => context.pop(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: QmText(
                        text: workout.name,
                      ),
                    ),
                    QmText(
                      text: utils.timeAgo(workout.creationDate),
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Hero(
                  tag: workout.id,
                  child: SizedBox.square(
                    dimension: width * 0.2,
                    child: QmImage.network(
                      source: workout.imageURL,
                      fallbackIcon: EvaIcons.plus,
                    ),
                  ),
                ),
                FittedBox(
                  child: Column(
                    children: [
                      QmIconButton(
                        onPressed: () {
                          if (programId != null) {
                            programUtil.deleteWorkoutToProgram(
                              workoutCollectionName: workoutCollectionName,
                              context: context,
                              programId: programId,
                            );
                          } else {
                            workoutUtil.delete(
                              workoutCollectionName: workoutCollectionName,
                              context: context,
                            );
                          }
                        },
                        icon: EvaIcons.trash,
                      ),
                      QmIconButton(
                        onPressed: () {},
                        icon: EvaIcons.share,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              AsyncValue<List<ExerciseModel>> exercisesProviderChooser() {
                if (programId != null) {
                  return ref.watch(
                    programExercisesProvider(
                      (programId, workoutCollectionName),
                    ),
                  );
                } else {
                  return ref.watch(exercisesProvider(workoutCollectionName));
                }
              }

              final exercisesWatcher = exercisesProviderChooser();

              return exercisesWatcher.when(
                data: (exercises) {
                  return Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: StaggeredGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: isDesktop()
                            ? 3
                            : isTablet()
                                ? 2
                                : 1,
                        children: List.generate(
                          exercises.length + 1,
                          (index) {
                            if (index == exercises.length && showAddButton) {
                              return AddExerciseTile(
                                width: height,
                                height: height,
                                workout: workout,
                                programId: programId,
                                programName: programName,
                                workoutCollectionName: workoutCollectionName,
                              );
                            } else {
                              final exercise = exercises[index];

                              return ExerciseBlock(
                                width: width,
                                height: height,
                                exercise: exercise,
                                workoutCollectionName: workoutCollectionName,
                                programId: programId,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
                loading: () => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: StaggeredGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: isDesktop()
                        ? 3
                        : isTablet()
                            ? 2
                            : 1,
                    children: List.generate(
                      3,
                      (index) => QmShimmer.rectangle(
                        width: 300,
                        height: 300,
                        radius: 10,
                      ),
                    ),
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: QmText(
                    text: error.toString(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
