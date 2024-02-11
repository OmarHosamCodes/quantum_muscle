// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

class AddExerciseTile extends StatelessWidget {
  const AddExerciseTile({
    required this.width,
    required this.height,
    required this.workout,
    required this.workoutCollectionName,
    super.key,
    this.programId,
    this.programName,
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
      topCardWidget: Consumer(
        builder: (_, ref, __) {
          final imageWatcher = ref.watch(exerciseImageBytesProvider) ?? '';
          final networkImageWatcher =
              ref.watch(exerciseNetworkImageProvider) ?? '';

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: networkImageWatcher.isEmpty,
                child: Flexible(
                  child: QmBlock(
                    width: 100,
                    height: height * .2,
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
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final publicExercisesWatcher =
                          ref.watch(publicExercisesProvider);

                      return publicExercisesWatcher.when(
                        data: (publicExercises) {
                          return QmBlock(
                            width: 100,
                            height: height * .2,
                            onTap: () => context.push(Routes.addExerciseR),
                            child: QmImageNetwork(
                              source: networkImageWatcher,
                              fallbackIcon: EvaIcons.search,
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return QmText(text: error.toString());
                        },
                        loading: () => const Center(
                          child: QmCircularProgressIndicator(),
                        ),
                      );
                    },
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
