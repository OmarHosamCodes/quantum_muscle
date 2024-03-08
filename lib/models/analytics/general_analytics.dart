/// Represents the analytics data for general statistics.
class GeneralAnalyticsModel {
  /// Creates a new instance of [GeneralAnalyticsModel].
  GeneralAnalyticsModel({
    this.totalPrograms,
    this.totalTrainees,
    this.totalWorkouts,
    this.totalExercises,
  });

  /// Creates a new instance of [GeneralAnalyticsModel] from a map.
  factory GeneralAnalyticsModel.fromMap(Map<String, dynamic> map) =>
      GeneralAnalyticsModel(
        totalPrograms: map[totalProgramsKey] as int?,
        totalTrainees: map[totalTraineesKey] as int?,
        totalWorkouts: map[totalWorkoutsKey] as int?,
        totalExercises: map[totalExercisesKey] as int?,
      );

  /// The total number of programs.
  int? totalPrograms;

  /// The total number of trainees.
  int? totalTrainees;

  /// The total number of workouts.
  int? totalWorkouts;

  /// The total number of exercises.
  int? totalExercises;

  /// The key for the 'totalPrograms' property in the map.
  static const String totalProgramsKey = 'totalPrograms';

  /// The key for the 'totalTrainees' property in the map.
  static const String totalTraineesKey = 'totalTrainees';

  /// The key for the 'totalWorkouts' property in the map.
  static const String totalWorkoutsKey = 'totalWorkouts';

  /// The key for the 'totalExercises' property in the map.
  static const String totalExercisesKey = 'totalExercises';

  /// Converts the [GeneralAnalyticsModel] instance to a map.
  Map<String, dynamic> toMap() => {
        totalProgramsKey: totalPrograms,
        totalTraineesKey: totalTrainees,
        totalWorkoutsKey: totalWorkouts,
        totalExercisesKey: totalExercises,
      };
}
