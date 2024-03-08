import 'package:quantum_muscle/library.dart';

/// A tile widget used for adding exercises.
class AddExerciseTile extends StatelessWidget {
  /// Constructs an [AddExerciseTile] widget.
  ///
  /// The [width] and [height] parameters specify the dimensions of the tile.
  /// The [workout] parameter is the workout model associated with the tile.
  /// The [workoutCollectionName] parameter is the name of the workout collection.
  /// The [programId] and [programName] parameters are optional and represent the program ID and name.
  const AddExerciseTile({
    required this.width,
    required this.height,
    required this.workout,
    required this.workoutCollectionName,
    super.key,
    this.programId,
    this.programName,
  });

  /// The width of the tile.
  final double width;

  /// The height of the tile.
  final double height;

  /// The workout model associated with the tile.
  final WorkoutModel workout;

  /// The ID of the program.
  final String? programId;

  /// The name of the program.
  final String? programName;

  /// The name of the workout collection.
  final String workoutCollectionName;

  /// The text controller for the exercise name input field.
  static final exerciseNameTextController = TextEditingController();

  /// The text controller for the exercise target input field.
  static final exerciseTargetTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SlimyCard(
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 150 ? 150 : height * 0.2,
      topCardWidget: Consumer(
        builder: (_, ref, __) {
          final exerciseContent = ref.watch(
            chooseProvider.select((value) => value.exerciseContent),
          );

          if (exerciseContent != null) {
            return QmBlock(
              width: 100,
              height: height * .2,
              onTap: () async => ref
                  .read(
                    chooseProvider.notifier,
                  )
                  .setExerciseContent(
                    (await exerciseUtil.chooseImageFromStorage())!,
                  ),
              child: QmImage.smart(
                source: exerciseContent,
                fallbackIcon: EvaIcons.plus,
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: QmButton.icon(
                  onPressed: () async {
                    final image = await exerciseUtil.chooseImageFromStorage();
                    ref
                        .read(chooseProvider.notifier)
                        .setExerciseContent(image!);
                  },
                  icon: EvaIcons.plus,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final publicExercisesWatcher =
                        ref.watch(publicExercisesProvider);

                    return publicExercisesWatcher.when(
                      data: (publicExercises) {
                        return QmButton.icon(
                          onPressed: () => context.push(Routes.addExerciseR),
                          icon: EvaIcons.search,
                        );
                      },
                      error: (error, stackTrace) {
                        return QmText(text: error.toString());
                      },
                      loading: () => const Center(
                        child: QmLoader.indicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomCardWidget: FittedBox(
        fit: BoxFit.cover,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width,
              height: 100,
              child: QmTextField(
                textInputAction: TextInputAction.next,
                controller: exerciseNameTextController,
                hintText: S.current.Name,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width,
              height: 100,
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  return QmTextField(
                    textInputAction: TextInputAction.go,
                    controller: exerciseTargetTextController,
                    hintText: S.current.Target,
                    fontSize: 40,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Consumer(
              builder: (_, ref, __) {
                final exerciseContent = ref.watch(
                  chooseProvider.select((value) => value.exerciseContent),
                );
                return QmButton.text(
                  onPressed: () async {
                    if (exerciseNameTextController.text.isNotEmpty &&
                        exerciseTargetTextController.text.isNotEmpty) {
                      if (programId != null) {
                        await programUtil.addExerciesToProgramWorkout(
                          context: context,
                          programId: programId!,
                          workoutCollectionName: workoutCollectionName,
                          programName: programName!,
                          exerciseName: exerciseNameTextController.text,
                          exerciseTarget: exerciseTargetTextController.text,
                          content: exerciseContent!,
                          contentType: ExerciseContentConstants.image,
                          isLink: exerciseContent.startsWith('http'),
                        );
                      } else {
                        await exerciseUtil.add(
                          context: context,
                          workoutCollectionName: workoutCollectionName,
                          exerciseName: exerciseNameTextController.text,
                          exerciseTarget: exerciseTargetTextController.text,
                          content: exerciseContent!,
                          contentType: ExerciseContentConstants.image,
                          isLink: exerciseContent.startsWith('http'),
                        );
                      }
                    } else {
                      openQmDialog(
                        context: context,
                        title: S.current.Failed,
                        message: S.current.DefaultError,
                      );
                    }
                  },
                  text: S.current.Add,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
