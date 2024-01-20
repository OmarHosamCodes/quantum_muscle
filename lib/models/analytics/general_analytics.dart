class GeneralAnalyticsModel {
  static const String totalProgramsKey = 'totalPrograms';
  static const String totalClientsKey = 'totalClients';
  static const String totalWorkoutsKey = 'totalWorkouts';
  static const String totalExercisesKey = 'totalExercises';
  static const String totalFollowersKey = 'totalFollowers';

  int? totalPrograms;
  int? totalClients;
  int? totalWorkouts;
  int? totalExercises;
  int? totalFollowers;
  GeneralAnalyticsModel({
    this.totalPrograms,
    this.totalClients,
    this.totalWorkouts,
    this.totalExercises,
    this.totalFollowers,
  });

  factory GeneralAnalyticsModel.fromMap(Map<String, dynamic> map) =>
      GeneralAnalyticsModel(
        totalPrograms: map[totalProgramsKey],
        totalClients: map[totalClientsKey],
        totalWorkouts: map[totalWorkoutsKey],
        totalExercises: map[totalExercisesKey],
        totalFollowers: map[totalFollowersKey],
      );

  Map<String, dynamic> toMap() => {
        totalProgramsKey: totalPrograms,
        totalClientsKey: totalClients,
        totalWorkoutsKey: totalWorkouts,
        totalExercisesKey: totalExercises,
        totalFollowersKey: totalFollowers,
      };
}
