// ignore_for_file: use_build_context_synchronously, unused_result, avoid_print

import '/library.dart';

final exerciseImageBytesProvider = StateProvider<String?>((ref) => null);

class ExerciseUtil extends Utils {
  static ExerciseUtil get instance => ExerciseUtil();

  Future<void> addExercise({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String workoutName,
    required String workoutId,
    required String exerciseName,
    required String exerciseTarget,
    required String showcaseFile,
    required String showcaseType,
    required int indexToInsert,
  }) async {
    openQmLoaderDialog(context: context);

    final id = const Uuid().v4().toString().substring(0, 6);
    if (user != null) {
      try {
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.usersUserWorkoutsPath)
            .child("$workoutName-$workoutId")
            .child("$exerciseName$exerciseTarget$id.png");
        UploadTask uploadeTask =
            storageRef.putString(showcaseFile, format: PutStringFormat.base64);
        await uploadeTask.then(
          (_) async {
            final exerciseModel = ExerciseModel(
              id: id,
              name: exerciseName,
              target: exerciseTarget,
              sets: [],
              showcaseUrl: await storageRef.getDownloadURL(),
              showcaseType: ExerciseShowcase.values.firstWhere(
                (element) => element.name == showcaseType,
              ),
            );
            print(exerciseModel.toMap());
            await firebaseFirestore
                .collection(DBPathsConstants.usersPath)
                .doc(userUid!)
                .collection(DBPathsConstants.usersUserWorkoutsPath)
                .doc("$workoutName-$workoutId")
                .set(
              {
                WorkoutModel.exercisesKey: FieldValue.arrayUnion(
                  [
                    {
                      indexToInsert.toString(): exerciseModel.toMap(),
                    }
                  ],
                )
              },
              SetOptions(merge: true),
            );
          },
        ).then((_) {
          ref.invalidate(workoutsStreamProvider);
          ref.read(workoutsStreamProvider(Utils().userUid!));
          ref.read(exerciseImageBytesProvider.notifier).state = null;
          context.pop();
        });
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
