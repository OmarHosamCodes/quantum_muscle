class GeneralAnalyticsModel {
  GeneralAnalyticsModel({
    this.totalPrograms,
    this.totalTrainees,
    this.totalWorkouts,
    this.totalExercises,
  });

  factory GeneralAnalyticsModel.fromMap(Map<String, dynamic> map) =>
      GeneralAnalyticsModel(
        totalPrograms: map[totalProgramsKey] as int?,
        totalTrainees: map[totalTraineesKey] as int?,
        totalWorkouts: map[totalWorkoutsKey] as int?,
        totalExercises: map[totalExercisesKey] as int?,
      );
  static const String totalProgramsKey = 'totalPrograms';
  static const String totalTraineesKey = 'totalTrainees';
  static const String totalWorkoutsKey = 'totalWorkouts';
  static const String totalExercisesKey = 'totalExercises';
  static const String totalFollowersKey = 'totalFollowers';

  int? totalPrograms;
  int? totalTrainees;
  int? totalWorkouts;
  int? totalExercises;

  Map<String, dynamic> toMap() => {
        totalProgramsKey: totalPrograms,
        totalTraineesKey: totalTrainees,
        totalWorkoutsKey: totalWorkouts,
        totalExercisesKey: totalExercises,
      };
}
