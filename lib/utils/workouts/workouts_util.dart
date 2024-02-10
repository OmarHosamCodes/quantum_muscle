// ignore_for_file: use_build_context_synchronously

import '/library.dart';

//todo try to make it inside the class
final workoutImageBytesProvider = StateProvider<String?>((ref) => null);
final workoutNetworkImageProvider = StateProvider<String?>((ref) => null);

class WorkoutUtil extends Utils {
  Future<void> addWorkout({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String workoutName,
    required String image,
    required WidgetRef ref,
    required bool isLink,
  }) async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (user != null) {
      try {
        firebaseAnalytics.logEvent(
            name: AnalyticsEventNamesConstants.addWorkout);
        final id = const Uuid().v4().toString().substring(0, 12);

        if (isLink) {
          WorkoutModel workoutModel = WorkoutModel(
            id: id,
            name: workoutName,
            imageURL: image,
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
        } else {
          Reference storageRef = firebaseStorage
              .ref()
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child("$workoutName-$id")
              .child("$workoutName-showcase.png");

          await storageRef.putString(image, format: PutStringFormat.base64);

          WorkoutModel workoutModel = WorkoutModel(
            id: id,
            name: workoutName,
            imageURL: await storageRef.getDownloadURL(),
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

  Future<void> deleteWorkout({
    required String workoutCollectionName,
    required BuildContext context,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeWorkout,
      );
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

  Future<List<(dynamic, List<String>)>> getWorkoutImages() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.workoutsPath)
        .get()
        .then((value) => value.data()!['names'] as List);

    final finalList = names
        .map(
          (e) async => await firebaseStorage
              .ref()
              .child(DBPathsConstants.publicPath)
              .child(DBPathsConstants.workoutsPath)
              .child(e)
              .list()
              .then((value) async => value.items
                  .map((e) async => await e.getDownloadURL())
                  .toList())
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
