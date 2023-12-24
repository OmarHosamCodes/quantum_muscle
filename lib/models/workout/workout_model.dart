import '/library.dart';

class WorkoutModel {
  static const String workoutIdKey = 'workoutId';
  static const String workoutNameKey = 'workoutName';
  static const String workoutExercisesKey = 'workoutExercises';
  static const String workoutImgEncodedKey = 'workoutImgEncoded';
  static const String workoutCreationDateKey = 'workoutCreationDate';

  String? workoutId;
  String? workoutName;
  List? workoutExercises;
  String? workoutImgEncoded;
  String? workoutCreationDate;

  WorkoutModel({
    required this.workoutId,
    required this.workoutName,
    required this.workoutExercises,
    required this.workoutImgEncoded,
    required this.workoutCreationDate,
  });

  factory WorkoutModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return WorkoutModel(
      workoutId: map[workoutIdKey],
      workoutName: map[workoutNameKey],
      workoutExercises: map[workoutExercisesKey],
      workoutImgEncoded: map[workoutImgEncodedKey],
      workoutCreationDate: map[workoutCreationDateKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      workoutIdKey: workoutId,
      workoutNameKey: workoutName,
      workoutExercisesKey: workoutExercises,
      workoutImgEncodedKey: workoutImgEncoded,
      workoutCreationDateKey: workoutCreationDate,
    };
  }
}
