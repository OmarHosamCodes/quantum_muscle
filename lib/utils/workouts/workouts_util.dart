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
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        final id = const Uuid().v4().toString().substring(0, 12);

        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.usersUserWorkoutsPath)
            .child("$workoutName-$id")
            .child("$workoutName-showcase.png");

        storageRef.putString(imageFile, format: PutStringFormat.base64).then(
          (_) async {
            final workoutModel = WorkoutModel(
              id: id,
              name: workoutName,
              imgUrl: await storageRef.getDownloadURL(),
              exercises: [],
              creationDate: Timestamp.now(),
            );
            await firebaseFirestore
                .collection(DBPathsConstants.usersPath)
                .doc(userUid)
                .collection(DBPathsConstants.usersUserWorkoutsPath)
                .doc("$workoutName-$id")
                .set(
                  workoutModel.toMap(),
                  SetOptions(merge: true),
                )
                .then(
              (_) {
                ref.invalidate(workoutsProvider);
                ref.read(workoutsProvider(Utils().userUid!));
                while (context.canPop()) {
                  context.pop();
                }
              },
            );
          },
        );
      } on FirebaseException catch (e) {
        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.message!,
        );
      }
    }
  }
}
