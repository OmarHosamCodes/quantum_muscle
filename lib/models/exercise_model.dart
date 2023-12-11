class ExerciseModel {
  static const String exersiceNameKey = 'exerciseName';
  static const String exerciseTargetKey = 'exerciseTarget';
  static const String exerciseSetsKey = 'exerciseSets';
  static const String exerciseImgEncodedKey = 'exerciseImgEncoded';

  String? exerciseName;
  String? exerciseTarget;
  String? exerciseImgEncoded;
  List<dynamic>? exerciseSets;

  ExerciseModel({
    this.exerciseName,
    this.exerciseTarget,
    this.exerciseSets,
    this.exerciseImgEncoded,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      exerciseName: map[exersiceNameKey],
      exerciseTarget: map[exerciseTargetKey],
      exerciseSets: map[exerciseSetsKey],
      exerciseImgEncoded: map[exerciseImgEncodedKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      exersiceNameKey: exerciseName,
      exerciseTargetKey: exerciseTarget,
      exerciseSetsKey: exerciseSets,
      exerciseImgEncodedKey: exerciseImgEncoded,
    };
  }
}
