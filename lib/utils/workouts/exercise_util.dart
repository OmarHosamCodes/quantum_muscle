// ignore_for_file: use_build_context_synchronously, unused_result, avoid_print

import '/library.dart';

final exerciseImageBytesProvider = StateProvider<String?>((ref) => null);

class ExerciseUtil extends Utils {
  Future<void> addExercise({
    required BuildContext context,
    required WidgetRef ref,
    required String workoutCollectionName,
    required String exerciseName,
    required String exerciseTarget,
    required String contentFile,
    required String contentType,
  }) async {
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        firebaseAnalytics.logEvent(
            name: AnalyticsEventNamesConstants.addExercise);
        final id = const Uuid().v4().toString().substring(0, 12);
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.workoutsPath)
            .child(workoutCollectionName)
            .child(DBPathsConstants.exercisesPath)
            .child("$exerciseName$exerciseTarget$id.png");

        await storageRef.putString(contentFile, format: PutStringFormat.base64);
        ExerciseModel exercise = ExerciseModel(
          id: id,
          name: exerciseName,
          target: exerciseTarget,
          sets: {
            '0': S.current.WeightXReps,
          },
          contentURL: await storageRef.getDownloadURL(),
          contentType: ExerciseContentType.image,
          creationDate: Timestamp.now(),
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid!)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .set(
          {
            WorkoutModel.exercisesKey: FieldValue.arrayUnion(
              [
                "${exercise.name}-${exercise.target}-${exercise.id}",
              ],
            ),
          },
          SetOptions(merge: true),
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid!)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .collection(DBPathsConstants.exercisesPath)
            .doc("${exercise.name}-${exercise.target}-${exercise.id}")
            .set(exercise.toMap(), SetOptions(merge: true));

        ref.read(exerciseImageBytesProvider.notifier).state = null;
        context.pop();
      } catch (e) {
        context.pop();
        openQmDialog(
          context: context,
          title: S.current.Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> addSet({
    required String workoutCollectionName,
    required String exerciseDocName,
    required WidgetRef ref,
    required int indexToInsert,
    required BuildContext context,
  }) async {
    try {
      firebaseAnalytics.logEvent(name: AnalyticsEventNamesConstants.addSet);
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid!)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): S.current.WeightXReps,
          },
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> changeSet({
    required GlobalKey<FormState>? formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required WidgetRef ref,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    bool isValid = formKey!.currentState!.validate();
    if (!isValid) return;
    try {
      firebaseAnalytics.logEvent(name: AnalyticsEventNamesConstants.changeSet);
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid!)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): "$weight x $reps",
          },
        },
        SetOptions(
          merge: true,
        ),
      );
      context.pop();
    } catch (e) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }

    addSet(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      ref: ref,
      indexToInsert: indexToInsert + 1,
      context: context,
    );
  }

  Future<void> addSetToProgramWorkout({
    required String workoutCollectionName,
    required String exerciseDocName,
    required WidgetRef ref,
    required int indexToInsert,
    required String programId,
    required BuildContext context,
  }) async {
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addProgramSet);
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): S.current.WeightXReps,
          },
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> addExerciesToProgramWorkout({
    required BuildContext context,
    required WidgetRef ref,
    required String workoutCollectionName,
    required String programId,
    required String programName,
    required String exerciseName,
    required String exerciseTarget,
    required String contentFile,
    required String contentType,
  }) async {
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        firebaseAnalytics.logEvent(
            name: AnalyticsEventNamesConstants.addProgramExercise);
        final id = const Uuid().v4().toString().substring(0, 12);
        ExerciseModel exercise = ExerciseModel(
          id: id,
          name: exerciseName,
          target: exerciseTarget,
          sets: {
            '0': S.current.WeightXReps,
          },
          contentURL: '',
          contentType: ExerciseContentType.image,
          creationDate: Timestamp.now(),
        );
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.programsPath)
            .child(programName)
            .child(workoutCollectionName)
            .child(DBPathsConstants.exercisesPath)
            .child("${exercise.name}-${exercise.target}-${exercise.id}.png");

        await storageRef.putString(contentFile, format: PutStringFormat.base64);

        exercise.contentURL = await storageRef.getDownloadURL();

        await firebaseFirestore
            .collection(DBPathsConstants.programsPath)
            .doc(programId)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .collection(DBPathsConstants.exercisesPath)
            .doc("${exercise.name}-${exercise.target}-${exercise.id}")
            .set(exercise.toMap(), SetOptions(merge: true));

        await firebaseFirestore
            .collection(DBPathsConstants.programsPath)
            .doc(programId)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .set(
          {
            WorkoutModel.exercisesKey: FieldValue.arrayUnion(
              [
                "${exercise.name}-${exercise.target}-${exercise.id}",
              ],
            ),
          },
          SetOptions(merge: true),
        );

        ref.read(exerciseImageBytesProvider.notifier).state = null;
        context.pop();
      } catch (e) {
        context.pop();
        openQmDialog(
          context: context,
          title: S.current.Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> changeSetToProgramWorkout({
    required GlobalKey<FormState>? formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required WidgetRef ref,
    required String programId,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    bool isValid = formKey!.currentState!.validate();
    if (!isValid) return;
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.changeProgramSet);
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): "$weight x $reps",
          },
        },
        SetOptions(
          merge: true,
        ),
      );
      context.pop();
    } catch (e) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }

    addSetToProgramWorkout(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      ref: ref,
      indexToInsert: indexToInsert + 1,
      programId: programId,
      context: context,
    );
  }
}
