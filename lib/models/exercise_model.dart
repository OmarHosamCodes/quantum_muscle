class ExerciseModel {
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
      exerciseName: map['exerciseName'],
      exerciseTarget: map['exerciseTarget'],
      exerciseSets: map['exerciseSets'],
      exerciseImgEncoded: map['exerciseImgEncoded'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'exerciseTarget': exerciseTarget,
      'exerciseSets': exerciseSets,
      'exerciseImgEncoded': exerciseImgEncoded,
    };
  }
}
