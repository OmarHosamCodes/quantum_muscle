// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

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
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (user != null) {
      try {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addWorkout,
        );
        final id = const Uuid().v4().substring(0, 12);

        if (isLink) {
          final workoutModel = WorkoutModel(
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
              .doc('$workoutName-$id')
              .set(
                workoutModel.toMap(),
                SetOptions(merge: true),
              );
        } else {
          final storageRef = firebaseStorage
              .ref()
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child('$workoutName-$id')
              .child('$workoutName-showcase.png');

          await storageRef.putString(image, format: PutStringFormat.base64);

          final workoutModel = WorkoutModel(
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
              .doc('$workoutName-$id')
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
      await firebaseAnalytics.logEvent(
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

  Future<List<(String, List<String>)>> getWorkoutImages() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.workoutsPath)
        .get()
        .then((value) => value.data()!['names'] as List);

    final finalList = names
        .map(
          (e) => firebaseStorage
              .ref()
              .child(DBPathsConstants.publicPath)
              .child(DBPathsConstants.workoutsPath)
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
    final result = await Future.wait(finalList);
    return result;
  }
}
