import 'package:quantum_muscle/library.dart';

class WorkoutModel {
  WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.imageURL,
    required this.creationDate,
  });
  WorkoutModel.empty()
      : id = '',
        name = '',
        exercises = [],
        imageURL = '',
        creationDate = Timestamp.now();

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
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String exercisesKey = 'exercises';
  static const String imageURLKey = 'imageURL';
  static const String creationDateKey = 'creationDate';
  static const String modelKey = 'workoutModel';

  String id;
  String name;
  List<dynamic> exercises;
  String imageURL;
  Timestamp creationDate;

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        exercisesKey: exercises,
        imageURLKey: imageURL,
        creationDateKey: creationDate,
      };
}
