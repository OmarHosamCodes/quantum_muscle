import 'package:quantum_muscle/library.dart';

/// Provider that streams a list of [WorkoutModel] objects.
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

/// Provider that streams a list of [ExerciseModel] objects for a specific workout collection.
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

/// Provider that fetches a list of public workouts.
final publicWorkoutsProvider =
    FutureProvider<List<(dynamic, List<String>)>>((ref) async {
  final publicWorkouts = await WorkoutUtil().getPublic();

  return publicWorkouts;
});

/// Provider that fetches a list of public exercises.
final publicExercisesProvider =
    FutureProvider<List<(String, List<ExerciseTemplate>)>>((ref) async {
  final publicExercises = await ExerciseUtil().getPublic();

  return publicExercises;
});

/// Represents the state of adding a workout.
class AddWorkoutState {
  /// Creates a new instance of [AddWorkoutState].
  AddWorkoutState({
    required this.name,
    required this.content,
  });

  /// The name of the workout.
  final String name;

  /// The content of the workout.
  final String? content;

  /// Creates a copy of the [AddWorkoutState] with optional changes.
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

/// Notifier for managing the state of adding a workout.
class AddWorkoutNotifier extends StateNotifier<AddWorkoutState> {
  /// Creates a new instance of [AddWorkoutNotifier].
  AddWorkoutNotifier()
      : super(
          AddWorkoutState(
            name: '',
            content: null,
          ),
        );

  /// Sets the name of the workout.
  void setName(String name) => state = state.copyWith(name: name);

  /// Resets the state of adding a workout.
  void resetState() => state = AddWorkoutState(
        name: '',
        content: null,
      );

  /// Sets the content of the workout.
  void setContent(String? content) => state = state.copyWith(content: content);
}

/// Provider for the [AddWorkoutNotifier] state notifier.
final addWorkoutNotifierProvider =
    StateNotifierProvider<AddWorkoutNotifier, AddWorkoutState>(
  (ref) => AddWorkoutNotifier(),
);
