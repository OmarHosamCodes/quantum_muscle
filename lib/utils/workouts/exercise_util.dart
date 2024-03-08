// ignore_for_file: use_build_context_synchronously, unused_result, avoid_print

import 'package:quantum_muscle/library.dart';

/// Utility class for the exercises.
class ExerciseUtil extends Utils {
  /// Adds an exercise to the workout.
  Future<void> add({
    required BuildContext context,
    required String workoutCollectionName,
    required String exerciseName,
    required String exerciseTarget,
    required String content,
    required String contentType,
    required bool isLink,
  }) async {
    QmLoader.openLoader(context: context);
    if (user != null) {
      try {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addExercise,
        );
        final id = const Uuid().v8();
        final exercisesCollection = usersCollection
            .doc(userUid)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .collection(DBPathsConstants.exercisesPath);

        ExerciseModel exercise;

        if (isLink) {
          exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {'0': S.current.WeightXReps},
            contentURL: content,
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
        } else {
          final storageRef = firebaseStorage
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child(workoutCollectionName)
              .child(DBPathsConstants.exercisesPath)
              .child('$exerciseName$exerciseTarget$id.png');

          await storageRef.putString(content, format: PutStringFormat.base64);
          exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {'0': S.current.WeightXReps},
            contentURL: await storageRef.getDownloadURL(),
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
        }

        await exercisesCollection
            .doc('${exercise.name}-${exercise.target}-${exercise.id}')
            .set(exercise.toMap(), SetOptions(merge: true));

        await usersCollection
            .doc(userUid)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .set(
          {
            WorkoutModel.exercisesKey: FieldValue.arrayUnion(
              [
                '${exercise.name}-${exercise.target}-${exercise.id}',
              ],
            ),
          },
          SetOptions(merge: true),
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
    }
  }

  /// Adds a set to the exercise.
  Future<void> addSet({
    required String workoutCollectionName,
    required String exerciseDocName,
    required int indexToInsert,
    required BuildContext context,
  }) async {
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addSet,
      );
      const setsKey = ExerciseModel.setsKey;
      final weightXReps = S.current.WeightXReps;

      await usersCollection
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          setsKey: {
            indexToInsert.toString(): weightXReps,
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

  /// Changes the set.
  Future<void> changeSet({
    required GlobalKey<FormState> formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.changeSet,
      );

      const setsKey = ExerciseModel.setsKey;
      final setString = '$weight x $reps';

      await usersCollection
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          setsKey: {
            indexToInsert.toString(): setString,
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

    await addSet(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      indexToInsert: indexToInsert + 1,
      context: context,
    );
  }

  /// Deletes the exercise.
  Future<List<(dynamic, List<String>)>> getPublic() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.exercisesPath)
        .get()
        .then((value) => List<String>.from(value.data()!['names'] as List));

    final finalList = names.map((e) async {
      final value = await firebaseStorage
          .child(DBPathsConstants.publicPath)
          .child(DBPathsConstants.exercisesPath)
          .child(e)
          .list();
      final urls =
          await Future.wait(value.items.map((e) => e.getDownloadURL()));
      return (e, urls);
    });

    return Future.wait(finalList);
  }
}
