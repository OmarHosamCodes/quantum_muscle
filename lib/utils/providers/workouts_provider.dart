import '/library.dart';

//todo make it workoutModel, string
final workoutsProvider =
    StreamProvider.family<List<WorkoutModel>, String>((ref, id) async* {
  Stream<List<WorkoutModel>> workouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .orderBy(
        WorkoutModel.creationDateKey,
        descending: true,
      )
      .snapshots()
      .map(
        (event) =>
            event.docs.map((e) => WorkoutModel.fromMap(e.data())).toList(),
      );
  yield* workouts;
});

final exercisesProvider =
    StreamProvider.family<List<ExerciseModel>, Map<String, List>>(
        (ref, workoutAndExercises) async* {
  Stream<List<ExerciseModel>> exercisesModelsList = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid!)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .doc(workoutAndExercises.keys.first)
      .collection(DBPathsConstants.usersUserProgramsAndWorkoutsExercisesPath)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList());

  yield* exercisesModelsList;
});
