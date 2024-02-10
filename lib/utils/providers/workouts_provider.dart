import '/library.dart';

final workoutsProvider = StreamProvider<List<WorkoutModel>>((ref) async* {
  Stream<List<WorkoutModel>> workouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid!)
      .collection(DBPathsConstants.workoutsPath)
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

final exercisesProvider = StreamProvider.family<List<ExerciseModel>, String>(
    (ref, workoutCollectionName) async* {
  Stream<List<ExerciseModel>> exercisesModelsList = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid!)
      .collection(DBPathsConstants.workoutsPath)
      .doc(workoutCollectionName)
      .collection(DBPathsConstants.exercisesPath)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList());
  yield* exercisesModelsList;
});

final publicWorkoutsProvider =
    FutureProvider<List<(dynamic, List<String>)>>((ref) async {
  List<(dynamic, List<String>)> publicWorkouts =
      await WorkoutUtil().getWorkoutImages();
  return publicWorkouts;
});

final publicExercisesProvider =
    FutureProvider<List<(dynamic, List<String>)>>((ref) async {
  return await ExerciseUtil().getExerciseImages();
});
