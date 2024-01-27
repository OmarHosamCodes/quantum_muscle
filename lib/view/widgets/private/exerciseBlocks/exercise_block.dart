import '/library.dart';

class ExerciseBlock extends StatelessWidget {
  const ExerciseBlock({
    super.key,
    required this.width,
    required this.height,
    required this.exercise,
    required this.workoutCollectionName,
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
      borderRadius: 10,
      width: 300,
      topCardWidget: Stack(
        alignment: Alignment.center,
        children: [
          QmBlock(
            width: width,
            height: height,
            borderRadius: SimpleConstants.borderRadius,
            color: ColorConstants.disabledColorWithOpacity,
          ),
          QmImageNetwork(
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
                    overflow: TextOverflow.fade,
                    maxWidth: width * .3,
                  ),
                ),
                QmText(
                  text: exercise.target,
                  overflow: TextOverflow.fade,
                  isSeccoundary: true,
                  maxWidth: width * .25,
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
            flex: 1,
            child: QmIconButton(
              onPressed: () => pageController.previousPage(
                duration: SimpleConstants.fastAnimationDuration,
                curve: Curves.ease,
              ),
              icon: EvaIcons.arrowBack,
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              exercisesProviderChooser() {
                if (programId != null) {
                  return ref.watch(programExercisesProvider(
                      (programId!, workoutCollectionName)));
                } else {
                  return ref.watch(exercisesProvider(workoutCollectionName));
                }
              }

              final exercisesWatcher = exercisesProviderChooser();

              return exercisesWatcher.when(
                data: (exercises) {
                  var theExercise = exercises
                      .firstWhere((element) => element.id == exercise.id);
                  var itemCount = theExercise.sets.length;

                  return Flexible(
                    flex: 2,
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        String set = theExercise.sets.values.elementAt(index);

                        return QmBlock(
                          color: ColorConstants.disabledColorWithOpacity,
                          onTap: () => showModalBottomSheet(
                            context: context,
                            backgroundColor: ColorConstants.secondaryColor,
                            builder: (context) => _ChangeSetModalSheet(
                              height: height,
                              workoutCollectionName: workoutCollectionName,
                              exerciseDocName:
                                  "${theExercise.name}-${theExercise.target}-${theExercise.id}",
                              index: index,
                              programId: programId,
                            ),
                          ),
                          width: width * .2,
                          height: height * .3,
                          child: QmText(
                            text: set,
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () =>
                    const Center(child: QmCircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: QmText(text: error.toString()),
                ),
              );
            },
          ),
          QmIconButton(
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

class _ChangeSetModalSheet extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final setWeightTextController = TextEditingController();
    final setRepsTextController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    final exerciseUtil = ExerciseUtil();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QmTextField(
              fieldColor: ColorConstants.disabledColor,
              controller: setRepsTextController,
              height: height * .1,
              width: double.maxFinite,
              hintText: S.current.Reps,
              validator: (value) {
                if (ValidationController.validateOnlyNumbers(value!) == false) {
                  return S.current.EnterValidNumber;
                }
                return null;
              },
            ),
            QmTextField(
              fieldColor: ColorConstants.disabledColor,
              controller: setWeightTextController,
              height: height * .1,
              width: double.maxFinite,
              hintText: S.current.Weight,
              validator: (value) {
                if (ValidationController.validateOnlyNumbers(value!) == false) {
                  return S.current.EnterValidNumber;
                }
                return null;
              },
            ),
            Consumer(
              builder: (_, ref, __) {
                return QmBlock(
                  onTap: () {
                    if (programId != null) {
                      exerciseUtil.changeSetToProgramWorkout(
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
                    text: S.current.AddWorkout,
                    maxWidth: double.maxFinite,
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
