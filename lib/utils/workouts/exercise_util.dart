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
    required String? showcaseFile,
    required String showcaseType,
    required Map<String, List> workoutAndExercises,
  }) async {
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        ExerciseModel exercise = ExerciseModel(
          id: '',
          name: '',
          target: '',
          sets: [],
          showcaseUrl: '',
          showcaseType: ExerciseShowcase.image,
          creationDate: Timestamp.now(),
        );
        final id = const Uuid().v4().toString().substring(0, 12);
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.usersUserWorkoutsPath)
            .child(workoutCollectionName)
            .child(DBPathsConstants.usersUserProgramsAndWorkoutsExercisesPath)
            .child("$exerciseName$exerciseTarget$id.png");
        exercise.id = id;
        exercise.name = exerciseName;
        exercise.target = exerciseTarget;
        if (showcaseFile != null) {
          await storageRef.putString(showcaseFile,
              format: PutStringFormat.base64);
          exercise.showcaseUrl = await storageRef.getDownloadURL();
        } else {
          openQmDialog(
              context: context,
              title: S.current.Failed,
              message: S.current.AddAPhoto);
          return;
        }
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid!)
            .collection(DBPathsConstants.usersUserWorkoutsPath)
            .doc(workoutCollectionName)
            .collection(
                DBPathsConstants.usersUserProgramsAndWorkoutsExercisesPath)
            .doc("$exerciseName$exerciseTarget$id")
            .set(exercise.toMap(), SetOptions(merge: true));

        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid!)
            .collection(DBPathsConstants.usersUserWorkoutsPath)
            .doc(workoutCollectionName)
            .set(
          {
            WorkoutModel.exercisesKey: FieldValue.arrayUnion(
              [
                "$exerciseName$exerciseTarget$id",
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

  Future<void> addSet({
    required String workoutCollectionName,
    required String exerciseDocName,
  }) async {
    await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userUid!)
        .collection(DBPathsConstants.usersUserWorkoutsPath)
        .doc(workoutCollectionName)
        .collection(DBPathsConstants.usersUserProgramsAndWorkoutsExercisesPath)
        .doc(exerciseDocName)
        .set({
      ExerciseModel.setsKey: FieldValue.arrayUnion(
        [
          S.current.WeightXReps,
        ],
      ),
    }, SetOptions(merge: false));
  }

  Future<void> addExerciesToProgramWorkout({
    required BuildContext context,
    required WidgetRef ref,
    required String programId,
    required String workoutName,
    required String workoutId,
    required String exerciseName,
    required String exerciseTarget,
    required String showcaseFile,
    required String showcaseType,
  }) async {
    openQmLoaderDialog(context: context);

    final id = const Uuid().v8().toString().substring(0, 8);
    if (user != null) {
      try {
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.usersUserProgramsPath)
            .child(programId)
            .child("$workoutName-$workoutId")
            .child("$exerciseName$exerciseTarget$id.png");
        UploadTask uploadeTask =
            storageRef.putString(showcaseFile, format: PutStringFormat.base64);
        index() async {
          final workoutsList = await firebaseFirestore
              .collection(DBPathsConstants.usersUserProgramsPath)
              .doc(programId)
              .get()
              .then((value) =>
                  value.data()![ProgramModel.workoutsKey] as List<dynamic>);
          for (var workout in workoutsList) {
            if (workout['id'] == workoutId) {
              return workoutsList.indexOf(workout);
            }
          }
        }

        await uploadeTask;
        final exerciseModel = ExerciseModel(
          id: id,
          name: exerciseName,
          target: exerciseTarget,
          sets: [],
          showcaseUrl: await storageRef.getDownloadURL(),
          showcaseType: ExerciseShowcase.values.firstWhere(
            (element) => element.name == showcaseType,
          ),
          creationDate: Timestamp.now(),
        );
        print(exerciseModel.toMap());

        await firebaseFirestore
            .collection(DBPathsConstants.usersUserProgramsPath)
            .doc(programId)
            .set(
          {
            ProgramModel.workoutsKey: {
              (await index()).toString(): {
                WorkoutModel.exercisesKey: FieldValue.arrayUnion(
                  [
                    exerciseModel.toMap(),
                  ],
                ),
              },
            },
          },
          SetOptions(merge: false),
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
}
