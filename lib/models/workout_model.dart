class WorkoutModel {
  final String? name;
  final List<String>? exercises;
  final int? duration;

  WorkoutModel({
    this.name,
    this.exercises,
    this.duration,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
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
