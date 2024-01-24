// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class AddExerciseTile extends StatelessWidget {
  const AddExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.workout,
    this.programId,
    this.programName,
    required this.workoutCollectionName,
  });
  final double width;
  final double height;
  final WorkoutModel workout;
  final String? programId;
  final String? programName;
  final String workoutCollectionName;

  @override
  Widget build(BuildContext context) {
    final exerciseNameTextController = TextEditingController();
    final exerciseTargetTextController = TextEditingController();
    final exerciseUtil = ExerciseUtil();

    return SlimyCard(
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 150 ? 150 : height * 0.2,
      borderRadius: 10,
      topCardWidget: Consumer(builder: (context, ref, _) {
        final imageSource = ref.watch(exerciseImageBytesProvider) ?? '';
        return QmBlock(
          width: width * .9,
          height: height * .2,
          isNormal: true,
          onTap: () => exerciseUtil.chooseImageFromStorage(
            ref: ref,
            provider: exerciseImageBytesProvider,
          ),
          child: Image(
            image: MemoryImage(base64Decode(imageSource)),
            fit: BoxFit.scaleDown,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                EvaIcons.plus,
                color: ColorConstants.iconColor,
              );
            },
          ),
        );
      }),
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
            Consumer(builder: (context, ref, _) {
              final imageSource = ref.watch(exerciseImageBytesProvider);
              return QmBlock(
                onTap: () async {
                  if (exerciseNameTextController.text.isNotEmpty &&
                      exerciseTargetTextController.text.isNotEmpty) {
                    if (programId != null) {
                      await exerciseUtil.addExerciesToProgramWorkout(
                        context: context,
                        ref: ref,
                        programId: programId!,
                        workoutCollectionName: workoutCollectionName,
                        programName: programName!,
                        exerciseName: exerciseNameTextController.text,
                        exerciseTarget: exerciseTargetTextController.text,
                        showcaseFile: imageSource!,
                        showcaseType: ExerciseShowcaseConstants.image,
                      );
                    } else {
                      await exerciseUtil.addExercise(
                        context: context,
                        ref: ref,
                        workoutCollectionName: workoutCollectionName,
                        exerciseName: exerciseNameTextController.text,
                        exerciseTarget: exerciseTargetTextController.text,
                        showcaseFile: imageSource!,
                        showcaseType: ExerciseShowcaseConstants.image,
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
                color: ColorConstants.secondaryColor,
                width: width,
                height: height * .2,
                child: QmText(
                  text: S.current.Add,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
