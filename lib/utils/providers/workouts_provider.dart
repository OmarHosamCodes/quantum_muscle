import 'package:quantum_muscle/library.dart';

final workoutsProvider = StreamProvider<List<WorkoutModel>>((ref) async* {
  final workouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid)
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
  final exercisesModelsList = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid)
      .collection(DBPathsConstants.workoutsPath)
      .doc(workoutCollectionName)
      .collection(DBPathsConstants.exercisesPath)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList(),
      );
  yield* exercisesModelsList;
});

final publicWorkoutsProvider =
    FutureProvider<List<(dynamic, List<String>)>>((ref) async {
  final publicWorkouts = await WorkoutUtil().getPublic();

  return publicWorkouts;
});

final publicExercisesProvider =
    FutureProvider<List<(dynamic, List<String>)>>((ref) async {
  final publicExercises = await ExerciseUtil().getPublic();

  return publicExercises;
});

class AddWorkoutState {
  AddWorkoutState({
    required this.name,
    required this.content,
  });

  final String name;
  final String? content;
  AddWorkoutState copyWith({
    String? name,
    bool? isNameValid,
    String? content,
  }) {
    return AddWorkoutState(
      name: name ?? this.name,
      content: content ?? this.content,
    );
  }
}

class AddWorkoutNotifier extends StateNotifier<AddWorkoutState> {
  AddWorkoutNotifier()
      : super(
          AddWorkoutState(
            name: '',
            content: null,
          ),
        );

  void setName(
    String name,
  ) =>
      state = state.copyWith(name: name);

  void resetState() => state = AddWorkoutState(
        name: '',
        content: null,
      );
  void setContent(String content) => state = state.copyWith(content: content);
}

final addWorkoutNotifierProvider =
    StateNotifierProvider<AddWorkoutNotifier, AddWorkoutState>(
  (ref) => AddWorkoutNotifier(),
);
