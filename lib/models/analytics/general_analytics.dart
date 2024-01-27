class GeneralAnalyticsModel {
  static const String totalProgramsKey = 'totalPrograms';
  static const String totalTraineesKey = 'totalTrainees';
  static const String totalWorkoutsKey = 'totalWorkouts';
  static const String totalExercisesKey = 'totalExercises';
  static const String totalFollowersKey = 'totalFollowers';

  int? totalPrograms;
  int? totalTrainees;
  int? totalWorkouts;
  int? totalExercises;
  GeneralAnalyticsModel({
    this.totalPrograms,
    this.totalTrainees,
    this.totalWorkouts,
    this.totalExercises,
  });

  factory GeneralAnalyticsModel.fromMap(Map<String, dynamic> map) =>
      GeneralAnalyticsModel(
        totalPrograms: map[totalProgramsKey],
        totalTrainees: map[totalTraineesKey],
        totalWorkouts: map[totalWorkoutsKey],
        totalExercises: map[totalExercisesKey],
      );

  Map<String, dynamic> toMap() => {
        totalProgramsKey: totalPrograms,
        totalTraineesKey: totalTrainees,
        totalWorkoutsKey: totalWorkouts,
        totalExercisesKey: totalExercises,
      };
}
