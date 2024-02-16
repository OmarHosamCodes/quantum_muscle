// ignore_for_file: use_build_context_synchronously, unused_result, avoid_print

import 'package:quantum_muscle/library.dart';

class ExerciseUtil extends Utils {
  Future<void> add({
    required BuildContext context,
    required WidgetRef ref,
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

        if (isLink) {
          final exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {
              '0': S.current.WeightXReps,
            },
            contentURL: content,
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
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
          await usersCollection
              .doc(userUid)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .collection(DBPathsConstants.exercisesPath)
              .doc('${exercise.name}-${exercise.target}-${exercise.id}')
              .set(exercise.toMap(), SetOptions(merge: true));
        } else {
          final storageRef = firebaseStorage
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child(workoutCollectionName)
              .child(DBPathsConstants.exercisesPath)
              .child('$exerciseName$exerciseTarget$id.png');

          await storageRef.putString(content, format: PutStringFormat.base64);
          final exercise = ExerciseModel(
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
          await usersCollection
              .doc(userUid)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .collection(DBPathsConstants.exercisesPath)
              .doc('${exercise.name}-${exercise.target}-${exercise.id}')
              .set(exercise.toMap(), SetOptions(merge: true));
        }
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
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addSet,
      );
      await usersCollection
          .doc(userUid)
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
    required GlobalKey<FormState> formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required WidgetRef ref,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.changeSet,
      );
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): '$weight x $reps',
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
      ref: ref,
      indexToInsert: indexToInsert + 1,
      context: context,
    );
  }

  Future<List<(dynamic, List<String>)>> getPublic() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.exercisesPath)
        .get()
        .then((value) => value.data()!['names'] as List);

    final finalList = names
        .map(
          (e) => firebaseStorage
              .child(DBPathsConstants.publicPath)
              .child(DBPathsConstants.exercisesPath)
              .child(e as String)
              .list()
              .then(
                (value) async =>
                    value.items.map((e) => e.getDownloadURL()).toList(),
              )
              .then(
            (value) async {
              final urls = await Future.wait(value);
              return (e, urls);
            },
          ),
        )
        .toList();
    return Future.value(await Future.wait(finalList));
  }
}
