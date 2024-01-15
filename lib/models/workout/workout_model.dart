import '/library.dart';

class WorkoutModel {
  static const String idKey = 'Id';
  static const String nameKey = 'Name';
  static const String exercisesKey = 'Exercises';
  static const String imgUrlKey = 'ImgUrl';
  static const String creationDateKey = 'CreationDate';
  static const String modelKey = 'WorkoutModel';

  String id;
  String name;
  List exercises;
  String imgUrl;
  Timestamp creationDate;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.imgUrl,
    required this.creationDate,
  });

  factory WorkoutModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return WorkoutModel(
      id: map[idKey],
      name: map[nameKey],
      exercises: map[exercisesKey],
      imgUrl: map[imgUrlKey],
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
        imgUrl: map[imgUrlKey],
        creationDate: map[creationDateKey],
      );

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        exercisesKey: exercises,
        imgUrlKey: imgUrl,
        creationDateKey: creationDate,
      };
}
