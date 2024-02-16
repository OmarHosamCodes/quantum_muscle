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

  static final exerciseNameTextController = TextEditingController();
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
          final exerciseImage = ref.watch(
            chooseProvider.select((value) => value.exerciseImage),
          );
          final networkImage = ref.watch(
            chooseProvider.select((value) => value.publicExerciseImage),
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: networkImage.isEmpty,
                child: Flexible(
                  child: QmBlock(
                    width: 100,
                    height: height * .2,
                    onTap: () async => ref
                        .read(
                          chooseProvider.notifier,
                        )
                        .setExerciseImage(
                          (await exerciseUtil.chooseImageFromStorage())!,
                        ),
                    child: QmImage.memory(
                      source: exerciseImage,
                      fallbackIcon: EvaIcons.plus,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: exerciseImage.isEmpty,
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
                            child: QmImage.network(
                              source: networkImage,
                              fallbackIcon: EvaIcons.search,
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return QmText(text: error.toString());
                        },
                        loading: () => Center(
                          child: QmLoader.indicator(),
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
            SizedBox(
              width: width,
              height: 100,
              child: QmTextField(
                textInputAction: TextInputAction.next,
                controller: exerciseNameTextController,
                hintText: S.current.EnterExerciseName,
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
                  final exerciseImage = ref.watch(
                    chooseProvider.select((value) => value.exerciseImage),
                  );
                  final networkImage = ref.watch(
                    chooseProvider.select((value) => value.publicExerciseImage),
                  );
                  return QmTextField(
                    textInputAction: TextInputAction.go,
                    controller: exerciseTargetTextController,
                    hintText: S.current.EnterExerciseTarget,
                    fontSize: 40,
                    onEditingComplete: () async {
                      if (exerciseNameTextController.text.isNotEmpty &&
                          exerciseTargetTextController.text.isNotEmpty) {
                        if (exerciseImage.isEmpty) {
                          if (programId != null) {
                            await programUtil.addExerciesToProgramWorkout(
                              context: context,
                              ref: ref,
                              programId: programId!,
                              workoutCollectionName: workoutCollectionName,
                              programName: programName!,
                              exerciseName: exerciseNameTextController.text,
                              exerciseTarget: exerciseTargetTextController.text,
                              content: exerciseImage,
                              contentType: ExerciseShowcaseConstants.image,
                              isLink: false,
                            );
                          } else {
                            await exerciseUtil.add(
                              context: context,
                              ref: ref,
                              workoutCollectionName: workoutCollectionName,
                              exerciseName: exerciseNameTextController.text,
                              exerciseTarget: exerciseTargetTextController.text,
                              content: exerciseImage,
                              contentType: ExerciseShowcaseConstants.image,
                              isLink: false,
                            );
                          }
                        } else {
                          if (programId != null) {
                            await programUtil.addExerciesToProgramWorkout(
                              context: context,
                              ref: ref,
                              programId: programId!,
                              workoutCollectionName: workoutCollectionName,
                              programName: programName!,
                              exerciseName: exerciseNameTextController.text,
                              exerciseTarget: exerciseTargetTextController.text,
                              content: networkImage,
                              contentType: ExerciseShowcaseConstants.image,
                              isLink: true,
                            );
                          } else {
                            await exerciseUtil.add(
                              context: context,
                              ref: ref,
                              workoutCollectionName: workoutCollectionName,
                              exerciseName: exerciseNameTextController.text,
                              exerciseTarget: exerciseTargetTextController.text,
                              content: networkImage,
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
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Consumer(
              builder: (_, ref, __) {
                final exerciseImage = ref.watch(
                  chooseProvider.select((value) => value.exerciseImage),
                );
                final networkImage = ref.watch(
                  chooseProvider.select((value) => value.publicExerciseImage),
                );
                return QmBlock(
                  onTap: () async {
                    if (exerciseNameTextController.text.isNotEmpty &&
                        exerciseTargetTextController.text.isNotEmpty) {
                      if (exerciseImage.isEmpty) {
                        if (programId != null) {
                          await programUtil.addExerciesToProgramWorkout(
                            context: context,
                            ref: ref,
                            programId: programId!,
                            workoutCollectionName: workoutCollectionName,
                            programName: programName!,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: exerciseImage,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: false,
                          );
                        } else {
                          await exerciseUtil.add(
                            context: context,
                            ref: ref,
                            workoutCollectionName: workoutCollectionName,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: exerciseImage,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: false,
                          );
                        }
                      } else {
                        if (programId != null) {
                          await programUtil.addExerciesToProgramWorkout(
                            context: context,
                            ref: ref,
                            programId: programId!,
                            workoutCollectionName: workoutCollectionName,
                            programName: programName!,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: networkImage,
                            contentType: ExerciseShowcaseConstants.image,
                            isLink: true,
                          );
                        } else {
                          await exerciseUtil.add(
                            context: context,
                            ref: ref,
                            workoutCollectionName: workoutCollectionName,
                            exerciseName: exerciseNameTextController.text,
                            exerciseTarget: exerciseTargetTextController.text,
                            content: networkImage,
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
