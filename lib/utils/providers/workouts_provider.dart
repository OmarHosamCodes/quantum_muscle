import '/library.dart';

//todo make it workoutModel, string
final workoutsProvider =
    StreamProvider.family<List<WorkoutModel>, String>((ref, id) {
  Stream<List<WorkoutModel>> workouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .orderBy(
        WorkoutModel.creationDateKey,
        descending: true,
      )
      .get()
      .then(
        (value) =>
            value.docs.map((e) => WorkoutModel.fromMap(e.data())).toList(),
      )
      .asStream();
  return workouts;
});
