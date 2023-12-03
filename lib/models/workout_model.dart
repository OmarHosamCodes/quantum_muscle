import '../library.dart';

class WorkoutModel {
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
      workoutId: map['workoutId'] ?? 'Invalid Id',
      workoutName: map['workoutName'] ?? 'Invalid Name',
      workoutExercises: map['workoutExercises'] ?? '',
      workoutImgEncoded: map['workoutImgEncoded'] ?? 'Invalid Image',
      workoutCreationDate: map['workoutCreationDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'workoutName': workoutName,
      'workoutExercises': workoutExercises,
      'workoutImgEncoded': workoutImgEncoded,
      'workoutCreationDate': workoutCreationDate,
    };
  }
}
