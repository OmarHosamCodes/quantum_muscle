import '/library.dart';

class WorkoutDetailsScreen extends ConsumerWidget {
  const WorkoutDetailsScreen({
    super.key,
    required this.arguments,
  });

  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutName = arguments[WorkoutModel.nameKey] as String;
    final workoutImage = arguments[WorkoutModel.imgUrlKey] as String;
    final workoutCreationDate =
        arguments[WorkoutModel.creationDateKey] as Timestamp;
    final workoutId = arguments[WorkoutModel.idKey] as String;
    final workoutIndex = arguments["index"] as int;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

    ref.watch(workoutsStreamProvider(Utils().userUid!));
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
                    QmText(
                      text: workoutName,
                    ),
                    QmText(
                      text: Utils().timeAgo(workoutCreationDate),
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Hero(
                  tag: workoutId,
                  child: Image(
                    image: CachedNetworkImageProvider(
                      workoutImage,
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
                        onPressed: () {},
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
          Consumer(builder: (context, ref, _) {
            final workoutStream =
                ref.watch(workoutsStreamProvider(Utils().userUid!));
            return workoutStream.when(
              data: (data) {
                final exercises = data!.docs[workoutIndex].data().exercises;
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
                          if (index == exercises.length) {
                            return AddExerciseTile(
                              width: height,
                              height: height,
                              indexToInsert: exercises.length,
                              workoutName: workoutName,
                              id: workoutId,
                            );
                          } else {
                            final exercise = ExerciseModel.fromMap(
                                exercises[index]['$index']);

                            return ExerciseTile(
                              width: width,
                              height: height,
                              showcaseUrl: exercise.showcaseUrl,
                              name: exercise.name,
                              target: exercise.target,
                              sets: exercise.sets,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => QmText(text: error.toString()),
              loading: () => const QmCircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }
}
