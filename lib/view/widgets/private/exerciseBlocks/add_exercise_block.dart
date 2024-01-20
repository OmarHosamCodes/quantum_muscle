// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class AddExerciseTile extends ConsumerWidget {
  const AddExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.workout,
    this.programId,
    required this.workoutCollectionName,
    required this.workoutAndExercises,
  });
  final double width;
  final double height;
  final WorkoutModel workout;
  final String? programId;
  final String workoutCollectionName;
  final Map<String, List<dynamic>> workoutAndExercises;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseNameTextController = TextEditingController();
    final exerciseTargetTextController = TextEditingController();
    final ExerciseUtil exerciseUtil = ExerciseUtil();
    String? imageSource = ref.watch(exerciseImageBytesProvider) ?? '';
    Uint8List imageBytes() => base64Decode(imageSource);

    return SlimyCard(
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 150 ? 150 : height * 0.2,
      borderRadius: 10,
      topCardWidget: QmBlock(
        width: width * .9,
        height: height * .2,
        isNormal: true,
        onTap: () => exerciseUtil.chooseImageFromStorage(
          ref: ref,
          provider: exerciseImageBytesProvider,
        ),
        child: Image(
          image: MemoryImage(imageBytes()),
          fit: BoxFit.scaleDown,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.add,
              color: ColorConstants.iconColor,
            );
          },
        ),
      ),
      bottomCardWidget: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QmTextField(
              height: height * .2,
              width: width,
              controller: exerciseNameTextController,
              hintText: S.current.EnterExerciseName,
              fontSize: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            QmTextField(
              height: height * .2,
              width: width,
              controller: exerciseTargetTextController,
              hintText: S.current.EnterExerciseTarget,
              fontSize: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            QmBlock(
              onTap: () async {
                if (exerciseNameTextController.text.isNotEmpty &&
                    exerciseTargetTextController.text.isNotEmpty) {
                  // if (programId != null) {
                  //   await exerciseUtil.addExerciesToProgramWorkout(
                  //     context: context,
                  //     ref: ref,
                  //     workoutName: workoutName,
                  //     workoutId: id,
                  //     exerciseName: exerciseNameTextController.text,
                  //     exerciseTarget: exerciseTargetTextController.text,
                  //     showcaseFile: imageSource,
                  //     showcaseType: ExerciseShowcaseConstants.image,
                  //     programId: programId!,
                  //   );
                  // }
                  await exerciseUtil.addExercise(
                    context: context,
                    ref: ref,
                    workoutCollectionName: workoutCollectionName,
                    exerciseName: exerciseNameTextController.text,
                    exerciseTarget: exerciseTargetTextController.text,
                    showcaseFile: imageSource,
                    showcaseType: ExerciseShowcaseConstants.image,
                    workoutAndExercises: workoutAndExercises,
                  );
                }
              },
              color: ColorConstants.secondaryColor,
              width: width,
              height: height * .2,
              child: QmText(
                text: S.current.Add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
