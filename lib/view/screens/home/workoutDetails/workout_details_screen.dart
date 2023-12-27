import '/library.dart';

class WorkoutDetailsScreen extends ConsumerWidget {
  const WorkoutDetailsScreen({
    super.key,
    required this.workoutId,
    required this.arguments,
  });
  final String workoutId;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutName = arguments[WorkoutModel.workoutNameKey] as String;
    final workoutImage =
        arguments[WorkoutModel.workoutImgEncodedKey] as Uint8List;
    final workoutCreationDate =
        arguments[WorkoutModel.workoutCreationDateKey] as String;
    final workoutExercises =
        arguments[WorkoutModel.workoutExercisesKey] as List;

    final scrollController = ScrollController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    ref.watch(workoutsStreamProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QmText(
                      text: workoutName,
                    ),
                    QmText(
                      text: workoutCreationDate,
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Hero(
                  tag: workoutId,
                  child: Image(
                    image: MemoryImage(
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
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: workoutExercises.length + 1,
                itemBuilder: (context, index) {
                  if (index == workoutExercises.length) {
                    return AddExerciseTile(
                      width: height,
                      height: height,
                      indexToInsert: workoutExercises.length,
                      workoutName: "$workoutName-$workoutId",
                    );
                  } else {
                    final exercise = ExerciseModel.fromMap(
                        workoutExercises[index]['E$index']);
                    return ExerciseTile(
                      exercise: exercise,
                      width: width,
                      height: height,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
