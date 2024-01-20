import '/library.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({
    super.key,
    required this.arguments,
  });

  final Map<String, dynamic> arguments;
  @override
  Widget build(BuildContext context) {
    final workout = arguments[WorkoutModel.modelKey] as WorkoutModel;
    final showAddButton = arguments['showAddButton'] as bool;
    final programId = arguments['ProgramId'] as String?;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final workoutCollectionName = "${workout.name}-${workout.id}";
    final workoutAndExercises = {workoutCollectionName: workout.exercises};
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: Image(
                    image: CachedNetworkImageProvider(
                      workout.imgUrl,
                    ),
                    fit: BoxFit.scaleDown,
                    height: height * 0.2,
                    width: width * 0.2,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.add_a_photo_outlined,
                        color: ColorConstants.secondaryColor,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const QmCircularProgressIndicator();
                    },
                  ),
                ),
                FittedBox(
                  child: Column(
                    children: [
                      QmIconButton(
                        onPressed: () => WorkoutUtil().deleteWorkout(
                          workoutCollectionName: workoutCollectionName,
                          context: context,
                        ),
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
              final exercisesWatcher =
                  ref.watch(exercisesProvider(workoutAndExercises));
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
                                workoutCollectionName: workoutCollectionName,
                                workoutAndExercises: workoutAndExercises,
                              );
                            } else {
                              final exercise = exercises[index];

                              return ExerciseTile(
                                width: width,
                                height: height,
                                exercise: exercise,
                                workoutCollectionName: workoutCollectionName,
                                workoutAndExercises: workoutAndExercises,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
                loading: () =>
                    const Center(child: QmCircularProgressIndicator()),
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
