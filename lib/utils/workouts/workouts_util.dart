// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

class WorkoutUtil extends Utils {
  Future<void> add({
    required BuildContext context,
    required String name,
    required String image,
    required WidgetRef ref,
    required bool isLink,
    required GlobalKey<FormState> formKey,
  }) async {
    QmLoader.openLoader(context: context);
    if (user != null) {
      try {
        if (!formKey.currentState!.validate()) return;
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addWorkout,
        );
        final id = const Uuid().v8();

        if (isLink) {
          final workoutModel = WorkoutModel(
            id: id,
            name: name,
            imageURL: image,
            exercises: [],
            creationDate: Timestamp.now(),
          );

          await usersCollection
              .doc(userUid)
              .collection(DBPathsConstants.workoutsPath)
              .doc('$name-$id')
              .set(
                workoutModel.toMap(),
                SetOptions(merge: true),
              );
        } else {
          final storageRef = firebaseStorage
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child('$name-$id')
              .child('$name-showcase.png');
          await storageRef.putString(image, format: PutStringFormat.base64);

          final workoutModel = WorkoutModel(
            id: id,
            name: name,
            imageURL: await storageRef.getDownloadURL(),
            exercises: [],
            creationDate: Timestamp.now(),
          );

          await usersCollection
              .doc(userUid)
              .collection(DBPathsConstants.workoutsPath)
              .doc('$name-$id')
              .set(
                workoutModel.toMap(),
                SetOptions(merge: true),
              );
        }
        QmLoader.closeLoader(context: context);
      } catch (e) {
        QmLoader.closeLoader(context: context);

        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> delete({
    required String workoutCollectionName,
    required BuildContext context,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeWorkout,
      );
      await usersCollection
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .delete();

      QmLoader.closeLoader(context: context);
      context.pop();
    } catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }

  Future<List<(String, List<String>)>> getPublic() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.workoutsPath)
        .get()
        .then((value) => value.data()!['names'] as List);

    final finalList = names
        .map(
          (e) => firebaseStorage
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

class WorkoutUtil2 extends Utils {
//
}
