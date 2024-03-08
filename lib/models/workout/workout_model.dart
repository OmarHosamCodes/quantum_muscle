import 'package:quantum_muscle/library.dart';

/// Represents a workout model.
class WorkoutModel {
  /// Creates a new instance of [WorkoutModel].
  WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.imageURL,
    required this.creationDate,
  });

  /// Creates an empty instance of [WorkoutModel].
  WorkoutModel.empty()
      : id = '',
        name = '',
        exercises = [],
        imageURL = '',
        creationDate = Timestamp.now();

  /// Creates a [WorkoutModel] instance from a Firestore document snapshot.
  factory WorkoutModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data()!;
    return WorkoutModel(
      id: map[idKey] as String,
      name: map[nameKey] as String,
      exercises: List<dynamic>.from(map[exercisesKey] as List<dynamic>),
      imageURL: map[imageURLKey] as String,
      creationDate: map[creationDateKey] as Timestamp,
    );
  }

  /// Creates a [WorkoutModel] instance from a map.
  factory WorkoutModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      WorkoutModel(
        id: map[idKey] as String,
        name: map[nameKey] as String,
        exercises: List<dynamic>.from(map[exercisesKey] as List<dynamic>),
        imageURL: map[imageURLKey] as String,
        creationDate: map[creationDateKey] as Timestamp,
      );

  /// The unique identifier of the workout.
  final String id;

  /// The name of the workout.
  final String name;

  /// The list of exercises in the workout.
  final List<dynamic> exercises;

  /// The URL of the workout's image.
  final String imageURL;

  /// The creation date of the workout.
  final Timestamp creationDate;

  /// The key for the 'id' field in the Firestore document.
  static const String idKey = 'id';

  /// The key for the 'name' field in the Firestore document.
  static const String nameKey = 'name';

  /// The key for the 'exercises' field in the Firestore document.
  static const String exercisesKey = 'exercises';

  /// The key for the 'imageURL' field in the Firestore document.
  static const String imageURLKey = 'imageURL';

  /// The key for the 'creationDate' field in the Firestore document.
  static const String creationDateKey = 'creationDate';

  /// The key for the 'workoutModel' field in the Firestore document.
  static const String modelKey = 'workoutModel';

  /// Converts the [WorkoutModel] instance to a map.
  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        exercisesKey: exercises,
        imageURLKey: imageURL,
        creationDateKey: creationDate,
      };
}
