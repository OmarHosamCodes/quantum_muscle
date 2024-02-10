import '/library.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({
    super.key,
    required this.arguments,
  });

  final Map<String, dynamic> arguments;
  @override
  Widget build(BuildContext context) {
    WorkoutModel workout = arguments[WorkoutModel.modelKey];
    bool showAddButton = arguments['showAddButton'];
    String? programId = arguments['programId'];
    String? programName = arguments['programName'];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String workoutCollectionName = "${workout.name}-${workout.id}";
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QmIconButton(
                    icon: EvaIcons.arrowBack, onPressed: () => context.pop()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: QmText(
                        text: workout.name,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    QmText(
                      text: Utils().timeAgo(workout.creationDate),
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Hero(
                  tag: workout.id,
                  child: SizedBox.square(
                    dimension: width * 0.2,
                    child: QmImageNetwork(
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
                            ProgramsUtil().deleteWorkoutToProgram(
                              workoutCollectionName: workoutCollectionName,
                              context: context,
                              programId: programId,
                            );
                          } else {
                            WorkoutUtil().deleteWorkout(
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
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: StaggeredGrid.count(
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
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
                loading: () => StaggeredGrid.count(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount: isDesktop()
                      ? 3
                      : isTablet()
                          ? 2
                          : 1,
                  children: List.generate(
                    3,
                    (index) => const QmShimmer(
                      width: 100,
                      height: 100,
                      radius: 10,
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