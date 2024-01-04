import '/library.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsSnapshot =
        ref.watch(workoutsStreamProvider(Utils().userUid!));
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

    return Scaffold(
      body: workoutsSnapshot.when(
        data: (data) {
          if (data!.docs.isEmpty) {
            return BigAddWorkout(width: width, height: height);
          } else {
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop()
                    ? 4
                    : isTablet()
                        ? 3
                        : 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.1,
              ),
              itemCount: data.docs.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == data.docs.length) {
                  return SmallAddWorkout(
                    width: width,
                    height: height,
                  );
                } else {
                  final workout = data.docs[index].data();
                  final workoutName = workout.name;
                  final workoutExercises = workout.exercises;
                  final workoutImgUrl = workout.imgUrl;
                  final workoutCreationDate = workout.creationDate;
                  final workoutId = workout.id;

                  return QmBlock(
                    padding: const EdgeInsets.all(10),
                    width: 0,
                    height: 0,
                    isGradient: false,
                    onTap: () => context.pushNamed(
                      Routes.workoutRootR,
                      extra: {
                        WorkoutModel.nameKey: workoutName,
                        WorkoutModel.imgUrlKey: workoutImgUrl,
                        WorkoutModel.exercisesKey: workoutExercises,
                        WorkoutModel.creationDateKey: workoutCreationDate,
                        WorkoutModel.idKey: workoutId,
                        "index": index,
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
                                text: workoutName,
                                maxWidth: double.maxFinite,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: QmText(
                                text: Utils().timeAgo(workoutCreationDate),
                                isSeccoundary: true,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Draggable(
                            data: {
                              WorkoutModel.nameKey: workoutName,
                              WorkoutModel.imgUrlKey: workoutImgUrl,
                              WorkoutModel.exercisesKey: workoutExercises,
                              WorkoutModel.creationDateKey: workoutCreationDate,
                              WorkoutModel.idKey: workoutId,
                              "index": index,
                            },
                            feedback: QmBlock(
                              padding: const EdgeInsets.all(10),
                              color: ColorConstants.disabledColor,
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
                                      tag: workoutId,
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                            workoutImgUrl),
                                        fit: BoxFit.scaleDown,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.add_a_photo_outlined,
                                            color:
                                                ColorConstants.secondaryColor,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const QmCircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: QmText(
                                      text: workoutName,
                                      maxWidth: double.maxFinite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            child: Hero(
                              tag: workoutId,
                              child: Image(
                                image:
                                    CachedNetworkImageProvider(workoutImgUrl),
                                fit: BoxFit.scaleDown,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: ColorConstants.secondaryColor,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const QmCircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
        loading: () => const Center(child: QmCircularProgressIndicator()),
        error: (e, s) => BigAddWorkout(width: width, height: height),
      ),
    );
  }
}
