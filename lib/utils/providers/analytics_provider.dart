import '/library.dart';

final generalAnalyticsProvider =
    FutureProvider.family<GeneralAnalyticsModel, String>((ref, id) {
  final userData = ref.watch(userProvider(id)).value!;
  final programs = ref.watch(programsProvider).value!;
  final workouts = ref.watch(workoutsProvider(id)).value!;

  return GeneralAnalyticsModel(
    totalPrograms: userData.programs.length,
    totalClients: programs.map((e) => e.traineesIds).length,
    totalWorkouts: workouts.length,
    totalExercises: workouts.map((e) => e.exercises.length).length,
    totalFollowers: userData.followers.length,
  );
});
