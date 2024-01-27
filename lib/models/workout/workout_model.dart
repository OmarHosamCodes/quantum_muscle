import '/library.dart';

class WorkoutModel {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String exercisesKey = 'exercises';
  static const String imageURLKey = 'imageURL';
  static const String creationDateKey = 'creationDate';
  static const String modelKey = 'workoutModel';

  String id;
  String name;
  List exercises;
  String imageURL;
  Timestamp creationDate;

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
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return WorkoutModel(
      id: map[idKey],
      name: map[nameKey],
      exercises: map[exercisesKey],
      imageURL: map[imageURLKey],
      creationDate: map[creationDateKey],
    );
  }
  factory WorkoutModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      WorkoutModel(
        id: map[idKey],
        name: map[nameKey],
        exercises: map[exercisesKey],
        imageURL: map[imageURLKey],
        creationDate: map[creationDateKey],
      );

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        exercisesKey: exercises,
        imageURLKey: imageURL,
        creationDateKey: creationDate,
      };
}
