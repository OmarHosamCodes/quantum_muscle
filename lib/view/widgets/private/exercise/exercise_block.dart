// ignore_for_file: lines_longer_than_80_chars

import 'package:quantum_muscle/library.dart';

class ExerciseBlock extends StatelessWidget {
  const ExerciseBlock({
    required this.width,
    required this.height,
    required this.exercise,
    required this.workoutCollectionName,
    super.key,
    this.programId,
  });
  final String? programId;
  final double width;
  final double height;
  final ExerciseModel exercise;
  final String workoutCollectionName;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return SlimyCard(
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 150 ? 150 : height * 0.2,
      topCardWidget: Stack(
        alignment: Alignment.center,
        children: [
          QmBlock(
            width: width,
            height: height,
            borderRadius: SimpleConstants.borderRadius,
            color: ColorConstants.disabledColor,
          ),
          QmImage.network(
            source: exercise.contentURL,
            fallbackIcon: EvaIcons.plus,
          ),
          Positioned(
            top: 0,
            left: 5,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: QmText(
                    text: exercise.name,
                  ),
                ),
                QmText(
                  text: exercise.target,
                  isSeccoundary: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomCardWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: QmButton.icon(
              onPressed: () => pageController.previousPage(
                duration: SimpleConstants.fastAnimationDuration,
                curve: Curves.ease,
              ),
              icon: EvaIcons.arrowBack,
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              AsyncValue<List<ExerciseModel>> exercisesProviderChooser() {
                if (programId != null) {
                  return ref.watch(
                    programExercisesProvider(
                      (programId!, workoutCollectionName),
                    ),
                  );
                } else {
                  return ref.watch(exercisesProvider(workoutCollectionName));
                }
              }

              final exercisesWatcher = exercisesProviderChooser();

              return exercisesWatcher.when(
                data: (exercises) {
                  final theExercise = exercises
                      .firstWhere((element) => element.id == exercise.id);
                  final itemCount = theExercise.sets.length;

                  return Flexible(
                    flex: 2,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final set =
                            theExercise.sets.values.elementAt(index) as String;

                        return QmBlock(
                          color: ColorConstants.disabledColor,
                          onTap: () => showModalBottomSheet<void>(
                            showDragHandle: true,
                            context: context,
                            backgroundColor: ColorConstants.primaryColor,
                            builder: (context) => _ChangeSetModalSheet(
                              height: height,
                              workoutCollectionName: workoutCollectionName,
                              exerciseDocName:
                                  '${theExercise.name}-${theExercise.target}-${theExercise.id}',
                              index: index,
                              programId: programId,
                            ),
                          ),
                          width: width * .2,
                          height: height * .3,
                          child: Center(
                            child: QmSimpleText(
                              text: set,
                              isSeccoundary: true,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => SizedBox(
                  width: width * .2,
                  height: height * .3,
                  child: Center(
                    child: QmLoader.indicator(),
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: QmText(text: error.toString()),
                ),
              );
            },
          ),
          QmButton.icon(
            onPressed: () => pageController.nextPage(
              duration: SimpleConstants.fastAnimationDuration,
              curve: Curves.ease,
            ),
            icon: EvaIcons.arrowForward,
          ),
        ],
      ),
    );
  }
}

class _ChangeSetModalSheet extends ConsumerWidget {
  const _ChangeSetModalSheet({
    required this.height,
    required this.workoutCollectionName,
    required this.exerciseDocName,
    required this.index,
    this.programId,
  });
  final double height;
  final String workoutCollectionName;
  final String exerciseDocName;
  final int index;
  final String? programId;

  static final setRepsTextController = TextEditingController();
  static final setWeightTextController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseUtil = ExerciseUtil();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            QmTextField(
              textInputAction: TextInputAction.next,
              fieldColor: ColorConstants.disabledColor,
              controller: setWeightTextController,
              hintText: S.current.Weight,
              validator: (value) {
                if (ValidationController.validateOnlyNumbers(value!) == false) {
                  return S.current.EnterValidNumber;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            QmTextField(
              textInputAction: TextInputAction.go,
              fieldColor: ColorConstants.disabledColor,
              controller: setRepsTextController,
              hintText: S.current.Reps,
              validator: (value) {
                if (ValidationController.validateOnlyNumbers(value!) == false) {
                  return S.current.EnterValidNumber;
                }
                return null;
              },
              onEditingComplete: () {
                if (programId != null) {
                  programUtil.changeSetToProgramWorkout(
                    formKey: formKey,
                    workoutCollectionName: workoutCollectionName,
                    exerciseDocName: exerciseDocName,
                    context: context,
                    ref: ref,
                    programId: programId!,
                    indexToInsert: index,
                    reps: setRepsTextController.text,
                    weight: setWeightTextController.text,
                  );
                } else {
                  exerciseUtil.changeSet(
                    formKey: formKey,
                    context: context,
                    reps: setRepsTextController.text,
                    weight: setWeightTextController.text,
                    ref: ref,
                    workoutCollectionName: workoutCollectionName,
                    exerciseDocName: exerciseDocName,
                    indexToInsert: index,
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            QmBlock(
              color: ColorConstants.accentColor,
              onTap: () {
                if (programId != null) {
                  programUtil.changeSetToProgramWorkout(
                    formKey: formKey,
                    workoutCollectionName: workoutCollectionName,
                    exerciseDocName: exerciseDocName,
                    context: context,
                    ref: ref,
                    programId: programId!,
                    indexToInsert: index,
                    reps: setRepsTextController.text,
                    weight: setWeightTextController.text,
                  );
                } else {
                  exerciseUtil.changeSet(
                    formKey: formKey,
                    context: context,
                    reps: setRepsTextController.text,
                    weight: setWeightTextController.text,
                    ref: ref,
                    workoutCollectionName: workoutCollectionName,
                    exerciseDocName: exerciseDocName,
                    indexToInsert: index,
                  );
                }
              },
              height: height * .1,
              width: double.maxFinite,
              child: QmText(
                text: S.current.Add,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
