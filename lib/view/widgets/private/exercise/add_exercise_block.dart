// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/view/widgets/private/exercise/network_exercises_sheet.dart';

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
      topCardWidget: Consumer(
        builder: (_, ref, __) {
          final imageWatcher = ref.watch(exerciseImageBytesProvider) ?? '';
          final networkImageWatcher =
              ref.watch(exerciseNetworkImageProvider) ?? '';

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: networkImageWatcher.isEmpty,
                child: Flexible(
                  child: QmBlock(
                    width: 100,
                    height: height * .2,
                    isNormal: true,
                    onTap: () => exerciseUtil.chooseImageFromStorage(
                      ref: ref,
                      provider: exerciseImageBytesProvider,
                    ),
                    child: QmImageMemory(
                      source: imageWatcher,
                      fallbackIcon: EvaIcons.plus,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: imageWatcher.isEmpty,
                child: Flexible(
                  child: QmBlock(
                    width: 100,
                    height: height * .2,
                    isNormal: true,
                    onTap: () => openNetworkExercisesSheet(context: context),
                    child: QmImageNetwork(
                      source: networkImageWatcher,
                      fallbackIcon: EvaIcons.search,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
              fontSize: 40,
            ),
            const SizedBox(
              height: 5,
            ),
            QmTextField(
              height: height * .2,
              width: width,
              controller: exerciseTargetTextController,
              hintText: S.current.EnterExerciseTarget,
              fontSize: 40,
            ),
            const SizedBox(
              height: 5,
            ),
            Consumer(
              builder: (_, ref, __) {
                final imageWatcher = ref.watch(exerciseImageBytesProvider);
                final networkImageWatcher =
                    ref.watch(exerciseNetworkImageProvider);
                return QmBlock(
                  onTap: () async {
                    if (exerciseNameTextController.text.isNotEmpty &&
                        exerciseTargetTextController.text.isNotEmpty) {
                      if (imageWatcher != null) {
                        if (programId != null) {
                          await ProgramsUtil().addExerciesToProgramWorkout(
                            context: context,
                            ref: ref,
                            programId: programId!,
                            workoutCollectionName: workoutCollectionName,
                            programName: programName!,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: imageWatcher,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: false,
                          );
                        } else {
                          await exerciseUtil.addExercise(
                            context: context,
                            ref: ref,
                            workoutCollectionName: workoutCollectionName,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: imageWatcher,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: false,
                          );
                        }
                      } else {
                        if (programId != null) {
                          await ProgramsUtil().addExerciesToProgramWorkout(
                            context: context,
                            ref: ref,
                            programId: programId!,
                            workoutCollectionName: workoutCollectionName,
                            programName: programName!,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: networkImageWatcher!,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: true,
                          );
                        } else {
                          await exerciseUtil.addExercise(
                            context: context,
                            ref: ref,
                            workoutCollectionName: workoutCollectionName,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: networkImageWatcher!,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: true,
                          );
                        }
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
                    style: const TextStyle(
                      color: ColorConstants.textColor,
                      fontSize: 40,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
