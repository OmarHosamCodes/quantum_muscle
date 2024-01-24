// ignore_for_file: use_build_context_synchronously

import '/library.dart';

//todo try to make it inside the class
final workoutImageBytesProvider = StateProvider<String?>((ref) => null);

class WorkoutUtil extends Utils {
  Future<void> addWorkout({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String workoutName,
    required String imageFile,
    required WidgetRef ref,
  }) async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (user != null) {
      try {
        final id = const Uuid().v4().toString().substring(0, 12);

        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.workoutsPath)
            .child("$workoutName-$id")
            .child("$workoutName-showcase.png");

        await storageRef.putString(imageFile, format: PutStringFormat.base64);

        WorkoutModel workoutModel = WorkoutModel(
          id: id,
          name: workoutName,
          imgUrl: await storageRef.getDownloadURL(),
          exercises: [],
          creationDate: Timestamp.now(),
        );

        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .collection(DBPathsConstants.workoutsPath)
            .doc("$workoutName-$id")
            .set(
              workoutModel.toMap(),
              SetOptions(merge: true),
            );
      } catch (e) {
        context.pop();
        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> deleteWorkout({
    required String workoutCollectionName,
    required BuildContext context,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .delete();
      while (context.canPop()) {
        context.pop();
      }
    } catch (e) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }
}
