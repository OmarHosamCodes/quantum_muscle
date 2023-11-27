import '../library.dart';

class WorkoutModel {
  String? name;
  List<String>? exercises;
  int? duration;

  WorkoutModel({
    this.name,
    this.exercises,
    this.duration,
  });

  factory WorkoutModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return WorkoutModel(
      name: map['name'],
      exercises: map['exercises'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises,
      'duration': duration,
    };
  }
}
